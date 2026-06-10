import AppKit
import SwiftUI

final class RecordingPreviewBarWindow: NSObject {
    private var barWindow: NSWindow?
    private static let windowLevel: NSWindow.Level = .screenSaver + 2

    func show(
        controller: RecordingController,
        onStart: @escaping () -> Void,
        onCancel: @escaping () -> Void
    ) {
        let visibleFrame = targetVisibleFrame(for: controller.currentRecordingInterfaceFrame)
        let width = min(max(880, visibleFrame.width * 0.72), visibleFrame.width - 40)
        let height: CGFloat = 86
        let frame = NSRect(
            x: visibleFrame.midX - width / 2,
            y: visibleFrame.minY + 112,
            width: width,
            height: height
        )

        let window = configuredWindow(frame: frame, movableByBackground: true)

        let rootView = RecordingPreviewBarView(
            controller: controller,
            onStart: {
                onStart()
            },
            onCancel: { [weak self] in
                self?.hide()
                onCancel()
            }
        )
        .frame(width: width, height: height)

        let contentView = NSHostingView(rootView: rootView)
        contentView.layer?.backgroundColor = NSColor.clear.cgColor
        window.contentView = contentView
        NSApp.activate(ignoringOtherApps: true)
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()
    }

    func showStopButton(
        controller: RecordingController,
        onStop: @escaping () -> Void
    ) {
        if barWindow != nil {
            hide()
        }

        let visibleFrame = targetVisibleFrame(for: controller.currentRecordingInterfaceFrame)
        let width: CGFloat = 154
        let height: CGFloat = 62
        let margin: CGFloat = 24
        let frame = NSRect(
            x: visibleFrame.maxX - width - margin,
            y: visibleFrame.minY + margin,
            width: width,
            height: height
        )

        let window = configuredWindow(frame: frame, movableByBackground: false)
        let rootView = RecordingStopBarView(
            controller: controller,
            onStop: { [weak self] in
                self?.hide()
                onStop()
            }
        )
        .frame(width: width, height: height)

        let contentView = NSHostingView(rootView: rootView)
        contentView.layer?.backgroundColor = NSColor.clear.cgColor
        window.contentView = contentView
        window.orderFrontRegardless()
    }

    func hide() {
        barWindow?.contentView = nil
        barWindow?.orderOut(nil)
        barWindow?.close()
        barWindow = nil
    }

    func bringToFront() {
        barWindow?.level = Self.windowLevel
        barWindow?.orderFrontRegardless()
    }

    private func configuredWindow(frame: NSRect, movableByBackground: Bool) -> NSWindow {
        if let existingWindow = barWindow {
            existingWindow.setFrame(frame, display: true, animate: true)
            existingWindow.level = Self.windowLevel
            existingWindow.sharingType = .none
            existingWindow.isMovableByWindowBackground = movableByBackground
            return existingWindow
        }

        let window = RecordingPreviewBarPanel(
            contentRect: frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.level = Self.windowLevel
        window.collectionBehavior = [.canJoinAllSpaces, .stationary, .fullScreenAuxiliary, .ignoresCycle]
        window.backgroundColor = .clear
        window.isOpaque = false
        window.hasShadow = false
        window.isMovableByWindowBackground = movableByBackground
        window.isReleasedWhenClosed = false
        // Do not let the floating controls appear in screen recordings.
        window.sharingType = .none
        window.isFloatingPanel = true
        window.hidesOnDeactivate = false
        window.worksWhenModal = true
        barWindow = window
        return window
    }

    private func targetVisibleFrame(for targetFrame: CGRect?) -> NSRect {
        if let targetFrame,
           let screen = NSScreen.screens.max(by: { first, second in
               first.frame.intersection(targetFrame).area < second.frame.intersection(targetFrame).area
           }),
           !screen.frame.intersection(targetFrame).isNull {
            return screen.visibleFrame
        }

        return (NSScreen.main ?? NSScreen.screens.first)?.visibleFrame
            ?? NSRect(x: 0, y: 0, width: 960, height: 640)
    }
}

private extension CGRect {
    var area: CGFloat {
        guard !isNull else { return 0 }
        return max(0, width) * max(0, height)
    }
}

private final class RecordingPreviewBarPanel: NSPanel {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { false }
}

private struct RecordingPreviewBarView: View {
    @ObservedObject private var controller: RecordingController
    @ObservedObject private var recordingState: RecordingState
    @ObservedObject private var audioManager: AudioManager
    @ObservedObject private var cameraManager: CameraManager

    let onStart: () -> Void
    let onCancel: () -> Void

    init(
        controller: RecordingController,
        onStart: @escaping () -> Void,
        onCancel: @escaping () -> Void
    ) {
        self.controller = controller
        self.recordingState = controller.recordingState
        self.audioManager = controller.audioManager
        self.cameraManager = controller.cameraManager
        self.onStart = onStart
        self.onCancel = onCancel
    }

    var body: some View {
        HStack(spacing: 10) {
            Button(action: onCancel) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: 34, height: 34)
                    .background(Color.primary.opacity(0.08), in: Circle())
            }
            .buttonStyle(.plain)
            .help("Cancel preview")

            modeButton(.fullScreen, icon: "rectangle", title: "Display")
            modeButton(.selectedWindow, icon: "macwindow", title: "Window")
            modeButton(.selectedArea, icon: "rectangle.dashed", title: "Area")

            verticalDivider

            if recordingState.captureMode == .fullScreen {
                displayMenu
                verticalDivider
            } else if recordingState.captureMode == .selectedArea {
                ratioMenu
                verticalDivider
            }

            toggleButton(
                isOn: recordingState.microphoneEnabled,
                icon: "mic.fill",
                title: "Microphone"
            ) {
                recordingState.microphoneEnabled.toggle()
            }

            toggleButton(
                isOn: recordingState.systemAudioEnabled,
                icon: "speaker.wave.2.fill",
                title: "System Audio"
            ) {
                recordingState.systemAudioEnabled.toggle()
            }

            toggleButton(
                isOn: recordingState.cameraOverlayEnabled,
                icon: "video.fill",
                title: "Camera"
            ) {
                recordingState.cameraOverlayEnabled.toggle()
                if recordingState.cameraOverlayEnabled {
                    controller.restartCameraPreview()
                } else {
                    controller.updatePreview()
                }
            }

            if recordingState.cameraOverlayEnabled {
                cameraShapeMenu
                cameraPositionMenu
                cameraSizeMenu
            }

            optionsMenu

            Button(action: onStart) {
                HStack(spacing: 8) {
                    if controller.isStarting {
                        ProgressView()
                            .controlSize(.small)
                    } else {
                        RecordGlyph(outerDiameter: 15, innerDiameter: 6)
                    }
                    Text("Start")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundStyle(.white)
                .frame(height: 46)
                .padding(.horizontal, 20)
                .background(Color.blue, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .buttonStyle(.plain)
            .disabled(controller.isStarting || controller.isRecording || controller.isStopping)
            .opacity(controller.isStarting || controller.isRecording || controller.isStopping ? 0.55 : 1)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .foregroundStyle(.primary)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: .black.opacity(0.24), radius: 18, y: 10)
        .onAppear {
            controller.refreshDevicesAndPermissions()
            controller.beginPreview()
        }
        .onChange(of: cameraManager.selectedCameraID) { _, _ in
            controller.restartCameraPreview()
        }
    }

    private var verticalDivider: some View {
        Rectangle()
            .fill(Color.primary.opacity(0.18))
            .frame(width: 1, height: 38)
            .padding(.horizontal, 2)
    }

    private var ratioMenu: some View {
        Menu {
            ForEach(AreaAspectRatioPreset.allCases, id: \.self) { preset in
                Button {
                    recordingState.captureMode = .selectedArea
                    recordingState.areaAspectRatioPreset = preset
                    recordingState.selectedArea = .zero
                    controller.updatePreview()
                } label: {
                    Text("\(preset.title) · \(preset.subtitle)")
                }
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "aspectratio")
                    .font(.system(size: 15, weight: .semibold))
                Text(recordingState.areaAspectRatioPreset.title)
                    .font(.system(size: 13, weight: .semibold))
                Image(systemName: "chevron.down")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.secondary)
            }
            .frame(height: 46)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(recordingState.captureMode == .selectedArea ? Color.blue.opacity(0.20) : Color.primary.opacity(0.08))
            )
        }
        .menuStyle(.borderlessButton)
        .fixedSize()
        .help("Area aspect ratio")
    }

    private var displayMenu: some View {
        let displays = controller.availableDisplays
        let selectedDisplay = controller.selectedDisplayTarget

        return Menu {
            ForEach(displays) { display in
                Button {
                    controller.selectDisplay(display)
                } label: {
                    let title = display.displayName == display.shortName
                        ? display.shortName
                        : "\(display.shortName) · \(display.displayName)"

                    if selectedDisplay?.id == display.id {
                        Label(title, systemImage: "checkmark")
                    } else {
                        Text(title)
                    }
                }
            }
        } label: {
            menuChip(
                icon: displays.count > 1 ? "display.2" : "display",
                title: selectedDisplay?.shortName ?? "Display"
            )
        }
        .menuStyle(.borderlessButton)
        .fixedSize()
        .help("Display")
    }

    private var cameraShapeMenu: some View {
        Menu {
            ForEach(CameraOverlayShape.allCases, id: \.self) { shape in
                Button(shape.displayName) {
                    recordingState.cameraOverlayShape = shape
                    controller.updatePreview()
                }
            }
        } label: {
            menuChip(
                icon: cameraShapeIcon,
                title: cameraShapeTitle
            )
        }
        .menuStyle(.borderlessButton)
        .fixedSize()
    }

    private var cameraShapeIcon: String {
        switch recordingState.cameraOverlayShape {
        case .circle:
            return "circle"
        case .roundedSquare:
            return "rectangle"
        case .roundedBox:
            return "square"
        }
    }

    private var cameraShapeTitle: String {
        switch recordingState.cameraOverlayShape {
        case .circle:
            return "Circle"
        case .roundedSquare:
            return "Rectangle"
        case .roundedBox:
            return "Rounded Box"
        }
    }

    private var cameraPositionMenu: some View {
        Menu {
            ForEach(CameraOverlayPosition.allCases, id: \.self) { position in
                Button(position.displayName) {
                    recordingState.cameraOverlayPosition = position
                    controller.resetCustomCameraOverlayFrame()
                }
            }
        } label: {
            menuChip(icon: "arrow.up.left.and.arrow.down.right", title: recordingState.cameraOverlayPosition.displayName)
        }
        .menuStyle(.borderlessButton)
        .fixedSize()
    }

    private var cameraSizeMenu: some View {
        Menu {
            ForEach(CameraOverlaySize.allCases, id: \.self) { size in
                Button(size.displayName) {
                    recordingState.cameraOverlaySize = size
                    controller.updatePreview()
                }
            }
        } label: {
            menuChip(icon: "rectangle.resize", title: recordingState.cameraOverlaySize.displayName)
        }
        .menuStyle(.borderlessButton)
        .fixedSize()
    }

    private var optionsMenu: some View {
        Menu {
            if recordingState.microphoneEnabled {
                Picker("Microphone", selection: $audioManager.selectedMicrophone) {
                    ForEach(audioManager.availableMicrophones) { device in
                        Text(device.name)
                            .tag(device)
                    }
                }
                .disabled(audioManager.isLoading)
            }

            if recordingState.cameraOverlayEnabled {
                Picker("Camera", selection: $cameraManager.selectedCameraID) {
                    if cameraManager.availableCameras.isEmpty {
                        Text("No camera available")
                            .tag("")
                    } else {
                        ForEach(cameraManager.availableCameras) { camera in
                            Text(camera.name)
                                .tag(camera.id)
                        }
                    }
                }
                .disabled(cameraManager.availableCameras.isEmpty)
            }

            if !recordingState.microphoneEnabled && !recordingState.cameraOverlayEnabled {
                Text("No devices enabled")
            }
        } label: {
            Text("Devices")
                .font(.system(size: 13, weight: .semibold))
            .frame(height: 46)
            .padding(.horizontal, 12)
            .background(Color.primary.opacity(0.08), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .menuStyle(.borderlessButton)
        .fixedSize()
    }

    private func modeButton(_ mode: RecordingCaptureMode, icon: String, title: String) -> some View {
        let selected = recordingState.captureMode == mode

        return Button {
            switch mode {
            case .fullScreen:
                recordingState.captureMode = .fullScreen
                recordingState.selectedWindowTarget = nil
                controller.updatePreview()
            case .selectedArea:
                controller.selectAreaForPreview()
            case .selectedWindow:
                controller.selectWindowForPreview()
            }
        } label: {
            VStack(spacing: 3) {
                Image(systemName: icon)
                    .font(.system(size: 19, weight: .semibold))
                Text(title)
                    .font(.system(size: 10, weight: .semibold))
            }
            .frame(width: 54, height: 50)
            .foregroundStyle(selected ? .white : .primary)
            .background(selected ? Color.blue.opacity(0.85) : Color.primary.opacity(0.08), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
        .help(title)
    }

    private func toggleButton(isOn: Bool, icon: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 17, weight: .semibold))
                .frame(width: 46, height: 46)
                .foregroundStyle(isOn ? .white : .primary)
                .background(isOn ? Color.blue.opacity(0.85) : Color.primary.opacity(0.08), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
        .help(title)
    }

    private func menuChip(icon: String, title: String) -> some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .font(.system(size: 13, weight: .semibold))
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .lineLimit(1)
            Image(systemName: "chevron.down")
                .font(.system(size: 9, weight: .bold))
                .foregroundStyle(.secondary)
        }
        .frame(height: 46)
        .padding(.horizontal, 10)
        .background(Color.primary.opacity(0.08), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

private struct RecordingStopBarView: View {
    @ObservedObject private var controller: RecordingController
    @ObservedObject private var recordingState: RecordingState
    let onStop: () -> Void

    init(
        controller: RecordingController,
        onStop: @escaping () -> Void
    ) {
        self.controller = controller
        self.recordingState = controller.recordingState
        self.onStop = onStop
    }

    var body: some View {
        HStack(spacing: 0) {
            StopWindowDragHandle()
                .frame(width: 18, height: 46)
                .padding(.leading, 7)
                .padding(.trailing, 3)

            Button(action: onStop) {
                ZStack {
                    Image(systemName: "stop.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.red)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.2), radius: 8, y: 4)

                    if controller.isStopping {
                        Circle()
                            .fill(Color.black.opacity(0.24))
                            .frame(width: 44, height: 44)
                        ProgressView()
                            .controlSize(.small)
                            .tint(.white)
                    }
                }
                .frame(width: 48, height: 46)
            }
            .buttonStyle(.plain)
            .disabled(controller.isStopping)
            .opacity(controller.isStopping ? 0.75 : 1)
            .help("Stop recording")
            .accessibilityLabel("Stop recording")

            Text(timeString(from: recordingState.recordingDuration))
                .font(.system(size: 13, weight: .semibold, design: .monospaced))
                .foregroundStyle(.primary.opacity(0.74))
                .lineLimit(1)
                .frame(width: 50, alignment: .leading)
                .padding(.leading, 6)
                .padding(.trailing, 6)
        }
        .padding(8)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.24), radius: 18, y: 10)
    }

    private func timeString(from duration: TimeInterval) -> String {
        let totalSeconds = max(0, Int(duration))
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

private struct StopWindowDragHandle: View {
    var body: some View {
        WindowDragHandleRepresentable()
            .overlay {
                VStack(spacing: 4) {
                    ForEach(0..<3, id: \.self) { _ in
                        Capsule()
                            .fill(Color.primary.opacity(0.34))
                            .frame(width: 4, height: 4)
                    }
                }
            }
            .contentShape(Rectangle())
            .help("Drag")
    }
}

private struct WindowDragHandleRepresentable: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        StopWindowDragHandleView()
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

private final class StopWindowDragHandleView: NSView {
    override func mouseDown(with event: NSEvent) {
        window?.performDrag(with: event)
    }

    override func resetCursorRects() {
        addCursorRect(bounds, cursor: .openHand)
    }
}
