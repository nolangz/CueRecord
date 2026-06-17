import AppKit
import AVFoundation
import Combine
import SwiftUI

@MainActor
final class RecordingEditorWindow: NSObject, NSWindowDelegate {
    private var window: NSWindow?
    private var onClose: (() -> Void)?

    func show(
        controller: RecordingController,
        capturedOutput: CapturedRecordingOutput,
        onDelete: @escaping () -> Void,
        onExport: @escaping (RecordingEditDecision) -> Void,
        onClose: @escaping () -> Void
    ) {
        if let window {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }

        self.onClose = onClose
        let session = RecordingEditSession(capturedOutput: capturedOutput)
        let rootView = RecordingEditorView(
            session: session,
            controller: controller,
            onDelete: { [weak self] in
                self?.hide()
                onDelete()
            },
            onExport: { [weak self] decision in
                self?.hide()
                onExport(decision)
            }
        )

        let visibleFrame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1280, height: 820)
        let width = min(max(1120, visibleFrame.width * 0.74), visibleFrame.width - 80)
        let height = min(max(700, visibleFrame.height * 0.78), visibleFrame.height - 80)
        let frame = NSRect(
            x: visibleFrame.midX - width / 2,
            y: visibleFrame.midY - height / 2,
            width: width,
            height: height
        )

        let window = NSWindow(
            contentRect: frame,
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.title = uiText("Edit Recording")
        window.titlebarAppearsTransparent = true
        window.toolbarStyle = .unified
        window.minSize = NSSize(width: 980, height: 620)
        window.setFrameAutosaveName("RecordingEditorWindow")
        window.isReleasedWhenClosed = false
        window.delegate = self
        window.contentView = NSHostingView(rootView: rootView)

        self.window = window
        NSApp.activate(ignoringOtherApps: true)
        window.makeKeyAndOrderFront(nil)
    }

    func hide() {
        window?.contentView = nil
        window?.orderOut(nil)
        window?.close()
        window = nil
    }

    func windowWillClose(_ notification: Notification) {
        window?.contentView = nil
        window = nil
        let close = onClose
        onClose = nil
        close?()
    }
}

@MainActor
private final class RecordingEditSession: ObservableObject {
    let capturedOutput: CapturedRecordingOutput
    let screenPlayer: AVPlayer
    let cameraPlayer: AVPlayer?
    let duration: Double
    let videoSize: CGSize
    let hasCamera: Bool

    @Published var cuts: [RecordingEditCut]
    @Published var selectedCutID: UUID?
    @Published private(set) var isPlaying = false

    init(capturedOutput: CapturedRecordingOutput) {
        self.capturedOutput = capturedOutput
        screenPlayer = AVPlayer(url: capturedOutput.outputURL)
        if let cameraURL = capturedOutput.cameraURL {
            cameraPlayer = AVPlayer(url: cameraURL)
        } else {
            cameraPlayer = nil
        }

        hasCamera = capturedOutput.cameraURL != nil
        duration = Self.assetDuration(for: capturedOutput.outputURL)
        videoSize = Self.assetVideoSize(for: capturedOutput.outputURL)
        let defaultFrame = Self.defaultCameraFrame(
            overlayMetadataURL: capturedOutput.overlayMetadataURL,
            videoSize: videoSize
        )
        let defaultShape = Self.defaultCameraShape(overlayMetadataURL: capturedOutput.overlayMetadataURL)
        let defaultMode: RecordingEditLayoutMode = hasCamera ? .screenWithCamera : .screenFullScreen
        let cut = RecordingEditCut(
            startTime: 0,
            endTime: max(duration, 0.1),
            layoutMode: defaultMode,
            cameraFrame: defaultFrame,
            cameraShape: defaultShape
        )
        cuts = [cut]
        selectedCutID = cut.id
    }

    var selectedCut: RecordingEditCut? {
        guard let selectedCutID else { return cuts.first }
        return cuts.first { $0.id == selectedCutID } ?? cuts.first
    }

    var canDeleteSelectedCut: Bool {
        cuts.count > 1
    }

    var exportDecision: RecordingEditDecision {
        RecordingEditDecision(cuts: normalizedCuts())
    }

    func updateSelectedCut(_ update: (inout RecordingEditCut) -> Void) {
        guard let selectedCutID,
              let index = cuts.firstIndex(where: { $0.id == selectedCutID })
        else {
            return
        }

        var cut = cuts[index]
        update(&cut)
        normalize(&cut)
        cuts[index] = cut
    }

    func addCut() {
        guard let selectedCut,
              let index = cuts.firstIndex(where: { $0.id == selectedCut.id })
        else {
            let cut = RecordingEditCut(
                startTime: 0,
                endTime: max(duration, 0.1),
                layoutMode: hasCamera ? .screenWithCamera : .screenFullScreen,
                cameraFrame: .defaultCameraFrame,
                cameraShape: .circle
            )
            cuts.append(cut)
            selectedCutID = cut.id
            return
        }

        let midpoint = selectedCut.startTime + max(selectedCut.duration / 2, 0.5)
        guard midpoint < selectedCut.endTime - 0.1 else { return }

        var first = selectedCut
        first.endTime = midpoint
        var second = selectedCut
        second.id = UUID()
        second.startTime = midpoint
        cuts[index] = first
        cuts.insert(second, at: index + 1)
        selectedCutID = second.id
    }

    func deleteSelectedCut() {
        guard canDeleteSelectedCut,
              let selectedCutID,
              let index = cuts.firstIndex(where: { $0.id == selectedCutID })
        else {
            return
        }

        cuts.remove(at: index)
        self.selectedCutID = cuts[min(index, cuts.count - 1)].id
    }

    func seekToSelectedCutStart() {
        let seconds = selectedCut?.startTime ?? 0
        let time = CMTime(seconds: seconds, preferredTimescale: 600)
        screenPlayer.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
        cameraPlayer?.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
    }

    func play() {
        seekIfNeededForSelectedCut()
        screenPlayer.play()
        cameraPlayer?.play()
        isPlaying = true
    }

    func pause() {
        screenPlayer.pause()
        cameraPlayer?.pause()
        isPlaying = false
    }

    func togglePlayback() {
        isPlaying ? pause() : play()
    }

    private func seekIfNeededForSelectedCut() {
        guard let selectedCut else { return }
        let currentSeconds = CMTimeGetSeconds(screenPlayer.currentTime())
        guard currentSeconds.isFinite,
              currentSeconds >= selectedCut.startTime,
              currentSeconds <= selectedCut.endTime
        else {
            seekToSelectedCutStart()
            return
        }
    }

    private func normalizedCuts() -> [RecordingEditCut] {
        let cleaned = cuts
            .map { cut -> RecordingEditCut in
                var next = cut
                normalize(&next)
                return next
            }
            .filter { $0.duration > 0.05 }
            .sorted { $0.startTime < $1.startTime }

        if cleaned.isEmpty {
            return [
                RecordingEditCut(
                    startTime: 0,
                    endTime: max(duration, 0.1),
                    layoutMode: hasCamera ? .screenWithCamera : .screenFullScreen,
                    cameraFrame: .defaultCameraFrame,
                    cameraShape: .circle
                )
            ]
        }

        return cleaned
    }

    private func normalize(_ cut: inout RecordingEditCut) {
        let maxDuration = max(duration, 0.1)
        cut.startTime = min(max(0, cut.startTime), maxDuration)
        cut.endTime = min(max(cut.startTime + 0.1, cut.endTime), maxDuration)
        if cut.layoutMode.requiresCamera && !hasCamera {
            cut.layoutMode = .screenFullScreen
        }
        cut.cameraFrame = cut.cameraFrame.clamped()
    }

    private static func assetDuration(for url: URL) -> Double {
        let asset = AVURLAsset(url: url)
        let seconds = CMTimeGetSeconds(asset.duration)
        return seconds.isFinite ? max(0, seconds) : 0
    }

    private static func assetVideoSize(for url: URL) -> CGSize {
        let asset = AVURLAsset(url: url)
        guard let track = asset.tracks(withMediaType: .video).first else {
            return CGSize(width: 1920, height: 1080)
        }

        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: max(abs(size.width), 1), height: max(abs(size.height), 1))
    }

    private static func defaultCameraFrame(
        overlayMetadataURL: URL?,
        videoSize: CGSize
    ) -> RecordingEditNormalizedRect {
        guard let metadata = readOverlayMetadata(from: overlayMetadataURL),
              let sample = metadata.samples.first
        else {
            return .defaultCameraFrame
        }

        let outputExtent = CGRect(origin: .zero, size: videoSize)
        let targetRect = overlayTargetRect(
            from: sample.frame.cgRect,
            recordingRect: metadata.recordingRect?.cgRect,
            outputExtent: outputExtent
        )
        return RecordingEditNormalizedRect(videoRect: targetRect, in: outputExtent)
    }

    private static func defaultCameraShape(overlayMetadataURL: URL?) -> CameraOverlayShape {
        guard let metadata = readOverlayMetadata(from: overlayMetadataURL),
              let sample = metadata.samples.first
        else {
            return .circle
        }

        return shape(from: sample.shape)
    }

    private static func readOverlayMetadata(from url: URL?) -> RecordingEditorOverlayMetadataFile? {
        guard let url,
              let data = try? Data(contentsOf: url)
        else {
            return nil
        }

        return try? JSONDecoder().decode(RecordingEditorOverlayMetadataFile.self, from: data)
    }

    private static func overlayTargetRect(
        from overlayFrame: CGRect,
        recordingRect: CGRect?,
        outputExtent: CGRect
    ) -> CGRect {
        let sourceRect = recordingRect ?? outputExtent
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

    private static func shape(from value: String) -> CameraOverlayShape {
        switch value {
        case "roundedRectangle":
            return .roundedSquare
        case "roundedSquare":
            return .roundedBox
        default:
            return .circle
        }
    }
}

private struct RecordingEditorView: View {
    @ObservedObject private var interfaceLanguage = InterfaceLanguageSettings.shared
    @ObservedObject var session: RecordingEditSession
    @ObservedObject var controller: RecordingController

    let onDelete: () -> Void
    let onExport: (RecordingEditDecision) -> Void

    private func t(_ english: String) -> String {
        interfaceLanguage.text(english)
    }

    var body: some View {
        VStack(spacing: 0) {
            HSplitView {
                cutsSidebar
                    .frame(minWidth: 190, idealWidth: 220, maxWidth: 280, maxHeight: .infinity)

                previewPane
                    .frame(minWidth: 500, maxWidth: .infinity, maxHeight: .infinity)

                inspector
                    .frame(minWidth: 280, idealWidth: 312, maxWidth: 360, maxHeight: .infinity)
            }

            Divider()

            footer
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(nsColor: .windowBackgroundColor))
        .onDisappear {
            session.pause()
        }
    }

    private var cutsSidebar: some View {
        VStack(spacing: 0) {
            HStack {
                Text(t("Cuts"))
                    .font(.headline)
                Spacer()
                Button {
                    session.addCut()
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 28, height: 28)
                }
                .buttonStyle(.borderless)
                .help(t("Add Cut"))
                .accessibilityLabel(t("Add Cut"))
            }
            .padding(.horizontal, 14)
            .padding(.top, 18)
            .padding(.bottom, 8)

            List(selection: $session.selectedCutID) {
                ForEach(Array(session.cuts.enumerated()), id: \.element.id) { index, cut in
                    RecordingCutRow(index: index, cut: cut)
                        .tag(cut.id)
                }
            }
            .listStyle(.sidebar)

            Button(role: .destructive) {
                session.deleteSelectedCut()
            } label: {
                Label(t("Delete Cut"), systemImage: "trash")
                    .frame(maxWidth: .infinity)
            }
            .disabled(!session.canDeleteSelectedCut)
            .padding(12)
            .accessibilityLabel(t("Delete Cut"))
        }
        .background(.bar)
    }

    private var previewPane: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Text(t("Preview"))
                    .font(.headline)
                if let cut = session.selectedCut {
                    Text("\(timeString(cut.startTime)) - \(timeString(cut.endTime))")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Button {
                    session.seekToSelectedCutStart()
                } label: {
                    Label(t("Restart Playback"), systemImage: "backward.end.fill")
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                Button {
                    session.togglePlayback()
                } label: {
                    Label(session.isPlaying ? t("Pause") : t("Play"), systemImage: session.isPlaying ? "pause.fill" : "play.fill")
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
            .padding(.bottom, 10)

            RecordingEditorPreviewCanvas(session: session)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
        }
    }

    private var inspector: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text(t("Current Cut"))
                    .font(.headline)

                modeSection
                timingSection
                cameraSection
            }
            .padding(20)
        }
        .background(Color(nsColor: .controlBackgroundColor))
    }

    private var modeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(t("Display Mode"))
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Picker(t("Display Mode"), selection: layoutModeBinding) {
                ForEach(RecordingEditLayoutMode.allCases, id: \.self) { mode in
                    Label(t(mode.shortLabel), systemImage: mode.systemImage)
                        .tag(mode)
                        .disabled(mode.requiresCamera && !session.hasCamera)
                }
            }
            .pickerStyle(.segmented)
        }
    }

    private var timingSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(t("Timing"))
                .font(.subheadline)
                .foregroundStyle(.secondary)

            timeSlider(title: t("Start"), value: startTimeBinding, range: 0...max(session.duration, 0.1))
            timeSlider(title: t("End"), value: endTimeBinding, range: 0...max(session.duration, 0.1))
        }
    }

    @ViewBuilder
    private var cameraSection: some View {
        if session.hasCamera {
            VStack(alignment: .leading, spacing: 12) {
                Text(t("Camera Frame"))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 8) {
                    Text(t("Position"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 2), spacing: 8) {
                        positionButton(t("Top Left"), x: 0.06, y: 0.06)
                        positionButton(t("Top Right"), x: 0.70, y: 0.06)
                        positionButton(t("Bottom Left"), x: 0.06, y: 0.70)
                        positionButton(t("Bottom Right"), x: 0.70, y: 0.70)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(t("Size"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Slider(value: cameraSizeBinding, in: 0.12...0.46)
                }

                Picker(t("Shape"), selection: cameraShapeBinding) {
                    ForEach(CameraOverlayShape.allCases, id: \.self) { shape in
                        Text(shape.localizedDisplayName)
                            .tag(shape)
                    }
                }
                .pickerStyle(.menu)
            }
            .disabled(session.selectedCut?.layoutMode == .screenFullScreen)
        } else {
            Text(t("No camera track was recorded."))
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var footer: some View {
        HStack {
            Button(role: .destructive) {
                session.pause()
                onDelete()
            } label: {
                Label(t("Delete Recording"), systemImage: "trash")
            }
            .disabled(controller.isExporting)

            Spacer()

            Button {
                session.pause()
                onExport(session.exportDecision)
            } label: {
                Label(t("Export"), systemImage: "square.and.arrow.up")
            }
            .buttonStyle(.borderedProminent)
            .keyboardShortcut(.defaultAction)
            .disabled(controller.isExporting)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(.bar)
    }

    private var layoutModeBinding: Binding<RecordingEditLayoutMode> {
        Binding {
            session.selectedCut?.layoutMode ?? .screenFullScreen
        } set: { mode in
            session.updateSelectedCut { cut in
                cut.layoutMode = mode
            }
        }
    }

    private var startTimeBinding: Binding<Double> {
        Binding {
            session.selectedCut?.startTime ?? 0
        } set: { value in
            session.updateSelectedCut { cut in
                cut.startTime = min(value, cut.endTime - 0.1)
            }
        }
    }

    private var endTimeBinding: Binding<Double> {
        Binding {
            session.selectedCut?.endTime ?? session.duration
        } set: { value in
            session.updateSelectedCut { cut in
                cut.endTime = max(value, cut.startTime + 0.1)
            }
        }
    }

    private var cameraSizeBinding: Binding<Double> {
        Binding {
            session.selectedCut?.cameraFrame.width ?? RecordingEditNormalizedRect.defaultCameraFrame.width
        } set: { value in
            session.updateSelectedCut { cut in
                let centerX = cut.cameraFrame.x + cut.cameraFrame.width / 2
                let centerY = cut.cameraFrame.y + cut.cameraFrame.height / 2
                cut.cameraFrame.width = value
                cut.cameraFrame.height = value
                cut.cameraFrame.x = centerX - value / 2
                cut.cameraFrame.y = centerY - value / 2
            }
        }
    }

    private var cameraShapeBinding: Binding<CameraOverlayShape> {
        Binding {
            session.selectedCut?.cameraShape ?? .circle
        } set: { shape in
            session.updateSelectedCut { cut in
                cut.cameraShape = shape
            }
        }
    }

    private func positionButton(_ title: String, x: Double, y: Double) -> some View {
        Button(title) {
            session.updateSelectedCut { cut in
                cut.cameraFrame.x = x
                cut.cameraFrame.y = y
            }
        }
        .buttonStyle(.bordered)
        .controlSize(.small)
    }

    private func timeSlider(title: String, value: Binding<Double>, range: ClosedRange<Double>) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(timeString(value.wrappedValue))
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
            Slider(value: value, in: range)
        }
    }

    private func timeString(_ seconds: Double) -> String {
        let safeSeconds = max(0, seconds)
        let minutes = Int(safeSeconds) / 60
        let wholeSeconds = Int(safeSeconds) % 60
        let tenths = Int((safeSeconds.truncatingRemainder(dividingBy: 1) * 10).rounded(.down))
        return String(format: "%02d:%02d.%01d", minutes, wholeSeconds, tenths)
    }
}

private struct RecordingCutRow: View {
    @ObservedObject private var interfaceLanguage = InterfaceLanguageSettings.shared
    let index: Int
    let cut: RecordingEditCut

    private func t(_ english: String) -> String {
        interfaceLanguage.text(english)
    }

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: cut.layoutMode.systemImage)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.secondary)
                .frame(width: 20)

            VStack(alignment: .leading, spacing: 3) {
                Text("\(t("Cut")) \(index + 1)")
                    .font(.system(size: 13, weight: .semibold))
                Text("\(timeString(cut.startTime)) - \(timeString(cut.endTime)) · \(t(cut.layoutMode.shortLabel))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 4)
    }

    private func timeString(_ seconds: Double) -> String {
        let safeSeconds = max(0, seconds)
        let minutes = Int(safeSeconds) / 60
        let wholeSeconds = Int(safeSeconds) % 60
        return String(format: "%02d:%02d", minutes, wholeSeconds)
    }
}

private struct RecordingEditorPreviewCanvas: View {
    @ObservedObject private var interfaceLanguage = InterfaceLanguageSettings.shared
    @ObservedObject var session: RecordingEditSession
    @State private var dragStartFrame: RecordingEditNormalizedRect?

    private func t(_ english: String) -> String {
        interfaceLanguage.text(english)
    }

    var body: some View {
        GeometryReader { geometry in
            let fittedSize = aspectFit(session.videoSize, in: geometry.size)

            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.black)

                if let cut = session.selectedCut {
                    ZStack {
                        switch cut.layoutMode {
                        case .cameraFullScreen:
                            if session.hasCamera {
                                RecordingPlayerLayerView(player: session.cameraPlayer, gravity: .resizeAspectFill)
                            } else {
                                unavailableCameraView
                            }
                        case .screenFullScreen:
                            RecordingPlayerLayerView(player: session.screenPlayer, gravity: .resizeAspect)
                        case .screenWithCamera:
                            RecordingPlayerLayerView(player: session.screenPlayer, gravity: .resizeAspect)
                            if session.hasCamera {
                                draggableCameraOverlay(cut: cut, canvasSize: fittedSize)
                            }
                        }
                    }
                    .frame(width: fittedSize.width, height: fittedSize.height)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .strokeBorder(Color.primary.opacity(0.10))
                    }
                }
            }
            .frame(width: fittedSize.width, height: fittedSize.height)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var unavailableCameraView: some View {
        VStack(spacing: 8) {
            Image(systemName: "video.slash")
                .font(.system(size: 32, weight: .semibold))
            Text(t("No camera track was recorded."))
                .font(.subheadline)
        }
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func draggableCameraOverlay(cut: RecordingEditCut, canvasSize: CGSize) -> some View {
        let frame = cut.cameraFrame.clamped()
        let width = max(44, canvasSize.width * CGFloat(frame.width))
        let height = max(44, canvasSize.height * CGFloat(frame.height))
        let x = canvasSize.width * CGFloat(frame.x) + width / 2
        let y = canvasSize.height * CGFloat(frame.y) + height / 2

        return RecordingCameraPreviewSurface(player: session.cameraPlayer, shape: cut.cameraShape)
            .frame(width: width, height: height)
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(.black.opacity(0.38), in: Circle())
                    .padding(6)
            }
            .position(x: x, y: y)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if dragStartFrame == nil {
                            dragStartFrame = frame
                        }
                        guard var next = dragStartFrame else { return }
                        next.x += Double(value.translation.width / max(canvasSize.width, 1))
                        next.y += Double(value.translation.height / max(canvasSize.height, 1))
                        next.clamp()
                        session.updateSelectedCut { cut in
                            cut.cameraFrame = next
                        }
                    }
                    .onEnded { _ in
                        dragStartFrame = nil
                    }
            )
            .accessibilityLabel(t("Camera Frame"))
    }

    private func aspectFit(_ sourceSize: CGSize, in containerSize: CGSize) -> CGSize {
        let sourceAspect = sourceSize.width / max(sourceSize.height, 1)
        let containerAspect = containerSize.width / max(containerSize.height, 1)

        if sourceAspect > containerAspect {
            let width = containerSize.width
            return CGSize(width: width, height: width / sourceAspect)
        }

        let height = containerSize.height
        return CGSize(width: height * sourceAspect, height: height)
    }
}

private struct RecordingCameraPreviewSurface: View {
    let player: AVPlayer?
    let shape: CameraOverlayShape

    var body: some View {
        switch shape {
        case .circle:
            surface
                .clipShape(Circle())
                .overlay(Circle().strokeBorder(.white.opacity(0.85), lineWidth: 2))
        case .roundedSquare, .roundedBox:
            surface
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).strokeBorder(.white.opacity(0.85), lineWidth: 2))
        }
    }

    private var surface: some View {
        RecordingPlayerLayerView(player: player, gravity: .resizeAspectFill)
            .background(Color.black)
    }
}

private struct RecordingPlayerLayerView: NSViewRepresentable {
    let player: AVPlayer?
    let gravity: AVLayerVideoGravity

    func makeNSView(context: Context) -> RecordingPlayerLayerHostView {
        let view = RecordingPlayerLayerHostView()
        view.playerLayer.player = player
        view.playerLayer.videoGravity = gravity
        return view
    }

    func updateNSView(_ nsView: RecordingPlayerLayerHostView, context: Context) {
        nsView.playerLayer.player = player
        nsView.playerLayer.videoGravity = gravity
    }
}

private final class RecordingPlayerLayerHostView: NSView {
    let playerLayer = AVPlayerLayer()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer = CALayer()
        layer?.backgroundColor = NSColor.black.cgColor
        layer?.addSublayer(playerLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layout() {
        super.layout()
        playerLayer.frame = bounds
    }
}

private nonisolated struct RecordingEditorOverlayMetadataFile: Codable {
    let recordingRect: RecordingEditorCodableRect?
    let samples: [RecordingEditorOverlayMetadataSample]
}

private nonisolated struct RecordingEditorOverlayMetadataSample: Codable {
    let frame: RecordingEditorCodableRect
    let shape: String
}

private nonisolated struct RecordingEditorCodableRect: Codable {
    let x: Double
    let y: Double
    let width: Double
    let height: Double

    var cgRect: CGRect {
        CGRect(x: x, y: y, width: width, height: height)
    }
}
