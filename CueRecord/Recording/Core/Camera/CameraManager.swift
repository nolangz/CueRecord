import Foundation
import AVFoundation
import Combine
import CoreImage

struct CameraDevice: Identifiable, Hashable {
    let id: String
    let name: String
}

@MainActor
class CameraManager: NSObject, ObservableObject {
    @Published var isAvailable = false
    @Published var isCapturing = false
    @Published var availableCameras: [CameraDevice] = []
    @Published var selectedCameraID = ""
    
    // 采集会话相关状态：由后台(startCapture 的 nonisolated 执行器)与主线程(stopCapture)
    // 共同访问，故标记 nonisolated(unsafe) 并用 sessionLock 串行化关键区，避免数据竞争。
    // 关键修复(macOS 26 / Swift 6.3.2 运行时缺陷)：startCapture 不再是 @MainActor，
    // 其内部的 await(waitForFirstFrame/Task.sleep)发生在后台执行器上，主执行器永不
    // 跨 await 挂起，从根上避免主执行器引用被打乱后点 SwiftUI 按钮/下拉框崩溃。
    private nonisolated(unsafe) var captureSession: AVCaptureSession?
    private nonisolated(unsafe) var videoDevice: AVCaptureDevice?
    private nonisolated(unsafe) var videoInput: AVCaptureDeviceInput?
    private nonisolated(unsafe) var videoOutput: AVCaptureVideoDataOutput?
    private nonisolated let outputQueue = DispatchQueue(label: "cameraQueue", qos: .userInteractive)
    private nonisolated let sessionLock = NSLock()
    // 供 nonisolated 控制流读取的"是否正在采集"内部标志(与 @Published isCapturing 同步更新)。
    private nonisolated(unsafe) var isCapturingInternal = false

    private let frameBuffer = CameraFrameBuffer()
    private nonisolated(unsafe) var isStartingCapture = false
    private nonisolated let ciContext = CIContext()
    private var deviceObservers: [NSObjectProtocol] = []
    private var refreshWorkItem: DispatchWorkItem?
    private let frameRouter = CameraFrameRouter()
    private nonisolated(unsafe) var captureGeneration: UInt64 = 0
    private nonisolated(unsafe) var activeCameraID: String?
    private nonisolated static let firstFrameTimeout: TimeInterval = 4.0
    
    override init() {
        super.init()
        startCameraDeviceObservation()
        refreshCameraDevices()
    }

    deinit {
        for observer in deviceObservers {
            NotificationCenter.default.removeObserver(observer)
        }
        refreshWorkItem?.cancel()
    }

    // MARK: - 设备热插拔监听
    private func startCameraDeviceObservation() {
        let notificationCenter = NotificationCenter.default
        let queue = OperationQueue.main

        let connectedObserver = notificationCenter.addObserver(
            forName: AVCaptureDevice.wasConnectedNotification,
            object: nil,
            queue: queue
        ) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.scheduleCameraDeviceRefresh()
            }
        }

        let disconnectedObserver = notificationCenter.addObserver(
            forName: AVCaptureDevice.wasDisconnectedNotification,
            object: nil,
            queue: queue
        ) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.scheduleCameraDeviceRefresh()
            }
        }

        deviceObservers = [connectedObserver, disconnectedObserver]
        print("📷 已监听摄像头设备变化")
    }

    private func scheduleCameraDeviceRefresh() {
        refreshWorkItem?.cancel()

        let workItem = DispatchWorkItem { [weak self] in
            Task { @MainActor [weak self] in
                self?.handleCameraDevicesChanged()
            }
        }
        refreshWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: workItem)
    }

    private func handleCameraDevicesChanged() {
        let previousSelectedCameraID = selectedCameraID
        let wasCapturing = isCapturing

        refreshCameraDevices()

        guard wasCapturing, selectedCameraID != previousSelectedCameraID else { return }

        stopCapture()
        // Task.detached：在后台执行器上 await startCapture，主执行器不跨 await 挂起。
        Task.detached { [weak self] in
            guard let self else { return }
            let available = await MainActor.run { self.isAvailable }
            guard available else { return }
            do {
                try await self.startCapture()
            } catch {
                print("⚠️  摄像头热切换失败: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - 检查摄像头可用性
    func checkCameraAvailability() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        let hasCamera = !discoverCaptureDevices().isEmpty

        isAvailable = (authStatus == .authorized) && hasCamera
        print("📷 摄像头可用性: \(isAvailable) (权限: \(authStatus.rawValue), 设备: \(hasCamera))")
    }

    func refreshCameraDevices() {
        let devices = discoverCaptureDevices()
        availableCameras = devices.map { device in
            CameraDevice(id: device.uniqueID, name: device.localizedName)
        }

        if selectedCameraID.isEmpty || !availableCameras.contains(where: { $0.id == selectedCameraID }) {
            selectedCameraID = availableCameras.first?.id ?? ""
        }

        checkCameraAvailability()
        print("📷 找到 \(availableCameras.count) 个摄像头设备")
    }

    var selectedCameraName: String {
        availableCameras.first(where: { $0.id == selectedCameraID })?.name ?? "No cameras available"
    }
    
    // MARK: - 开始摄像头捕获
    // nonisolated：整段在后台执行器运行，await(waitForFirstFrame)不在主执行器上挂起。
    // AVCaptureSession 的配置/startRunning 本就建议放后台(startRunning 会阻塞)。
    nonisolated func startCapture() async throws {
        // 快照主线程 @Published 状态(同步闭包，主执行器不跨 await)
        let snapshot = await MainActor.run { () -> (available: Bool, selectedID: String) in
            (self.isAvailable, self.selectedCameraID)
        }
        guard snapshot.available else { return }

        guard let requestedDevice = selectedCaptureDevice(selectedID: snapshot.selectedID) else {
            throw CameraError.deviceNotFound
        }

        if isCapturingInternal || isStartingCapture {
            if activeCameraID == requestedDevice.uniqueID {
                let receivedFirstFrame = await waitForFirstFrame(
                    timeout: Self.firstFrameTimeout,
                    generation: captureGeneration
                )
                if !receivedFirstFrame {
                    throw CameraError.firstFrameTimeout
                }
                return
            }

            stopCapture()
        }

        let generation = nextCaptureGeneration()
        isStartingCapture = true
        defer {
            if captureGeneration == generation {
                isStartingCapture = false
            }
        }

        print("📷 启动摄像头捕获...")
        frameBuffer.clear()

        // 在本地变量上完成所有配置(尚未共享，无需加锁)；慢调用 startRunning() 放在锁外，
        // 避免主线程上的 stopCapture 因等待本锁而阻塞(否则会再次出现“转圈”)。
        let session = AVCaptureSession()
        session.beginConfiguration()

        if session.canSetSessionPreset(.high) {
            session.sessionPreset = .high
        }

        configureNativeFraming(for: requestedDevice)

        let input: AVCaptureDeviceInput
        do {
            input = try AVCaptureDeviceInput(device: requestedDevice)
        } catch {
            throw error
        }
        guard session.canAddInput(input) else {
            throw CameraError.cannotAddInput
        }
        session.addInput(input)

        let output = AVCaptureVideoDataOutput()
        output.alwaysDiscardsLateVideoFrames = true
        output.setSampleBufferDelegate(self, queue: outputQueue)
        output.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
        ]
        guard session.canAddOutput(output) else {
            throw CameraError.cannotAddOutput
        }
        session.addOutput(output)
        session.commitConfiguration()

        // 仅在锁内做指针赋值(快)，随后锁外 startRunning。
        sessionLock.lock()
        captureSession = session
        videoDevice = requestedDevice
        videoInput = input
        videoOutput = output
        activeCameraID = requestedDevice.uniqueID
        sessionLock.unlock()

        frameRouter.setActiveOutput(ObjectIdentifier(output))
        session.startRunning()

        guard captureGeneration == generation else {
            frameRouter.setActiveOutput(nil)
            session.stopRunning()
            return
        }

        isCapturingInternal = true
        await MainActor.run { self.isCapturing = true }

        let receivedFirstFrame = await waitForFirstFrame(timeout: Self.firstFrameTimeout, generation: generation)
        if !receivedFirstFrame {
            guard captureGeneration == generation else { return }
            stopCapture()
            throw CameraError.firstFrameTimeout
        }

        if #available(macOS 12.3, *) {
            print("📷 Center Stage active: \(requestedDevice.isCenterStageActive)")
        }
        print("✅ 摄像头捕获已启动: \(requestedDevice.localizedName)")
    }

    // MARK: - 停止摄像头捕获
    // nonisolated：可从主线程或 startCapture 的后台执行器调用；不含 await，
    // @Published 更新通过同步派发回主线程(主执行器不跨 await)。
    nonisolated func stopCapture() {
        print("📷 停止摄像头捕获...")

        _ = nextCaptureGeneration()
        frameRouter.setActiveOutput(nil)
        // 锁内仅取出并置空指针(快)，stopRunning 放锁外，避免与 startCapture 互相阻塞。
        sessionLock.lock()
        let sessionToStop = captureSession
        captureSession = nil
        videoDevice = nil
        videoInput = nil
        videoOutput = nil
        activeCameraID = nil
        sessionLock.unlock()
        sessionToStop?.stopRunning()
        frameBuffer.clear()

        isCapturingInternal = false
        isStartingCapture = false
        // @Published 更新派发到主执行器；闭包体为同步(无 await)，主执行器不跨 await 挂起，
        // 故不触发 macOS 26.5.1 的执行器打乱缺陷。绝不使用 MainActor.assumeIsolated。
        Task { @MainActor [weak self] in self?.isCapturing = false }
        print("✅ 摄像头捕获已停止")
    }

    private nonisolated func nextCaptureGeneration() -> UInt64 {
        sessionLock.lock(); defer { sessionLock.unlock() }
        captureGeneration &+= 1
        return captureGeneration
    }

    // MARK: - 获取当前摄像头画面
    func getCurrentFrame() -> CVPixelBuffer? {
        frameBuffer.currentPixelBuffer
    }

    func dequeueLatestFrame() -> CameraFrameSample? {
        frameBuffer.dequeueLatest()
    }

    nonisolated func setRecordingFrameHandler(_ handler: (@Sendable (CameraFrameSample) -> Void)?) {
        frameRouter.setHandler(handler)
    }

    var receivedFrameCount: UInt64 {
        frameBuffer.receivedCount
    }

    var droppedFrameCount: Int {
        frameBuffer.droppedCount
    }

    // nonisolated 计数访问器：供后台写盘队列上的 nonisolated 消费者读取，
    // frameBuffer 为 Sendable 的 nonisolated 类型，可安全跨线程读取。
    nonisolated var receivedFrameCountValue: UInt64 {
        frameBuffer.receivedCount
    }

    nonisolated var droppedFrameCountValue: Int {
        frameBuffer.droppedCount
    }

    var currentFrameAspectRatio: CGFloat? {
        frameBuffer.currentAspectRatio
    }

    private nonisolated func selectedCaptureDevice(selectedID: String) -> AVCaptureDevice? {
        let devices = discoverCaptureDevices()

        if let device = devices.first(where: { $0.uniqueID == selectedID }) {
            return device
        }

        return devices.first(where: { $0.position == .front }) ?? devices.first
    }

    private nonisolated func discoverCaptureDevices() -> [AVCaptureDevice] {
        let deviceTypes: [AVCaptureDevice.DeviceType]

        if #available(macOS 14.0, *) {
            deviceTypes = [.builtInWideAngleCamera, .external]
        } else {
            deviceTypes = [.builtInWideAngleCamera, .externalUnknown]
        }

        return AVCaptureDevice.DiscoverySession(
            deviceTypes: deviceTypes,
            mediaType: .video,
            position: .unspecified
        ).devices
    }

    private nonisolated func configureNativeFraming(for device: AVCaptureDevice) {
        if #available(macOS 12.3, *) {
            guard let bestFormat = preferredCenterStageFormat(for: device) else {
                print("📷 Center Stage not supported on selected camera")
                return
            }

            do {
                try device.lockForConfiguration()
                device.activeFormat = bestFormat.format

                if bestFormat.supports30FPS {
                    device.activeVideoMinFrameDuration = CMTime(value: 1, timescale: 30)
                    device.activeVideoMaxFrameDuration = CMTime(value: 1, timescale: 30)
                }

                device.unlockForConfiguration()
                print("📷 Using Center Stage camera format: \(bestFormat.width)x\(bestFormat.height)")
            } catch {
                print("⚠️  Center Stage camera format failed: \(error.localizedDescription)")
            }

            AVCaptureDevice.centerStageControlMode = .cooperative
            AVCaptureDevice.isCenterStageEnabled = true
            print("📷 Center Stage requested for camera framing")
        }
    }

    private nonisolated func waitForFirstFrame(timeout: TimeInterval, generation: UInt64) async -> Bool {
        let deadline = Date().addingTimeInterval(timeout)
        while Date() < deadline {
            guard captureGeneration == generation else { return false }
            if frameBuffer.currentPixelBuffer != nil {
                return true
            }
            try? await Task.sleep(nanoseconds: 66_000_000)
        }
        return captureGeneration == generation && frameBuffer.currentPixelBuffer != nil
    }

    @available(macOS 12.3, *)
    private nonisolated func preferredCenterStageFormat(for device: AVCaptureDevice) -> (format: AVCaptureDevice.Format, width: Int32, height: Int32, supports30FPS: Bool)? {
        let preferredAspectRatio: CGFloat = 16.0 / 9.0
        let targetPixels = 1920 * 1080

        let candidates = device.formats.compactMap { format -> (format: AVCaptureDevice.Format, width: Int32, height: Int32, aspectRatio: CGFloat, pixelCount: Int, supports30FPS: Bool)? in
            guard format.isCenterStageSupported else { return nil }

            let dimensions = CMVideoFormatDescriptionGetDimensions(format.formatDescription)
            guard dimensions.width > 0, dimensions.height > 0 else { return nil }

            let supports30FPS = format.videoSupportedFrameRateRanges.contains { range in
                range.minFrameRate <= 30 && range.maxFrameRate >= 30
            }

            return (
                format: format,
                width: dimensions.width,
                height: dimensions.height,
                aspectRatio: CGFloat(dimensions.width) / CGFloat(dimensions.height),
                pixelCount: Int(dimensions.width * dimensions.height),
                supports30FPS: supports30FPS
            )
        }

        return candidates.min { lhs, rhs in
            if lhs.supports30FPS != rhs.supports30FPS {
                return lhs.supports30FPS
            }

            let lhsAspectScore = abs(lhs.aspectRatio - preferredAspectRatio)
            let rhsAspectScore = abs(rhs.aspectRatio - preferredAspectRatio)

            if abs(lhsAspectScore - rhsAspectScore) > 0.01 {
                return lhsAspectScore < rhsAspectScore
            }

            let lhsResolutionScore = abs(lhs.pixelCount - targetPixels)
            let rhsResolutionScore = abs(rhs.pixelCount - targetPixels)
            return lhsResolutionScore < rhsResolutionScore
        }
        .map { candidate in
            (
                format: candidate.format,
                width: candidate.width,
                height: candidate.height,
                supports30FPS: candidate.supports30FPS
            )
        }
    }
    
    // MARK: - 创建圆形蒙版摄像头画面
    func createCircularCameraOverlay(size: CGSize) -> CIImage? {
        guard let pixelBuffer = frameBuffer.currentPixelBuffer else {
            print("⚠️  摄像头当前帧为空")
            return nil 
        }
        
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        // 计算缩放比例以适应目标尺寸
        let inputSize = ciImage.extent.size
        let scale = min(size.width / inputSize.width, size.height / inputSize.height)
        
        // 缩放图像
        let scaledImage = ciImage.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        
        // 创建圆形裁剪蒙版
        let radius = min(size.width, size.height) / 2
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        
        // 简化的圆形蒙版实现
        
        // 使用自定义圆形蒙版
        let maskImage = createCircularMask(size: size, center: center, radius: radius)
        
        // 应用蒙版
        let maskedImage = scaledImage.applyingFilter("CIBlendWithMask", parameters: [
            kCIInputMaskImageKey: maskImage
        ])
        
        // 添加白色边框
        let borderImage = createCircularBorder(size: size, center: center, radius: radius, borderWidth: 2.0)
        let finalImage = maskedImage.composited(over: borderImage)
        
        return finalImage
    }
    
    // MARK: - 创建圆形蒙版
    private func createCircularMask(size: CGSize, center: CGPoint, radius: CGFloat) -> CIImage {
        // 创建径向渐变作为蒙版
        guard let gradient = CIFilter(name: "CIRadialGradient") else {
            return CIImage.empty()
        }
        
        gradient.setValue(CIVector(x: center.x, y: center.y), forKey: "inputCenter")
        gradient.setValue(radius - 1, forKey: "inputRadius0")
        gradient.setValue(radius, forKey: "inputRadius1")
        gradient.setValue(CIColor.white, forKey: "inputColor0")
        gradient.setValue(CIColor.clear, forKey: "inputColor1")
        
        return gradient.outputImage?.cropped(to: CGRect(origin: .zero, size: size)) ?? CIImage.empty()
    }
    
    // MARK: - 创建圆形边框
    private func createCircularBorder(size: CGSize, center: CGPoint, radius: CGFloat, borderWidth: CGFloat) -> CIImage {
        // 简化边框实现 - 创建白色圆形背景
        guard let borderFilter = CIFilter(name: "CIRadialGradient") else {
            return CIImage.empty()
        }
        
        borderFilter.setValue(CIVector(x: center.x, y: center.y), forKey: "inputCenter")
        borderFilter.setValue(radius - borderWidth, forKey: "inputRadius0")
        borderFilter.setValue(radius, forKey: "inputRadius1")
        borderFilter.setValue(CIColor.white, forKey: "inputColor0")
        borderFilter.setValue(CIColor.clear, forKey: "inputColor1")
        
        return borderFilter.outputImage?.cropped(to: CGRect(origin: .zero, size: size)) ?? CIImage.empty()
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    nonisolated func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let timestamp = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)

        // 仅处理当前活动输出的帧（热切换时丢弃旧 session 的残帧）
        let routing = frameRouter.route(for: ObjectIdentifier(output))
        guard routing.isActive else { return }

        // 关键修复：直接在采集队列写入线程安全缓冲。
        // 预览阶段（无录制消费者）绝不每帧 Task{@MainActor}，避免持续向主执行器
        // 灌任务把 MainActor 执行器引用搞坏（接 Studio Display 后点任意按钮即崩溃）。
        let frame = frameBuffer.push(
            pixelBuffer: pixelBuffer,
            timestamp: timestamp,
            enqueue: routing.handler == nil
        )

        // 仅在真正录制时把帧交给录制消费者。关键修复：直接在采集队列上同步回调，
        // 既不创建并发 Task、也不用 DispatchQueue.main + MainActor.assumeIsolated。
        // 二者都会每帧调用 swift_task_isCurrentExecutor（macOS 26 / Swift 6 已知缺陷
        // 函数），高频敲打会冲坏主执行器追踪，导致之后任意 SwiftUI 按钮/下拉框点击
        // 崩溃。消费者(ScreenRecorder.appendCameraFrame)已改为 nonisolated，在自己的
        // 后台串行队列上写盘，无需跳主执行器。
        if let handler = routing.handler {
            handler(frame)
        }
    }
}

/// 采集回调（nonisolated，运行在采集队列）与录制消费者之间的线程安全路由。
/// 持有「当前活动输出」标识与录制帧回调，避免 nonisolated 回调直接读取
/// `@MainActor` 隔离的 CameraManager 属性而产生数据竞争。
nonisolated final class CameraFrameRouter: @unchecked Sendable {
    private let lock = NSLock()
    private var handler: (@Sendable (CameraFrameSample) -> Void)?
    private var activeOutputID: ObjectIdentifier?

    func setHandler(_ handler: (@Sendable (CameraFrameSample) -> Void)?) {
        lock.lock(); defer { lock.unlock() }
        self.handler = handler
    }

    func setActiveOutput(_ id: ObjectIdentifier?) {
        lock.lock(); defer { lock.unlock() }
        self.activeOutputID = id
    }

    func route(for outputID: ObjectIdentifier) -> (isActive: Bool, handler: (@Sendable (CameraFrameSample) -> Void)?) {
        lock.lock(); defer { lock.unlock() }
        guard activeOutputID == outputID else { return (false, nil) }
        return (true, handler)
    }
}

// MARK: - 错误类型
enum CameraError: Error, LocalizedError {
    case sessionCreationFailed
    case deviceNotFound
    case inputCreationFailed
    case outputCreationFailed
    case cannotAddInput
    case cannotAddOutput
    case permissionDenied
    case firstFrameTimeout
    
    var errorDescription: String? {
        switch self {
        case .sessionCreationFailed:
            return "Failed to create camera session"
        case .deviceNotFound:
            return "No camera device found"
        case .inputCreationFailed:
            return "Failed to create camera input"
        case .outputCreationFailed:
            return "Failed to create camera output"
        case .cannotAddInput:
            return "Could not add camera input"
        case .cannotAddOutput:
            return "Could not add camera output"
        case .permissionDenied:
            return "Camera permission denied"
        case .firstFrameTimeout:
            return "Camera did not deliver a video frame"
        }
    }
}
