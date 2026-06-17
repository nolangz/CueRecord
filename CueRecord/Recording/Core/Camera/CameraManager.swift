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
    
    private var captureSession: AVCaptureSession?
    private var videoDevice: AVCaptureDevice?
    private var videoInput: AVCaptureDeviceInput?
    private var videoOutput: AVCaptureVideoDataOutput?
    private var outputQueue = DispatchQueue(label: "cameraQueue", qos: .userInteractive)
    
    private let frameBuffer = CameraFrameBuffer()
    private var isStartingCapture = false
    private let ciContext = CIContext()
    private var deviceObservers: [NSObjectProtocol] = []
    private var refreshWorkItem: DispatchWorkItem?
    private var recordingFrameHandler: ((CameraFrameSample) -> Void)?
    private static let firstFrameTimeout: TimeInterval = 4.0
    
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
        Task { @MainActor [weak self] in
            guard let self, self.isAvailable else { return }
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
    func startCapture() async throws {
        guard isAvailable else { return }
        if isCapturing || isStartingCapture {
            let receivedFirstFrame = await waitForFirstFrame(timeout: Self.firstFrameTimeout)
            if !receivedFirstFrame {
                throw CameraError.firstFrameTimeout
            }
            return
        }

        isStartingCapture = true
        defer { isStartingCapture = false }
        
        print("📷 启动摄像头捕获...")
        frameBuffer.clear()
        
        // 创建捕获会话
        captureSession = AVCaptureSession()
        guard let session = captureSession else {
            throw CameraError.sessionCreationFailed
        }
        
        session.beginConfiguration()
        
        // 设置捕获质量
        if session.canSetSessionPreset(.high) {
            session.sessionPreset = .high
        }
        
        // 获取选中的摄像头
        videoDevice = selectedCaptureDevice()

        guard let device = videoDevice else {
            throw CameraError.deviceNotFound
        }

        configureNativeFraming(for: device)
        
        // 创建输入
        videoInput = try AVCaptureDeviceInput(device: device)
        guard let input = videoInput else {
            throw CameraError.inputCreationFailed
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        } else {
            throw CameraError.cannotAddInput
        }
        
        // 创建输出
        videoOutput = AVCaptureVideoDataOutput()
        guard let output = videoOutput else {
            throw CameraError.outputCreationFailed
        }
        
        output.setSampleBufferDelegate(self, queue: outputQueue)
        output.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
        ]
        
        if session.canAddOutput(output) {
            session.addOutput(output)
        } else {
            throw CameraError.cannotAddOutput
        }
        
        session.commitConfiguration()
        session.startRunning()
        
        isCapturing = true
        let receivedFirstFrame = await waitForFirstFrame(timeout: Self.firstFrameTimeout)
        if !receivedFirstFrame {
            stopCapture()
            throw CameraError.firstFrameTimeout
        }

        if #available(macOS 12.3, *) {
            print("📷 Center Stage active: \(device.isCenterStageActive)")
        }
        print("✅ 摄像头捕获已启动: \(device.localizedName)")
    }
    
    // MARK: - 停止摄像头捕获
    func stopCapture() {
        print("📷 停止摄像头捕获...")
        
        captureSession?.stopRunning()
        captureSession = nil
        videoDevice = nil
        videoInput = nil
        videoOutput = nil
        frameBuffer.clear()
        
        isCapturing = false
        print("✅ 摄像头捕获已停止")
    }
    
    // MARK: - 获取当前摄像头画面
    func getCurrentFrame() -> CVPixelBuffer? {
        frameBuffer.currentPixelBuffer
    }

    func dequeueLatestFrame() -> CameraFrameSample? {
        frameBuffer.dequeueLatest()
    }

    func setRecordingFrameHandler(_ handler: ((CameraFrameSample) -> Void)?) {
        recordingFrameHandler = handler
    }

    var receivedFrameCount: UInt64 {
        frameBuffer.receivedCount
    }

    var droppedFrameCount: Int {
        frameBuffer.droppedCount
    }

    var currentFrameAspectRatio: CGFloat? {
        frameBuffer.currentAspectRatio
    }

    private func selectedCaptureDevice() -> AVCaptureDevice? {
        let devices = discoverCaptureDevices()

        if let device = devices.first(where: { $0.uniqueID == selectedCameraID }) {
            return device
        }

        return devices.first(where: { $0.position == .front }) ?? devices.first
    }

    private func discoverCaptureDevices() -> [AVCaptureDevice] {
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

    private func configureNativeFraming(for device: AVCaptureDevice) {
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

    private func waitForFirstFrame(timeout: TimeInterval) async -> Bool {
        let deadline = Date().addingTimeInterval(timeout)
        while Date() < deadline {
            if frameBuffer.currentPixelBuffer != nil {
                return true
            }
            try? await Task.sleep(nanoseconds: 66_000_000)
        }
        return frameBuffer.currentPixelBuffer != nil
    }

    @available(macOS 12.3, *)
    private func preferredCenterStageFormat(for device: AVCaptureDevice) -> (format: AVCaptureDevice.Format, width: Int32, height: Int32, supports30FPS: Bool)? {
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
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let timestamp = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
        
        // 更新当前帧
        Task { @MainActor in
            let hasRecordingConsumer = recordingFrameHandler != nil
            let frame = frameBuffer.push(
                pixelBuffer: pixelBuffer,
                timestamp: timestamp,
                enqueue: !hasRecordingConsumer
            )
            recordingFrameHandler?(frame)
        }
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
