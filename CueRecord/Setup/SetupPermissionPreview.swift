import AppKit
@preconcurrency import AVFoundation
import Combine
import CoreAudio
import CoreImage
import SwiftUI

struct ScreenPermissionPreview: View {
    @ObservedObject var permissionsManager: PermissionsManager
    let isBusy: Bool
    let request: () async -> Void
    @State private var hasRequestedOnAppear = false

    var body: some View {
        HStack(spacing: 18) {
            PermissionStatusBlock(
                systemImage: "rectangle.dashed",
                title: "Screen and System Audio Recording",
                status: permissionsManager.screenRecordingAuthorized ? "Granted" : "Not Granted",
                isGranted: permissionsManager.screenRecordingAuthorized
            )

            Spacer(minLength: 12)

            Button {
                Task {
                    await request()
                }
            } label: {
                Text(isBusy ? "Working" : (permissionsManager.screenRecordingAuthorized ? "Recheck" : "Authorize"))
                    .frame(width: 92)
            }
            .disabled(isBusy)
        }
        .permissionPreviewPadding()
        .task {
            guard !hasRequestedOnAppear, !permissionsManager.screenRecordingAuthorized else { return }
            hasRequestedOnAppear = true
            await request()
        }
    }
}

struct MicrophonePermissionPreview: View {
    @ObservedObject var permissionsManager: PermissionsManager
    @ObservedObject var audioManager: AudioManager
    @StateObject private var monitor = SetupMicrophoneMonitor()

    var body: some View {
        HStack(spacing: 18) {
            PermissionStatusBlock(
                systemImage: "mic.fill",
                title: "Test Microphone",
                status: microphoneStatus,
                isGranted: monitor.hasReceivedSample || permissionsManager.microphoneAuthorized,
                detail: monitor.errorMessage
            )

            VStack(alignment: .trailing, spacing: 12) {
                MicrophoneLevelMeter(level: monitor.level)

                Button {
                    Task {
                        await activate(forceRestart: true)
                    }
                } label: {
                    Text(monitor.isStarting ? "Testing" : "Test Microphone")
                        .frame(width: 128)
                }
                .disabled(monitor.isStarting)
            }
        }
        .permissionPreviewPadding()
        .task {
            await activate(forceRestart: false)
        }
        .onChange(of: permissionsManager.microphoneAuthorized) { _, isAuthorized in
            if isAuthorized {
                Task {
                    await monitor.start(forceRestart: false, audioManager: audioManager)
                }
            } else {
                monitor.stop()
            }
        }
        .onDisappear {
            monitor.stop()
        }
    }

    @MainActor
    private func activate(forceRestart: Bool) async {
        if !permissionsManager.microphoneAuthorized {
            await permissionsManager.requestMicrophonePermission()
        }

        await audioManager.refreshMicrophoneDevices()
        await monitor.start(forceRestart: forceRestart, audioManager: audioManager)
        await permissionsManager.checkMicrophonePermission()
    }

    private var microphoneStatus: String {
        if monitor.hasReceivedSample {
            return "Input OK"
        }
        if permissionsManager.microphoneAuthorized {
            return "Granted"
        }
        return "Not Granted"
    }
}

struct CameraPermissionPreview: View {
    @ObservedObject var permissionsManager: PermissionsManager
    @ObservedObject var cameraManager: CameraManager
    @StateObject private var preview = SetupCameraPreviewController()

    var body: some View {
        HStack(spacing: 18) {
            VStack(alignment: .leading, spacing: 12) {
                PermissionStatusBlock(
                    systemImage: "camera.fill",
                    title: "Test Camera",
                    status: cameraStatus,
                    isGranted: preview.hasReceivedFrame || permissionsManager.cameraAuthorized,
                    detail: preview.errorMessage
                )

                Button {
                    Task {
                        await activate(forceRestart: true)
                    }
                } label: {
                    Text(preview.isStarting ? "Testing" : "Test Camera")
                        .frame(width: 108)
                }
                .disabled(preview.isStarting)
            }

            Spacer(minLength: 10)

            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.black.opacity(0.32))

                if preview.isRunning {
                    CameraManagerFramePreview(cameraManager: cameraManager)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                } else {
                    Image(systemName: "camera")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: 166, height: 100)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(nsColor: .separatorColor), lineWidth: 1)
            )
        }
        .permissionPreviewPadding()
        .task {
            await activate(forceRestart: false)
        }
        .onChange(of: permissionsManager.cameraAuthorized) { _, isAuthorized in
            if isAuthorized {
                Task {
                    await preview.start(
                        forceRestart: false,
                        permissionsManager: permissionsManager,
                        cameraManager: cameraManager
                    )
                }
            } else {
                preview.stop(cameraManager: cameraManager)
            }
        }
        .onDisappear {
            preview.stop(cameraManager: cameraManager)
        }
    }

    @MainActor
    private func activate(forceRestart: Bool) async {
        await preview.start(
            forceRestart: forceRestart,
            permissionsManager: permissionsManager,
            cameraManager: cameraManager
        )
        await permissionsManager.checkCameraPermission()
    }

    private var cameraStatus: String {
        if preview.hasReceivedFrame {
            return "Video OK"
        }
        if permissionsManager.cameraAuthorized {
            return "Granted"
        }
        return "Not Granted"
    }
}

private struct PermissionStatusBlock: View {
    let systemImage: String
    let title: String
    let status: String
    let isGranted: Bool
    var detail: String? = nil

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: systemImage)
                .font(.title3)
                .foregroundStyle(isGranted ? .green : Color.accentColor)
                .frame(width: 30, height: 30)

            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Text(title)
                        .font(.callout)
                        .fontWeight(.semibold)

                    Label(status, systemImage: isGranted ? "checkmark.circle.fill" : "circle")
                        .font(.caption)
                        .foregroundStyle(isGranted ? .green : .secondary)
                        .labelStyle(.titleAndIcon)
                }

                if let detail, !detail.isEmpty {
                    Text(detail)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct MicrophoneLevelMeter: View {
    let level: CGFloat

    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            ForEach(0..<12, id: \.self) { index in
                Capsule()
                    .fill(barColor(for: index))
                    .frame(width: 5, height: CGFloat(7 + index * 3))
            }
        }
        .frame(width: 104, height: 42, alignment: .bottom)
        .padding(.horizontal, 9)
        .padding(.vertical, 7)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(nsColor: .controlBackgroundColor))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color(nsColor: .separatorColor), lineWidth: 1)
        )
        .accessibilityLabel("Microphone input level")
    }

    private func barColor(for index: Int) -> Color {
        let activeBars = Int((level * 12).rounded(.down))
        guard index < activeBars else {
            return Color(nsColor: .separatorColor)
        }

        if index > 9 {
            return .orange
        }

        return .green
    }
}

@MainActor
private final class SetupMicrophoneMonitor: ObservableObject {
    @Published var level: CGFloat = 0
    @Published var isRunning = false
    @Published var isStarting = false
    @Published var hasReceivedSample = false
    @Published var errorMessage: String?

    private var engine: AVAudioEngine?
    private var sampleWaitTask: Task<Void, Never>?
    private var smoothedLevel: CGFloat = 0

    func start(forceRestart: Bool, audioManager: AudioManager) async {
        if isRunning, forceRestart {
            stop()
        }

        guard !isRunning, !isStarting else { return }
        isStarting = true
        hasReceivedSample = false
        errorMessage = nil

        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        if authorizationStatus == .notDetermined {
            let granted = await AVCaptureDevice.requestAccess(for: .audio)
            guard granted else {
                fail("Microphone permission not granted")
                return
            }
        } else if authorizationStatus != .authorized {
            fail("Microphone permission not granted")
            return
        }

        startAVAudioEngineMicrophone(deviceID: audioManager.selectedMicrophone.deviceID)
    }

    func stop() {
        guard isRunning || isStarting else { return }

        sampleWaitTask?.cancel()
        sampleWaitTask = nil
        engine?.inputNode.removeTap(onBus: 0)
        engine?.stop()
        engine = nil
        level = 0
        smoothedLevel = 0
        isRunning = false
        isStarting = false
        hasReceivedSample = false
    }

    private func startAVAudioEngineMicrophone(deviceID: AudioDeviceID?) {
        let engine = AVAudioEngine()
        configureInputDevice(deviceID, engine: engine)
        let inputNode = engine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        guard format.sampleRate > 0, format.channelCount > 0 else {
            fail("No input device")
            return
        }

        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 512, format: format) { [weak self] buffer, _ in
            guard let channelData = buffer.floatChannelData else { return }
            let frameLength = Int(buffer.frameLength)
            guard frameLength > 0 else { return }

            var sum: Float = 0
            let channelCount = Int(buffer.format.channelCount)
            for channel in 0..<channelCount {
                for frame in 0..<frameLength {
                    let sample = channelData[channel][frame]
                    sum += sample * sample
                }
            }

            let sampleCount = max(1, frameLength * max(1, channelCount))
            let rms = sqrt(sum / Float(sampleCount))
            let normalizedLevel = Self.normalizedLevel(forRMS: Double(rms))

            Task { @MainActor in
                self?.markReceivedAudioSample(level: normalizedLevel)
            }
        }

        do {
            engine.prepare()
            try engine.start()
            self.engine = engine
            isRunning = true
            isStarting = false
            waitForFirstSample()
        } catch {
            inputNode.removeTap(onBus: 0)
            fail("Microphone failed to start")
            print("❌ 麦克风检测启动失败: \(error.localizedDescription)")
        }
    }

    private func configureInputDevice(_ deviceID: AudioDeviceID?, engine: AVAudioEngine) {
        guard let deviceID else { return }
        guard let audioUnit = engine.inputNode.audioUnit else { return }

        var selectedDeviceID = deviceID
        let propertySize = UInt32(MemoryLayout<AudioDeviceID>.size)
        let status = AudioUnitSetProperty(
            audioUnit,
            kAudioOutputUnitProperty_CurrentDevice,
            kAudioUnitScope_Global,
            0,
            &selectedDeviceID,
            propertySize
        )

        if status != noErr {
            print("⚠️  麦克风测试设备设置失败: \(status)")
        }
    }

    private func markReceivedAudioSample(level normalizedLevel: CGFloat) {
        sampleWaitTask?.cancel()
        sampleWaitTask = nil
        hasReceivedSample = true
        errorMessage = nil

        let attack: CGFloat = normalizedLevel > smoothedLevel ? 0.22 : 0.12
        smoothedLevel = smoothedLevel + (normalizedLevel - smoothedLevel) * attack
        level = smoothedLevel
    }

    nonisolated private static func normalizedLevel(forRMS rms: Double) -> CGFloat {
        guard rms > 0 else { return 0 }

        let decibels = 20 * log10(rms)
        let floorDB = -60.0
        let ceilingDB = -3.0
        let clampedDB = min(max(decibels, floorDB), ceilingDB)
        let linearLevel = (clampedDB - floorDB) / (ceilingDB - floorDB)

        return CGFloat(pow(linearLevel, 1.7))
    }

    private func waitForFirstSample() {
        sampleWaitTask?.cancel()
        sampleWaitTask = Task { @MainActor in
            try? await Task.sleep(nanoseconds: 5_000_000_000)
            guard !Task.isCancelled, isRunning, !hasReceivedSample else { return }
            errorMessage = "No audio input"
        }
    }

    private func fail(_ message: String) {
        sampleWaitTask?.cancel()
        sampleWaitTask = nil
        level = 0
        smoothedLevel = 0
        isRunning = false
        isStarting = false
        hasReceivedSample = false
        engine = nil
        errorMessage = message
    }
}

@MainActor
private final class SetupCameraPreviewController: ObservableObject {
    @Published var isRunning = false
    @Published var isStarting = false
    @Published var hasReceivedFrame = false
    @Published var errorMessage: String?

    private var startedCameraManager = false
    private var frameWaitTask: Task<Void, Never>?

    func start(
        forceRestart: Bool,
        permissionsManager: PermissionsManager,
        cameraManager: CameraManager
    ) async {
        if isRunning, forceRestart {
            stop(cameraManager: cameraManager)
        }

        guard !isRunning, !isStarting else { return }
        isStarting = true
        hasReceivedFrame = false
        errorMessage = nil

        if !permissionsManager.cameraAuthorized {
            await permissionsManager.requestCameraPermission()
            await permissionsManager.checkCameraPermission()
        }

        guard permissionsManager.cameraAuthorized else {
            fail("Camera permission not granted")
            return
        }

        do {
            cameraManager.refreshCameraDevices()
            try await cameraManager.startCapture()
            guard cameraManager.isCapturing else {
                fail("Camera failed to start")
                return
            }

            startedCameraManager = true
            isRunning = true
            isStarting = false
            waitForFirstFrame(cameraManager: cameraManager)
        } catch {
            fail("Camera failed to start")
            print("❌ 摄像头测试启动失败: \(error.localizedDescription)")
        }
    }

    func stop(cameraManager: CameraManager) {
        frameWaitTask?.cancel()
        frameWaitTask = nil
        if startedCameraManager {
            cameraManager.stopCapture()
        }
        startedCameraManager = false
        isRunning = false
        isStarting = false
        hasReceivedFrame = false
    }

    private func fail(_ message: String) {
        frameWaitTask?.cancel()
        frameWaitTask = nil
        isRunning = false
        isStarting = false
        hasReceivedFrame = false
        errorMessage = message
    }

    private func waitForFirstFrame(cameraManager: CameraManager) {
        frameWaitTask?.cancel()
        frameWaitTask = Task { @MainActor in
            for _ in 0..<75 {
                guard !Task.isCancelled, isRunning, !hasReceivedFrame else { return }
                if cameraManager.getCurrentFrame() != nil {
                    hasReceivedFrame = true
                    errorMessage = nil
                    return
                }
                try? await Task.sleep(nanoseconds: 66_666_667)
            }

            guard !Task.isCancelled, isRunning, !hasReceivedFrame else { return }
            errorMessage = "No video frame"
        }
    }
}

private struct CameraManagerFramePreview: View {
    @ObservedObject var cameraManager: CameraManager
    @State private var image: NSImage?

    private let ciContext = CIContext()

    var body: some View {
        ZStack {
            if let image {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .controlSize(.small)
                    .tint(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
        .task {
            await renderFrames()
        }
    }

    @MainActor
    private func renderFrames() async {
        while !Task.isCancelled {
            if let pixelBuffer = cameraManager.getCurrentFrame() {
                let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
                if let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent) {
                    image = NSImage(
                        cgImage: cgImage,
                        size: NSSize(width: cgImage.width, height: cgImage.height)
                    )
                }
            }
            try? await Task.sleep(nanoseconds: 66_666_667)
        }
    }
}

private extension View {
    func permissionPreviewPadding() -> some View {
        self
            .frame(maxWidth: .infinity, minHeight: 160, alignment: .center)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
    }
}
