//
//  MarqueeTextView.swift
//  CueRecord
//
//

import SwiftUI

// MARK: - Data

enum TeleprompterWordPace {
    case normal
    case fast
    case slow
}

struct WordItem: Identifiable {
    let id: Int
    let word: String
    let displayText: String
    let charOffset: Int // char offset of this word in the full text (counting spaces)
    let isAnnotation: Bool // true for [bracket] words and emoji-only words
    let isLineBreak: Bool
    let isCueDirective: Bool
    let isFastCue: Bool
    let isSlowCue: Bool
    let pace: TeleprompterWordPace
}

// MARK: - Preference key to report word Y positions

struct WordYPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

// MARK: - Teleprompter

enum TeleprompterLineAnchor {
    case center
    case top
}

struct SpeechScrollView: View {
    let words: [String]
    let highlightedCharCount: Int
    var font: NSFont = .systemFont(ofSize: 18, weight: .semibold)
    var highlightColor: Color = .white
    var cueColor: Color = .white
    var cueUnreadOpacity: Double = 0.2
    var cueReadOpacity: Double = 0.5
    var onWordTap: ((Int) -> Void)? = nil
    /// Called when user starts/stops manual scrolling in smooth mode.
    /// Bool: true = scrolling started (pause timer), false = scrolling ended (resume timer).
    /// Double: new word progress to resume from (only meaningful when false).
    var onManualScroll: ((Bool, Double) -> Void)? = nil
    var smoothScroll: Bool = false
    /// Continuous word progress (e.g. 3.7 = 70% through 4th word). Drives scroll in smooth mode.
    var smoothWordProgress: Double = 0
    var lineAnchor: TeleprompterLineAnchor = .center

    var isListening: Bool = true
    @State private var scrollOffset: CGFloat = 0
    @State private var manualOffset: CGFloat = 0
    @State private var wordYPositions: [Int: CGFloat] = [:]
    @State private var containerHeight: CGFloat = 0
    @State private var isUserScrolling: Bool = false

    var body: some View {
        GeometryReader { geo in
            WordFlowLayout(
                words: words,
                highlightedCharCount: highlightedCharCount,
                font: font,
                highlightColor: highlightColor,
                cueColor: cueColor,
                cueUnreadOpacity: cueUnreadOpacity,
                cueReadOpacity: cueReadOpacity,
                highlightWords: !smoothScroll,
                containerWidth: geo.size.width,
                onWordTap: { charOffset in
                    manualOffset = 0
                    onWordTap?(charOffset)
                    // Force recenter on tapped word
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        recalcCenter(containerHeight: containerHeight)
                    }
                },
                scrollOffset: scrollOffset + manualOffset,
                viewportHeight: geo.size.height
            )
            .onPreferenceChange(WordYPreferenceKey.self) { positions in
                let wasEmpty = wordYPositions.isEmpty
                wordYPositions = positions
                // After a page switch, wordYPositions was cleared — recenter once new positions arrive
                if wasEmpty && !positions.isEmpty {
                    recalcCenter(containerHeight: containerHeight)
                }
            }
            .offset(y: scrollOffset + manualOffset)
            .animation(smoothScroll ? .linear(duration: 0.06) : .easeOut(duration: 0.5), value: scrollOffset)
            .animation(.easeOut(duration: 0.15), value: manualOffset)
            .onChange(of: geo.size.height) { _, newHeight in
                containerHeight = newHeight
                if highlightedCharCount == 0 && smoothWordProgress == 0 {
                    scrollOffset = initialScrollOffset(containerHeight: newHeight)
                } else if isListening {
                    recalcCenter(containerHeight: newHeight)
                }
            }
            .onChange(of: highlightedCharCount) { _, _ in
                if isListening && !smoothScroll {
                    manualOffset = 0
                    recalcCenter(containerHeight: containerHeight)
                }
            }
            .onChange(of: smoothWordProgress) { _, _ in
                if isListening && smoothScroll {
                    manualOffset = 0
                    recalcCenter(containerHeight: containerHeight)
                }
            }
            .onChange(of: isListening) { _, listening in
                if listening {
                    manualOffset = 0
                    recalcCenter(containerHeight: containerHeight)
                }
            }
            .onChange(of: words) { _, _ in
                scrollOffset = initialScrollOffset(containerHeight: containerHeight)
                manualOffset = 0
                wordYPositions = [:]
            }
            .onAppear {
                containerHeight = geo.size.height
                scrollOffset = initialScrollOffset(containerHeight: containerHeight)
            }
            .overlay(
                ScrollWheelView(
                    onScroll: { delta in
                        let canScroll = smoothScroll ? isListening : !isListening
                        guard canScroll else { return }

                        // Pause timer when user starts scrolling in smooth mode
                        if smoothScroll && !isUserScrolling {
                            isUserScrolling = true
                            onManualScroll?(true, 0)
                        }

                        let maxY = wordYPositions.values.max() ?? 0
                        let containerHeight = geo.size.height
                        let maxUp = containerHeight * 0.5
                        let maxDown = max(0, maxY - containerHeight * 0.5)

                        let newOffset = manualOffset + delta
                        let upperBound = maxUp
                        let lowerBound = -maxDown

                        if newOffset > upperBound {
                            let over = newOffset - upperBound
                            manualOffset = upperBound + over * 0.2
                        } else if newOffset < lowerBound {
                            let over = lowerBound - newOffset
                            manualOffset = lowerBound - over * 0.2
                        } else {
                            manualOffset = newOffset
                        }
                    },
                    onScrollEnd: {
                        if smoothScroll && isUserScrolling {
                            // Find the word at the new visual center
                            let newProgress = wordProgressAtCurrentOffset()
                            withAnimation(.easeOut(duration: 0.15)) {
                                manualOffset = 0
                            }
                            isUserScrolling = false
                            onManualScroll?(false, newProgress)
                        } else {
                            let maxY = wordYPositions.values.max() ?? 0
                            let containerHeight = geo.size.height
                            let upperBound = containerHeight * 0.5
                            let lowerBound = -max(0, maxY - containerHeight * 0.5)

                            if manualOffset > upperBound || manualOffset < lowerBound {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    manualOffset = min(upperBound, max(lowerBound, manualOffset))
                                }
                            }
                        }
                    }
                )
            )
        }
        .clipped()
        .mask(
            LinearGradient(
                stops: [
                    .init(color: .clear, location: 0),
                    .init(color: .white, location: 0.05),
                    .init(color: .white, location: 0.95),
                    .init(color: .clear, location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }

    private var estimatedLineHeight: CGFloat {
        font.pointSize * 1.4
    }

    private func targetLineY(containerHeight: CGFloat) -> CGFloat {
        switch lineAnchor {
        case .center:
            return containerHeight * 0.5
        case .top:
            return estimatedLineHeight * 1.5
        }
    }

    private func initialScrollOffset(containerHeight: CGFloat) -> CGFloat {
        targetLineY(containerHeight: containerHeight) - estimatedLineHeight * 0.5
    }

    private func recalcCenter(containerHeight: CGFloat) {
        if smoothScroll {
            let anchorY = smoothReadLineY(containerHeight: containerHeight)
            let wordIdx = Int(smoothWordProgress)
            let fraction = smoothWordProgress - Double(wordIdx)
            let clampedIdx = max(0, min(wordIdx, words.count - 1))
            guard let wordY = wordYPositions[clampedIdx] else { return }
            let nextY = wordYPositions[clampedIdx + 1] ?? wordY
            let interpolatedY = wordY + (nextY - wordY) * CGFloat(fraction)
            scrollOffset = anchorY - interpolatedY
        } else {
            // Word-tracking/voice-activated: keep the active line at the configured read position.
            let wordIdx = activeWordIndex()
            if let wordY = wordYPositions[wordIdx] {
                let target = targetLineY(containerHeight: containerHeight) - wordY
                // Only update if it actually changed to avoid redundant animations
                if abs(scrollOffset - target) > 1 {
                    scrollOffset = target
                }
            }
        }
    }

    private func smoothReadLineY(containerHeight: CGFloat) -> CGFloat {
        switch lineAnchor {
        case .center:
            return containerHeight - 20
        case .top:
            return targetLineY(containerHeight: containerHeight)
        }
    }

    /// Find the word progress at the current visual position (scrollOffset + manualOffset)
    private func wordProgressAtCurrentOffset() -> Double {
        let readLineY = smoothScroll
            ? smoothReadLineY(containerHeight: containerHeight)
            : targetLineY(containerHeight: containerHeight)
        let targetY = readLineY - (scrollOffset + manualOffset)

        // Find the closest word and interpolate
        let sorted = wordYPositions.sorted { $0.key < $1.key }
        guard !sorted.isEmpty else { return smoothWordProgress }

        for i in 0..<sorted.count {
            let (wordIdx, wordY) = sorted[i]
            if i + 1 < sorted.count {
                let (_, nextY) = sorted[i + 1]
                if targetY >= wordY && targetY <= nextY {
                    let frac = (nextY - wordY) > 0 ? Double(targetY - wordY) / Double(nextY - wordY) : 0
                    return Double(wordIdx) + frac
                }
            } else if targetY >= wordY {
                return Double(wordIdx)
            }
        }
        // If scrolled above all words, return 0
        if targetY < (sorted.first?.value ?? 0) {
            return 0
        }
        return Double(words.count)
    }

    private func activeWordIndex() -> Int {
        var offset = 0
        for (i, word) in words.enumerated() {
            let end = offset + word.count
            if highlightedCharCount <= end { return i }
            offset = end + 1
        }
        return max(0, words.count - 1)
    }

    /// Returns (wordIndex, fractionThroughWord) for smooth interpolation
    private func activeWordFraction() -> (Int, Double) {
        var offset = 0
        for (i, word) in words.enumerated() {
            let end = offset + word.count
            if highlightedCharCount <= end {
                let wordLen = max(1, word.count)
                let into = highlightedCharCount - offset
                return (i, Double(into) / Double(wordLen))
            }
            offset = end + 1
        }
        return (max(0, words.count - 1), 1.0)
    }
}

// MARK: - Word Flow Layout

struct WordFlowLayout: View {
    let words: [String]
    let highlightedCharCount: Int
    let font: NSFont
    var highlightColor: Color = .white
    var cueColor: Color = .white
    var cueUnreadOpacity: Double = 0.2
    var cueReadOpacity: Double = 0.5
    var highlightWords: Bool = true
    let containerWidth: CGFloat
    var onWordTap: ((Int) -> Void)? = nil
    var scrollOffset: CGFloat = 0
    var viewportHeight: CGFloat = 0

    // Compute line spacing based on font metrics — fonts with large built-in
    // line height (e.g. OpenDyslexic) need less extra spacing
    private var lineSpacing: CGFloat {
        let intrinsicHeight = font.ascender - font.descender + font.leading
        let ratio = intrinsicHeight / font.pointSize
        // System fonts: ratio ~1.2, OpenDyslexic: ratio ~1.7+
        return ratio > 1.5 ? 2 : 8
    }

    private var fastPaceColor: Color {
        Color(red: 0.38, green: 0.68, blue: 1.0)
    }

    // Simple layout cache to avoid re-measuring words on every highlight update
    private static var _cacheKey: String = ""
    private static var _cachedItems: [WordItem] = []
    private static var _cachedLines: [[WordItem]] = []

    private func cachedLayout() -> ([WordItem], [[WordItem]]) {
        let key = "\(words.joined(separator: "\u{1F}"))|\(font.pointSize)|\(Int(containerWidth))"
        if key == Self._cacheKey {
            return (Self._cachedItems, Self._cachedLines)
        }
        let items = buildItems()
        let lines = buildLines(items: items)
        Self._cacheKey = key
        Self._cachedItems = items
        Self._cachedLines = lines
        return (items, lines)
    }

    // Find the index of the next word to read (first non-fully-lit, non-annotation word)
    private func nextWordIndex(items: [WordItem]) -> Int {
        for item in items {
            if item.isAnnotation || item.isLineBreak || item.isCueDirective { continue }
            let charsIntoWord = highlightedCharCount - item.charOffset
            let litCount = max(0, min(item.word.count, charsIntoWord))
            let letterCount = max(1, item.word.filter { $0.isLetter || $0.isNumber }.count)
            if litCount < letterCount {
                return item.id
            }
        }
        return -1
    }

    var body: some View {
        let (items, lines) = cachedLayout()
        let nextIdx = nextWordIndex(items: items)
        let totalLines = lines.count
        let centersMarkedBreathLines = words.contains(where: TeleprompterLineBreak.isMarkerBreakToken)
        let stackAlignment: HorizontalAlignment = centersMarkedBreathLines ? .center : .leading
        let rowAlignment: Alignment = centersMarkedBreathLines ? .center : .leading

        // Estimate line height for visibility culling using actual font metrics
        let lineH = ceil(font.ascender - font.descender + font.leading) + lineSpacing

        // Determine visible range of lines
        let canCull = viewportHeight > 0 && totalLines > 0
        let buffer: CGFloat = 400
        let startLine = canCull ? max(0, min(totalLines, Int(floor((-scrollOffset - buffer) / lineH)))) : 0
        let endLine = canCull ? max(startLine, min(totalLines, Int(ceil((viewportHeight - scrollOffset + buffer) / lineH)))) : totalLines

        VStack(alignment: stackAlignment, spacing: lineSpacing) {
            if startLine > 0 {
                Color.clear.frame(height: CGFloat(startLine) * lineH)
            }

            ForEach(startLine..<endLine, id: \.self) { lineIdx in
                HStack(spacing: 0) {
                    ForEach(lines[lineIdx], id: \.id) { item in
                        wordView(for: item, isNextWord: item.id == nextIdx)
                            .id(item.id)
                    }
                }
                .frame(maxWidth: .infinity, alignment: rowAlignment)
            }

            if endLine < totalLines {
                Color.clear.frame(height: CGFloat(totalLines - endLine) * lineH)
            }
        }
        .frame(maxWidth: .infinity, alignment: rowAlignment)
        .coordinateSpace(name: "flowLayout")
    }

    @ViewBuilder
    private func wordView(for item: WordItem, isNextWord: Bool) -> some View {
        let wordLen = item.word.count
        let charsIntoWord = highlightedCharCount - item.charOffset
        let litCount = max(0, min(wordLen, charsIntoWord))
        let letterCount = max(1, item.word.filter { $0.isLetter || $0.isNumber }.count)
        let isFullyLit = litCount >= letterCount
        let isCurrentWord = isNextWord || (charsIntoWord >= 0 && !isFullyLit)
        let displayText = item.displayText + " "
        let isSlow = item.pace == .slow
        let isFast = item.pace == .fast
        let slowTracking = isSlow ? max(1.5, font.pointSize * 0.08) : 0

        // When highlighting is off (classic/silence-paused), use uniform color
        if !highlightWords {
            Text(displayText)
                .font(displayFont(for: item))
                .foregroundStyle(uniformColor(for: item, isFast: isFast, isSlow: isSlow))
                .tracking(slowTracking)
                .background(
                    GeometryReader { wordGeo in
                        Color.clear.preference(
                            key: WordYPreferenceKey.self,
                            value: [item.id: wordGeo.frame(in: .named("flowLayout")).midY]
                        )
                    }
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    onWordTap?(item.charOffset)
                }
        } else if item.isFastCue {
            Text(displayText)
                .font(.system(size: max(11, font.pointSize * 0.72), weight: .bold, design: .rounded))
                .foregroundStyle(fastPaceColor.opacity(0.9))
                .padding(.trailing, 4)
        } else if item.isAnnotation {
            // Annotations: italic, dimmed with cue color
            let annotationColor: Color = isFullyLit
                ? cueColor.opacity(cueReadOpacity)
                : cueColor.opacity(cueUnreadOpacity)

            Text(displayText)
                .font(Font(font).italic())
                .foregroundStyle(annotationColor)
                .background(
                    GeometryReader { wordGeo in
                        Color.clear.preference(
                            key: WordYPreferenceKey.self,
                            value: [item.id: wordGeo.frame(in: .named("flowLayout")).midY]
                        )
                    }
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    onWordTap?(item.charOffset)
                }
        } else {
            // Dim color: highlight color variant for current word, full for unread
            let dimColor: Color = isCurrentWord
                ? highlightColor.opacity(0.6)
                : highlightColor

            // Base color for the whole word
            let wordColor: Color = isSlow
                ? (isFullyLit ? Color(red: 1.0, green: 0.78, blue: 0.35).opacity(0.38) : Color(red: 1.0, green: 0.78, blue: 0.35).opacity(isCurrentWord ? 0.78 : 0.95))
                : isFast
                    ? fastPaceColor.opacity(isFullyLit ? 0.38 : (isCurrentWord ? 0.78 : 0.95))
                    : (isFullyLit ? highlightColor.opacity(0.3) : dimColor)

            Text(displayText)
                .font(Font(font))
                .foregroundStyle(wordColor)
                .tracking(slowTracking)
                .underline(isCurrentWord, color: wordColor)
                .background(
                    GeometryReader { wordGeo in
                        Color.clear.preference(
                            key: WordYPreferenceKey.self,
                            value: [item.id: wordGeo.frame(in: .named("flowLayout")).midY]
                        )
                    }
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    onWordTap?(item.charOffset)
                }
        }
    }

    private func displayFont(for item: WordItem) -> Font {
        if item.isFastCue {
            return .system(size: max(11, font.pointSize * 0.72), weight: .bold, design: .rounded)
        }

        if item.isAnnotation {
            return Font(font).italic()
        }

        return Font(font)
    }

    private func uniformColor(for item: WordItem, isFast: Bool, isSlow: Bool) -> Color {
        if item.isFastCue {
            return fastPaceColor.opacity(0.85)
        }

        if isSlow {
            return Color(red: 1.0, green: 0.78, blue: 0.35).opacity(0.92)
        }

        if isFast {
            return fastPaceColor.opacity(0.92)
        }

        if item.isAnnotation {
            return cueColor.opacity(cueUnreadOpacity)
        }

        return highlightColor
    }

    private func buildItems() -> [WordItem] {
        var items: [WordItem] = []
        var offset = 0
        var pace: TeleprompterWordPace = .normal
        for (i, word) in words.enumerated() {
            let isLineBreak = TeleprompterLineBreak.isBreakToken(word)
            let isFastCue = TeleprompterPaceCue.isFastToken(word)
            let isSlowCue = TeleprompterPaceCue.isSlowToken(word)
            let isCueDirective = TeleprompterPaceCue.isCueToken(word)
            let isAnnotation = isLineBreak || isCueDirective || Self.isAnnotationWord(word)
            let displayText = isFastCue ? "››" : word

            if isLineBreak {
                pace = .normal
            }

            items.append(WordItem(
                id: i,
                word: word,
                displayText: displayText,
                charOffset: offset,
                isAnnotation: isAnnotation,
                isLineBreak: isLineBreak,
                isCueDirective: isCueDirective,
                isFastCue: isFastCue,
                isSlowCue: isSlowCue,
                pace: pace
            ))

            if isSlowCue {
                pace = .slow
            } else if isFastCue {
                pace = .fast
            }

            offset += word.count + 1 // +1 for space
        }
        return items
    }

    static func isAnnotationWord(_ word: String) -> Bool {
        // Words inside square brackets like [smile]
        if word.hasPrefix("[") && word.hasSuffix("]") { return true }
        // Emoji-only words (no letters or numbers)
        let stripped = word.filter { $0.isLetter || $0.isNumber }
        if stripped.isEmpty { return true }
        return false
    }

    private func buildLines(items: [WordItem]) -> [[WordItem]] {
        var lines: [[WordItem]] = [[]]
        var currentLineWidth: CGFloat = 0
        let spaceWidth = (" " as NSString).size(withAttributes: [.font: font]).width

        for item in items {
            if item.isSlowCue {
                continue
            }

            if item.isLineBreak {
                if !lines[lines.count - 1].isEmpty {
                    lines.append([])
                    currentLineWidth = 0
                }
                continue
            }

            if item.isFastCue, !lines[lines.count - 1].isEmpty {
                lines.append([])
                currentLineWidth = 0
            }

            let tracking = item.pace == .slow ? max(1.5, font.pointSize * 0.08) : 0
            let displayWidth = (item.displayText as NSString).size(withAttributes: [.font: font]).width
            let trackingWidth = max(0, CGFloat(max(0, item.displayText.count - 1)) * tracking)
            let wordWidth = displayWidth + trackingWidth + spaceWidth
            if currentLineWidth + wordWidth > containerWidth && !lines[lines.count - 1].isEmpty {
                lines.append([])
                currentLineWidth = 0
            }
            lines[lines.count - 1].append(item)
            currentLineWidth += wordWidth
        }

        if lines.count > 1, lines.last?.isEmpty == true {
            lines.removeLast()
        }

        return lines
    }
}

// MARK: - Elapsed Time

struct ElapsedTimeView: View {
    let fontSize: CGFloat

    @State private var startDate = Date()

    var body: some View {
        TimelineView(.periodic(from: startDate, by: 1)) { context in
            let elapsed = context.date.timeIntervalSince(startDate)
            let minutes = Int(elapsed) / 60
            let seconds = Int(elapsed) % 60
            Text(String(format: "%02d:%02d", minutes, seconds))
                .font(.system(size: fontSize, weight: .medium, design: .monospaced))
                .foregroundStyle(.white.opacity(0.5))
        }
    }
}

// MARK: - Audio Waveform + Progress

struct AudioWaveformProgressView: View {
    let levels: [CGFloat]
    let progress: Double // 0.0 to 1.0

    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            ForEach(Array(levels.enumerated()), id: \.offset) { index, level in
                let barProgress = Double(index) / Double(max(1, levels.count - 1))
                let isLit = barProgress <= progress

                RoundedRectangle(cornerRadius: 1.5)
                    .fill(isLit
                          ? Color.yellow.opacity(0.9)
                          : Color.white.opacity(0.15)
                    )
                    .frame(width: 3, height: max(3, level * 28))
                    .animation(.easeOut(duration: 0.08), value: level)
            }
        }
    }
}

// Keep the old one for backward compat
struct AudioWaveformView: View {
    let levels: [CGFloat]
    var color: Color = .white

    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            ForEach(Array(levels.enumerated()), id: \.offset) { _, level in
                RoundedRectangle(cornerRadius: 1.5)
                    .fill(color.opacity(0.4 + Double(level) * 0.6))
                    .frame(width: 3, height: max(3, level * 28 + 3))
                    .animation(.easeOut(duration: 0.08), value: level)
            }
        }
    }
}

// MARK: - Scroll Wheel Handler

struct ScrollWheelView: NSViewRepresentable {
    var onScroll: (CGFloat) -> Void
    var onScrollEnd: (() -> Void)?

    init(onScroll: @escaping (CGFloat) -> Void, onScrollEnd: (() -> Void)? = nil) {
        self.onScroll = onScroll
        self.onScrollEnd = onScrollEnd
    }

    func makeNSView(context: Context) -> ScrollWheelNSView {
        let view = ScrollWheelNSView()
        view.onScroll = onScroll
        view.onScrollEnd = onScrollEnd
        return view
    }

    func updateNSView(_ nsView: ScrollWheelNSView, context: Context) {
        nsView.onScroll = onScroll
        nsView.onScrollEnd = onScrollEnd
    }
}

class ScrollWheelNSView: NSView {
    var onScroll: ((CGFloat) -> Void)?
    var onScrollEnd: (() -> Void)?
    private var scrollMonitor: Any?

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        if window != nil && scrollMonitor == nil {
            scrollMonitor = NSEvent.addLocalMonitorForEvents(matching: .scrollWheel) { [weak self] event in
                guard let self, let window = self.window else { return event }
                // Only handle if event is in our window
                if event.window == window {
                    let delta = event.scrollingDeltaY
                    let scaled = event.hasPreciseScrollingDeltas ? delta : delta * 10
                    self.onScroll?(scaled)

                    if event.phase == .ended || event.momentumPhase == .ended {
                        self.onScrollEnd?()
                    }
                }
                return event
            }
        }
    }

    override func removeFromSuperview() {
        if let monitor = scrollMonitor {
            NSEvent.removeMonitor(monitor)
            scrollMonitor = nil
        }
        super.removeFromSuperview()
    }

    override func hitTest(_ point: NSPoint) -> NSView? {
        return nil
    }
}
