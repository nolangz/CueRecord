import AppKit
import AVFoundation
import Combine
import CoreGraphics
import Foundation

@MainActor
final class RecordingController: ObservableObject {
    static let shared = RecordingController()
    private static let selectedDisplayIDDefaultsKey = "recording.selectedDisplayID"

    let recordingState = RecordingState()
    let permissionsManager = PermissionsManager()
    let audioManager = AudioManager()

    private let screenRecorder = ScreenRecorder()
    private let areaSelector = AreaSelector()
    private let windowSelector = WindowSelector()
    private let recordingIndicator = RecordingIndicatorWindow()
    private let previewRecordingIndicator = RecordingIndicatorWindow()

    private var circularCameraWindow: CircularCameraWindow?
    private var previewCameraWindow: CircularCameraWindow?
    private var recordingTimer: Timer?
    private var selectedWindowTrackingTimer: Timer?
    private var isPreviewActive = false
    private var pendingStopCompletions: [() -> Void] = []
    // 录制启动完成回调暂存：detached 编排任务不直接捕获非 Sendable 的 completion 闭包，
    // 而是通过该属性在 MainActor.run 中回调，避免跨执行器捕获问题。
    private var pendingStartCompletion: ((Bool) -> Void)?
    private var preparedDisplayID: CGDirectDisplayID?

    @Published var isStarting = false
    @Published private(set) var isStopping = false
    @Published private(set) var isRecording = false
    @Published private(set) var isPreviewing = false
    @Published private(set) var isExporting = false
    @Published private(set) var exportStatusText: String?
    @Published private(set) var pendingCapturedRecording: CapturedRecordingOutput?
    @Published private(set) var recordingLibraryChangeID = UUID()
    @Published private(set) var lastOutputURL: URL?
    @Published var lastError: String?

    var cameraManager: CameraManager {
        screenRecorder.getCameraManager()
    }

    var availableDisplays: [ScreenRecordingDisplayTarget] {
        NSScreen.screens.enumerated().map { index, screen in
            let displayID = CGDirectDisplayID(screen.displayID)
            return ScreenRecordingDisplayTarget(
                id: displayID,
                frame: screen.frame,
                name: screen.localizedName,
                index: index
            )
        }
    }

    var selectedDisplayTarget: ScreenRecordingDisplayTarget? {
        let displays = availableDisplays
        if let selectedDisplayID = recordingState.selectedDisplayID,
           let display = displays.first(where: { $0.id == selectedDisplayID }) {
            return display
        }

        return displays.first { display in
            NSScreen.main?.displayID == display.id
        } ?? displays.first
    }

    var currentRecordingInterfaceFrame: CGRect? {
        resolvedRecordingTarget()?.interfaceFrame ?? selectedDisplayTarget?.frame
    }

    var hasPendingCapturedRecording: Bool {
        pendingCapturedRecording != nil
    }

    var canRenderPendingCameraOnly: Bool {
        pendingCapturedRecording?.canRenderCameraOnly == true
    }

    private init() {
        configureOutputDirectory()
        restoreSelectedDisplay()

        screenRecorder.setCameraOverlaySnapshotProvider { [weak self] in
            guard let self else { return nil }
            if let snapshot = self.circularCameraWindow?.metadataSnapshot() {
                return snapshot
            }
            guard let frame = self.recordingState.customCameraOverlayFrame else { return nil }
            return CameraOverlaySnapshot(
                frame: frame,
                shape: self.recordingState.cameraOverlayShape,
                size: self.recordingState.cameraOverlaySize
            )
        }

        screenRecorder.setPostProcessingHandler { [weak self] event in
            self?.handleRecordingPostProcessingEvent(event)
        }
    }

    func refreshDevicesAndPermissions() {
        Task {
            await permissionsManager.checkAllPermissions()
            await audioManager.refreshMicrophoneDevices()
            cameraManager.refreshCameraDevices()
            updatePreview()
        }
    }

    func requestPermissions() {
        Task {
            await permissionsManager.requestAllPermissions()
            updatePreview()
        }
    }

    func selectDisplay(_ display: ScreenRecordingDisplayTarget) {
        recordingState.captureMode = .fullScreen
        recordingState.selectedDisplayID = display.id
        preparedDisplayID = display.id
        UserDefaults.standard.set(Int(display.id), forKey: Self.selectedDisplayIDDefaultsKey)
        recordingState.selectedWindowTarget = nil
        recordingState.recordingMode = .fullScreen
        updatePreview()
    }

    private func restoreSelectedDisplay() {
        let savedDisplayID = UserDefaults.standard.integer(forKey: Self.selectedDisplayIDDefaultsKey)
        guard savedDisplayID > 0 else { return }
        let displayID = CGDirectDisplayID(savedDisplayID)
        recordingState.selectedDisplayID = displayID
        preparedDisplayID = displayID
    }

    func startConfiguredRecording(completion: @escaping (Bool) -> Void) {
        switch recordingState.captureMode {
        case .fullScreen:
            endPreview()
            recordingState.recordingMode = .fullScreen
            let displayID = selectedDisplayTarget?.id
            preparedDisplayID = displayID
            startRecording(displayID: displayID) { [weak self] started in
                if !started {
                    self?.beginPreview()
                }
                completion(started)
            }
        case .selectedArea:
            endPreview()
            areaSelector.selectArea(aspectRatioPreset: recordingState.areaAspectRatioPreset) { [weak self] rect in
                guard let self, let rect else {
                    self?.beginPreview()
                    completion(false)
                    return
                }

                self.recordingState.recordingMode = .selectedArea(rect)
                self.recordingState.selectedArea = rect
                self.startRecording { [weak self] started in
                    if !started {
                        self?.beginPreview()
                    }
                    completion(started)
                }
            }
        case .selectedWindow:
            endPreview()
            windowSelector.selectWindow { [weak self] target in
                guard let self, let target else {
                    self?.beginPreview()
                    completion(false)
                    return
                }

                let currentTarget = self.refreshedWindowTarget(target) ?? target
                self.setSelectedWindowTarget(currentTarget)
                self.startRecording { [weak self] started in
                    if !started {
                        self?.beginPreview()
                    }
                    completion(started)
                }
            }
        }
    }

    func startPreviewedRecording(completion: @escaping (Bool) -> Void) {
        switch recordingState.captureMode {
        case .fullScreen:
            recordingState.recordingMode = .fullScreen
            let displayID = selectedDisplayTarget?.id
            preparedDisplayID = displayID
            beginPreparedRecording(displayID: displayID, completion: completion)
        case .selectedArea:
            let rect = !recordingState.selectedArea.isEmpty ? recordingState.selectedArea : previewRecordingRect()
            guard let rect else {
                completion(false)
                return
            }

            recordingState.selectedArea = rect
            recordingState.recordingMode = .selectedArea(rect)
            beginPreparedRecording(completion: completion)
        case .selectedWindow:
            if let target = recordingState.selectedWindowTarget {
                let currentTarget = refreshedWindowTarget(target) ?? target
                setSelectedWindowTarget(currentTarget)
                beginPreparedRecording(completion: completion)
                return
            }

            selectWindowForPreview { [weak self] target in
                guard let self, let target else {
                    completion(false)
                    return
                }

                let currentTarget = self.refreshedWindowTarget(target) ?? target
                self.setSelectedWindowTarget(currentTarget)
                self.beginPreparedRecording(completion: completion)
            }
        }
    }

    func selectAreaForPreview(completion: ((CGRect?) -> Void)? = nil) {
        let previousMode = recordingState.captureMode
        recordingState.captureMode = .selectedArea
        previewRecordingIndicator.hideIndicator()

        areaSelector.selectArea(aspectRatioPreset: recordingState.areaAspectRatioPreset) { [weak self] rect in
            guard let self else {
                completion?(nil)
                return
            }

            if let rect {
                self.recordingState.selectedArea = rect
                self.recordingState.recordingMode = .selectedArea(rect)
            } else if self.recordingState.selectedArea.isEmpty {
                self.recordingState.captureMode = previousMode
            }

            self.beginPreview()
            completion?(rect)
        }
    }

    func selectWindowForPreview(completion: ((WindowRecordingTarget?) -> Void)? = nil) {
        let previousMode = recordingState.captureMode
        recordingState.captureMode = .selectedWindow
        previewRecordingIndicator.hideIndicator()

        windowSelector.selectWindow { [weak self] target in
            guard let self else {
                completion?(nil)
                return
            }

            if let target {
                self.setSelectedWindowTarget(target)
            } else if self.recordingState.selectedWindowTarget == nil {
                self.recordingState.captureMode = previousMode
            }

            self.beginPreview()
            completion?(target)
        }
    }

    func beginPreview() {
        guard !recordingState.isRecording && !screenRecorder.isRecording else { return }

        isPreviewActive = true
        isPreviewing = true
        updatePreview()
    }

    func updatePreview() {
        guard isPreviewActive, !recordingState.isRecording, !screenRecorder.isRecording else { return }

        guard let previewRect = previewRecordingRect() else {
            previewRecordingIndicator.hideIndicator()
            updateCameraPreview(recordingRect: nil)
            return
        }

        if recordingState.captureMode == .selectedArea {
            previewRecordingIndicator.showInteractiveIndicator(
                for: previewRect,
                aspectRatio: recordingState.areaAspectRatioPreset.aspectRatio ?? previewRect.width / max(previewRect.height, 1)
            ) { [weak self] rect in
                self?.updateSelectedAreaPreview(to: rect)
            }
        } else {
            previewRecordingIndicator.showIndicator(for: previewRect)
        }

        if recordingState.captureMode == .fullScreen {
            preparedDisplayID = selectedDisplayTarget?.id
        }

        updateCameraPreview(recordingRect: previewRect)

        if recordingState.captureMode == .selectedWindow {
            startSelectedWindowTracking()
        } else if !recordingState.isRecording && !screenRecorder.isRecording {
            stopSelectedWindowTracking()
        }
    }

    private func updateSelectedAreaPreview(to rect: CGRect) {
        guard isPreviewActive,
              recordingState.captureMode == .selectedArea,
              !recordingState.isRecording,
              !screenRecorder.isRecording
        else {
            return
        }

        if let cameraFrame = recordingState.customCameraOverlayFrame,
           !recordingState.selectedArea.isEmpty {
            let dx = rect.minX - recordingState.selectedArea.minX
            let dy = rect.minY - recordingState.selectedArea.minY
            recordingState.customCameraOverlayFrame = cameraFrame.offsetBy(dx: dx, dy: dy)
        }

        recordingState.selectedArea = rect
        recordingState.recordingMode = .selectedArea(rect)
        updateCameraPreview(recordingRect: rect)
    }

    func resetCustomCameraOverlayFrame() {
        recordingState.customCameraOverlayFrame = nil
        updatePreview()
    }

    func restartCameraPreview() {
        guard isPreviewActive else { return }

        if !recordingState.isRecording && !screenRecorder.isRecording {
            cameraManager.stopCapture()
        }

        updatePreview()
    }

    func endPreview() {
        isPreviewActive = false
        isPreviewing = false
        previewRecordingIndicator.hideIndicator()
        previewCameraWindow?.hide()
        previewCameraWindow = nil
        if !recordingState.isRecording && !screenRecorder.isRecording {
            stopSelectedWindowTracking()
        }

        if !recordingState.isRecording && !screenRecorder.isRecording {
            cameraManager.stopCapture()
        }
    }

    func stopRecording(completion: (() -> Void)? = nil) {
        if let completion {
            pendingStopCompletions.append(completion)
        }

        guard !isStopping else { return }
        guard recordingState.isRecording || screenRecorder.isRecording else {
            runPendingStopCompletions()
            return
        }

        isStopping = true
        stopRecordingTimer()
        stopSelectedWindowTracking()
        recordingIndicator.hideIndicator()
        let expectedOutputURL = recordingState.outputURL
        if let snapshot = circularCameraWindow?.metadataSnapshot() {
            recordingState.customCameraOverlayFrame = snapshot.frame
        }
        circularCameraWindow?.hide()
        circularCameraWindow = nil

        // Task.detached：stopRecording(已 nonisolated)的 await 在后台执行器完成，
        // 主执行器不跨 await 挂起；结果与状态用同步 MainActor.run 更新。
        Task.detached { [weak self] in
            guard let self else { return }
            var captured: CapturedRecordingOutput?
            var stopError: String?
            do {
                captured = try await self.screenRecorder.stopRecording()
            } catch {
                stopError = error.localizedDescription
            }
            await MainActor.run {
                if let stopError { self.lastError = stopError }
                self.pendingCapturedRecording = captured
                    ?? self.capturedRecordingOutput(for: expectedOutputURL)
                self.recordingState.stopRecording()
                self.isRecording = false
                self.isStopping = false
                self.runPendingStopCompletions()
            }
        }
    }

    private func capturedRecordingOutput(for outputURL: URL) -> CapturedRecordingOutput? {
        CapturedRecordingOutput(discovering: outputURL)
    }

    func renderPendingCapturedRecording(
        mode: RecordingRenderMode,
        exportSettings: RecordingExportSettings = .default
    ) {
        guard let capturedOutput = pendingCapturedRecording, !isExporting else { return }
        renderCapturedRecording(capturedOutput, mode: mode, exportSettings: exportSettings)
    }

    func renderPendingCapturedRecording(
        editDecision: RecordingEditDecision,
        exportSettings: RecordingExportSettings = .default
    ) {
        renderPendingCapturedRecording(mode: .edited(editDecision), exportSettings: exportSettings)
    }

    func renderCapturedRecording(
        _ capturedOutput: CapturedRecordingOutput,
        editDecision: RecordingEditDecision,
        exportSettings: RecordingExportSettings = .default
    ) {
        renderCapturedRecording(capturedOutput, mode: .edited(editDecision), exportSettings: exportSettings)
    }

    func renderCapturedRecording(
        _ capturedOutput: CapturedRecordingOutput,
        mode: RecordingRenderMode,
        exportSettings: RecordingExportSettings = .default
    ) {
        guard !isExporting else { return }
        if pendingCapturedRecording?.outputURL.standardizedFileURL == capturedOutput.outputURL.standardizedFileURL {
            pendingCapturedRecording = nil
        }
        screenRecorder.renderCapturedRecording(capturedOutput, mode: mode, exportSettings: exportSettings)
    }

    func deletePendingCapturedRecording() {
        guard let capturedOutput = pendingCapturedRecording else { return }
        pendingCapturedRecording = nil
        deleteCapturedRecording(capturedOutput)
    }

    func deleteCapturedRecording(_ capturedOutput: CapturedRecordingOutput) {
        do {
            _ = try screenRecorder.deleteCapturedRecording(capturedOutput)
            lastOutputURL = nil
            exportStatusText = nil
            recordingLibraryChangeID = UUID()
        } catch {
            lastError = error.localizedDescription
        }
    }

    private func handleRecordingPostProcessingEvent(_ event: RecordingPostProcessingEvent) {
        switch event {
        case .started(_, let mode):
            isExporting = true
            exportStatusText = uiText(mode.statusText)
        case .completed(let result):
            isExporting = false
            exportStatusText = nil
            lastOutputURL = result.finalOutputURL
            recordingLibraryChangeID = UUID()
            revealRecordingInFinder(result.finalOutputURL)
        }
    }

    private func startRecording(
        displayID requestedDisplayID: CGDirectDisplayID? = nil,
        completion: ((Bool) -> Void)? = nil
    ) {
        guard !recordingState.isRecording && !screenRecorder.isRecording && !isStarting else {
            completion?(false)
            return
        }

        isStarting = true
        lastError = nil
        pendingStartCompletion = completion
        let displayIDForRecording = requestedDisplayID ?? preparedDisplayID ?? selectedDisplayTarget?.id

        // 关键修复(macOS 26.5.1 / Swift 6.3.2 运行时缺陷)：用 Task.detached 在后台执行器
        // 编排，screenRecorder.startRecording(已 nonisolated)的 await 不在主执行器挂起；
        // 主线程状态全部用同步 MainActor.run 更新，主执行器永不跨 await 挂起。
        Task.detached { [weak self] in
            guard let self else { return }

            // 屏幕录制权限：同步预检(CGPreflight)，避免在主执行器上 await SCShareableContent。
            let screenGranted = CGPreflightScreenCaptureAccess()
            await MainActor.run { self.permissionsManager.screenRecordingAuthorized = screenGranted }
            guard screenGranted else {
                await MainActor.run {
                    self.isStarting = false
                    self.lastError = "Screen recording permission is required."
                }
                // 未授权：走一次性请求流程(会弹系统框，低频路径)。
                await self.permissionsManager.requestScreenRecordingPermission()
                await MainActor.run {
                    self.pendingStartCompletion?(false)
                    self.pendingStartCompletion = nil
                }
                return
            }

            // 麦克风/摄像头权限：同步读取状态；缺失且需要时按需一次性请求(低频)。
            let micAuthorized = AVCaptureDevice.authorizationStatus(for: .audio) == .authorized
            let camAuthorized = AVCaptureDevice.authorizationStatus(for: .video) == .authorized
            await MainActor.run {
                self.permissionsManager.microphoneAuthorized = micAuthorized
                self.permissionsManager.cameraAuthorized = camAuthorized
            }
            let needMic = await MainActor.run { self.recordingState.microphoneEnabled && !micAuthorized }
            if needMic { await self.permissionsManager.requestMicrophonePermission() }
            let needCam = await MainActor.run { self.recordingState.cameraOverlayEnabled && !camAuthorized }
            if needCam { await self.permissionsManager.requestCameraPermission() }

            // 在主线程一次性准备录制状态并取出本次配置(同步闭包)。
            let prep = await MainActor.run { () -> (outputURL: URL, mode: RecordingMode, cameraOverlay: Bool, cameraPosition: CameraOverlayPosition, cameraSize: CameraOverlaySize, systemAudio: Bool, microphone: Bool, micDevice: String?) in
                if self.recordingState.cameraOverlayEnabled
                    && AVCaptureDevice.authorizationStatus(for: .video) != .authorized {
                    self.recordingState.cameraOverlayEnabled = false
                }
                if case .selectedWindow = self.recordingState.recordingMode {
                    _ = self.refreshSelectedWindowTarget()
                }
                self.recordingState.startRecording()
                self.isRecording = true
                self.startRecordingTimer()
                return (
                    self.recordingState.outputURL,
                    self.recordingState.recordingMode,
                    self.recordingState.cameraOverlayEnabled,
                    self.recordingState.cameraOverlayPosition,
                    self.recordingState.cameraOverlaySize,
                    self.recordingState.systemAudioEnabled,
                    self.recordingState.microphoneEnabled,
                    self.audioManager.getMicrophoneDeviceIDForSCK()
                )
            }

            do {
                try await self.screenRecorder.startRecording(
                    mode: prep.mode,
                    outputURL: prep.outputURL,
                    cameraOverlay: prep.cameraOverlay,
                    cameraPosition: prep.cameraPosition,
                    cameraSize: prep.cameraSize,
                    systemAudioEnabled: prep.systemAudio,
                    microphoneEnabled: prep.microphone,
                    microphoneDeviceID: prep.micDevice,
                    displayID: displayIDForRecording
                )

                await MainActor.run {
                    self.showRecordingOverlays()
                    self.isStarting = false
                    self.pendingStartCompletion?(true)
                    self.pendingStartCompletion = nil
                }
            } catch {
                await MainActor.run {
                    self.recordingState.stopRecording()
                    self.isRecording = false
                    self.stopRecordingTimer()
                    self.lastError = error.localizedDescription
                    self.isStarting = false
                    self.pendingStartCompletion?(false)
                    self.pendingStartCompletion = nil
                }
            }
        }
    }

    private func beginPreparedRecording(
        displayID requestedDisplayID: CGDirectDisplayID? = nil,
        completion: @escaping (Bool) -> Void
    ) {
        endPreview()
        startRecording(displayID: requestedDisplayID) { [weak self] started in
            if !started {
                self?.beginPreview()
            }
            completion(started)
        }
    }

    private func showRecordingOverlays() {
        if case .selectedArea(let rect) = recordingState.recordingMode {
            recordingIndicator.showIndicator(for: rect)
        }

        if case .selectedWindow = recordingState.recordingMode {
            startSelectedWindowTracking()
        }

        guard recordingState.cameraOverlayEnabled else { return }

        if circularCameraWindow == nil {
            circularCameraWindow = CircularCameraWindow(cameraManager: cameraManager)
        }

        circularCameraWindow?.show(
            at: recordingState.cameraOverlayPosition,
            size: recordingState.cameraOverlaySize,
            shape: recordingState.cameraOverlayShape,
            recordingRect: currentRecordingFrame(),
            customFrame: recordingState.customCameraOverlayFrame
        ) { [weak self] frame in
            self?.recordingState.customCameraOverlayFrame = frame
        }
    }

    private func currentRecordingFrame() -> CGRect? {
        resolvedRecordingTarget()?.overlayFrame
    }

    private var displayGeometries: [RecordingDisplayGeometry] {
        availableDisplays.map { display in
            RecordingDisplayGeometry(
                id: display.id,
                frame: display.frame,
                name: display.name,
                index: display.index
            )
        }
    }

    private func resolvedRecordingTarget(
        mode: RecordingMode? = nil,
        selectedDisplayID: CGDirectDisplayID? = nil
    ) -> ResolvedRecordingTarget? {
        let activeMode = mode ?? recordingState.recordingMode
        let activeDisplayID = selectedDisplayID
            ?? preparedDisplayID
            ?? recordingState.selectedDisplayID
            ?? selectedDisplayTarget?.id

        return ResolvedRecordingTarget.resolve(
            mode: activeMode,
            selectedDisplayID: activeDisplayID,
            displays: displayGeometries
        )
    }

    private func setSelectedWindowTarget(_ target: WindowRecordingTarget) {
        recordingState.selectedWindowTarget = target
        recordingState.selectedArea = target.frame
        recordingState.recordingMode = .selectedWindow(target)
    }

    private func refreshedWindowTarget(_ target: WindowRecordingTarget) -> WindowRecordingTarget? {
        windowSelector.refreshedTarget(target)
    }

    @discardableResult
    private func refreshSelectedWindowTarget() -> (target: WindowRecordingTarget, frameChanged: Bool)? {
        guard let currentTarget = activeSelectedWindowTarget(),
              let refreshedTarget = refreshedWindowTarget(currentTarget)
        else {
            return nil
        }

        let frameChanged = !rectsApproximatelyEqual(currentTarget.frame, refreshedTarget.frame)
        if frameChanged
            || recordingState.selectedWindowTarget?.windowID != refreshedTarget.windowID
            || recordingState.selectedWindowTarget?.title != refreshedTarget.title
            || recordingState.selectedWindowTarget?.ownerName != refreshedTarget.ownerName {
            setSelectedWindowTarget(refreshedTarget)
        }

        return (refreshedTarget, frameChanged)
    }

    private func activeSelectedWindowTarget() -> WindowRecordingTarget? {
        if let target = recordingState.selectedWindowTarget {
            return target
        }

        if case .selectedWindow(let target) = recordingState.recordingMode {
            return target
        }

        return nil
    }

    private func rectsApproximatelyEqual(_ lhs: CGRect, _ rhs: CGRect) -> Bool {
        abs(lhs.origin.x - rhs.origin.x) < 0.5
            && abs(lhs.origin.y - rhs.origin.y) < 0.5
            && abs(lhs.width - rhs.width) < 0.5
            && abs(lhs.height - rhs.height) < 0.5
    }

    private func startSelectedWindowTracking() {
        guard selectedWindowTrackingTimer == nil else { return }

        selectedWindowTrackingTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            Task { @MainActor [weak self] in
                self?.updateSelectedWindowTracking()
            }
        }
    }

    private func stopSelectedWindowTracking() {
        selectedWindowTrackingTimer?.invalidate()
        selectedWindowTrackingTimer = nil
    }

    private func updateSelectedWindowTracking() {
        let shouldTrackPreview = isPreviewActive && recordingState.captureMode == .selectedWindow
        let shouldTrackRecording: Bool
        if case .selectedWindow = recordingState.recordingMode {
            shouldTrackRecording = recordingState.isRecording || screenRecorder.isRecording
        } else {
            shouldTrackRecording = false
        }

        guard shouldTrackPreview || shouldTrackRecording else {
            stopSelectedWindowTracking()
            return
        }

        guard let refresh = refreshSelectedWindowTarget() else {
            if shouldTrackPreview {
                previewRecordingIndicator.hideIndicator()
                updateCameraPreview(recordingRect: nil)
            }
            return
        }

        guard refresh.frameChanged else { return }

        if shouldTrackPreview {
            updatePreview()
        }

        if shouldTrackRecording {
            updateRecordingCameraWindow(recordingRect: refresh.target.frame)
        }
    }

    private func updateRecordingCameraWindow(recordingRect: CGRect?) {
        guard recordingState.cameraOverlayEnabled else { return }

        circularCameraWindow?.show(
            at: recordingState.cameraOverlayPosition,
            size: recordingState.cameraOverlaySize,
            shape: recordingState.cameraOverlayShape,
            recordingRect: recordingRect,
            customFrame: recordingState.customCameraOverlayFrame
        ) { [weak self] frame in
            self?.recordingState.customCameraOverlayFrame = frame
        }
    }

    private func updateCameraPreview(recordingRect: CGRect?) {
        guard recordingState.cameraOverlayEnabled else {
            previewCameraWindow?.hide()
            previewCameraWindow = nil

            if !recordingState.isRecording && !screenRecorder.isRecording {
                cameraManager.stopCapture()
            }
            return
        }

        if previewCameraWindow == nil {
            previewCameraWindow = CircularCameraWindow(cameraManager: cameraManager)
        }

        previewCameraWindow?.show(
            at: recordingState.cameraOverlayPosition,
            size: recordingState.cameraOverlaySize,
            shape: recordingState.cameraOverlayShape,
            recordingRect: recordingRect,
            customFrame: recordingState.customCameraOverlayFrame
        ) { [weak self] frame in
            self?.recordingState.customCameraOverlayFrame = frame
        }

        // Task.detached：摄像头启动(已 nonisolated)的 await 在后台执行器完成，
        // 主执行器不跨 await 挂起；权限同步读取，状态用同步 MainActor.run 更新。
        Task.detached { [weak self] in
            guard let self else { return }
            let camAuthorized = AVCaptureDevice.authorizationStatus(for: .video) == .authorized
            let proceed = await MainActor.run { () -> Bool in
                self.permissionsManager.cameraAuthorized = camAuthorized
                guard camAuthorized,
                      self.isPreviewActive,
                      !self.recordingState.isRecording,
                      !self.screenRecorder.isRecording else { return false }
                self.cameraManager.refreshCameraDevices()
                return true
            }
            guard proceed else { return }

            do {
                try await self.cameraManager.startCapture()
            } catch {
                await MainActor.run { self.lastError = error.localizedDescription }
            }
        }
    }

    private func previewRecordingRect() -> CGRect? {
        switch recordingState.captureMode {
        case .fullScreen:
            return previewScreenRect()
        case .selectedArea:
            if !recordingState.selectedArea.isEmpty {
                return recordingState.selectedArea
            }
            return defaultAreaPreviewRect()
        case .selectedWindow:
            return previewWindowRect() ?? defaultAreaPreviewRect()
        }
    }

    private func previewScreenRect() -> CGRect? {
        selectedDisplayTarget?.frame.insetBy(dx: 8, dy: 8)
    }

    private func defaultAreaPreviewRect() -> CGRect? {
        let screen = screen(for: selectedDisplayTarget?.id) ?? NSScreen.main
        guard let screen else { return nil }

        let visibleFrame = screen.visibleFrame
        let fallbackAspectRatio: CGFloat = 16.0 / 9.0
        let aspectRatio = recordingState.areaAspectRatioPreset.aspectRatio ?? fallbackAspectRatio

        var width = visibleFrame.width * 0.62
        var height = width / aspectRatio

        if height > visibleFrame.height * 0.62 {
            height = visibleFrame.height * 0.62
            width = height * aspectRatio
        }

        return CGRect(
            x: visibleFrame.midX - width / 2,
            y: visibleFrame.midY - height / 2,
            width: width,
            height: height
        )
    }

    private func screen(for displayID: CGDirectDisplayID?) -> NSScreen? {
        guard let displayID else { return nil }
        return NSScreen.screens.first { CGDirectDisplayID($0.displayID) == displayID }
    }

    private func previewWindowRect() -> CGRect? {
        if let target = refreshSelectedWindowTarget()?.target ?? recordingState.selectedWindowTarget {
            return target.frame.insetBy(dx: 4, dy: 4)
        }

        return NSApp.windows
            .first { window in
                !(window is NSPanel)
                    && window.isVisible
                    && window.frame.width > 120
                    && window.frame.height > 120
            }?
            .frame
            .insetBy(dx: 4, dy: 4)
    }

    private func startRecordingTimer() {
        stopRecordingTimer()
        recordingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            Task { @MainActor [weak self] in
                self?.recordingState.updateRecordingDuration()
            }
        }
    }

    private func stopRecordingTimer() {
        recordingTimer?.invalidate()
        recordingTimer = nil
    }

    private func runPendingStopCompletions() {
        let completions = pendingStopCompletions
        pendingStopCompletions.removeAll()
        completions.forEach { $0() }
    }

    private func preferredCompletedOutputURL(for baseOutputURL: URL) -> URL? {
        let fileManager = FileManager.default
        let basePath = baseOutputURL.deletingPathExtension().path
        let fileExtension = baseOutputURL.pathExtension

        let compositedURL = URL(fileURLWithPath: "\(basePath)_composited.\(fileExtension)")
        if fileManager.fileExists(atPath: compositedURL.path) {
            return compositedURL
        }

        if fileManager.fileExists(atPath: baseOutputURL.path) {
            return baseOutputURL
        }

        let cameraURL = URL(fileURLWithPath: "\(basePath)_camera.\(fileExtension)")
        if fileManager.fileExists(atPath: cameraURL.path) {
            return cameraURL
        }

        return nil
    }

    private func revealRecordingInFinder(_ url: URL) {
        NSWorkspace.shared.open(url.deletingLastPathComponent())
    }

    private func configureOutputDirectory() {
        let outputDirectory = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first
            ?? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            ?? URL(fileURLWithPath: NSHomeDirectory())
        try? FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true)
        recordingState.outputDirectory = outputDirectory
    }
}
