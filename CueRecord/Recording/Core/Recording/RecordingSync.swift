import CoreMedia
import Foundation

nonisolated enum AudioAlignmentDecision: Equatable, Sendable {
    case waitForVideo
    case dropBeforeVideo(overlap: CMTime)
    case append(relativeTo: CMTime, partialOverlap: CMTime)
}

nonisolated struct AudioStartGate: Sendable {
    static let defaultHoldLimit = CMTime(seconds: 0.5, preferredTimescale: 600)

    let holdLimit: CMTime

    init(holdLimit: CMTime = AudioStartGate.defaultHoldLimit) {
        self.holdLimit = holdLimit
    }

    func decision(
        audioStart: CMTime,
        audioDuration: CMTime?,
        firstVideoStart: CMTime?
    ) -> AudioAlignmentDecision {
        guard let firstVideoStart else {
            return .waitForVideo
        }

        guard audioStart.isValid, firstVideoStart.isValid else {
            return .append(relativeTo: firstVideoStart, partialOverlap: .zero)
        }

        if audioStart >= firstVideoStart {
            return .append(relativeTo: firstVideoStart, partialOverlap: .zero)
        }

        let duration = validDuration(audioDuration)
        let audioEnd = duration.map { audioStart + $0 } ?? audioStart
        guard audioEnd > firstVideoStart else {
            return .dropBeforeVideo(overlap: .zero)
        }

        let leadingOverlap = firstVideoStart - audioStart
        return .append(relativeTo: firstVideoStart, partialOverlap: max(.zero, leadingOverlap))
    }

    func shouldKeepPendingAudio(
        newestAudioStart: CMTime,
        oldestAudioStart: CMTime
    ) -> Bool {
        guard newestAudioStart.isValid, oldestAudioStart.isValid else { return true }
        return newestAudioStart - oldestAudioStart <= holdLimit
    }

    private func validDuration(_ duration: CMTime?) -> CMTime? {
        guard let duration, duration.isValid, duration > .zero else { return nil }
        return duration
    }
}

nonisolated struct BoundedDropOldestBuffer<Element> {
    private(set) var elements: [Element] = []
    let capacity: Int
    private(set) var droppedCount = 0

    init(capacity: Int) {
        self.capacity = max(1, capacity)
    }

    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }

    mutating func append(_ element: Element) {
        if elements.count >= capacity {
            elements.removeFirst()
            droppedCount += 1
        }
        elements.append(element)
    }

    mutating func removeAll() -> [Element] {
        let current = elements
        elements.removeAll(keepingCapacity: true)
        return current
    }

    mutating func removeLast() -> Element? {
        elements.popLast()
    }

    mutating func clear() {
        elements.removeAll(keepingCapacity: true)
    }
}
