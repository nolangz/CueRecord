import Foundation
import AVFoundation
import Combine
import ScreenCaptureKit
import CoreGraphics
import CoreMedia
import CoreVideo
import AppKit

@MainActor
class PermissionsManager: ObservableObject {
    @Published var screenRecordingAuthorized = false
    @Published var microphoneAuthorized = false
    @Published var cameraAuthorized = false
    
    @Published var isCheckingPermissions = false
    
    init() {
        Task {
            await checkAllPermissions()
        }
    }
    
    // MARK: - 检查所有权限状态
    func checkAllPermissions() async {
        print("🔐 检查所有权限状态...")
        isCheckingPermissions = true
        
        await checkScreenRecordingPermission()
        await checkMicrophonePermission()
        await checkCameraPermission()
        
        isCheckingPermissions = false
        print("✅ 权限检查完成 - 屏幕:\(screenRecordingAuthorized) 麦克风:\(microphoneAuthorized) 摄像头:\(cameraAuthorized)")
    }
    
    // MARK: - 屏幕录制权限
    func checkScreenRecordingPermission() async {
        if #available(macOS 12.3, *) {
            let preflightGranted = CGPreflightScreenCaptureAccess()
            print("📺 CoreGraphics 屏幕录制预检: \(preflightGranted ? "已授权" : "未授权")")

            guard preflightGranted else {
                screenRecordingAuthorized = false
                return
            }

            do {
                // 尝试获取屏幕内容来验证 ScreenCaptureKit 在当前系统上的实际可用性。
                let availableContent = try await SCShareableContent.excludingDesktopWindows(
                    false,
                    onScreenWindowsOnly: true
                )
                screenRecordingAuthorized = !availableContent.displays.isEmpty
                print("📺 ScreenCaptureKit 屏幕录制权限: \(screenRecordingAuthorized ? "已授权" : "未授权")")
                
                if screenRecordingAuthorized {
                    print("📺 发现 \(availableContent.displays.count) 个显示器")
                    for (index, display) in availableContent.displays.enumerated() {
                        print("   显示器 \(index + 1): \(display.width)x\(display.height)")
                    }
                } else {
                    print("⚠️  无法获取显示器信息，可能权限未授权")
                }
            } catch {
                screenRecordingAuthorized = false
                print("❌ 屏幕录制权限检查失败: \(error.localizedDescription)")
            }
        } else {
            screenRecordingAuthorized = false
            print("⚠️  系统版本过低，不支持ScreenCaptureKit")
        }
    }
    
    func requestScreenRecordingPermission() async {
        print("📺 请求屏幕录制权限...")
        guard #available(macOS 12.3, *) else {
            screenRecordingAuthorized = false
            print("⚠️  系统版本过低，不支持ScreenCaptureKit")
            return
        }

        prepareForScreenRecordingPrompt()

        if CGPreflightScreenCaptureAccess() {
            await checkScreenRecordingPermission()
            return
        }

        await triggerScreenCaptureKitPermissionProbe(reason: "pre-request")
        if CGPreflightScreenCaptureAccess() {
            await checkScreenRecordingPermission()
            return
        }

        let grantedFromPrompt = CGRequestScreenCaptureAccess()
        print("📺 屏幕录制权限请求结果: \(grantedFromPrompt ? "已授权" : "未立即授权")")

        await waitForScreenRecordingPermissionUpdate()

        if !screenRecordingAuthorized {
            await triggerScreenCaptureKitPermissionProbe(reason: "post-request")
            await waitForScreenRecordingPermissionUpdate()
        }
        
        if !screenRecordingAuthorized {
            // 如果权限未授权，引导用户到系统设置。
            openScreenRecordingSettings()
        }
    }

    private func prepareForScreenRecordingPrompt() {
        if NSApp.activationPolicy() != .regular {
            NSApp.setActivationPolicy(.regular)
        }

        for window in NSApp.windows where !(window is NSPanel) {
            window.makeKeyAndOrderFront(nil)
        }

        NSApp.activate(ignoringOtherApps: true)
    }

    @available(macOS 12.3, *)
    private func triggerScreenCaptureKitPermissionProbe(reason: String) async {
        do {
            let availableContent = try await SCShareableContent.excludingDesktopWindows(
                false,
                onScreenWindowsOnly: true
            )
            guard let display = availableContent.displays.first else {
                print("📺 ScreenCaptureKit 授权探测(\(reason)): 未发现显示器")
                return
            }

            let configuration = SCStreamConfiguration()
            configuration.width = max(2, min(display.width, 1280))
            configuration.height = max(2, min(display.height, 720))
            configuration.pixelFormat = kCVPixelFormatType_32BGRA
            configuration.minimumFrameInterval = CMTime(value: 1, timescale: 5)
            configuration.queueDepth = 1
            configuration.showsCursor = false
            configuration.capturesAudio = false

            let filter = SCContentFilter(display: display, excludingWindows: [])
            let probe = ScreenCapturePermissionProbe()
            let stream = SCStream(filter: filter, configuration: configuration, delegate: probe)

            try stream.addStreamOutput(
                probe,
                type: .screen,
                sampleHandlerQueue: DispatchQueue(label: "com.cuerecord.screen-permission-probe")
            )
            try await stream.startCapture()
            try? await Task.sleep(nanoseconds: 400_000_000)
            try? await stream.stopCapture()

            print("📺 ScreenCaptureKit 授权探测(\(reason)): 已启动最小捕获流")
        } catch {
            let nsError = error as NSError
            print("📺 ScreenCaptureKit 授权探测(\(reason))失败: \(nsError.domain) \(nsError.code) \(nsError.localizedDescription)")
        }
    }

    private func waitForScreenRecordingPermissionUpdate() async {
        for _ in 0..<8 {
            try? await Task.sleep(nanoseconds: 350_000_000)
            if CGPreflightScreenCaptureAccess() {
                await checkScreenRecordingPermission()
                return
            }
        }

        await checkScreenRecordingPermission()
    }
    
    private func openScreenRecordingSettings() {
        let urls = [
            "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture",
            "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenRecording"
        ]

        for rawURL in urls {
            guard let url = URL(string: rawURL) else { continue }
            if NSWorkspace.shared.open(url) {
                print("🔗 已打开系统设置 - 屏幕与系统音频录制权限（macOS 26）/ 屏幕录制权限")
                return
            }
        }

        print("⚠️  无法自动打开系统设置，请手动前往 隐私与安全性 > 屏幕与系统音频录制")
    }
    
    // MARK: - 麦克风权限
    func checkMicrophonePermission() async {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        microphoneAuthorized = (status == .authorized)
        print("🎤 麦克风权限: \(status == .authorized ? "已授权" : "未授权")")
    }
    
    func requestMicrophonePermission() async {
        print("🎤 请求麦克风权限...")
        let granted = await AVCaptureDevice.requestAccess(for: .audio)
        microphoneAuthorized = granted
        print("🎤 麦克风权限请求结果: \(granted ? "已授权" : "被拒绝")")
    }
    
    // MARK: - 摄像头权限
    func checkCameraPermission() async {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        cameraAuthorized = (status == .authorized)
        print("📷 摄像头权限: \(status == .authorized ? "已授权" : "未授权")")
    }
    
    func requestCameraPermission() async {
        print("📷 请求摄像头权限...")
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        cameraAuthorized = granted
        print("📷 摄像头权限请求结果: \(granted ? "已授权" : "被拒绝")")
    }
    
    // MARK: - 工具方法
    var allPermissionsGranted: Bool {
        return screenRecordingAuthorized && microphoneAuthorized && cameraAuthorized
    }
    
    var essentialPermissionsGranted: Bool {
        return screenRecordingAuthorized
    }
    
    func requestAllPermissions() async {
        print("🔐 请求所有权限...")
        await requestScreenRecordingPermission()
        await requestMicrophonePermission() 
        await requestCameraPermission()
    }
}

@available(macOS 12.3, *)
private final class ScreenCapturePermissionProbe: NSObject, SCStreamOutput, SCStreamDelegate {
    func stream(_ stream: SCStream, didOutputSampleBuffer sampleBuffer: CMSampleBuffer, of type: SCStreamOutputType) {
        // Receiving one sample is enough to force the system privacy registration path.
    }
}
