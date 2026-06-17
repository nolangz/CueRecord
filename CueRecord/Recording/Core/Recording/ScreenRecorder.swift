import Foundation
import AppKit
import AVFoundation
import Combine
import CoreGraphics
import CoreImage
import ScreenCaptureKit

private nonisolated struct CameraOverlayMetadataFile: Codable, Sendable {
    let version: Int
    let screenFile: String
    let cameraFile: String?
    let coordinateSpace: String
    let generatedAt: String
    let recordingMode: String
    let recordingRect: CodableRect?
    let samples: [CameraOverlayMetadataSample]
}

private nonisolated struct CameraOverlayMetadataSample: Codable, Sendable {
    let time: Double
    let frame: CodableRect
    let shape: String
    let size: String
}

private nonisolated struct ResolvedRecordingEditCut: Sendable {
    let cut: RecordingEditCut
    let startSeconds: Double
    let endSeconds: Double
    let outputStartSeconds: Double

    var duration: Double {
        max(0, endSeconds - startSeconds)
    }
}

private nonisolated struct CodableRect: Codable, Equatable, Sendable {
    let x: Double
    let y: Double
    let width: Double
    let height: Double

    init(_ rect: CGRect) {
        x = rect.origin.x
        y = rect.origin.y
        width = rect.width
        height = rect.height
    }

    var cgRect: CGRect {
        CGRect(x: x, y: y, width: width, height: height)
    }
}

private extension CGRect {
    var area: CGFloat {
        max(width, 0) * max(height, 0)
    }
}

private enum AudioType {
    case systemAudio
    case microphone
}

private struct PendingAudioSample {
    let sampleBuffer: CMSampleBuffer
    let type: AudioType
}

@MainActor
class ScreenRecorder: NSObject, ObservableObject {
    @Published var isRecording = false
    @Published var canRecord = false
    
    private var stream: SCStream?
    private var videoWriterInput: AVAssetWriterInput?
    private var videoWriter: AVAssetWriter?
    private var pixelBufferAdapter: AVAssetWriterInputPixelBufferAdaptor?

    // 音频录制组件
    private var audioWriterInput: AVAssetWriterInput?
    private var microphoneWriterInput: AVAssetWriterInput?  // macOS 15+ 独立麦克风轨道
    private var avAudioEngineRecorder: AVAudioEngineRecorder?  // AVAudioEngine录制器

    private var recordingStartTime: CMTime = .zero
    private var frameCount: Int64 = 0
    private var firstVideoFrameTime: CMTime?  // 记录第一帧视频的时间戳
    private let audioStartGate = AudioStartGate()
    private var pendingAudioBuffers: [PendingAudioSample] = []
    private let recordingMetrics = RecordingMetricsRecorder()
    private var screenCapturePixelFormat: OSType = kCVPixelFormatType_32BGRA
    
    // 录制配置
    private var outputURL: URL?
    private var recordingRect: CGRect?
    private var isFullScreen: Bool = true
    private var recordingModeName: String = "fullScreen"
    
    // 音频录制配置
    private var systemAudioEnabled: Bool = false
    private var microphoneEnabled: Bool = false
    private var microphoneDeviceID: String? = nil
    
    // 摄像头叠加层
    private let cameraManager = CameraManager()
    private var enableCameraOverlay = false
    private var cameraOverlayPosition: CameraOverlayPosition = .topRight
    private var cameraOverlaySize: CameraOverlaySize = .medium
    private var cameraOverlaySnapshotProvider: (() -> CameraOverlaySnapshot?)?

    // 独立摄像头视频轨
    private var cameraWriter: AVAssetWriter?
    private var cameraWriterInput: AVAssetWriterInput?
    private var cameraPixelBufferAdapter: AVAssetWriterInputPixelBufferAdaptor?
    private var cameraRecordingTask: Task<Void, Never>?
    private var cameraOutputURL: URL?
    private var overlayMetadataURL: URL?
    private var cameraOutputDimensions: (width: Int, height: Int)?
    private var cameraFrameCount: Int64 = 0
    private var postProcessingHandler: (@MainActor (RecordingPostProcessingEvent) -> Void)?
    private var cameraFirstFrameTime: CMTime?
    private var overlayMetadataStartTime: CMTime?
    private var lastCameraElapsedTime: Double?
    private var overlayMetadataSamples: [CameraOverlayMetadataSample] = []
    private let cameraCIContext = CIContext()

    private nonisolated static let screenTargetFrameRate = 60

    private nonisolated static func rec709VideoColorProperties() -> [String: Any] {
        [
            AVVideoTransferFunctionKey: AVVideoTransferFunction_ITU_R_709_2,
            AVVideoColorPrimariesKey: AVVideoColorPrimaries_ITU_R_709_2,
            AVVideoYCbCrMatrixKey: AVVideoYCbCrMatrix_ITU_R_709_2
        ]
    }

    private nonisolated static func evenPixelDimension(_ value: CGFloat) -> Int {
        max(2, Int(value.rounded(.toNearestOrAwayFromZero)) / 2 * 2)
    }
    
    override init() {
        super.init()
        checkCanRecord()
    }
    
    // MARK: - 权限和能力检查
    private func checkCanRecord() {
        Task {
            do {
                // 检查ScreenCaptureKit可用性和权限
                let availableContent = try await SCShareableContent.excludingDesktopWindows(false, onScreenWindowsOnly: true)
                canRecord = !availableContent.displays.isEmpty
                print("📺 ScreenCaptureKit 可用: \(canRecord)")
            } catch {
                canRecord = false
                print("❌ ScreenCaptureKit 检查失败: \(error)")
            }
        }
    }
    
    // MARK: - 设置摄像头叠加层
    func setCameraOverlay(enabled: Bool, position: CameraOverlayPosition, size: CameraOverlaySize) {
        enableCameraOverlay = enabled
        cameraOverlayPosition = position
        cameraOverlaySize = size
    }
    
    // MARK: - 获取摄像头管理器
    func getCameraManager() -> CameraManager {
        return cameraManager
    }

    func setCameraOverlaySnapshotProvider(_ provider: @escaping () -> CameraOverlaySnapshot?) {
        cameraOverlaySnapshotProvider = provider
    }
    
    // MARK: - 录制控制
    func startRecording(
        mode: RecordingMode, 
        outputURL: URL, 
        cameraOverlay: Bool = false, 
        cameraPosition: CameraOverlayPosition = .topRight, 
        cameraSize: CameraOverlaySize = .medium,
        systemAudioEnabled: Bool = false,
        microphoneEnabled: Bool = false,
        microphoneDeviceID: String? = nil,
        displayID: CGDirectDisplayID? = nil
    ) async throws {
        guard canRecord && !isRecording else {
            throw RecordingError.invalidState
        }
        
        print("🎬 开始屏幕录制...")

        do {
            self.outputURL = outputURL
            self.systemAudioEnabled = systemAudioEnabled
            self.microphoneEnabled = microphoneEnabled
            self.microphoneDeviceID = microphoneDeviceID
            pendingAudioBuffers.removeAll()
            frameCount = 0
            firstVideoFrameTime = nil
            setCameraOverlay(enabled: cameraOverlay, position: cameraPosition, size: cameraSize)

            // 启动摄像头（如果需要）
            if enableCameraOverlay {
                // 重新检查摄像头可用性（权限可能刚被授权）
                cameraManager.refreshCameraDevices()
                // 等待一下让权限状态更新
                try await Task.sleep(nanoseconds: 500_000_000) // 0.5秒
                try await cameraManager.startCapture()
            }

            switch mode {
            case .fullScreen:
                try await startFullScreenRecording(displayID: displayID)
            case .selectedArea(let rect):
                try await startAreaRecording(rect: rect)
            case .selectedWindow(let target):
                try await startWindowRecording(target: target)
            }
        } catch {
            await cleanupAfterFailedStart()
            throw error
        }
        
        isRecording = true
        print("✅ 屏幕录制已开始")
    }
    
    func stopRecording(onCaptureStopped: (() -> Void)? = nil) async throws -> CapturedRecordingOutput? {
        guard isRecording else { return nil }
        
        print("⏹️  停止屏幕录制...")
        
        // 停止stream
        if let stream = stream {
            try await stream.stopCapture()
        }
        stream = nil
        
        // 停止AVAudioEngine录制 (仅macOS 13-14)
        if #available(macOS 15.0, *) {
            // macOS 15+使用SCK，无需停止AVAudioEngine
        } else {
            avAudioEngineRecorder?.stopRecording()
            avAudioEngineRecorder = nil
        }
        
        // 停止独立摄像头视频轨，再关闭摄像头采集
        await stopCameraTrackRecording()
        cameraManager.stopCapture()
        onCaptureStopped?()
        
        // 完成视频写入
        let capturedOutput = await finishVideoWriting()
        
        isRecording = false
        frameCount = 0
        firstVideoFrameTime = nil  // 重置首帧视频时间

        print("✅ 屏幕录制已停止")
        return capturedOutput
    }

    func setPostProcessingHandler(_ handler: @escaping @MainActor (RecordingPostProcessingEvent) -> Void) {
        postProcessingHandler = handler
    }

    func renderCapturedRecording(_ capturedOutput: CapturedRecordingOutput, mode: RecordingRenderMode) {
        Self.startRecordingPostProcessing(
            capturedOutput: capturedOutput,
            mode: mode,
            handler: postProcessingHandler
        )
    }

    @discardableResult
    func deleteCapturedRecording(_ capturedOutput: CapturedRecordingOutput) throws -> [URL] {
        try RecordingArtifactOrganizer.deleteArtifacts(for: capturedOutput)
    }

    private func cleanupAfterFailedStart() async {
        print("🧹 清理录制启动失败后的临时资源")

        if let stream {
            try? await stream.stopCapture()
        }
        stream = nil

        if cameraRecordingTask != nil {
            let task = cameraRecordingTask
            cameraRecordingTask = nil
            task?.cancel()
            await task?.value
        }

        cameraManager.stopCapture()
        videoWriter?.cancelWriting()
        cameraWriter?.cancelWriting()

        videoWriter = nil
        videoWriterInput = nil
        audioWriterInput = nil
        microphoneWriterInput = nil
        pixelBufferAdapter = nil
        cameraWriter = nil
        cameraWriterInput = nil
        cameraPixelBufferAdapter = nil
        cameraOutputDimensions = nil
        cameraFirstFrameTime = nil
        overlayMetadataStartTime = nil
        lastCameraElapsedTime = nil
        overlayMetadataSamples = []
        pendingAudioBuffers.removeAll()
        frameCount = 0
        firstVideoFrameTime = nil
        isRecording = false
    }
    
    // MARK: - 全屏录制
    private func startFullScreenRecording(displayID: CGDirectDisplayID?) async throws {
        print("📺 开始全屏录制...")
        
        let availableContent = try await SCShareableContent.excludingDesktopWindows(false, onScreenWindowsOnly: true)
        let display: SCDisplay
        if let displayID {
            guard let selectedDisplay = availableContent.displays.first(where: { $0.displayID == displayID }) else {
                let availableIDs = availableContent.displays.map(\.displayID)
                print("❌ 指定显示器不存在: \(displayID), 可用显示器: \(availableIDs)")
                throw RecordingError.noDisplayFound
            }
            display = selectedDisplay
        } else {
            guard let firstDisplay = availableContent.displays.first else {
                throw RecordingError.noDisplayFound
            }
            display = firstDisplay
        }
        
        isFullScreen = true
        recordingModeName = "fullScreen"
        recordingRect = display.frame

        print("📺 全屏录制目标显示器: \(display.displayID)")
        
        try await setupStreamAndWriter(for: display, rect: nil, availableContent: availableContent)
    }
    
    // MARK: - 区域录制  
    private func startAreaRecording(rect: CGRect) async throws {
        print("🔍 开始区域录制: \(rect)")
        
        let availableContent = try await SCShareableContent.excludingDesktopWindows(false, onScreenWindowsOnly: true)
        guard let display = displayContaining(rect, in: availableContent.displays) ?? availableContent.displays.first else {
            throw RecordingError.noDisplayFound
        }
        
        isFullScreen = false
        recordingModeName = "selectedArea"
        recordingRect = rect
        
        // 保存选择的区域到UserDefaults
        saveSelectedArea(rect)
        
        try await setupStreamAndWriter(for: display, rect: rect, availableContent: availableContent)
    }

    // MARK: - 窗口录制
    private func startWindowRecording(target: WindowRecordingTarget) async throws {
        print("🪟 开始窗口录制: \(target.displayName), id: \(target.windowID), frame: \(target.frame)")

        let availableContent = try await SCShareableContent.excludingDesktopWindows(false, onScreenWindowsOnly: true)
        guard let display = displayContaining(target.frame, in: availableContent.displays) ?? availableContent.displays.first else {
            throw RecordingError.noDisplayFound
        }
        guard let window = availableContent.windows.first(where: { $0.windowID == target.windowID }) else {
            throw RecordingError.noWindowFound
        }

        isFullScreen = false
        recordingModeName = "selectedWindow"
        recordingRect = target.frame

        try await setupStreamAndWriter(for: display, rect: nil, window: window, availableContent: availableContent)
    }

    private func displayContaining(_ rect: CGRect, in displays: [SCDisplay]) -> SCDisplay? {
        displays.max { first, second in
            first.frame.intersection(rect).area < second.frame.intersection(rect).area
        }
    }

    private func backingScaleFactor(for rect: CGRect?) -> CGFloat {
        guard let rect else {
            return NSScreen.main?.backingScaleFactor ?? 1.0
        }

        return NSScreen.screens
            .max { first, second in
                first.frame.intersection(rect).area < second.frame.intersection(rect).area
            }?
            .backingScaleFactor ?? NSScreen.main?.backingScaleFactor ?? 1.0
    }

    private func nativeDisplayPixelDimensions(
        for filter: SCContentFilter,
        display: SCDisplay
    ) -> (width: Int, height: Int, scaleFactor: CGFloat, source: String) {
        if #available(macOS 14.0, *) {
            let contentRect = filter.contentRect
            let scaleFactor = max(CGFloat(filter.pointPixelScale), 1)
            let width = Self.evenPixelDimension(contentRect.width * scaleFactor)
            let height = Self.evenPixelDimension(contentRect.height * scaleFactor)

            if width > 2, height > 2 {
                return (width, height, scaleFactor, "SCContentFilter.contentRect * pointPixelScale")
            }
        }

        if let screen = NSScreen.screens.first(where: { CGDirectDisplayID($0.displayID) == display.displayID }) {
            let scaleFactor = max(screen.backingScaleFactor, 1)
            let width = Self.evenPixelDimension(screen.frame.width * scaleFactor)
            let height = Self.evenPixelDimension(screen.frame.height * scaleFactor)

            if width > 2, height > 2 {
                return (width, height, scaleFactor, "NSScreen.frame * backingScaleFactor")
            }
        }

        return (
            max(2, display.width / 2 * 2),
            max(2, display.height / 2 * 2),
            1,
            "SCDisplay.width/height fallback"
        )
    }
    
    // MARK: - Stream 和 Writer 设置
    private func setupStreamAndWriter(
        for display: SCDisplay,
        rect: CGRect?,
        window: SCWindow? = nil,
        availableContent: SCShareableContent? = nil
    ) async throws {
        guard let outputURL = outputURL else {
            throw RecordingError.invalidOutputURL
        }
        
        // 设置录制配置
        let config = SCStreamConfiguration()
        
        // 视频质量配置
        let capturePixelFormat = RecordingPixelFormatPolicy.selectedFormat()
        let pixelFormat = capturePixelFormat.osType
        screenCapturePixelFormat = pixelFormat
        config.pixelFormat = pixelFormat
        print("🎥 Capture pixel format: \(capturePixelFormat.displayName)")
        config.showsCursor = true
        config.scalesToFit = false
        config.minimumFrameInterval = CMTime(value: 1, timescale: CMTimeScale(Self.screenTargetFrameRate))
        
        // 音频配置
        config.capturesAudio = self.systemAudioEnabled
        config.excludesCurrentProcessAudio = true  // 避免录制自己应用的声音
        
        // macOS 15+ 麦克风支持
        if #available(macOS 15.0, *) {
            config.captureMicrophone = self.microphoneEnabled
            if let deviceID = self.microphoneDeviceID {
                config.microphoneCaptureDeviceID = deviceID
            }
        }

        // 设置录制内容过滤器。Full screen uses this filter's display-specific
        // pointPixelScale so selected external Retina displays record at native pixels.
        let filter: SCContentFilter
        if let window = window {
            filter = SCContentFilter(desktopIndependentWindow: window)
        } else {
            let excludedWindows = ownShareableWindows(in: availableContent)
            if !excludedWindows.isEmpty {
                print("🪟 Excluding \(excludedWindows.count) CueRecord windows from capture")
            }
            filter = SCContentFilter(display: display, excludingWindows: excludedWindows)
        }
        
        if let window = window {
            let targetRect = recordingRect ?? window.frame
            let scaleFactor = backingScaleFactor(for: targetRect)
            let pixelWidth = round(targetRect.width * scaleFactor)
            let pixelHeight = round(targetRect.height * scaleFactor)
            let alignedWidth = max(2, Int(pixelWidth / 2) * 2)
            let alignedHeight = max(2, Int(pixelHeight / 2) * 2)

            config.width = alignedWidth
            config.height = alignedHeight
            config.scalesToFit = false
            config.queueDepth = 5
            config.colorSpaceName = CGColorSpace.sRGB

            print("🪟 窗口录制配置:")
            print("   目标窗口: \(targetRect)")
            print("   缩放因子: \(scaleFactor)")
            print("   输出分辨率: \(alignedWidth)x\(alignedHeight)")
        } else if let rect = rect {
            // 🎯 区域录制配置 - 像素对齐优化
            let scaleFactor = backingScaleFactor(for: rect)
            
            // 1. 像素对齐：确保所有坐标都是整数像素
            let pixelX = round(rect.origin.x * scaleFactor)
            let pixelWidth = round(rect.width * scaleFactor)
            let pixelHeight = round(rect.height * scaleFactor)
            
            // 2. 确保宽高为偶数（H.264编码要求）
            let alignedWidth = Int(pixelWidth / 2) * 2
            let alignedHeight = Int(pixelHeight / 2) * 2
            
            // 3. 转换回点坐标（用于sourceRect）
            let alignedRect = CGRect(
                x: pixelX / scaleFactor,
                y: rect.origin.y,  // 暂时保持Y坐标
                width: CGFloat(alignedWidth) / scaleFactor,
                height: CGFloat(alignedHeight) / scaleFactor
            )
            recordingRect = alignedRect
            
            // 4. 坐标系转换：macOS（左下） -> ScreenCaptureKit（左上）
            let convertedX = alignedRect.origin.x - display.frame.origin.x
            let convertedY = display.frame.maxY - alignedRect.maxY
            let convertedRect = CGRect(
                x: convertedX,
                y: convertedY,
                width: alignedRect.width,
                height: alignedRect.height
            )
            
            // 5. 设置配置：关键是1:1采样，避免缩放
            config.sourceRect = convertedRect
            config.width = alignedWidth
            config.height = alignedHeight
            config.scalesToFit = false  // 关键：禁用缩放
            config.queueDepth = 5
            config.colorSpaceName = CGColorSpace.sRGB
            
            print("🎯 像素对齐优化:")
            print("   原始区域: \(rect)")
            print("   像素对齐后: \(alignedRect)")
            print("   转换后区域: \(convertedRect)")
            print("   输出分辨率: \(alignedWidth)x\(alignedHeight) (1:1采样)")
        } else {
            let nativeDimensions = nativeDisplayPixelDimensions(for: filter, display: display)
            config.width = nativeDimensions.width
            config.height = nativeDimensions.height
            config.queueDepth = 5
            config.colorSpaceName = CGColorSpace.sRGB

            print("📺 显示器信息:")
            print("   Display ID: \(display.displayID)")
            print("   Frame: \(display.frame)")
            print("   ScreenCaptureKit报告: \(display.width)x\(display.height)")
            print("   像素倍率: \(nativeDimensions.scaleFactor)")
            print("   分辨率来源: \(nativeDimensions.source)")
            print("   最终录制分辨率: \(nativeDimensions.width)x\(nativeDimensions.height)")
        }

        recordingMetrics.configure(
            mode: recordingModeName,
            displayID: display.displayID,
            recordingRect: recordingRect,
            outputWidth: config.width,
            outputHeight: config.height,
            pixelFormat: screenCapturePixelFormat
        )
        
        // 创建并配置stream
        stream = SCStream(filter: filter, configuration: config, delegate: self)
        
        // 设置视频写入器
        try setupVideoWriter(width: config.width, height: config.height, outputURL: outputURL)
        
        // 设置音频录制
        if self.systemAudioEnabled || self.microphoneEnabled {
            try setupAudioCapture(
                systemAudioEnabled: self.systemAudioEnabled, 
                microphoneEnabled: self.microphoneEnabled,
                microphoneDeviceID: self.microphoneDeviceID
            )
        }
        
        // 在添加所有输入后，开始写入会话
        guard let writer = videoWriter else {
            throw RecordingError.writerNotFound
        }
        guard writer.startWriting() else {
            print("❌ AVAssetWriter 启动失败: \(writer.error?.localizedDescription ?? "未知错误")")
            print("   输出路径: \(outputURL.path)")
            throw RecordingError.writerSetupFailed
        }
        print("✅ AVAssetWriter 开始写入")
        
        // 添加视频输出回调
        try stream?.addStreamOutput(self, type: .screen, sampleHandlerQueue: DispatchQueue(label: "videoQueue"))
        
        // 开始捕获
        try await stream?.startCapture()

        if enableCameraOverlay {
            startCameraTrackRecording()
        }
        
        // 启动AVAudioEngine麦克风录制 (仅macOS 13-14)
        if #available(macOS 15.0, *) {
            // macOS 15+使用SCK，无需额外启动AVAudioEngine
        } else {
            if let avRecorder = avAudioEngineRecorder,
               let micInput = microphoneWriterInput {
                try avRecorder.startRecording(writerInput: micInput)
                print("🎤 AVAudioEngine开始录制麦克风")
            }
        }
        
        print("📹 Stream配置完成 - 分辨率: \(config.width)x\(config.height)")
    }

    private func ownShareableWindows(in availableContent: SCShareableContent?) -> [SCWindow] {
        guard let availableContent else { return [] }

        let processID = pid_t(ProcessInfo.processInfo.processIdentifier)
        let appWindowIDs = Set(NSApp.windows.map { CGWindowID($0.windowNumber) }.filter { $0 > 0 })

        return availableContent.windows.filter { window in
            window.owningApplication?.processID == processID || appWindowIDs.contains(window.windowID)
        }
    }
    
    // MARK: - 音频录制设置
    private func setupAudioCapture(
        systemAudioEnabled: Bool,
        microphoneEnabled: Bool,
        microphoneDeviceID: String?
    ) throws {
        print("🎤 设置音频录制 - 系统音频: \(systemAudioEnabled), 麦克风: \(microphoneEnabled)")
        
        guard let videoWriter = videoWriter else {
            throw RecordingError.writerNotFound
        }
        
        // 设置系统音频录制
        if systemAudioEnabled {
            try setupSystemAudioInput(videoWriter: videoWriter)
            try stream?.addStreamOutput(self, type: .audio, sampleHandlerQueue: DispatchQueue(label: "audioQueue"))
            print("✅ 系统音频录制已启用")
        }
        
        // 设置麦克风录制
        if microphoneEnabled {
            if #available(macOS 15.0, *) {
                // macOS 15+: 使用ScreenCaptureKit原生支持
                try setupMicrophoneInput(videoWriter: videoWriter)
                try stream?.addStreamOutput(self, type: .microphone, sampleHandlerQueue: DispatchQueue(label: "microphoneQueue"))
                print("✅ 麦克风录制已启用 (SCK原生支持)")
            } else {
                // macOS 13-14: 使用AVAudioEngine
                try setupAVAudioEngineMicrophone(
                    videoWriter: videoWriter,
                    deviceID: microphoneDeviceID
                )
                print("✅ 麦克风录制已启用 (AVAudioEngine兼容方案)")
            }
        }
    }
    
    private func setupSystemAudioInput(videoWriter: AVAssetWriter) throws {
        // 配置系统音频输入
        let audioSettings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderBitRateKey: 192000
        ]
        
        audioWriterInput = AVAssetWriterInput(mediaType: .audio, outputSettings: audioSettings)
        audioWriterInput?.expectsMediaDataInRealTime = true
        
        guard let audioInput = audioWriterInput else {
            throw RecordingError.audioSetupFailed
        }
        
        guard videoWriter.canAdd(audioInput) else {
            throw RecordingError.audioSetupFailed
        }
        
        videoWriter.add(audioInput)
        print("🔊 系统音频输入已配置")
    }
    
    // MARK: - AVAudioEngine麦克风设置
    private func setupAVAudioEngineMicrophone(videoWriter: AVAssetWriter, deviceID: String?) throws {
        // 配置麦克风音频输入
        let micSettings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,  // 立体声
            AVEncoderBitRateKey: 192000
        ]
        
        microphoneWriterInput = AVAssetWriterInput(mediaType: .audio, outputSettings: micSettings)
        microphoneWriterInput?.expectsMediaDataInRealTime = true
        
        guard let micInput = microphoneWriterInput else {
            throw RecordingError.audioSetupFailed
        }
        
        guard videoWriter.canAdd(micInput) else {
            throw RecordingError.audioSetupFailed
        }
        
        videoWriter.add(micInput)
        
        // 创建并配置AVAudioEngine录制器
        avAudioEngineRecorder = AVAudioEngineRecorder()
        
        // 设置音频设备
        if let deviceID = deviceID,
           let audioDeviceID = AudioDeviceID(deviceID) {
            avAudioEngineRecorder?.setInputDevice(deviceID: audioDeviceID)
        }
        
        print("🎤 AVAudioEngine麦克风录制已配置")
    }
    
    @available(macOS 15.0, *)
    private func setupMicrophoneInput(videoWriter: AVAssetWriter) throws {
        // 配置麦克风音频输入（独立轨道）
        let micSettings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,  // 麦克风通常是单声道
            AVEncoderBitRateKey: 128000
        ]
        
        microphoneWriterInput = AVAssetWriterInput(mediaType: .audio, outputSettings: micSettings)
        microphoneWriterInput?.expectsMediaDataInRealTime = true
        
        guard let micInput = microphoneWriterInput else {
            throw RecordingError.audioSetupFailed
        }
        
        guard videoWriter.canAdd(micInput) else {
            throw RecordingError.audioSetupFailed
        }
        
        videoWriter.add(micInput)
        print("🎤 SCK麦克风输入已配置")
    }
    
    // MARK: - 视频写入器设置
    private func setupVideoWriter(width: Int, height: Int, outputURL: URL) throws {
        // 删除已存在的文件
        if FileManager.default.fileExists(atPath: outputURL.path) {
            try FileManager.default.removeItem(at: outputURL)
        }
        
        // 创建视频写入器（使用 .mov 以便后续混音和兼容性更好）
        videoWriter = try AVAssetWriter(outputURL: outputURL, fileType: .mov)
        
        guard let writer = videoWriter else {
            throw RecordingError.writerSetupFailed
        }
        
        // First quality step: raise the encoder bitrate while keeping the
        // capture pipeline unchanged. This improves text/detail clarity without
        // reintroducing the SCK startup pressure from later experiments.
        let totalPixels = width * height
        let bitsPerPixel: Double
        
        // 🎯 关键优化：区域录制使用更高的单位像素码率
        // 因为区域录制通常包含更多细节内容（如代码、文字）
        if !isFullScreen {
            // 区域录制：提高单位像素码率
            if totalPixels > 1920 * 1080 {
                bitsPerPixel = 0.24  // 更高质量
            } else if totalPixels > 1280 * 720 {
                bitsPerPixel = 0.28
            } else {
                bitsPerPixel = 0.32  // 小区域使用最高质量
            }
        } else {
            // 全屏录制：标准码率
            if totalPixels > 1920 * 1080 {
                bitsPerPixel = 0.18
            } else if totalPixels > 1280 * 720 {
                bitsPerPixel = 0.20
            } else {
                bitsPerPixel = 0.22
            }
        }
        
        let minimumBitRate = isFullScreen ? 12_000_000 : 16_000_000
        let bitRate = max(minimumBitRate, Int(Double(totalPixels) * bitsPerPixel * Double(Self.screenTargetFrameRate)))
        
        print("🎥 编码优化设置:")
        print("   分辨率: \(width)x\(height)")
        print("   像素总数: \(totalPixels)")
        print("   单位像素码率: \(bitsPerPixel) bits/pixel/frame")
        print("   总码率: \(bitRate) bps (\(bitRate/1000000) Mbps)")
        print("   模式: \(isFullScreen ? "全屏" : "区域")")
        
        let videoSettings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.h264,
            AVVideoWidthKey: width,
            AVVideoHeightKey: height,
            AVVideoColorPropertiesKey: Self.rec709VideoColorProperties(),
            AVVideoCompressionPropertiesKey: [
                AVVideoAverageBitRateKey: bitRate,
                AVVideoMaxKeyFrameIntervalKey: Self.screenTargetFrameRate / 2,
                AVVideoProfileLevelKey: AVVideoProfileLevelH264HighAutoLevel,
                AVVideoAllowFrameReorderingKey: false,
                AVVideoExpectedSourceFrameRateKey: Self.screenTargetFrameRate,
                AVVideoH264EntropyModeKey: AVVideoH264EntropyModeCABAC,
                // 额外的质量参数
                AVVideoQualityKey: isFullScreen ? 0.85 : 0.95  // 区域录制使用更高质量
            ]
        ]
        
        videoWriterInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
        videoWriterInput?.expectsMediaDataInRealTime = true
        
        guard let writerInput = videoWriterInput else {
            throw RecordingError.writerSetupFailed
        }
        
        // 像素缓冲适配器
        let pixelBufferAttributes: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA,
            kCVPixelBufferWidthKey as String: width,
            kCVPixelBufferHeightKey as String: height
        ]
        
        pixelBufferAdapter = AVAssetWriterInputPixelBufferAdaptor(
            assetWriterInput: writerInput,
            sourcePixelBufferAttributes: pixelBufferAttributes
        )
        
        writer.add(writerInput)
        
        // 注意：不在这里调用 startWriting()，需要先添加音频输入
        
        recordingStartTime = CMTime.zero
        
        print("🎥 视频写入器配置完成")
    }

    // MARK: - 独立摄像头视频轨
    private func startCameraTrackRecording() {
        guard cameraRecordingTask == nil, let outputURL else { return }

        cameraOutputURL = Self.siblingOutputURL(for: outputURL, suffix: "camera", extension: "mov")
        overlayMetadataURL = Self.siblingOutputURL(for: outputURL, suffix: "overlay", extension: "json")
        cameraFrameCount = 0
        cameraFirstFrameTime = nil
        cameraOutputDimensions = nil
        overlayMetadataStartTime = nil
        lastCameraElapsedTime = nil
        overlayMetadataSamples = []

        if let cameraOutputURL, FileManager.default.fileExists(atPath: cameraOutputURL.path) {
            try? FileManager.default.removeItem(at: cameraOutputURL)
        }
        if let overlayMetadataURL, FileManager.default.fileExists(atPath: overlayMetadataURL.path) {
            try? FileManager.default.removeItem(at: overlayMetadataURL)
        }

        cameraRecordingTask = Task { @MainActor [weak self] in
            await self?.recordCameraFrames()
        }

        print("📷 独立摄像头视频轨开始: \(cameraOutputURL?.lastPathComponent ?? "")")
    }

    private func recordCameraFrames() async {
        while !Task.isCancelled {
            if let frame = cameraManager.dequeueLatestFrame() {
                appendCameraFrame(frame)
            }

            try? await Task.sleep(nanoseconds: 33_333_333)
        }
    }

    private func appendCameraFrame(_ frame: CameraFrameSample) {
        guard let videoStartTime = firstVideoFrameTime else { return }

        let sourceTime = frame.timestamp.isValid
            ? frame.timestamp
            : CMTime(value: CMTimeValue(frame.sequence), timescale: 30)

        guard sourceTime >= videoStartTime else { return }

        let processedFrame = CameraFrameProcessor.mirroredVisibleImage(from: frame.pixelBuffer)

        do {
            if cameraWriter == nil {
                let dimensions = CameraFrameProcessor.evenDimensions(for: processedFrame.extent.size)
                try setupCameraVideoWriter(width: dimensions.width, height: dimensions.height)
            }
        } catch {
            print("❌ 摄像头视频写入器创建失败: \(error.localizedDescription)")
            cameraRecordingTask?.cancel()
            return
        }

        guard let writer = cameraWriter,
              let writerInput = cameraWriterInput,
              let adapter = cameraPixelBufferAdapter,
              let dimensions = cameraOutputDimensions,
              writer.status == .writing else {
            return
        }

        if cameraFirstFrameTime == nil {
            cameraFirstFrameTime = videoStartTime
            overlayMetadataStartTime = videoStartTime
            writer.startSession(atSourceTime: .zero)
        }

        let rawPresentationTime = CMTimeSubtract(sourceTime, videoStartTime)
        let presentationTime = rawPresentationTime.isValid && rawPresentationTime >= .zero
            ? rawPresentationTime
            : .zero
        lastCameraElapsedTime = presentationTime.seconds.isFinite ? presentationTime.seconds : lastCameraElapsedTime

        if cameraFrameCount % 8 == 0 {
            captureOverlayMetadataSample(at: lastCameraElapsedTime)
        }

        guard writerInput.isReadyForMoreMediaData,
              let outputPixelBuffer = renderCameraFrame(
                processedFrame.image,
                sourceExtent: processedFrame.extent,
                width: dimensions.width,
                height: dimensions.height,
                adapter: adapter
              ) else {
            return
        }

        if adapter.append(outputPixelBuffer, withPresentationTime: presentationTime) {
            cameraFrameCount += 1
            recordingMetrics.updateCamera(
                received: cameraManager.receivedFrameCount,
                written: cameraFrameCount,
                dropped: cameraManager.droppedFrameCount
            )
        } else {
            print("⚠️  摄像头帧写入失败: \(cameraFrameCount)")
        }
    }

    private func setupCameraVideoWriter(width: Int, height: Int) throws {
        guard let cameraOutputURL else { return }

        cameraWriter = try AVAssetWriter(outputURL: cameraOutputURL, fileType: .mov)
        guard let writer = cameraWriter else {
            throw RecordingError.writerSetupFailed
        }

        let bitRate = max(4_000_000, width * height * 4)
        let videoSettings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.h264,
            AVVideoWidthKey: width,
            AVVideoHeightKey: height,
            AVVideoColorPropertiesKey: Self.rec709VideoColorProperties(),
            AVVideoCompressionPropertiesKey: [
                AVVideoAverageBitRateKey: bitRate,
                AVVideoMaxKeyFrameIntervalKey: 30,
                AVVideoProfileLevelKey: AVVideoProfileLevelH264HighAutoLevel,
                AVVideoAllowFrameReorderingKey: false,
                AVVideoExpectedSourceFrameRateKey: 30,
                AVVideoQualityKey: 0.9
            ]
        ]

        cameraWriterInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
        cameraWriterInput?.expectsMediaDataInRealTime = true

        guard let writerInput = cameraWriterInput, writer.canAdd(writerInput) else {
            throw RecordingError.writerSetupFailed
        }

        let pixelBufferAttributes: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA,
            kCVPixelBufferWidthKey as String: width,
            kCVPixelBufferHeightKey as String: height,
            kCVPixelBufferCGImageCompatibilityKey as String: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
        ]

        cameraPixelBufferAdapter = AVAssetWriterInputPixelBufferAdaptor(
            assetWriterInput: writerInput,
            sourcePixelBufferAttributes: pixelBufferAttributes
        )
        writer.add(writerInput)

        guard writer.startWriting() else {
            throw RecordingError.writerSetupFailed
        }

        cameraOutputDimensions = (width, height)
        print("📷 摄像头视频写入器配置完成: \(width)x\(height)")
    }

    private func renderCameraFrame(
        _ image: CIImage,
        sourceExtent: CGRect,
        width: Int,
        height: Int,
        adapter: AVAssetWriterInputPixelBufferAdaptor
    ) -> CVPixelBuffer? {
        guard let pixelBufferPool = adapter.pixelBufferPool else { return nil }

        var outputPixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferPoolCreatePixelBuffer(nil, pixelBufferPool, &outputPixelBuffer)
        guard status == kCVReturnSuccess, let outputPixelBuffer else {
            return nil
        }

        let outputExtent = CGRect(x: 0, y: 0, width: width, height: height)
        let scaledImage = Self.aspectFill(
            image,
            sourceExtent: sourceExtent,
            targetRect: outputExtent
        )

        cameraCIContext.render(
            scaledImage,
            to: outputPixelBuffer,
            bounds: outputExtent,
            colorSpace: CGColorSpaceCreateDeviceRGB()
        )

        return outputPixelBuffer
    }

    private func stopCameraTrackRecording() async {
        let task = cameraRecordingTask
        cameraRecordingTask = nil
        task?.cancel()
        await task?.value

        captureOverlayMetadataSample(at: lastCameraElapsedTime)

        if let writer = cameraWriter {
            cameraWriterInput?.markAsFinished()
            await writer.finishWriting()

            switch writer.status {
            case .completed:
                print("✅ 摄像头视频保存成功: \(cameraOutputURL?.lastPathComponent ?? "")")
            case .failed:
                print("❌ 摄像头视频保存失败: \(writer.error?.localizedDescription ?? "未知错误")")
            case .cancelled:
                print("⚠️  摄像头视频写入被取消")
            default:
                print("⚠️  摄像头视频写入状态未知: \(writer.status.rawValue)")
            }
        }

        recordingMetrics.updateCamera(
            received: cameraManager.receivedFrameCount,
            written: cameraFrameCount,
            dropped: cameraManager.droppedFrameCount
        )

        writeOverlayMetadataFile()

        cameraWriter = nil
        cameraWriterInput = nil
        cameraPixelBufferAdapter = nil
        cameraOutputDimensions = nil
        cameraFirstFrameTime = nil
        overlayMetadataStartTime = nil
        lastCameraElapsedTime = nil
        overlayMetadataSamples = []
    }

    private func captureOverlayMetadataSample(at elapsedTime: Double? = nil) {
        guard enableCameraOverlay,
              overlayMetadataStartTime != nil,
              let snapshot = cameraOverlaySnapshotProvider?() else {
            return
        }

        let elapsedTime = elapsedTime ?? lastCameraElapsedTime ?? 0
        let sample = CameraOverlayMetadataSample(
            time: elapsedTime,
            frame: CodableRect(snapshot.frame),
            shape: metadataValue(for: snapshot.shape),
            size: metadataValue(for: snapshot.size)
        )

        if let lastSample = overlayMetadataSamples.last,
           abs(lastSample.time - sample.time) < 0.2,
           lastSample.frame == sample.frame,
           lastSample.shape == sample.shape,
           lastSample.size == sample.size {
            return
        }

        overlayMetadataSamples.append(sample)
    }

    private func writeOverlayMetadataFile() {
        guard let overlayMetadataURL, let outputURL else { return }

        let metadata = CameraOverlayMetadataFile(
            version: 1,
            screenFile: outputURL.lastPathComponent,
            cameraFile: cameraOutputURL?.lastPathComponent,
            coordinateSpace: "macOS global screen points; origin is bottom-left",
            generatedAt: ISO8601DateFormatter().string(from: Date()),
            recordingMode: recordingModeName,
            recordingRect: recordingRect.map(CodableRect.init),
            samples: overlayMetadataSamples
        )

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            let data = try encoder.encode(metadata)
            try data.write(to: overlayMetadataURL)
            print("✅ 摄像头叠加元数据保存成功: \(overlayMetadataURL.lastPathComponent)")
        } catch {
            print("❌ 摄像头叠加元数据保存失败: \(error.localizedDescription)")
        }
    }

    private nonisolated static func siblingOutputURL(for outputURL: URL, suffix: String, extension pathExtension: String) -> URL {
        let baseName = outputURL.deletingPathExtension().lastPathComponent
        return outputURL
            .deletingLastPathComponent()
            .appendingPathComponent("\(baseName)_\(suffix)")
            .appendingPathExtension(pathExtension)
    }

    private func metadataValue(for shape: CameraOverlayShape) -> String {
        switch shape {
        case .circle:
            return "circle"
        case .roundedSquare:
            return "roundedRectangle"
        case .roundedBox:
            return "roundedSquare"
        }
    }

    private func metadataValue(for size: CameraOverlaySize) -> String {
        switch size {
        case .small:
            return "small"
        case .medium:
            return "medium"
        case .large:
            return "large"
        }
    }

    // MARK: - 自动合成视频
    private nonisolated static func exportCompositedVideoIfNeeded(
        for screenURL: URL,
        cameraURL: URL?,
        overlayMetadataURL: URL?
    ) async -> URL? {
        guard let cameraURL,
              let overlayMetadataURL,
              FileManager.default.fileExists(atPath: cameraURL.path),
              FileManager.default.fileExists(atPath: overlayMetadataURL.path) else {
            return nil
        }

        let compositedURL = Self.siblingOutputURL(for: screenURL, suffix: "composited", extension: "mov")
        let tempVideoURL = Self.siblingOutputURL(for: screenURL, suffix: "composited_video_tmp", extension: "mov")

        do {
            let metadataData = try Data(contentsOf: overlayMetadataURL)
            let metadata = try JSONDecoder().decode(CameraOverlayMetadataFile.self, from: metadataData)

            try? FileManager.default.removeItem(at: compositedURL)
            try? FileManager.default.removeItem(at: tempVideoURL)

            print("🎞️  开始合成视频: \(compositedURL.lastPathComponent)")
            let rendered = try Self.renderCompositedVideo(
                screenURL: screenURL,
                cameraURL: cameraURL,
                metadata: metadata,
                outputURL: tempVideoURL
            )

            guard rendered else {
                print("❌ 合成视频渲染失败")
                return nil
            }

            let muxed = await Self.muxAudioFromScreenVideo(
                screenURL: screenURL,
                videoOnlyURL: tempVideoURL,
                outputURL: compositedURL
            )

            if muxed {
                try? FileManager.default.removeItem(at: tempVideoURL)
                print("✅ 合成视频保存成功: \(compositedURL.lastPathComponent)")
            } else {
                try FileManager.default.moveItem(at: tempVideoURL, to: compositedURL)
                print("✅ 合成视频保存成功（无音频复用）: \(compositedURL.lastPathComponent)")
            }
            return compositedURL
        } catch {
            print("❌ 合成视频失败: \(error.localizedDescription)")
            try? FileManager.default.removeItem(at: tempVideoURL)
            return nil
        }
    }

    private nonisolated static func exportTransparentCameraVideoIfNeeded(
        for screenURL: URL,
        cameraURL: URL?,
        overlayMetadataURL: URL?
    ) async -> URL? {
        guard let cameraURL,
              let overlayMetadataURL,
              FileManager.default.fileExists(atPath: cameraURL.path),
              FileManager.default.fileExists(atPath: overlayMetadataURL.path) else {
            return nil
        }

        let cameraOnlyURL = Self.siblingOutputURL(for: screenURL, suffix: "camera_only", extension: "mov")

        do {
            let metadataData = try Data(contentsOf: overlayMetadataURL)
            let metadata = try JSONDecoder().decode(CameraOverlayMetadataFile.self, from: metadataData)
            guard !metadata.samples.isEmpty else { return nil }

            try? FileManager.default.removeItem(at: cameraOnlyURL)

            print("🎞️  Rendering transparent camera video: \(cameraOnlyURL.lastPathComponent)")
            let rendered = try Self.renderTransparentCameraVideo(
                screenURL: screenURL,
                cameraURL: cameraURL,
                metadata: metadata,
                outputURL: cameraOnlyURL
            )

            guard rendered else {
                print("❌ Transparent camera render failed")
                try? FileManager.default.removeItem(at: cameraOnlyURL)
                return nil
            }

            print("✅ Transparent camera video saved: \(cameraOnlyURL.lastPathComponent)")
            return cameraOnlyURL
        } catch {
            print("❌ Transparent camera render failed: \(error.localizedDescription)")
            try? FileManager.default.removeItem(at: cameraOnlyURL)
            return nil
        }
    }

    private nonisolated static func exportEditedRecordingIfNeeded(
        for screenURL: URL,
        cameraURL: URL?,
        overlayMetadataURL: URL?,
        decision: RecordingEditDecision
    ) async -> URL? {
        let editedURL = Self.siblingOutputURL(for: screenURL, suffix: "edited", extension: "mov")
        let tempVideoURL = Self.siblingOutputURL(for: screenURL, suffix: "edited_video_tmp", extension: "mov")

        do {
            let metadata = overlayMetadataURL.flatMap { url -> CameraOverlayMetadataFile? in
                guard FileManager.default.fileExists(atPath: url.path) else { return nil }
                guard let data = try? Data(contentsOf: url) else { return nil }
                return try? JSONDecoder().decode(CameraOverlayMetadataFile.self, from: data)
            }

            try? FileManager.default.removeItem(at: editedURL)
            try? FileManager.default.removeItem(at: tempVideoURL)

            print("🎞️  Rendering edited recording: \(editedURL.lastPathComponent)")
            let rendered = try Self.renderEditedVideo(
                screenURL: screenURL,
                cameraURL: cameraURL,
                metadata: metadata,
                decision: decision,
                outputURL: tempVideoURL
            )

            guard rendered else {
                print("❌ Edited recording render failed")
                try? FileManager.default.removeItem(at: tempVideoURL)
                return nil
            }

            let muxed = await Self.muxAudioFromScreenVideo(
                screenURL: screenURL,
                videoOnlyURL: tempVideoURL,
                outputURL: editedURL,
                cuts: decision.cuts
            )

            if muxed {
                try? FileManager.default.removeItem(at: tempVideoURL)
                print("✅ Edited recording saved: \(editedURL.lastPathComponent)")
            } else {
                try FileManager.default.moveItem(at: tempVideoURL, to: editedURL)
                print("✅ Edited recording saved without audio remux: \(editedURL.lastPathComponent)")
            }

            return editedURL
        } catch {
            print("❌ Edited recording render failed: \(error.localizedDescription)")
            try? FileManager.default.removeItem(at: tempVideoURL)
            return nil
        }
    }

    private nonisolated static func renderCompositedVideo(
        screenURL: URL,
        cameraURL: URL,
        metadata: CameraOverlayMetadataFile,
        outputURL: URL
    ) throws -> Bool {
        let screenAsset = AVURLAsset(url: screenURL)
        let cameraAsset = AVURLAsset(url: cameraURL)

        guard let screenTrack = screenAsset.tracks(withMediaType: .video).first,
              let cameraTrack = cameraAsset.tracks(withMediaType: .video).first else {
            return false
        }

        let screenSize = Self.normalizedVideoSize(for: screenTrack)
        let outputWidth = max(2, Int(screenSize.width.rounded(.down)) / 2 * 2)
        let outputHeight = max(2, Int(screenSize.height.rounded(.down)) / 2 * 2)

        let screenReader = try AVAssetReader(asset: screenAsset)
        let cameraReader = try AVAssetReader(asset: cameraAsset)

        let readerSettings: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
        ]

        let screenOutput = AVAssetReaderTrackOutput(track: screenTrack, outputSettings: readerSettings)
        screenOutput.alwaysCopiesSampleData = false
        guard screenReader.canAdd(screenOutput) else { return false }
        screenReader.add(screenOutput)

        let cameraOutput = AVAssetReaderTrackOutput(track: cameraTrack, outputSettings: readerSettings)
        cameraOutput.alwaysCopiesSampleData = false
        guard cameraReader.canAdd(cameraOutput) else { return false }
        cameraReader.add(cameraOutput)

        let writer = try AVAssetWriter(outputURL: outputURL, fileType: .mov)
        let compositedBitRate = max(
            8_000_000,
            outputWidth * outputHeight * 3 * Self.screenTargetFrameRate / 30
        )
        let videoSettings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.h264,
            AVVideoWidthKey: outputWidth,
            AVVideoHeightKey: outputHeight,
            AVVideoColorPropertiesKey: Self.rec709VideoColorProperties(),
            AVVideoCompressionPropertiesKey: [
                AVVideoAverageBitRateKey: compositedBitRate,
                AVVideoMaxKeyFrameIntervalKey: Self.screenTargetFrameRate / 2,
                AVVideoProfileLevelKey: AVVideoProfileLevelH264HighAutoLevel,
                AVVideoAllowFrameReorderingKey: false,
                AVVideoExpectedSourceFrameRateKey: Self.screenTargetFrameRate,
                AVVideoQualityKey: 0.92
            ]
        ]

        let writerInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
        writerInput.expectsMediaDataInRealTime = false

        let pixelBufferAttributes: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA,
            kCVPixelBufferWidthKey as String: outputWidth,
            kCVPixelBufferHeightKey as String: outputHeight,
            kCVPixelBufferCGImageCompatibilityKey as String: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
        ]

        let adapter = AVAssetWriterInputPixelBufferAdaptor(
            assetWriterInput: writerInput,
            sourcePixelBufferAttributes: pixelBufferAttributes
        )

        guard writer.canAdd(writerInput) else { return false }
        writer.add(writerInput)

        guard screenReader.startReading(),
              cameraReader.startReading(),
              writer.startWriting() else {
            return false
        }

        writer.startSession(atSourceTime: .zero)

        let ciContext = CIContext()
        var currentCameraPixelBuffer: CVPixelBuffer?
        var currentCameraTime = CMTime.zero
        var nextCameraSample = cameraOutput.copyNextSampleBuffer()
        var maskCache: [String: CIImage] = [:]
        let outputExtent = CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight)

        func advanceCameraFrame(to screenTime: CMTime) {
            while let sample = nextCameraSample {
                let sampleTime = CMSampleBufferGetPresentationTimeStamp(sample)
                guard sampleTime <= screenTime || currentCameraPixelBuffer == nil else {
                    break
                }

                if let pixelBuffer = CMSampleBufferGetImageBuffer(sample) {
                    currentCameraPixelBuffer = pixelBuffer
                    currentCameraTime = sampleTime
                }

                nextCameraSample = cameraOutput.copyNextSampleBuffer()
            }
        }

        while let screenSample = screenOutput.copyNextSampleBuffer() {
            let screenTime = CMSampleBufferGetPresentationTimeStamp(screenSample)
            advanceCameraFrame(to: screenTime)

            guard let screenPixelBuffer = CMSampleBufferGetImageBuffer(screenSample),
                  let outputPixelBuffer = Self.createPixelBuffer(from: adapter) else {
                continue
            }

            let screenImage = CIImage(cvPixelBuffer: screenPixelBuffer)
            let cameraImage = currentCameraPixelBuffer.map { CIImage(cvPixelBuffer: $0) }
            let seconds = max(0, CMTimeGetSeconds(screenTime))
            let sample = Self.overlaySample(at: seconds, in: metadata.samples)
            let composedImage = Self.composeScreenImage(
                screenImage,
                cameraImage: cameraImage,
                overlaySample: sample,
                metadata: metadata,
                outputExtent: outputExtent,
                maskCache: &maskCache
            )

            ciContext.render(
                composedImage,
                to: outputPixelBuffer,
                bounds: outputExtent,
                colorSpace: CGColorSpaceCreateDeviceRGB()
            )

            while !writerInput.isReadyForMoreMediaData {
                Thread.sleep(forTimeInterval: 0.002)
            }

            let presentationTime = screenTime.isValid ? screenTime : currentCameraTime
            adapter.append(outputPixelBuffer, withPresentationTime: presentationTime)
        }

        writerInput.markAsFinished()
        screenReader.cancelReading()
        cameraReader.cancelReading()

        let completed = DispatchSemaphore(value: 0)
        writer.finishWriting {
            completed.signal()
        }
        completed.wait()

        return writer.status == .completed
    }

    private nonisolated static func renderEditedVideo(
        screenURL: URL,
        cameraURL: URL?,
        metadata: CameraOverlayMetadataFile?,
        decision: RecordingEditDecision,
        outputURL: URL
    ) throws -> Bool {
        let screenAsset = AVURLAsset(url: screenURL)
        guard let screenTrack = screenAsset.tracks(withMediaType: .video).first else {
            return false
        }

        let screenSize = Self.normalizedVideoSize(for: screenTrack)
        let outputWidth = max(2, Int(screenSize.width.rounded(.down)) / 2 * 2)
        let outputHeight = max(2, Int(screenSize.height.rounded(.down)) / 2 * 2)
        let outputExtent = CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight)

        let screenReader = try AVAssetReader(asset: screenAsset)
        let readerSettings: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
        ]

        let screenOutput = AVAssetReaderTrackOutput(track: screenTrack, outputSettings: readerSettings)
        screenOutput.alwaysCopiesSampleData = false
        guard screenReader.canAdd(screenOutput) else { return false }
        screenReader.add(screenOutput)

        var cameraReader: AVAssetReader?
        var cameraOutput: AVAssetReaderTrackOutput?
        if let cameraURL {
            let cameraAsset = AVURLAsset(url: cameraURL)
            if let cameraTrack = cameraAsset.tracks(withMediaType: .video).first {
                let reader = try AVAssetReader(asset: cameraAsset)
                let output = AVAssetReaderTrackOutput(track: cameraTrack, outputSettings: readerSettings)
                output.alwaysCopiesSampleData = false
                if reader.canAdd(output) {
                    reader.add(output)
                    cameraReader = reader
                    cameraOutput = output
                }
            }
        }

        let resolvedCuts = Self.resolvedEditCuts(
            decision.cuts,
            totalDuration: CMTimeGetSeconds(screenAsset.duration),
            hasCamera: cameraOutput != nil
        )
        guard !resolvedCuts.isEmpty else { return false }

        let writer = try AVAssetWriter(outputURL: outputURL, fileType: .mov)
        let editedBitRate = max(
            8_000_000,
            outputWidth * outputHeight * 3 * Self.screenTargetFrameRate / 30
        )
        let videoSettings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.h264,
            AVVideoWidthKey: outputWidth,
            AVVideoHeightKey: outputHeight,
            AVVideoColorPropertiesKey: Self.rec709VideoColorProperties(),
            AVVideoCompressionPropertiesKey: [
                AVVideoAverageBitRateKey: editedBitRate,
                AVVideoMaxKeyFrameIntervalKey: Self.screenTargetFrameRate / 2,
                AVVideoProfileLevelKey: AVVideoProfileLevelH264HighAutoLevel,
                AVVideoAllowFrameReorderingKey: false,
                AVVideoExpectedSourceFrameRateKey: Self.screenTargetFrameRate,
                AVVideoQualityKey: 0.92
            ]
        ]

        let writerInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
        writerInput.expectsMediaDataInRealTime = false

        let pixelBufferAttributes: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA,
            kCVPixelBufferWidthKey as String: outputWidth,
            kCVPixelBufferHeightKey as String: outputHeight,
            kCVPixelBufferCGImageCompatibilityKey as String: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
        ]

        let adapter = AVAssetWriterInputPixelBufferAdaptor(
            assetWriterInput: writerInput,
            sourcePixelBufferAttributes: pixelBufferAttributes
        )

        guard writer.canAdd(writerInput) else { return false }
        writer.add(writerInput)

        guard screenReader.startReading(),
              writer.startWriting() else {
            return false
        }

        if cameraReader?.startReading() != true {
            cameraReader = nil
            cameraOutput = nil
        }

        writer.startSession(atSourceTime: .zero)

        let ciContext = CIContext()
        var currentCameraPixelBuffer: CVPixelBuffer?
        var nextCameraSample = cameraOutput?.copyNextSampleBuffer()
        var maskCache: [String: CIImage] = [:]
        var cutIndex = 0

        func advanceCameraFrame(to screenTime: CMTime) {
            while let sample = nextCameraSample {
                let sampleTime = CMSampleBufferGetPresentationTimeStamp(sample)
                guard sampleTime <= screenTime || currentCameraPixelBuffer == nil else {
                    break
                }

                if let pixelBuffer = CMSampleBufferGetImageBuffer(sample) {
                    currentCameraPixelBuffer = pixelBuffer
                }

                nextCameraSample = cameraOutput?.copyNextSampleBuffer()
            }
        }

        while let screenSample = screenOutput.copyNextSampleBuffer() {
            let screenTime = CMSampleBufferGetPresentationTimeStamp(screenSample)
            let screenSeconds = CMTimeGetSeconds(screenTime)
            guard screenSeconds.isFinite else { continue }

            while cutIndex < resolvedCuts.count,
                  screenSeconds >= resolvedCuts[cutIndex].endSeconds {
                cutIndex += 1
            }

            guard cutIndex < resolvedCuts.count else { break }

            let resolvedCut = resolvedCuts[cutIndex]
            guard screenSeconds >= resolvedCut.startSeconds,
                  screenSeconds <= resolvedCut.endSeconds else {
                continue
            }

            advanceCameraFrame(to: screenTime)

            guard let screenPixelBuffer = CMSampleBufferGetImageBuffer(screenSample),
                  let outputPixelBuffer = Self.createPixelBuffer(from: adapter) else {
                continue
            }

            let screenImage = CIImage(cvPixelBuffer: screenPixelBuffer)
            let cameraImage = currentCameraPixelBuffer.map { CIImage(cvPixelBuffer: $0) }
            let overlaySample = metadata.map { Self.overlaySample(at: screenSeconds, in: $0.samples) } ?? nil
            let composedImage = Self.composeEditedImage(
                screenImage,
                cameraImage: cameraImage,
                cut: resolvedCut.cut,
                overlaySample: overlaySample,
                outputExtent: outputExtent,
                maskCache: &maskCache
            )

            ciContext.render(
                composedImage,
                to: outputPixelBuffer,
                bounds: outputExtent,
                colorSpace: CGColorSpaceCreateDeviceRGB()
            )

            while !writerInput.isReadyForMoreMediaData {
                Thread.sleep(forTimeInterval: 0.002)
            }

            let outputSeconds = resolvedCut.outputStartSeconds + (screenSeconds - resolvedCut.startSeconds)
            adapter.append(outputPixelBuffer, withPresentationTime: CMTime(seconds: outputSeconds, preferredTimescale: 600))
        }

        writerInput.markAsFinished()
        screenReader.cancelReading()
        cameraReader?.cancelReading()

        let completed = DispatchSemaphore(value: 0)
        writer.finishWriting {
            completed.signal()
        }
        completed.wait()

        return writer.status == .completed
    }

    private nonisolated static func renderTransparentCameraVideo(
        screenURL: URL,
        cameraURL: URL,
        metadata: CameraOverlayMetadataFile,
        outputURL: URL
    ) throws -> Bool {
        let screenAsset = AVURLAsset(url: screenURL)
        let cameraAsset = AVURLAsset(url: cameraURL)

        guard let screenTrack = screenAsset.tracks(withMediaType: .video).first,
              let cameraTrack = cameraAsset.tracks(withMediaType: .video).first else {
            return false
        }

        let screenSize = Self.normalizedVideoSize(for: screenTrack)
        let outputWidth = max(2, Int(screenSize.width.rounded(.down)) / 2 * 2)
        let outputHeight = max(2, Int(screenSize.height.rounded(.down)) / 2 * 2)

        let cameraReader = try AVAssetReader(asset: cameraAsset)
        let readerSettings: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
        ]

        let cameraOutput = AVAssetReaderTrackOutput(track: cameraTrack, outputSettings: readerSettings)
        cameraOutput.alwaysCopiesSampleData = false
        guard cameraReader.canAdd(cameraOutput) else { return false }
        cameraReader.add(cameraOutput)

        let writer = try AVAssetWriter(outputURL: outputURL, fileType: .mov)
        let alphaBitRate = max(
            6_000_000,
            outputWidth * outputHeight * Self.screenTargetFrameRate / 20
        )
        let videoSettings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.hevcWithAlpha,
            AVVideoWidthKey: outputWidth,
            AVVideoHeightKey: outputHeight,
            AVVideoColorPropertiesKey: Self.rec709VideoColorProperties(),
            AVVideoCompressionPropertiesKey: [
                AVVideoAverageBitRateKey: alphaBitRate,
                AVVideoMaxKeyFrameIntervalKey: Self.screenTargetFrameRate / 2,
                AVVideoAllowFrameReorderingKey: false,
                AVVideoExpectedSourceFrameRateKey: Self.screenTargetFrameRate,
                AVVideoQualityKey: 0.94
            ]
        ]

        let writerInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
        writerInput.expectsMediaDataInRealTime = false

        let pixelBufferAttributes: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA,
            kCVPixelBufferWidthKey as String: outputWidth,
            kCVPixelBufferHeightKey as String: outputHeight,
            kCVPixelBufferCGImageCompatibilityKey as String: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
        ]

        let adapter = AVAssetWriterInputPixelBufferAdaptor(
            assetWriterInput: writerInput,
            sourcePixelBufferAttributes: pixelBufferAttributes
        )

        guard writer.canAdd(writerInput) else { return false }
        writer.add(writerInput)

        guard cameraReader.startReading(),
              writer.startWriting() else {
            return false
        }

        writer.startSession(atSourceTime: .zero)

        let ciContext = CIContext()
        var maskCache: [String: CIImage] = [:]
        let outputExtent = CGRect(x: 0, y: 0, width: outputWidth, height: outputHeight)

        while let cameraSample = cameraOutput.copyNextSampleBuffer() {
            guard let cameraPixelBuffer = CMSampleBufferGetImageBuffer(cameraSample),
                  let outputPixelBuffer = Self.createPixelBuffer(from: adapter) else {
                continue
            }

            let cameraTime = CMSampleBufferGetPresentationTimeStamp(cameraSample)
            let seconds = max(0, CMTimeGetSeconds(cameraTime))
            let sample = Self.overlaySample(at: seconds, in: metadata.samples)
            let composedImage = Self.composeTransparentCameraImage(
                CIImage(cvPixelBuffer: cameraPixelBuffer),
                overlaySample: sample,
                metadata: metadata,
                outputExtent: outputExtent,
                maskCache: &maskCache
            )

            ciContext.render(
                composedImage,
                to: outputPixelBuffer,
                bounds: outputExtent,
                colorSpace: CGColorSpaceCreateDeviceRGB()
            )

            while !writerInput.isReadyForMoreMediaData {
                Thread.sleep(forTimeInterval: 0.002)
            }

            adapter.append(outputPixelBuffer, withPresentationTime: cameraTime.isValid ? cameraTime : .zero)
        }

        writerInput.markAsFinished()
        cameraReader.cancelReading()

        let completed = DispatchSemaphore(value: 0)
        writer.finishWriting {
            completed.signal()
        }
        completed.wait()

        return writer.status == .completed
    }

    private nonisolated static func composeScreenImage(
        _ screenImage: CIImage,
        cameraImage: CIImage?,
        overlaySample: CameraOverlayMetadataSample?,
        metadata: CameraOverlayMetadataFile,
        outputExtent: CGRect,
        maskCache: inout [String: CIImage]
    ) -> CIImage {
        guard let cameraImage, let overlaySample else {
            return screenImage.cropped(to: outputExtent)
        }

        let targetRect = Self.overlayTargetRect(
            from: overlaySample.frame.cgRect,
            metadata: metadata,
            outputExtent: outputExtent
        )

        guard targetRect.width > 1, targetRect.height > 1 else {
            return screenImage.cropped(to: outputExtent)
        }

        let scaledCamera = Self.aspectFill(
            cameraImage,
            sourceExtent: cameraImage.extent,
            targetRect: targetRect
        )

        let mask = Self.overlayMask(
            size: targetRect.size,
            shape: overlaySample.shape,
            cache: &maskCache
        ).transformed(by: CGAffineTransform(translationX: targetRect.minX, y: targetRect.minY))

        let blendedImage = scaledCamera.applyingFilter("CIBlendWithMask", parameters: [
            kCIInputBackgroundImageKey: screenImage.cropped(to: outputExtent),
            kCIInputMaskImageKey: mask
        ])

        return blendedImage.cropped(to: outputExtent)
    }

    private nonisolated static func composeTransparentCameraImage(
        _ cameraImage: CIImage,
        overlaySample: CameraOverlayMetadataSample?,
        metadata: CameraOverlayMetadataFile,
        outputExtent: CGRect,
        maskCache: inout [String: CIImage]
    ) -> CIImage {
        let transparentBackground = CIImage(color: CIColor(red: 0, green: 0, blue: 0, alpha: 0))
            .cropped(to: outputExtent)

        guard let overlaySample else {
            return transparentBackground
        }

        let targetRect = Self.overlayTargetRect(
            from: overlaySample.frame.cgRect,
            metadata: metadata,
            outputExtent: outputExtent
        )

        guard targetRect.width > 1, targetRect.height > 1 else {
            return transparentBackground
        }

        let scaledCamera = Self.aspectFill(
            cameraImage,
            sourceExtent: cameraImage.extent,
            targetRect: targetRect
        )

        let mask = Self.overlayMask(
            size: targetRect.size,
            shape: overlaySample.shape,
            cache: &maskCache
        ).transformed(by: CGAffineTransform(translationX: targetRect.minX, y: targetRect.minY))

        let blendedImage = scaledCamera.applyingFilter("CIBlendWithMask", parameters: [
            kCIInputBackgroundImageKey: transparentBackground,
            kCIInputMaskImageKey: mask
        ])

        return blendedImage.cropped(to: outputExtent)
    }

    private nonisolated static func composeEditedImage(
        _ screenImage: CIImage,
        cameraImage: CIImage?,
        cut: RecordingEditCut,
        overlaySample: CameraOverlayMetadataSample?,
        outputExtent: CGRect,
        maskCache: inout [String: CIImage]
    ) -> CIImage {
        let screenBase = screenImage.cropped(to: outputExtent)

        switch cut.layoutMode {
        case .screenFullScreen:
            return screenBase

        case .cameraFullScreen:
            guard let cameraImage else { return screenBase }
            return Self.aspectFill(
                cameraImage,
                sourceExtent: cameraImage.extent,
                targetRect: outputExtent
            )
            .cropped(to: outputExtent)

        case .screenWithCamera:
            guard let cameraImage else { return screenBase }

            let targetRect = cut.cameraFrame.videoRect(in: outputExtent)
            guard targetRect.width > 1, targetRect.height > 1 else {
                return screenBase
            }

            let scaledCamera = Self.aspectFill(
                cameraImage,
                sourceExtent: cameraImage.extent,
                targetRect: targetRect
            )

            let shape = Self.metadataShapeValue(for: cut.cameraShape)
            let mask = Self.overlayMask(
                size: targetRect.size,
                shape: shape,
                cache: &maskCache
            )
            .transformed(by: CGAffineTransform(translationX: targetRect.minX, y: targetRect.minY))

            let blendedImage = scaledCamera.applyingFilter("CIBlendWithMask", parameters: [
                kCIInputBackgroundImageKey: screenBase,
                kCIInputMaskImageKey: mask
            ])

            return blendedImage.cropped(to: outputExtent)
        }
    }

    private nonisolated static func aspectFill(
        _ image: CIImage,
        sourceExtent: CGRect,
        targetRect: CGRect
    ) -> CIImage {
        let scale = max(
            targetRect.width / max(sourceExtent.width, 1),
            targetRect.height / max(sourceExtent.height, 1)
        )
        let scaledWidth = sourceExtent.width * scale
        let scaledHeight = sourceExtent.height * scale
        let translationX = targetRect.midX - scaledWidth / 2 - sourceExtent.minX * scale
        let translationY = targetRect.midY - scaledHeight / 2 - sourceExtent.minY * scale

        return image
            .transformed(by: CGAffineTransform(scaleX: scale, y: scale))
            .transformed(by: CGAffineTransform(translationX: translationX, y: translationY))
    }

    private nonisolated static func overlayTargetRect(
        from overlayFrame: CGRect,
        metadata: CameraOverlayMetadataFile,
        outputExtent: CGRect
    ) -> CGRect {
        let sourceRect = metadata.recordingRect?.cgRect ?? outputExtent
        let scaleX = outputExtent.width / max(sourceRect.width, 1)
        let scaleY = outputExtent.height / max(sourceRect.height, 1)
        let uniformScale = min(scaleX, scaleY)
        let center = CGPoint(
            x: (overlayFrame.midX - sourceRect.minX) * scaleX,
            y: (overlayFrame.midY - sourceRect.minY) * scaleY
        )
        let size = CGSize(
            width: overlayFrame.width * uniformScale,
            height: overlayFrame.height * uniformScale
        )

        return CGRect(
            x: center.x - size.width / 2,
            y: center.y - size.height / 2,
            width: size.width,
            height: size.height
        )
    }

    private nonisolated static func overlayMask(size: CGSize, shape: String, cache: inout [String: CIImage]) -> CIImage {
        let width = max(2, Int(size.width.rounded()))
        let height = max(2, Int(size.height.rounded()))
        let key = "\(shape)-\(width)x\(height)"

        if let cachedMask = cache[key] {
            return cachedMask
        }

        let colorSpace = CGColorSpaceCreateDeviceGray()
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.none.rawValue
        ) else {
            return CIImage(color: .white).cropped(to: CGRect(x: 0, y: 0, width: width, height: height))
        }

        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context.setFillColor(CGColor(gray: 1, alpha: 1))

        if shape == "circle" {
            context.fillEllipse(in: rect)
        } else {
            let minSide = min(CGFloat(width), CGFloat(height))
            let radius = min(max(18, minSide * 0.16), minSide * 0.24)
            context.addPath(CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil))
            context.fillPath()
        }

        guard let cgImage = context.makeImage() else {
            return CIImage(color: .white).cropped(to: rect)
        }

        let mask = CIImage(cgImage: cgImage)
        cache[key] = mask
        return mask
    }

    private nonisolated static func metadataShapeValue(for shape: CameraOverlayShape) -> String {
        switch shape {
        case .circle:
            return "circle"
        case .roundedSquare:
            return "roundedRectangle"
        case .roundedBox:
            return "roundedSquare"
        }
    }

    private nonisolated static func resolvedEditCuts(
        _ cuts: [RecordingEditCut],
        totalDuration: Double,
        hasCamera: Bool
    ) -> [ResolvedRecordingEditCut] {
        let safeDuration = max(totalDuration.isFinite ? totalDuration : 0, 0.1)
        var outputStart = 0.0

        let sanitizedCuts = cuts
            .map { cut -> RecordingEditCut in
                var sanitized = cut
                sanitized.startTime = min(max(0, sanitized.startTime), safeDuration)
                sanitized.endTime = min(max(sanitized.startTime + 0.05, sanitized.endTime), safeDuration)
                if sanitized.layoutMode.requiresCamera && !hasCamera {
                    sanitized.layoutMode = .screenFullScreen
                }
                sanitized.cameraFrame = sanitized.cameraFrame.clamped()
                return sanitized
            }
            .filter { $0.duration > 0.05 }
            .sorted { $0.startTime < $1.startTime }

        let sourceCuts: [RecordingEditCut]
        if sanitizedCuts.isEmpty {
            sourceCuts = [
                RecordingEditCut(
                    startTime: 0,
                    endTime: safeDuration,
                    layoutMode: hasCamera ? .screenWithCamera : .screenFullScreen,
                    cameraFrame: .defaultCameraFrame,
                    cameraShape: .circle
                )
            ]
        } else {
            sourceCuts = sanitizedCuts
        }

        return sourceCuts.map { cut in
            let resolved = ResolvedRecordingEditCut(
                cut: cut,
                startSeconds: cut.startTime,
                endSeconds: cut.endTime,
                outputStartSeconds: outputStart
            )
            outputStart += resolved.duration
            return resolved
        }
    }

    private nonisolated static func overlaySample(
        at seconds: Double,
        in samples: [CameraOverlayMetadataSample]
    ) -> CameraOverlayMetadataSample? {
        guard var selectedSample = samples.first else { return nil }

        for sample in samples {
            guard sample.time <= seconds else { break }
            selectedSample = sample
        }

        return selectedSample
    }

    private nonisolated static func createPixelBuffer(from adapter: AVAssetWriterInputPixelBufferAdaptor) -> CVPixelBuffer? {
        guard let pixelBufferPool = adapter.pixelBufferPool else { return nil }

        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferPoolCreatePixelBuffer(nil, pixelBufferPool, &pixelBuffer)
        guard status == kCVReturnSuccess else { return nil }
        return pixelBuffer
    }

    private nonisolated static func normalizedVideoSize(for track: AVAssetTrack) -> CGSize {
        let naturalSize = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: abs(naturalSize.width), height: abs(naturalSize.height))
    }

    private nonisolated static func muxAudioFromScreenVideo(
        screenURL: URL,
        videoOnlyURL: URL,
        outputURL: URL,
        cuts: [RecordingEditCut]? = nil
    ) async -> Bool {
        let screenAsset = AVURLAsset(url: screenURL)
        let videoAsset = AVURLAsset(url: videoOnlyURL)
        let audioTracks = screenAsset.tracks(withMediaType: .audio)

        guard !audioTracks.isEmpty,
              let videoTrack = videoAsset.tracks(withMediaType: .video).first else {
            return false
        }

        if let cuts {
            return await Self.muxVideoWithEditedAudio(
                videoAsset: videoAsset,
                videoTrack: videoTrack,
                sourceDuration: screenAsset.duration,
                audioTracks: audioTracks,
                outputURL: outputURL,
                cuts: cuts
            )
        }

        if audioTracks.count > 1 {
            let mixedAudioURL = Self.siblingOutputURL(for: screenURL, suffix: "mixed_audio_tmp", extension: "m4a")
            try? FileManager.default.removeItem(at: mixedAudioURL)

            let mixed = await Self.exportSingleMixedAudioTrack(
                audioTracks: audioTracks,
                duration: videoAsset.duration,
                outputURL: mixedAudioURL
            )

            if mixed {
                defer { try? FileManager.default.removeItem(at: mixedAudioURL) }
                if await Self.muxVideoWithSingleAudioTrack(
                    videoAsset: videoAsset,
                    videoTrack: videoTrack,
                    audioURL: mixedAudioURL,
                    outputURL: outputURL
                ) {
                    return true
                }
                print("⚠️  Single-track audio mux failed; falling back to passthrough audio tracks")
            } else {
                print("⚠️  Mixed audio export failed; falling back to passthrough audio tracks")
            }
        }

        return await Self.muxVideoWithPassthroughAudioTracks(
            videoAsset: videoAsset,
            videoTrack: videoTrack,
            audioTracks: audioTracks,
            outputURL: outputURL
        )
    }

    private nonisolated static func muxVideoWithEditedAudio(
        videoAsset: AVURLAsset,
        videoTrack: AVAssetTrack,
        sourceDuration: CMTime,
        audioTracks: [AVAssetTrack],
        outputURL: URL,
        cuts: [RecordingEditCut]
    ) async -> Bool {
        let sourceDurationSeconds = CMTimeGetSeconds(sourceDuration)
        let resolvedCuts = Self.resolvedEditCuts(
            cuts,
            totalDuration: sourceDurationSeconds,
            hasCamera: true
        )
        guard !resolvedCuts.isEmpty else { return false }

        let composition = AVMutableComposition()
        guard let compositionVideoTrack = composition.addMutableTrack(
            withMediaType: .video,
            preferredTrackID: kCMPersistentTrackID_Invalid
        ) else {
            return false
        }

        do {
            try compositionVideoTrack.insertTimeRange(
                CMTimeRange(start: .zero, duration: videoAsset.duration),
                of: videoTrack,
                at: .zero
            )
            compositionVideoTrack.preferredTransform = videoTrack.preferredTransform
        } catch {
            print("❌ Edited video mux failed: \(error.localizedDescription)")
            return false
        }

        var mixParameters: [AVAudioMixInputParameters] = []
        for (index, audioTrack) in audioTracks.enumerated() {
            guard let compositionAudioTrack = composition.addMutableTrack(
                withMediaType: .audio,
                preferredTrackID: kCMPersistentTrackID_Invalid
            ) else {
                continue
            }

            for resolvedCut in resolvedCuts {
                let sourceStart = CMTime(seconds: resolvedCut.startSeconds, preferredTimescale: 600)
                let sourceDuration = CMTime(seconds: resolvedCut.duration, preferredTimescale: 600)
                let destinationStart = CMTime(seconds: resolvedCut.outputStartSeconds, preferredTimescale: 600)

                do {
                    try compositionAudioTrack.insertTimeRange(
                        CMTimeRange(start: sourceStart, duration: sourceDuration),
                        of: audioTrack,
                        at: destinationStart
                    )
                } catch {
                    print("⚠️  Failed to insert edited audio segment: \(error.localizedDescription)")
                }
            }

            let parameters = AVMutableAudioMixInputParameters(track: compositionAudioTrack)
            parameters.setVolume(audioMixVolume(forAudioTrackAt: index, trackCount: audioTracks.count), at: .zero)
            mixParameters.append(parameters)
        }

        guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else {
            return false
        }

        if !mixParameters.isEmpty {
            let audioMix = AVMutableAudioMix()
            audioMix.inputParameters = mixParameters
            exporter.audioMix = audioMix
        }

        exporter.outputURL = outputURL
        exporter.outputFileType = .mov
        exporter.shouldOptimizeForNetworkUse = false

        return await withCheckedContinuation { (continuation: CheckedContinuation<Bool, Never>) in
            exporter.exportAsynchronously {
                continuation.resume(returning: exporter.status == .completed)
            }
        }
    }

    private nonisolated static func exportSingleMixedAudioTrack(
        audioTracks: [AVAssetTrack],
        duration: CMTime,
        outputURL: URL
    ) async -> Bool {
        let composition = AVMutableComposition()
        var mixParameters: [AVAudioMixInputParameters] = []

        for (index, audioTrack) in audioTracks.enumerated() {
            guard let compositionTrack = composition.addMutableTrack(
                withMediaType: .audio,
                preferredTrackID: kCMPersistentTrackID_Invalid
            ) else {
                continue
            }

            let insertionTime = audioTrack.timeRange.start.isValid ? audioTrack.timeRange.start : .zero
            let availableDuration = CMTimeSubtract(duration, insertionTime)
            let sourceDuration = CMTimeMinimum(audioTrack.timeRange.duration, availableDuration)
            guard sourceDuration.isValid, sourceDuration > .zero else { continue }

            do {
                try compositionTrack.insertTimeRange(
                    CMTimeRange(start: .zero, duration: sourceDuration),
                    of: audioTrack,
                    at: insertionTime
                )
                let parameters = AVMutableAudioMixInputParameters(track: compositionTrack)
                parameters.setVolume(audioMixVolume(forAudioTrackAt: index, trackCount: audioTracks.count), at: .zero)
                mixParameters.append(parameters)
            } catch {
                print("⚠️  Failed to insert audio track for mix: \(error.localizedDescription)")
            }
        }

        guard !mixParameters.isEmpty,
              let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A) else {
            return false
        }

        let audioMix = AVMutableAudioMix()
        audioMix.inputParameters = mixParameters
        exporter.audioMix = audioMix
        exporter.outputURL = outputURL
        exporter.outputFileType = .m4a
        exporter.shouldOptimizeForNetworkUse = false

        print("🎚️  Exporting single mixed audio track from \(audioTracks.count) source tracks")
        return await withCheckedContinuation { (continuation: CheckedContinuation<Bool, Never>) in
            exporter.exportAsynchronously {
                continuation.resume(returning: exporter.status == .completed)
            }
        }
    }

    private nonisolated static func muxVideoWithSingleAudioTrack(
        videoAsset: AVURLAsset,
        videoTrack: AVAssetTrack,
        audioURL: URL,
        outputURL: URL
    ) async -> Bool {
        let audioAsset = AVURLAsset(url: audioURL)
        guard let audioTrack = audioAsset.tracks(withMediaType: .audio).first else {
            return false
        }

        return await muxVideoWithPassthroughAudioTracks(
            videoAsset: videoAsset,
            videoTrack: videoTrack,
            audioTracks: [audioTrack],
            outputURL: outputURL
        )
    }

    private nonisolated static func muxVideoWithPassthroughAudioTracks(
        videoAsset: AVURLAsset,
        videoTrack: AVAssetTrack,
        audioTracks: [AVAssetTrack],
        outputURL: URL
    ) async -> Bool {
        let composition = AVMutableComposition()

        guard let compositionVideoTrack = composition.addMutableTrack(
            withMediaType: .video,
            preferredTrackID: kCMPersistentTrackID_Invalid
        ) else {
            return false
        }

        do {
            try compositionVideoTrack.insertTimeRange(
                CMTimeRange(start: .zero, duration: videoAsset.duration),
                of: videoTrack,
                at: .zero
            )
            compositionVideoTrack.preferredTransform = videoTrack.preferredTransform

            for audioTrack in audioTracks {
                guard let compositionAudioTrack = composition.addMutableTrack(
                    withMediaType: .audio,
                    preferredTrackID: kCMPersistentTrackID_Invalid
                ) else { continue }

                try compositionAudioTrack.insertTimeRange(
                    CMTimeRange(start: .zero, duration: videoAsset.duration),
                    of: audioTrack,
                    at: .zero
                )
            }
        } catch {
            print("❌ 合成视频复用音频失败: \(error.localizedDescription)")
            return false
        }

        guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetPassthrough) else {
            return false
        }

        exporter.outputURL = outputURL
        exporter.outputFileType = .mov
        exporter.shouldOptimizeForNetworkUse = false

        return await withCheckedContinuation { (continuation: CheckedContinuation<Bool, Never>) in
            exporter.exportAsynchronously {
                continuation.resume(returning: exporter.status == .completed)
            }
        }
    }

    private nonisolated static func audioMixVolume(forAudioTrackAt index: Int, trackCount: Int) -> Float {
        guard trackCount > 1 else { return 1.0 }

        // AVAssetWriter adds system audio before microphone audio. Keep headroom
        // when both are present so playback apps do not clip while summing.
        return index == 0 ? 0.55 : 0.85
    }
    
    // MARK: - 完成视频写入
    private func finishVideoWriting() async -> CapturedRecordingOutput? {
        guard let writer = videoWriter else { return nil }
        let completedOutputURL = outputURL
        let completedCameraURL = enableCameraOverlay ? cameraOutputURL : nil
        let completedOverlayMetadataURL = enableCameraOverlay ? overlayMetadataURL : nil
        var capturedOutput: CapturedRecordingOutput?
        
        print("🎬 完成视频写入，总帧数: \(frameCount)")
        
        videoWriterInput?.markAsFinished()
        audioWriterInput?.markAsFinished()
        microphoneWriterInput?.markAsFinished()
        
        await writer.finishWriting()
        
        switch writer.status {
        case .completed:
            print("✅ 视频文件保存成功: \(completedOutputURL?.lastPathComponent ?? "")")
            if let url = completedOutputURL {
                let fileSize = try? FileManager.default.attributesOfItem(atPath: url.path)[.size] as? Int64 ?? 0
                print("📄 文件大小: \(fileSize ?? 0) bytes")
                writeRecordingMetrics(for: url)
                capturedOutput = CapturedRecordingOutput(
                    outputURL: url,
                    cameraURL: Self.existingFileURL(completedCameraURL),
                    overlayMetadataURL: Self.existingFileURL(completedOverlayMetadataURL)
                )
            }
        case .failed:
            print("❌ 视频文件保存失败: \(writer.error?.localizedDescription ?? "未知错误")")
            if let url = completedOutputURL {
                writeRecordingMetrics(for: url)
            }
        case .cancelled:
            print("⚠️  视频写入被取消")
            if let url = completedOutputURL {
                writeRecordingMetrics(for: url)
            }
        default:
            print("⚠️  视频写入状态未知: \(writer.status.rawValue)")
            if let url = completedOutputURL {
                writeRecordingMetrics(for: url)
            }
        }
        
        // 清理资源
        videoWriter = nil
        videoWriterInput = nil
        audioWriterInput = nil
        microphoneWriterInput = nil
        pixelBufferAdapter = nil

        return capturedOutput
    }

    private func writeRecordingMetrics(for outputURL: URL) {
        let expectedMinimumDuration: TimeInterval
        if frameCount > 0 {
            expectedMinimumDuration = min(0.5, max(0.1, Double(frameCount) / Double(Self.screenTargetFrameRate) * 0.5))
        } else {
            expectedMinimumDuration = 0.1
        }

        let validation = RecordingOutputValidator.validate(
            outputURL: outputURL,
            expectedMinimumDuration: expectedMinimumDuration
        )
        recordingMetrics.applyValidation(validation)
        recordingMetrics.markFinished()
        recordingMetrics.write(to: outputURL)
    }

    private nonisolated static func existingFileURL(_ url: URL?) -> URL? {
        guard let url, FileManager.default.fileExists(atPath: url.path) else { return nil }
        return url
    }

    private static func startRecordingPostProcessing(
        capturedOutput: CapturedRecordingOutput,
        mode: RecordingRenderMode,
        handler: (@MainActor (RecordingPostProcessingEvent) -> Void)?
    ) {
        handler?(.started(outputURL: capturedOutput.outputURL, mode: mode))
        Task.detached(priority: .utility) {
            let result = await Self.runRecordingPostProcessing(
                capturedOutput: capturedOutput,
                mode: mode
            )
            await MainActor.run {
                handler?(.completed(result))
            }
        }
    }

    private nonisolated static func runRecordingPostProcessing(
        capturedOutput: CapturedRecordingOutput,
        mode: RecordingRenderMode
    ) async -> RecordingPostProcessingResult {
        print("ℹ️  Starting recording post-processing")
        let outputURL = capturedOutput.outputURL
        let exportStart = Date()
        let compositedURL: URL?
        let cameraOnlyURL: URL?

        switch mode {
        case .all:
            compositedURL = await Self.exportCompositedVideoIfNeeded(
                for: outputURL,
                cameraURL: capturedOutput.cameraURL,
                overlayMetadataURL: capturedOutput.overlayMetadataURL
            )
            cameraOnlyURL = nil
        case .cameraOnlyTransparent:
            compositedURL = nil
            cameraOnlyURL = await Self.exportTransparentCameraVideoIfNeeded(
                for: outputURL,
                cameraURL: capturedOutput.cameraURL,
                overlayMetadataURL: capturedOutput.overlayMetadataURL
            )
        case .edited(let decision):
            compositedURL = await Self.exportEditedRecordingIfNeeded(
                for: outputURL,
                cameraURL: capturedOutput.cameraURL,
                overlayMetadataURL: capturedOutput.overlayMetadataURL,
                decision: decision
            )
            cameraOnlyURL = nil
        }

        let finalOutputURL = compositedURL
            ?? cameraOnlyURL
            ?? (mode == .cameraOnlyTransparent ? capturedOutput.cameraURL : nil)
            ?? outputURL
        if compositedURL != nil || cameraOnlyURL != nil {
            updateMetricsExportDuration(
                for: outputURL,
                duration: Date().timeIntervalSince(exportStart)
            )
        }

        let movedRawArtifactCount: Int
        do {
            let movedURLs = try RecordingArtifactOrganizer.moveRawArtifacts(
                in: outputURL.deletingLastPathComponent(),
                keeping: finalOutputURL
            )
            movedRawArtifactCount = movedURLs.count
            if movedRawArtifactCount > 0 {
                print("✅ Raw recording data moved to \(RecordingArtifactOrganizer.rawDataDirectoryName): \(movedRawArtifactCount) files")
            }
        } catch {
            movedRawArtifactCount = 0
            print("⚠️  Failed to organize raw recording data: \(error.localizedDescription)")
        }

        return RecordingPostProcessingResult(
            finalOutputURL: finalOutputURL,
            mode: mode,
            didExportCompositedVideo: compositedURL != nil,
            didExportCameraOnlyVideo: cameraOnlyURL != nil,
            movedRawArtifactCount: movedRawArtifactCount
        )
    }

    private nonisolated static func updateMetricsExportDuration(for outputURL: URL, duration: TimeInterval) {
        let metricsURL = RecordingMetricsRecorder.metricsURL(for: outputURL)
        guard FileManager.default.fileExists(atPath: metricsURL.path) else { return }

        do {
            let data = try Data(contentsOf: metricsURL)
            var snapshot = try JSONDecoder().decode(RecordingMetricsSnapshot.self, from: data)
            snapshot.exportDurationSeconds = duration

            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            try encoder.encode(snapshot).write(to: metricsURL)
            print("✅ Recording export metrics updated: \(metricsURL.lastPathComponent)")
        } catch {
            print("⚠️  Failed to update export metrics: \(error.localizedDescription)")
        }
    }

    // MARK: - 区域保存和恢复
    private func saveSelectedArea(_ rect: CGRect) {
        let rectDict: [String: Double] = [
            "x": rect.origin.x,
            "y": rect.origin.y,
            "width": rect.width,
            "height": rect.height
        ]
        UserDefaults.standard.set(rectDict, forKey: "lastSelectedArea")
        print("💾 保存选择区域: \(rect)")
    }
    
    func getLastSelectedArea() -> CGRect? {
        guard let rectDict = UserDefaults.standard.dictionary(forKey: "lastSelectedArea") as? [String: Double],
              let x = rectDict["x"],
              let y = rectDict["y"],
              let width = rectDict["width"],
              let height = rectDict["height"] else {
            return nil
        }
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

// MARK: - SCStreamOutput
extension ScreenRecorder: SCStreamOutput {
    func stream(_ stream: SCStream, didOutputSampleBuffer sampleBuffer: CMSampleBuffer, of type: SCStreamOutputType) {
        Task { @MainActor in
            switch type {
            case .screen:
                await processVideoSampleBuffer(sampleBuffer)
            case .audio:
                await processAudioSampleBuffer(sampleBuffer, type: .systemAudio)
            case .microphone:
                if #available(macOS 15.0, *) {
                    await processAudioSampleBuffer(sampleBuffer, type: .microphone)
                }
            @unknown default:
                break
            }
        }
    }
}

// MARK: - SCStreamDelegate
extension ScreenRecorder: SCStreamDelegate {
    func stream(_ stream: SCStream, didStopWithError error: Error) {
        print("❌ Stream意外停止: \(error.localizedDescription)")
        Task { @MainActor in
            isRecording = false
        }
    }
}

// MARK: - 媒体处理
extension ScreenRecorder {
    private func processVideoSampleBuffer(_ sampleBuffer: CMSampleBuffer) async {
        guard let writer = videoWriter,
              let writerInput = videoWriterInput,
              writer.status == .writing else {
            return
        }

        guard isCompleteScreenFrame(sampleBuffer) else { return }

        // 获取当前帧的原始时间戳
        let currentFrameTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)

        // 设置录制开始时间（只设置一次）
        if firstVideoFrameTime == nil {
            firstVideoFrameTime = currentFrameTime
            recordingStartTime = .zero
            writer.startSession(atSourceTime: recordingStartTime)
            flushPendingAudioBuffers()
            print("🎬 录制会话开始，首帧时间: \(CMTimeGetSeconds(currentFrameTime))秒")
        }

        // 计算相对于第一帧的时间差，使用实际时间戳
        guard let firstTime = firstVideoFrameTime else { return }
        let relativeTime = CMTimeSubtract(currentFrameTime, firstTime)
        guard let adjustedBuffer = adjustedVideoSampleBuffer(sampleBuffer, relativeTo: firstTime) else {
            return
        }

        // 调试输出
        if frameCount % 30 == 0 { // 每秒打印一次
            let seconds = CMTimeGetSeconds(relativeTime)
            print("🎬 视频帧 \(frameCount): \(String(format: "%.3f", seconds))秒")
        }

        // 写入帧数据
        if writerInput.isReadyForMoreMediaData {
            let success = writerInput.append(adjustedBuffer)
            if success {
                frameCount += 1
                recordingMetrics.incrementScreenAppended()
            } else {
                print("⚠️  帧写入失败，帧号: \(frameCount)")
            }
        } else {
            recordingMetrics.incrementScreenWriterNotReady()
            print("⚠️  写入器未就绪，跳过帧: \(frameCount)")
        }
    }

    private func isCompleteScreenFrame(_ sampleBuffer: CMSampleBuffer) -> Bool {
        guard let attachmentsArray = CMSampleBufferGetSampleAttachmentsArray(
            sampleBuffer,
            createIfNecessary: false
        ) as? [[SCStreamFrameInfo: Any]],
              let attachments = attachmentsArray.first,
              let statusRawValue = attachments[SCStreamFrameInfo.status] as? Int,
              let status = SCFrameStatus(rawValue: statusRawValue) else {
            return false
        }

        return status == .complete
    }

    private func adjustedVideoSampleBuffer(_ sampleBuffer: CMSampleBuffer, relativeTo firstTime: CMTime) -> CMSampleBuffer? {
        adjustedSampleBuffer(sampleBuffer, relativeTo: firstTime)
    }

    private func adjustedAudioSampleBuffer(_ sampleBuffer: CMSampleBuffer) -> CMSampleBuffer? {
        let originalTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
        let duration = CMSampleBufferGetDuration(sampleBuffer)

        switch audioStartGate.decision(
            audioStart: originalTime,
            audioDuration: duration,
            firstVideoStart: firstVideoFrameTime
        ) {
        case .waitForVideo:
            return nil
        case .dropBeforeVideo:
            recordingMetrics.incrementDroppedAudioBeforeVideo()
            return nil
        case .append(let relativeTo, let partialOverlap):
            if partialOverlap > .zero {
                recordingMetrics.addPartialAudioOverlap(partialOverlap)
            }
            return adjustedSampleBuffer(
                sampleBuffer,
                relativeTo: relativeTo,
                clampNegativeTimestamps: partialOverlap > .zero
            )
        }
    }

    private func adjustedSampleBuffer(
        _ sampleBuffer: CMSampleBuffer,
        relativeTo offset: CMTime,
        clampNegativeTimestamps: Bool = false
    ) -> CMSampleBuffer? {
        var timingEntryCount: CMItemCount = 0
        let entryCountStatus = CMSampleBufferGetSampleTimingInfoArray(
            sampleBuffer,
            entryCount: 0,
            arrayToFill: nil,
            entriesNeededOut: &timingEntryCount
        )

        guard entryCountStatus == noErr, timingEntryCount > 0 else {
            print("❌ 读取样本时间条目数量失败: \(entryCountStatus)")
            return nil
        }

        var timingInfo = [CMSampleTimingInfo](
            repeating: CMSampleTimingInfo(duration: .invalid, presentationTimeStamp: .invalid, decodeTimeStamp: .invalid),
            count: Int(timingEntryCount)
        )

        let timingStatus = CMSampleBufferGetSampleTimingInfoArray(
            sampleBuffer,
            entryCount: timingEntryCount,
            arrayToFill: &timingInfo,
            entriesNeededOut: nil
        )

        if timingStatus != noErr {
            print("❌ 读取样本时间信息失败: \(timingStatus)")
            return nil
        }

        for index in 0..<timingInfo.count {
            if timingInfo[index].presentationTimeStamp.isValid {
                var presentationTimeStamp = CMTimeSubtract(timingInfo[index].presentationTimeStamp, offset)
                if clampNegativeTimestamps, presentationTimeStamp.isValid, presentationTimeStamp < .zero {
                    presentationTimeStamp = .zero
                }
                timingInfo[index].presentationTimeStamp = presentationTimeStamp
            }
            if timingInfo[index].decodeTimeStamp.isValid {
                var decodeTimeStamp = CMTimeSubtract(timingInfo[index].decodeTimeStamp, offset)
                if clampNegativeTimestamps, decodeTimeStamp.isValid, decodeTimeStamp < .zero {
                    decodeTimeStamp = .zero
                }
                timingInfo[index].decodeTimeStamp = decodeTimeStamp
            }
        }

        var adjustedBuffer: CMSampleBuffer?
        let status = CMSampleBufferCreateCopyWithNewTiming(
            allocator: kCFAllocatorDefault,
            sampleBuffer: sampleBuffer,
            sampleTimingEntryCount: timingInfo.count,
            sampleTimingArray: &timingInfo,
            sampleBufferOut: &adjustedBuffer
        )

        if status != noErr {
            print("❌ 创建调整后的样本缓冲失败: \(status)")
            return nil
        }

        return adjustedBuffer
    }
    
    // MARK: - 音频处理
    private func processAudioSampleBuffer(_ sampleBuffer: CMSampleBuffer, type: AudioType) async {
        guard let writer = videoWriter,
              writer.status == .writing else {
            return
        }

        guard firstVideoFrameTime != nil else {
            queuePendingAudio(sampleBuffer, type: type)
            return
        }

        appendAudioSampleBuffer(sampleBuffer, type: type)
    }

    private func queuePendingAudio(_ sampleBuffer: CMSampleBuffer, type: AudioType) {
        pendingAudioBuffers.append(PendingAudioSample(sampleBuffer: sampleBuffer, type: type))
        recordingMetrics.incrementQueuedAudioBeforeVideo()

        guard let newestAudioStart = pendingAudioBuffers.last.map({ CMSampleBufferGetPresentationTimeStamp($0.sampleBuffer) }) else {
            return
        }

        while pendingAudioBuffers.count > 48 {
            pendingAudioBuffers.removeFirst()
            recordingMetrics.incrementDroppedAudioBeforeVideo()
        }

        while let oldestAudioStart = pendingAudioBuffers.first.map({ CMSampleBufferGetPresentationTimeStamp($0.sampleBuffer) }),
              !audioStartGate.shouldKeepPendingAudio(newestAudioStart: newestAudioStart, oldestAudioStart: oldestAudioStart) {
            pendingAudioBuffers.removeFirst()
            recordingMetrics.incrementDroppedAudioBeforeVideo()
        }
    }

    private func flushPendingAudioBuffers() {
        guard !pendingAudioBuffers.isEmpty else { return }

        let pending = pendingAudioBuffers
        pendingAudioBuffers.removeAll(keepingCapacity: true)
        for sample in pending {
            appendAudioSampleBuffer(sample.sampleBuffer, type: sample.type)
        }
    }

    private func appendAudioSampleBuffer(_ sampleBuffer: CMSampleBuffer, type: AudioType) {
        let writerInput: AVAssetWriterInput?
        
        switch type {
        case .systemAudio:
            writerInput = audioWriterInput
        case .microphone:
            writerInput = microphoneWriterInput
        }
        
        guard let input = writerInput else {
            print("⚠️  音频写入器不可用: \(type)")
            return
        }
        
        // SCK 音频与屏幕帧共享 host-time 时间轴；统一按首个完整视频帧归零。
        guard let adjustedBuffer = adjustedAudioSampleBuffer(sampleBuffer) else {
            return
        }
        
        if input.isReadyForMoreMediaData {
            let success = input.append(adjustedBuffer)
            if success {
                // 音频写入成功
                if frameCount % 300 == 0 {  // 每10秒打印一次
                    print("🔊 音频样本写入成功: \(type)")
                }
            } else {
                recordingMetrics.incrementAudioAppendFailed()
                print("❌ 音频样本写入失败: \(type)")
            }
        } else {
            recordingMetrics.incrementAudioWriterNotReady()
            print("⚠️  音频写入器未就绪: \(type)")
        }
    }
}

// MARK: - 错误类型
enum RecordingError: Error, LocalizedError {
    case invalidState
    case noDisplayFound
    case noWindowFound
    case invalidOutputURL
    case writerSetupFailed
    case writerNotFound
    case audioSetupFailed
    case permissionDenied
    
    var errorDescription: String? {
        switch self {
        case .invalidState:
            return "Invalid recording state"
        case .noDisplayFound:
            return "No recordable display found"
        case .noWindowFound:
            return "No recordable window found"
        case .invalidOutputURL:
            return "Invalid output file path"
        case .writerSetupFailed:
            return "Failed to set up video writer"
        case .writerNotFound:
            return "Video writer not found"
        case .audioSetupFailed:
            return "Failed to set up audio"
        case .permissionDenied:
            return "Screen recording permission denied"
        }
    }
}
