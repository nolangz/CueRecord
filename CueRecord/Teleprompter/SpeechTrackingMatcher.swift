import Foundation

struct SpeechTrackingAnchorMatch: Equatable {
    let endOffset: Int
    let matchedWordCount: Int
    let matchedSignalCount: Int
    let exactMatchCount: Int
    let sourceStart: Int
    let spokenStart: Int

    var score: Int {
        matchedWordCount * 160 + exactMatchCount * 28 + matchedSignalCount * 4 - sourceStart * 2 - spokenStart
    }
}

enum SpeechTrackingMatcher {
    private nonisolated static let immediateAnchorWordCount = 3

    nonisolated static func immediateThreeWordAnchor(in sourceText: String, spoken: String) -> SpeechTrackingAnchorMatch? {
        let sourceWords = sourceText.split(separator: " ").map(String.init)
        let spokenWords = splitTextIntoWords(spoken.lowercased())
        return immediateThreeWordAnchor(sourceWords: sourceWords, spokenWords: spokenWords)
    }

    nonisolated static func immediateThreeWordAnchor(sourceWords: [String], spokenWords: [String]) -> SpeechTrackingAnchorMatch? {
        let sourceTokens = contentTokens(from: sourceWords)
        let spokenTokens = spokenWords
            .map(normalizedToken)
            .filter { !$0.isEmpty }

        guard sourceTokens.count >= immediateAnchorWordCount,
              spokenTokens.count >= immediateAnchorWordCount
        else {
            return nil
        }

        var best: SpeechTrackingAnchorMatch?
        let maxSourceStart = sourceTokens.count - immediateAnchorWordCount
        let maxSpokenStart = spokenTokens.count - immediateAnchorWordCount

        for sourceStart in 0...maxSourceStart {
            for spokenStart in 0...maxSpokenStart {
                var hits = 0
                var exactHits = 0
                var matchedSignal = 0

                while sourceStart + hits < sourceTokens.count,
                      spokenStart + hits < spokenTokens.count {
                    let sourceToken = sourceTokens[sourceStart + hits]
                    let spokenToken = spokenTokens[spokenStart + hits]
                    let exact = sourceToken.normalized == spokenToken

                    guard exact || isFuzzyMatch(sourceToken.normalized, spokenToken) else {
                        break
                    }

                    hits += 1
                    exactHits += exact ? 1 : 0
                    matchedSignal += max(sourceToken.normalized.count, spokenToken.count)
                }

                guard hits >= immediateAnchorWordCount else { continue }

                let endToken = sourceTokens[sourceStart + hits - 1]
                let candidate = SpeechTrackingAnchorMatch(
                    endOffset: endToken.endOffset,
                    matchedWordCount: hits,
                    matchedSignalCount: matchedSignal,
                    exactMatchCount: exactHits,
                    sourceStart: sourceStart,
                    spokenStart: spokenStart
                )
                best = betterAnchor(best, candidate)
            }
        }

        return best
    }

    private nonisolated static func contentTokens(from sourceWords: [String]) -> [(normalized: String, endOffset: Int)] {
        var tokens: [(normalized: String, endOffset: Int)] = []
        var offset = 0

        for word in sourceWords {
            let endOffset = offset + word.count
            let normalized = normalizedToken(word)
            if !normalized.isEmpty && !isAnnotationWord(word) {
                tokens.append((normalized: normalized, endOffset: endOffset))
            }
            offset = endOffset + 1
        }

        return tokens
    }

    private nonisolated static func betterAnchor(_ current: SpeechTrackingAnchorMatch?, _ next: SpeechTrackingAnchorMatch) -> SpeechTrackingAnchorMatch {
        guard let current else { return next }

        if next.matchedWordCount != current.matchedWordCount {
            return next.matchedWordCount > current.matchedWordCount ? next : current
        }

        if next.exactMatchCount != current.exactMatchCount {
            return next.exactMatchCount > current.exactMatchCount ? next : current
        }

        if next.matchedSignalCount != current.matchedSignalCount {
            return next.matchedSignalCount > current.matchedSignalCount ? next : current
        }

        if next.spokenStart != current.spokenStart {
            return next.spokenStart < current.spokenStart ? next : current
        }

        if next.sourceStart != current.sourceStart {
            return next.sourceStart < current.sourceStart ? next : current
        }

        return next.endOffset > current.endOffset ? next : current
    }

    private nonisolated static func isAnnotationWord(_ word: String) -> Bool {
        if TeleprompterLineBreak.isBreakToken(word) || TeleprompterPaceCue.isCueToken(word) {
            return true
        }

        if word.hasPrefix("[") && word.hasSuffix("]") {
            return true
        }

        let stripped = word.filter { $0.isLetter || $0.isNumber }
        return stripped.isEmpty
    }

    private nonisolated static func normalizedToken(_ text: String) -> String {
        text.lowercased()
            .filter { $0.isLetter || $0.isNumber }
    }

    private nonisolated static func isFuzzyMatch(_ a: String, _ b: String) -> Bool {
        if a.isEmpty || b.isEmpty { return false }
        if a == b { return true }

        let shorter = min(a.count, b.count)
        if shorter >= 3 && (a.hasPrefix(b) || b.hasPrefix(a)) {
            return true
        }

        let shared = zip(a, b).prefix(while: { $0 == $1 }).count
        if shorter >= 3 && shared >= max(3, shorter * 3 / 5) {
            return true
        }

        let distance = editDistance(a, b)
        if shorter <= 2 { return false }
        if shorter <= 4 { return distance <= 1 }
        if shorter <= 8 { return distance <= 2 }
        return distance <= max(a.count, b.count) / 3
    }

    private nonisolated static func editDistance(_ a: String, _ b: String) -> Int {
        let a = Array(a)
        let b = Array(b)
        var dp = Array(0...b.count)

        for i in 1...a.count {
            var previous = dp[0]
            dp[0] = i
            for j in 1...b.count {
                let temp = dp[j]
                dp[j] = a[i - 1] == b[j - 1] ? previous : min(previous, dp[j], dp[j - 1]) + 1
                previous = temp
            }
        }

        return dp[b.count]
    }
}
