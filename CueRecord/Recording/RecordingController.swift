import AppKit
import Combine
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
    private var preparedDisplayID: CGDirectDisplayID?

    @Published var isStarting = false
    @Published private(set) var isStopping = false
    @Published private(set) var isRecording = false
    @Published private(set) var isPreviewing = false
    @Published private(set) var isExporting = false
    @Published private(set) var exportStatusText: String?
    @Published private(set) var pendingCapturedRecording: CapturedRecordingOutput?
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

        Task {
            var didRunStopCompletions = false
            let runStopCompletionsIfNeeded = { [weak self] in
                guard !didRunStopCompletions else { return }
                didRunStopCompletions = true
                self?.runPendingStopCompletions()
            }

            do {
                pendingCapturedRecording = try await screenRecorder.stopRecording()
                    ?? capturedRecordingOutput(for: expectedOutputURL)
            } catch {
                lastError = error.localizedDescription
                pendingCapturedRecording = capturedRecordingOutput(for: expectedOutputURL)
            }

            recordingState.stopRecording()
            isRecording = false
            isStopping = false
            runStopCompletionsIfNeeded()
        }
    }

    private func capturedRecordingOutput(for outputURL: URL) -> CapturedRecordingOutput? {
        guard FileManager.default.fileExists(atPath: outputURL.path) else { return nil }

        let basePath = outputURL.deletingPathExtension().path
        let fileExtension = outputURL.pathExtension
        let cameraURL = URL(fileURLWithPath: "\(basePath)_camera.\(fileExtension)")
        let overlayURL = URL(fileURLWithPath: "\(basePath)_overlay.json")

        return CapturedRecordingOutput(
            outputURL: outputURL,
            cameraURL: FileManager.default.fileExists(atPath: cameraURL.path) ? cameraURL : nil,
            overlayMetadataURL: FileManager.default.fileExists(atPath: overlayURL.path) ? overlayURL : nil
        )
    }

    func renderPendingCapturedRecording(mode: RecordingRenderMode) {
        guard let capturedOutput = pendingCapturedRecording, !isExporting else { return }
        pendingCapturedRecording = nil
        screenRecorder.renderCapturedRecording(capturedOutput, mode: mode)
    }

    func deletePendingCapturedRecording() {
        guard let capturedOutput = pendingCapturedRecording else { return }
        pendingCapturedRecording = nil

        do {
            _ = try screenRecorder.deleteCapturedRecording(capturedOutput)
            lastOutputURL = nil
            exportStatusText = nil
        } catch {
            lastError = error.localizedDescription
        }
    }

    private func handleRecordingPostProcessingEvent(_ event: RecordingPostProcessingEvent) {
        switch event {
        case .started(_, let mode):
            isExporting = true
            exportStatusText = mode.statusText
        case .completed(let result):
            isExporting = false
            exportStatusText = nil
            lastOutputURL = result.finalOutputURL
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
        let displayIDForRecording = requestedDisplayID ?? preparedDisplayID ?? selectedDisplayTarget?.id

        Task {
            await permissionsManager.checkAllPermissions()

            guard permissionsManager.screenRecordingAuthorized else {
                isStarting = false
                lastError = "Screen recording permission is required."
                await permissionsManager.requestScreenRecordingPermission()
                completion?(false)
                return
            }

            if recordingState.microphoneEnabled && !permissionsManager.microphoneAuthorized {
                await permissionsManager.requestMicrophonePermission()
            }

            if recordingState.cameraOverlayEnabled && !permissionsManager.cameraAuthorized {
                await permissionsManager.requestCameraPermission()
            }

            if recordingState.cameraOverlayEnabled && !permissionsManager.cameraAuthorized {
                recordingState.cameraOverlayEnabled = false
            }

            if case .selectedWindow = recordingState.recordingMode {
                _ = refreshSelectedWindowTarget()
            }

            recordingState.startRecording()
            isRecording = true
            startRecordingTimer()

            do {
                try await screenRecorder.startRecording(
                    mode: recordingState.recordingMode,
                    outputURL: recordingState.outputURL,
                    cameraOverlay: recordingState.cameraOverlayEnabled,
                    cameraPosition: recordingState.cameraOverlayPosition,
                    cameraSize: recordingState.cameraOverlaySize,
                    systemAudioEnabled: recordingState.systemAudioEnabled,
                    microphoneEnabled: recordingState.microphoneEnabled,
                    microphoneDeviceID: audioManager.getMicrophoneDeviceIDForSCK(),
                    displayID: displayIDForRecording
                )

                showRecordingOverlays()
                completion?(true)
            } catch {
                recordingState.stopRecording()
                isRecording = false
                stopRecordingTimer()
                lastError = error.localizedDescription
                completion?(false)
            }

            isStarting = false
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

        Task { @MainActor [weak self] in
            guard let self, self.isPreviewActive, !self.recordingState.isRecording, !self.screenRecorder.isRecording else { return }

            await self.permissionsManager.checkCameraPermission()
            guard self.permissionsManager.cameraAuthorized else { return }

            self.cameraManager.refreshCameraDevices()

            do {
                try await self.cameraManager.startCapture()
            } catch {
                self.lastError = error.localizedDescription
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
