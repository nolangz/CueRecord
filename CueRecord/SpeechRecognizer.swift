//
//  SpeechRecognizer.swift
//  CueRecord
//
//

import AppKit
import Foundation
import AVFoundation
import CoreAudio

struct AudioInputDevice: Identifiable, Hashable {
    let id: AudioDeviceID
    let uid: String
    let name: String

    static func allInputDevices() -> [AudioInputDevice] {
        var propertyAddress = AudioObjectPropertyAddress(
            mSelector: kAudioHardwarePropertyDevices,
            mScope: kAudioObjectPropertyScopeGlobal,
            mElement: kAudioObjectPropertyElementMain
        )
        var dataSize: UInt32 = 0
        guard AudioObjectGetPropertyDataSize(AudioObjectID(kAudioObjectSystemObject), &propertyAddress, 0, nil, &dataSize) == noErr else { return [] }

        let deviceCount = Int(dataSize) / MemoryLayout<AudioDeviceID>.size
        var deviceIDs = [AudioDeviceID](repeating: 0, count: deviceCount)
        guard AudioObjectGetPropertyData(AudioObjectID(kAudioObjectSystemObject), &propertyAddress, 0, nil, &dataSize, &deviceIDs) == noErr else { return [] }

        var result: [AudioInputDevice] = []
        for deviceID in deviceIDs {
            // Check if device has input streams
            var inputAddress = AudioObjectPropertyAddress(
                mSelector: kAudioDevicePropertyStreams,
                mScope: kAudioDevicePropertyScopeInput,
                mElement: kAudioObjectPropertyElementMain
            )
            var streamSize: UInt32 = 0
            guard AudioObjectGetPropertyDataSize(deviceID, &inputAddress, 0, nil, &streamSize) == noErr, streamSize > 0 else { continue }

            // Get UID
            var uidAddress = AudioObjectPropertyAddress(
                mSelector: kAudioDevicePropertyDeviceUID,
                mScope: kAudioObjectPropertyScopeGlobal,
                mElement: kAudioObjectPropertyElementMain
            )
            guard let uid = stringProperty(deviceID: deviceID, address: &uidAddress) else { continue }

            // Get name
            var nameAddress = AudioObjectPropertyAddress(
                mSelector: kAudioDevicePropertyDeviceNameCFString,
                mScope: kAudioObjectPropertyScopeGlobal,
                mElement: kAudioObjectPropertyElementMain
            )
            guard let name = stringProperty(deviceID: deviceID, address: &nameAddress) else { continue }

            result.append(AudioInputDevice(id: deviceID, uid: uid, name: name))
        }
        return result
    }

    private static func stringProperty(deviceID: AudioDeviceID, address: inout AudioObjectPropertyAddress) -> String? {
        var dataSize: UInt32 = 0
        guard AudioObjectGetPropertyDataSize(deviceID, &address, 0, nil, &dataSize) == noErr else {
            return nil
        }

        var value: Unmanaged<CFString>?
        guard AudioObjectGetPropertyData(deviceID, &address, 0, nil, &dataSize, &value) == noErr,
              let stringValue = value?.takeRetainedValue()
        else {
            return nil
        }

        return stringValue as String
    }

    static func deviceID(forUID uid: String) -> AudioDeviceID? {
        allInputDevices().first(where: { $0.uid == uid })?.id
    }
}

@Observable
class SpeechRecognizer {
    var recognizedCharCount: Int = 0
    var isListening: Bool = false
    var error: String?
    var audioLevels: [CGFloat] = Array(repeating: 0, count: 30)
    var lastSpokenText: String = ""
    var shouldDismiss: Bool = false
    var shouldAdvancePage: Bool = false

    /// True when recent audio levels indicate the user is actively speaking
    var isSpeaking: Bool {
        let recent = audioLevels.suffix(10)
        guard !recent.isEmpty else { return false }
        let avg = recent.reduce(0, +) / CGFloat(recent.count)
        return avg > 0.08
    }

    private let asr = SherpaOnnxStreamingASR()
    private var sourceText: String = ""
    private var normalizedSource: String = ""
    private var matchStartOffset: Int = 0  // char offset to start matching from
    private var sessionGeneration: Int = 0
    /// Sliding window of recent match positions for confidence gating.
    /// Larger jumps still need agreement, but short or anchored partial hits
    /// should move immediately so streaming ASR feels responsive.
    private var recentMatchPositions: [Int] = []

    private struct RecoveryAnchorResult {
        let endOffset: Int
        let score: Int
        let matchedWordCount: Int
        let matchedSignalCount: Int
        let exactMatchCount: Int
        let sourceStart: Int
        let spokenStart: Int
        let isPhraseMatch: Bool

        static let none = RecoveryAnchorResult(
            endOffset: 0,
            score: Int.min,
            matchedWordCount: 0,
            matchedSignalCount: 0,
            exactMatchCount: 0,
            sourceStart: 0,
            spokenStart: 0,
            isPhraseMatch: false
        )

        var isUsable: Bool {
            endOffset > 0
        }

        var isStrongForImmediateCatchUp: Bool {
            guard isUsable else { return false }

            if isPhraseMatch {
                return matchedSignalCount >= 6
            }

            if matchedWordCount >= 3 {
                return true
            }

            guard matchedWordCount >= 2, exactMatchCount >= 2 else {
                return matchedWordCount >= 2 && matchedSignalCount >= 10
            }

            if matchedSignalCount >= 6 {
                return true
            }

            return sourceStart <= 12 && spokenStart <= 4
        }
    }

    /// Update the source text while preserving the current recognized char count.
    /// Used by Director Mode to live-edit unread text without resetting read progress.
    func updateText(_ text: String, preservingCharCount: Int) {
        let words = splitTextIntoWords(text)
        let collapsed = words.joined(separator: " ")
        sourceText = collapsed
        normalizedSource = Self.normalize(collapsed)
        recognizedCharCount = min(preservingCharCount, collapsed.count)
        matchStartOffset = recognizedCharCount
        recentMatchPositions = []
    }

    /// Jump highlight to a specific char offset (e.g. when user taps a word)
    func jumpTo(charOffset: Int) {
        recognizedCharCount = charOffset
        matchStartOffset = charOffset
        recentMatchPositions = []
        if isListening {
            restartRecognition()
        }
    }

    func start(with text: String) {
        // Clean up any previous session immediately so pending restarts
        // and stale taps are removed before the async auth callback fires.
        cleanupRecognition()

        let words = splitTextIntoWords(text)
        let collapsed = words.joined(separator: " ")
        sourceText = collapsed
        normalizedSource = Self.normalize(collapsed)
        recognizedCharCount = 0
        matchStartOffset = 0
        recentMatchPositions = []
        error = nil
        sessionGeneration += 1

        // Check microphone permission first
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .denied, .restricted:
            error = "Microphone access denied. Open System Settings → Privacy & Security → Microphone to allow CueRecord."
            openMicrophoneSettings()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.beginRecognition()
                    } else {
                        self?.error = "Microphone access denied. Open System Settings → Privacy & Security → Microphone to allow CueRecord."
                    }
                }
            }
            return
        case .authorized:
            break
        @unknown default:
            break
        }

        beginRecognition()
    }

    private func openMicrophoneSettings() {
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Microphone") {
            NSWorkspace.shared.open(url)
        }
    }

    func stop() {
        isListening = false
        cleanupRecognition()
    }

    func forceStop() {
        isListening = false
        sourceText = ""
        recentMatchPositions = []
        cleanupRecognition()
    }

    func resume() {
        matchStartOffset = recognizedCharCount
        recentMatchPositions = []
        shouldDismiss = false
        beginRecognition()
    }

    private func cleanupRecognition() {
        asr.stop()
    }

    private func beginRecognition() {
        cleanupRecognition()

        let currentGeneration = sessionGeneration
        asr.onTextUpdate = { [weak self] spoken in
            guard let self, self.sessionGeneration == currentGeneration else { return }
            self.lastSpokenText = spoken
            self.matchCharacters(spoken: spoken)
        }
        asr.onNewSegment = { [weak self] in
            guard let self, self.sessionGeneration == currentGeneration else { return }
            self.matchStartOffset = self.recognizedCharCount
            self.recentMatchPositions = []
        }
        asr.onLevelUpdate = { [weak self] level in
            self?.audioLevels.append(level)
            if (self?.audioLevels.count ?? 0) > 30 {
                self?.audioLevels.removeFirst()
            }
        }
        asr.onError = { [weak self] message in
            guard let self, self.sessionGeneration == currentGeneration else { return }
            self.error = message
            self.isListening = false
        }

        isListening = true
        asr.start(selectedMicUID: NotchSettings.shared.selectedMicUID)
    }

    private func restartRecognition() {
        guard !sourceText.isEmpty else { return }
        isListening = true
        matchStartOffset = recognizedCharCount
        recentMatchPositions = []
        beginRecognition()
    }

    // MARK: - Fuzzy character-level matching

    private func matchCharacters(spoken: String) {
        let spokenSignalCount = Self.normalizedSignal(spoken).count
        guard spokenSignalCount > 0 else { return }

        // Strategy 1: character-level fuzzy match from the start offset
        let charResult = charLevelMatch(spoken: spoken)

        // Strategy 2: word-level match (handles STT word substitutions)
        let wordResult = wordLevelMatch(spoken: spoken)

        // Strategy 3: recovery anchors. If ASR drops a few words but the
        // following phrase is accurate, catch up from the later anchor.
        let recoveryMatch = bestRecoveryAnchorMatch(spoken: spoken)
        let recoveryResult = recoveryMatch.endOffset

        let best = selectBestMatch(
            charResult: charResult,
            wordResult: wordResult,
            recoveryResult: recoveryResult,
            spokenSignalCount: spokenSignalCount
        )
        guard best > 0 else { return }

        let newCount = matchStartOffset + best
        guard newCount > recognizedCharCount else { return }

        let candidate = min(newCount, sourceText.count)
        let forwardDelta = candidate - recognizedCharCount

        // Confidence gating: require 2-of-3 recent results to agree on
        // large forward movement to avoid single-result false-positive jumps.
        recentMatchPositions.append(candidate)
        if recentMatchPositions.count > 3 {
            recentMatchPositions.removeFirst()
        }

        // Check if at least 2 of the recent positions agree (within tolerance)
        let agreementThreshold = 10 // characters
        var confirmed = false
        if recentMatchPositions.count >= 2 {
            var agreeCount = 0
            for pos in recentMatchPositions {
                if abs(pos - candidate) <= agreementThreshold {
                    agreeCount += 1
                }
            }
            confirmed = agreeCount >= 2
        }

        let strategyDisagreesBecauseOneIsMissing = (charResult == 0) != (wordResult == 0)
        let shortStep = forwardDelta <= 28
        let anchoredPartial = strategyDisagreesBecauseOneIsMissing && best >= 2 && forwardDelta <= 90
        let strongSequentialMatch = best >= max(6, min(24, spokenSignalCount / 2)) && forwardDelta <= 180
        let strongRecoveryAnchor = recoveryMatch.isStrongForImmediateCatchUp
            && best >= recoveryResult
            && forwardDelta <= 1200

        let immediateThreeWordAnchor = recoveryMatch.matchedWordCount >= 3
            && best >= recoveryResult

        if immediateThreeWordAnchor {
            let anchorCandidate = min(matchStartOffset + recoveryResult, sourceText.count)
            if anchorCandidate > recognizedCharCount {
                recognizedCharCount = anchorCandidate
                recentMatchPositions = [anchorCandidate]
                return
            }
        }

        if confirmed || shortStep || anchoredPartial || strongSequentialMatch || strongRecoveryAnchor {
            recognizedCharCount = candidate
        }
    }

    private func bestRecoveryAnchorMatch(spoken: String) -> RecoveryAnchorResult {
        [
            immediateThreeWordAnchorMatch(spoken: spoken),
            recoveryAnchorMatch(spoken: spoken),
            windowedAnchorMatch(spoken: spoken),
            normalizedPhraseAnchorMatch(spoken: spoken)
        ].reduce(.none, betterRecoveryAnchor)
    }

    private func betterRecoveryAnchor(_ current: RecoveryAnchorResult, _ next: RecoveryAnchorResult) -> RecoveryAnchorResult {
        guard next.isUsable else { return current }
        guard current.isUsable else { return next }

        if next.score != current.score {
            return next.score > current.score ? next : current
        }

        return next.endOffset > current.endOffset ? next : current
    }

    private func immediateThreeWordAnchorMatch(spoken: String) -> RecoveryAnchorResult {
        let remainingSource = String(sourceText.dropFirst(matchStartOffset))
        guard let match = SpeechTrackingMatcher.immediateThreeWordAnchor(in: remainingSource, spoken: spoken) else {
            return .none
        }

        return RecoveryAnchorResult(
            endOffset: match.endOffset,
            score: match.score,
            matchedWordCount: match.matchedWordCount,
            matchedSignalCount: match.matchedSignalCount,
            exactMatchCount: match.exactMatchCount,
            sourceStart: match.sourceStart,
            spokenStart: match.spokenStart,
            isPhraseMatch: false
        )
    }

    private func selectBestMatch(charResult: Int, wordResult: Int, recoveryResult: Int, spokenSignalCount: Int) -> Int {
        let anchoredWordResult = max(wordResult, recoveryResult)
        if charResult == 0 { return anchoredWordResult }
        if anchoredWordResult == 0 { return charResult }

        let tolerance = max(20, min(60, spokenSignalCount * 2))
        if abs(charResult - anchoredWordResult) <= tolerance {
            return max(charResult, anchoredWordResult)
        }

        // If word-level matching found substantially more progress, keep it
        // when it has enough spoken evidence or a recovery anchor.
        if anchoredWordResult > charResult {
            let hasRecoveryAnchor = recoveryResult > 0 && anchoredWordResult >= recoveryResult
            if hasRecoveryAnchor || anchoredWordResult >= max(6, spokenSignalCount / 3) {
                return anchoredWordResult
            }
        }

        // Paraformer zh-en often emits Chinese as a continuous phrase while
        // the prompt is displayed as CJK character tokens. If char-level is
        // ahead by more than the word matcher, keep that stronger anchor.
        if charResult > anchoredWordResult && charResult >= 2 {
            return charResult
        }

        return min(charResult, anchoredWordResult)
    }

    private func charLevelMatch(spoken: String) -> Int {
        let remainingSource = String(sourceText.dropFirst(matchStartOffset))
        // Use Character arrays (not unicodeScalars) so counts match sourceText.count
        let src = Array(remainingSource.lowercased())
        let spk = Array(Self.normalize(spoken))

        var si = 0
        var ri = 0
        var lastGoodOrigIndex = 0

        while si < src.count && ri < spk.count {
            let sc = src[si]
            let rc = spk[ri]

            // Skip non-alphanumeric in source
            if !sc.isLetter && !sc.isNumber {
                si += 1
                continue
            }
            // Skip non-alphanumeric in spoken
            if !rc.isLetter && !rc.isNumber {
                ri += 1
                continue
            }

            if sc == rc {
                si += 1
                ri += 1
                lastGoodOrigIndex = si
            } else {
                // Try to re-sync: look ahead in both strings
                var found = false

                // Skip up to 3 chars in spoken (STT inserted extra chars)
                let maxSkipR = min(3, spk.count - ri - 1)
                if maxSkipR >= 1 {
                    for skipR in 1...maxSkipR {
                        let nextRI = ri + skipR
                        if nextRI < spk.count && spk[nextRI] == sc {
                            ri = nextRI
                            found = true
                            break
                        }
                    }
                }
                if found { continue }

                // Skip up to 3 chars in source (STT missed some chars)
                let maxSkipS = min(3, src.count - si - 1)
                if maxSkipS >= 1 {
                    for skipS in 1...maxSkipS {
                        let nextSI = si + skipS
                        if nextSI < src.count && src[nextSI] == rc {
                            si = nextSI
                            found = true
                            break
                        }
                    }
                }
                if found { continue }

                // No resync found — advance spoken pointer only.
                // Do NOT advance lastGoodOrigIndex; this is a genuine mismatch,
                // not a confirmed match position.
                ri += 1
            }
        }

        return lastGoodOrigIndex
    }

    private static func isAnnotationWord(_ word: String) -> Bool {
        if word.hasPrefix("[") && word.hasSuffix("]") { return true }
        let stripped = word.filter { $0.isLetter || $0.isNumber }
        return stripped.isEmpty
    }

    private func wordLevelMatch(spoken: String) -> Int {
        let remainingSource = String(sourceText.dropFirst(matchStartOffset))
        let sourceWords = remainingSource.split(separator: " ").map { String($0) }
        let spokenWords = splitTextIntoWords(spoken.lowercased())

        var si = 0 // source word index
        var ri = 0 // spoken word index
        var matchedCharCount = 0

        while si < sourceWords.count && ri < spokenWords.count {
            // Auto-skip annotation words in source (brackets, emoji)
            if Self.isAnnotationWord(sourceWords[si]) {
                matchedCharCount += sourceWords[si].count
                if si < sourceWords.count - 1 { matchedCharCount += 1 }
                si += 1
                continue
            }

            let srcWord = sourceWords[si].lowercased()
                .filter { $0.isLetter || $0.isNumber }
            let spkWord = spokenWords[ri]
                .filter { $0.isLetter || $0.isNumber }

            if srcWord == spkWord || isFuzzyMatch(srcWord, spkWord) {
                // Count original chars including trailing punctuation
                matchedCharCount += sourceWords[si].count
                si += 1
                ri += 1
                // Add space separator only if there's a following word
                if si < sourceWords.count {
                    matchedCharCount += 1
                }
            } else {
                // Try skipping up to 3 spoken words (STT hallucinated words)
                var foundSpk = false
                let maxSpkSkip = min(3, spokenWords.count - ri - 1)
                for skip in 1...max(1, maxSpkSkip) where skip <= maxSpkSkip {
                    let nextSpk = spokenWords[ri + skip].filter { $0.isLetter || $0.isNumber }
                    if srcWord == nextSpk || isFuzzyMatch(srcWord, nextSpk) {
                        ri += skip
                        foundSpk = true
                        break
                    }
                }
                if foundSpk { continue }

                // Try skipping up to 3 source words (user read fast, STT missed words)
                var foundSrc = false
                let maxSrcSkip = min(3, sourceWords.count - si - 1)
                for skip in 1...max(1, maxSrcSkip) where skip <= maxSrcSkip {
                    let nextSrc = sourceWords[si + skip].lowercased().filter { $0.isLetter || $0.isNumber }
                    if nextSrc == spkWord || isFuzzyMatch(nextSrc, spkWord) {
                        // Add all skipped source words' char counts
                        for s in 0..<skip {
                            matchedCharCount += sourceWords[si + s].count + 1
                        }
                        si += skip
                        foundSrc = true
                        break
                    }
                }
                if foundSrc { continue }

                // Try treating current source word as punctuation-only and skip it
                if srcWord.isEmpty {
                    matchedCharCount += sourceWords[si].count
                    if si < sourceWords.count - 1 { matchedCharCount += 1 }
                    si += 1
                    continue
                }
                // No match, advance spoken
                ri += 1
            }
        }

        // Auto-skip trailing annotation words at end of source
        while si < sourceWords.count && Self.isAnnotationWord(sourceWords[si]) {
            matchedCharCount += sourceWords[si].count
            if si < sourceWords.count - 1 { matchedCharCount += 1 }
            si += 1
        }

        return matchedCharCount
    }

    private func recoveryAnchorMatch(spoken: String) -> RecoveryAnchorResult {
        let remainingSource = String(sourceText.dropFirst(matchStartOffset))
        let sourceWords = remainingSource.split(separator: " ").map { String($0) }
        let spokenWords = splitTextIntoWords(spoken.lowercased())
            .map { Self.normalizedToken($0) }
            .filter { !$0.isEmpty }

        guard sourceWords.count >= 2, spokenWords.count >= 2 else { return .none }

        let sourceTokens = sourceWords.enumerated().map { index, word -> (raw: String, normalized: String, endOffset: Int, isAnnotation: Bool) in
            let priorLength = sourceWords.prefix(index).reduce(0) { $0 + $1.count + 1 }
            return (
                raw: word,
                normalized: Self.normalizedToken(word),
                endOffset: priorLength + word.count,
                isAnnotation: Self.isAnnotationWord(word)
            )
        }

        let maxInitialSourceSkip = min(2, sourceTokens.count - 1)
        let maxInitialSpokenSkip = min(2, spokenWords.count - 1)
        var best: RecoveryAnchorResult = .none

        for sourceStart in 0...maxInitialSourceSkip {
            for spokenStart in 0...maxInitialSpokenSkip {
                var si = sourceStart
                var ri = spokenStart
                var consecutiveHits = 0
                var exactHits = 0
                var matchedSignal = 0
                var lastEndOffset = 0

                while si < sourceTokens.count && ri < spokenWords.count {
                    let src = sourceTokens[si]
                    if src.isAnnotation || src.normalized.isEmpty {
                        lastEndOffset = src.endOffset
                        si += 1
                        continue
                    }

                    let spk = spokenWords[ri]
                    let exact = src.normalized == spk
                    guard exact || isFuzzyMatch(src.normalized, spk) else {
                        break
                    }

                    consecutiveHits += 1
                    exactHits += exact ? 1 : 0
                    matchedSignal += max(src.normalized.count, spk.count)
                    lastEndOffset = src.endOffset
                    si += 1
                    ri += 1

                    if consecutiveHits >= 2 {
                        let candidate = RecoveryAnchorResult(
                            endOffset: lastEndOffset,
                            score: consecutiveHits * 120 + exactHits * 24 + matchedSignal * 4 - sourceStart * 4 - spokenStart,
                            matchedWordCount: consecutiveHits,
                            matchedSignalCount: matchedSignal,
                            exactMatchCount: exactHits,
                            sourceStart: sourceStart,
                            spokenStart: spokenStart,
                            isPhraseMatch: false
                        )
                        best = betterRecoveryAnchor(best, candidate)
                    }
                }
            }
        }

        return best
    }

    private func windowedAnchorMatch(spoken: String) -> RecoveryAnchorResult {
        let remainingSource = String(sourceText.dropFirst(matchStartOffset))
        let sourceWords = remainingSource.split(separator: " ").map { String($0) }
        let spokenWords = splitTextIntoWords(spoken.lowercased())
            .map { Self.normalizedToken($0) }
            .filter { !$0.isEmpty }

        guard sourceWords.count >= 2, spokenWords.count >= 2 else { return .none }

        let sourceTokens = buildSourceTokens(from: sourceWords)
        let maxSourceStart = min(sourceTokens.count - 1, 80)
        let maxSpokenStart = min(spokenWords.count - 1, 10)
        var best: RecoveryAnchorResult = .none

        for sourceStart in 0...maxSourceStart {
            for spokenStart in 0...maxSpokenStart {
                var si = sourceStart
                var ri = spokenStart
                var hits = 0
                var exactHits = 0
                var matchedSignal = 0
                var lastEndOffset = 0

                while si < sourceTokens.count && ri < spokenWords.count {
                    let src = sourceTokens[si]
                    if src.isAnnotation || src.normalized.isEmpty {
                        lastEndOffset = src.endOffset
                        si += 1
                        continue
                    }

                    let spk = spokenWords[ri]
                    let exact = src.normalized == spk
                    guard exact || isFuzzyMatch(src.normalized, spk) else {
                        break
                    }

                    hits += 1
                    exactHits += exact ? 1 : 0
                    matchedSignal += max(src.normalized.count, spk.count)
                    lastEndOffset = src.endOffset
                    si += 1
                    ri += 1
                }

                let enoughForCJK = hits >= 3 || (hits >= 2 && sourceStart <= 8)
                let enoughForWords = hits >= 2 && matchedSignal >= 4
                guard enoughForCJK || enoughForWords else { continue }

                let candidate = RecoveryAnchorResult(
                    endOffset: lastEndOffset,
                    score: hits * 100 + exactHits * 20 + matchedSignal * 4 - sourceStart * 2 - spokenStart,
                    matchedWordCount: hits,
                    matchedSignalCount: matchedSignal,
                    exactMatchCount: exactHits,
                    sourceStart: sourceStart,
                    spokenStart: spokenStart,
                    isPhraseMatch: false
                )
                best = betterRecoveryAnchor(best, candidate)
            }
        }

        return best
    }

    private func normalizedPhraseAnchorMatch(spoken: String) -> RecoveryAnchorResult {
        let spokenChars = Array(Self.normalizedSignal(spoken))
        guard spokenChars.count >= 4 else { return .none }

        let remainingSource = String(sourceText.dropFirst(matchStartOffset))
        let sourceChars = Array(remainingSource.lowercased()).enumerated().compactMap { index, char -> (char: Character, endOffset: Int)? in
            guard char.isLetter || char.isNumber else { return nil }
            return (char: char, endOffset: index + 1)
        }
        guard sourceChars.count >= 4 else { return .none }

        let maxSourceStart = min(sourceChars.count - 1, 1200)
        let maxSpokenStart = min(spokenChars.count - 1, 80)
        let minRunLength = spokenChars.count >= 12 ? 6 : 4
        var best: RecoveryAnchorResult = .none

        for sourceStart in 0...maxSourceStart {
            for spokenStart in 0...maxSpokenStart {
                var runLength = 0
                while sourceStart + runLength < sourceChars.count,
                      spokenStart + runLength < spokenChars.count,
                      sourceChars[sourceStart + runLength].char == spokenChars[spokenStart + runLength] {
                    runLength += 1
                }

                guard runLength >= minRunLength else { continue }
                let endOffset = sourceChars[sourceStart + runLength - 1].endOffset
                let candidate = RecoveryAnchorResult(
                    endOffset: endOffset,
                    score: runLength * 100 - sourceStart * 2 - spokenStart,
                    matchedWordCount: 0,
                    matchedSignalCount: runLength,
                    exactMatchCount: 0,
                    sourceStart: sourceStart,
                    spokenStart: spokenStart,
                    isPhraseMatch: true
                )
                best = betterRecoveryAnchor(best, candidate)
            }
        }

        return best
    }

    private func buildSourceTokens(from words: [String]) -> [(normalized: String, endOffset: Int, isAnnotation: Bool)] {
        var tokens: [(normalized: String, endOffset: Int, isAnnotation: Bool)] = []
        var offset = 0
        for word in words {
            let endOffset = offset + word.count
            tokens.append((
                normalized: Self.normalizedToken(word),
                endOffset: endOffset,
                isAnnotation: Self.isAnnotationWord(word)
            ))
            offset = endOffset + 1
        }
        return tokens
    }

    private func isFuzzyMatch(_ a: String, _ b: String) -> Bool {
        if a.isEmpty || b.isEmpty { return false }
        // Exact match
        if a == b { return true }
        let shorter = min(a.count, b.count)
        // Prefix match — only for words with at least 3 chars to avoid
        // false positives like "or" matching "organization"
        if shorter >= 3 && (a.hasPrefix(b) || b.hasPrefix(a)) { return true }
        // Shared prefix >= 60% of shorter word (min 3 chars shared)
        let shared = zip(a, b).prefix(while: { $0 == $1 }).count
        if shorter >= 3 && shared >= max(3, shorter * 3 / 5) { return true }
        // Edit distance tolerance — stricter for very short words
        let dist = editDistance(a, b)
        if shorter <= 2 { return false } // 2-char words must be exact
        if shorter <= 4 { return dist <= 1 }
        if shorter <= 8 { return dist <= 2 }
        return dist <= max(a.count, b.count) / 3
    }

    private func editDistance(_ a: String, _ b: String) -> Int {
        let a = Array(a), b = Array(b)
        var dp = Array(0...b.count)
        for i in 1...a.count {
            var prev = dp[0]
            dp[0] = i
            for j in 1...b.count {
                let temp = dp[j]
                dp[j] = a[i-1] == b[j-1] ? prev : min(prev, dp[j], dp[j-1]) + 1
                prev = temp
            }
        }
        return dp[b.count]
    }

    private static func normalize(_ text: String) -> String {
        text.lowercased()
            .filter { $0.isLetter || $0.isNumber || $0.isWhitespace }
    }

    private static func normalizedToken(_ text: String) -> String {
        text.lowercased()
            .filter { $0.isLetter || $0.isNumber }
    }

    private static func normalizedSignal(_ text: String) -> String {
        normalizedToken(text)
    }
}
