import CoreMedia
import CoreGraphics
import CoreVideo
import Foundation

nonisolated struct CameraFrameSample {
    let pixelBuffer: CVPixelBuffer
    let timestamp: CMTime
    let sequence: UInt64
}

@MainActor
final class CameraFrameBuffer {
    private var queue = BoundedDropOldestBuffer<CameraFrameSample>(capacity: 8)
    private(set) var latestFrame: CameraFrameSample?
    private(set) var receivedCount: UInt64 = 0
    private(set) var deliveredCount: UInt64 = 0
    private var skippedPendingCount = 0

    var droppedCount: Int {
        queue.droppedCount + skippedPendingCount
    }

    var currentPixelBuffer: CVPixelBuffer? {
        latestFrame?.pixelBuffer
    }

    var currentAspectRatio: CGFloat? {
        guard let pixelBuffer = latestFrame?.pixelBuffer else { return nil }
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        guard width > 0, height > 0 else { return nil }
        return CGFloat(width) / CGFloat(height)
    }

    @discardableResult
    func push(pixelBuffer: CVPixelBuffer, timestamp: CMTime, enqueue: Bool = true) -> CameraFrameSample {
        receivedCount += 1
        let fallbackTimestamp = CMTime(value: CMTimeValue(receivedCount), timescale: 30)
        let frame = CameraFrameSample(
            pixelBuffer: pixelBuffer,
            timestamp: timestamp.isValid ? timestamp : fallbackTimestamp,
            sequence: receivedCount
        )
        latestFrame = frame
        if enqueue {
            queue.append(frame)
        }
        return frame
    }

    func dequeueLatest() -> CameraFrameSample? {
        let pending = queue.removeAll()
        guard let frame = pending.last else { return nil }
        skippedPendingCount += max(0, pending.count - 1)
        deliveredCount += 1
        return frame
    }

    func clear() {
        queue.clear()
        latestFrame = nil
        receivedCount = 0
        deliveredCount = 0
        skippedPendingCount = 0
    }
}
