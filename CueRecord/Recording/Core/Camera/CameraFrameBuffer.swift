import CoreMedia
import CoreGraphics
import CoreVideo
import Foundation

// pixelBuffer 仅在采集→消费之间只读传递，不做并发写，故标记为 @unchecked Sendable，
// 以便帧可以安全地从采集队列交给主线程的录制回调。
nonisolated struct CameraFrameSample: @unchecked Sendable {
    let pixelBuffer: CVPixelBuffer
    let timestamp: CMTime
    let sequence: UInt64
}

/// 线程安全的摄像头帧缓冲。
///
/// 历史实现把它标成 `@MainActor`，导致采集回调每来一帧都得 `Task { @MainActor }`
/// 跳一次主执行器；接上 Studio Display（12MP + Center Stage，30fps+）后会持续
/// 向主执行器灌任务，最终把 MainActor 的执行器引用搞坏，之后任何按钮/下拉框
/// 触发 `MainActor.assumeIsolated` 都会崩溃。改为自带锁的 nonisolated 类后，
/// 预览阶段可直接在采集队列上写帧，无需跳主线程。
nonisolated final class CameraFrameBuffer: @unchecked Sendable {
    private let lock = NSLock()
    private var queue = BoundedDropOldestBuffer<CameraFrameSample>(capacity: 8)
    private var _latestFrame: CameraFrameSample?
    private var _receivedCount: UInt64 = 0
    private var _deliveredCount: UInt64 = 0
    private var _skippedPendingCount = 0

    var droppedCount: Int {
        lock.lock(); defer { lock.unlock() }
        return queue.droppedCount + _skippedPendingCount
    }

    var receivedCount: UInt64 {
        lock.lock(); defer { lock.unlock() }
        return _receivedCount
    }

    var deliveredCount: UInt64 {
        lock.lock(); defer { lock.unlock() }
        return _deliveredCount
    }

    var currentPixelBuffer: CVPixelBuffer? {
        lock.lock(); defer { lock.unlock() }
        return _latestFrame?.pixelBuffer
    }

    var currentAspectRatio: CGFloat? {
        lock.lock(); defer { lock.unlock() }
        guard let pixelBuffer = _latestFrame?.pixelBuffer else { return nil }
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        guard width > 0, height > 0 else { return nil }
        return CGFloat(width) / CGFloat(height)
    }

    @discardableResult
    func push(pixelBuffer: CVPixelBuffer, timestamp: CMTime, enqueue: Bool = true) -> CameraFrameSample {
        lock.lock(); defer { lock.unlock() }
        _receivedCount += 1
        let fallbackTimestamp = CMTime(value: CMTimeValue(_receivedCount), timescale: 30)
        let frame = CameraFrameSample(
            pixelBuffer: pixelBuffer,
            timestamp: timestamp.isValid ? timestamp : fallbackTimestamp,
            sequence: _receivedCount
        )
        _latestFrame = frame
        if enqueue {
            queue.append(frame)
        }
        return frame
    }

    func dequeueLatest() -> CameraFrameSample? {
        lock.lock(); defer { lock.unlock() }
        let pending = queue.removeAll()
        guard let frame = pending.last else { return nil }
        _skippedPendingCount += max(0, pending.count - 1)
        _deliveredCount += 1
        return frame
    }

    func clear() {
        lock.lock(); defer { lock.unlock() }
        queue.clear()
        _latestFrame = nil
        _receivedCount = 0
        _deliveredCount = 0
        _skippedPendingCount = 0
    }
}
