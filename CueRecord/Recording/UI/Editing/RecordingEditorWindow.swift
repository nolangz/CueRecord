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
    private var timeObserverToken: Any?

    @Published var cuts: [RecordingEditCut]
    @Published var selectedCutID: UUID?
    @Published private(set) var isPlaying = false
    @Published private(set) var playheadTime: Double = 0

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
        playheadTime = cut.startTime

        timeObserverToken = screenPlayer.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 0.05, preferredTimescale: 600),
            queue: .main
        ) { [weak self] time in
            Task { @MainActor [weak self] in
                self?.updatePlayhead(from: time)
            }
        }
    }

    deinit {
        if let timeObserverToken {
            screenPlayer.removeTimeObserver(timeObserverToken)
        }
    }

    var selectedCut: RecordingEditCut? {
        guard let selectedCutID else { return cuts.first }
        return cuts.first { $0.id == selectedCutID } ?? cuts.first
    }

    var canMergeSelectedCut: Bool {
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

    func updateCut(id: RecordingEditCut.ID, _ update: (inout RecordingEditCut) -> Void) {
        guard let index = cuts.firstIndex(where: { $0.id == id }) else { return }
        var cut = cuts[index]
        update(&cut)
        normalize(&cut)
        cuts[index] = cut
    }

    func addCut() {
        guard !cuts.isEmpty else {
            let cut = RecordingEditCut(
                startTime: 0,
                endTime: max(duration, 0.1),
                layoutMode: hasCamera ? .screenWithCamera : .screenFullScreen,
                cameraFrame: .defaultCameraFrame,
                cameraShape: .circle
            )
            cuts.append(cut)
            selectedCutID = cut.id
            seek(to: cut.startTime, selectingCut: true)
            return
        }

        let minimumSegmentDuration = 0.1
        let splitTime = min(max(playheadTime, 0), max(duration, minimumSegmentDuration))
        guard let index = cuts.firstIndex(where: { cut in
            splitTime > cut.startTime + minimumSegmentDuration
                && splitTime < cut.endTime - minimumSegmentDuration
        }) else {
            seek(to: splitTime, selectingCut: true)
            return
        }

        var first = cuts[index]
        first.endTime = splitTime
        var second = cuts[index]
        second.id = UUID()
        second.startTime = splitTime
        cuts[index] = first
        cuts.insert(second, at: index + 1)
        selectedCutID = second.id
        seek(to: splitTime, selectingCut: false)
    }

    func mergeSelectedCut() {
        guard canMergeSelectedCut,
              let selectedCutID,
              let index = cuts.firstIndex(where: { $0.id == selectedCutID })
        else {
            return
        }

        if index > 0 {
            var merged = cuts[index - 1]
            let selected = cuts[index]
            merged.startTime = min(merged.startTime, selected.startTime)
            merged.endTime = max(merged.endTime, selected.endTime)
            cuts[index - 1] = merged
            cuts.remove(at: index)
            self.selectedCutID = merged.id
            seek(to: max(merged.startTime, min(playheadTime, merged.endTime)), selectingCut: false)
        } else {
            var merged = cuts[index]
            let next = cuts[index + 1]
            merged.startTime = min(merged.startTime, next.startTime)
            merged.endTime = max(merged.endTime, next.endTime)
            cuts[index] = merged
            cuts.remove(at: index + 1)
            self.selectedCutID = merged.id
            seek(to: max(merged.startTime, min(playheadTime, merged.endTime)), selectingCut: false)
        }
    }

    func seekToSelectedCutStart() {
        let seconds = selectedCut?.startTime ?? 0
        seek(to: seconds, selectingCut: false)
    }

    func selectCut(_ id: RecordingEditCut.ID, seek: Bool) {
        selectedCutID = id
        if seek, let cut = cuts.first(where: { $0.id == id }) {
            self.seek(to: cut.startTime, selectingCut: false)
        }
    }

    func seek(to seconds: Double, selectingCut: Bool) {
        let clampedSeconds = min(max(0, seconds), max(duration, 0.1))
        let time = CMTime(seconds: clampedSeconds, preferredTimescale: 600)
        screenPlayer.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
        cameraPlayer?.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
        playheadTime = clampedSeconds

        if selectingCut,
           let cut = cuts.first(where: { clampedSeconds >= $0.startTime && clampedSeconds <= $0.endTime }) {
            selectedCutID = cut.id
        }
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

    private func updatePlayhead(from time: CMTime) {
        let seconds = CMTimeGetSeconds(time)
        guard seconds.isFinite else { return }

        playheadTime = min(max(0, seconds), max(duration, 0.1))
        guard let selectedCut else { return }

        if playheadTime >= selectedCut.endTime {
            pause()
            seek(to: selectedCut.endTime, selectingCut: false)
        }
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

    @State private var timelineHeight: CGFloat = 260
    @State private var timelineResizeStartHeight: CGFloat?

    private let minimumTimelineHeight: CGFloat = 190
    private let maximumTimelineHeight: CGFloat = 380

    private func t(_ english: String) -> String {
        interfaceLanguage.text(english)
    }

    var body: some View {
        VStack(spacing: 0) {
            HSplitView {
                previewPane
                    .frame(minWidth: 620, maxWidth: .infinity, maxHeight: .infinity)

                inspector
                    .frame(minWidth: 220, idealWidth: 240, maxWidth: 270, maxHeight: .infinity)
            }
            .frame(maxHeight: .infinity)

            Divider()

            timelineResizeHandle

            RecordingEditorTimeline(session: session)
                .frame(height: timelineHeight)

            Divider()

            footer
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(nsColor: .windowBackgroundColor))
        .onDisappear {
            session.pause()
        }
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
            VStack(alignment: .leading, spacing: 16) {
                currentCutSummary

                modeSection
                cameraSection
            }
            .padding(16)
        }
        .background(Color(nsColor: .controlBackgroundColor))
    }

    private var currentCutSummary: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(t("Current Cut"))
                .font(.headline)

            if let cut = session.selectedCut {
                let index = (session.cuts.firstIndex { $0.id == cut.id } ?? 0) + 1
                HStack(spacing: 6) {
                    Image(systemName: cut.layoutMode.systemImage)
                        .foregroundStyle(.secondary)
                    Text("\(t("Cut")) \(index)")
                        .font(.subheadline.weight(.semibold))
                    Spacer()
                }
                Text("\(timeString(cut.startTime)) - \(timeString(cut.endTime))")
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
        }
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

    @ViewBuilder
    private var cameraSection: some View {
        if session.hasCamera {
            VStack(alignment: .leading, spacing: 12) {
                Text(t("Camera Shape"))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

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

    private var timelineResizeHandle: some View {
        RoundedRectangle(cornerRadius: 999, style: .continuous)
            .fill(Color.secondary.opacity(timelineResizeStartHeight == nil ? 0.24 : 0.48))
            .frame(width: 58, height: 3)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 5)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if timelineResizeStartHeight == nil {
                            timelineResizeStartHeight = timelineHeight
                        }
                        let startHeight = timelineResizeStartHeight ?? timelineHeight
                        timelineHeight = min(
                            max(startHeight - value.translation.height, minimumTimelineHeight),
                            maximumTimelineHeight
                        )
                    }
                    .onEnded { _ in
                        timelineResizeStartHeight = nil
                    }
            )
            .help(t("Resize Timeline"))
            .background(Color(nsColor: .windowBackgroundColor))
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

    private var cameraShapeBinding: Binding<CameraOverlayShape> {
        Binding {
            session.selectedCut?.cameraShape ?? .circle
        } set: { shape in
            session.updateSelectedCut { cut in
                cut.cameraShape = shape
            }
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

private struct RecordingEditorTimeline: View {
    @ObservedObject private var interfaceLanguage = InterfaceLanguageSettings.shared
    @ObservedObject var session: RecordingEditSession

    private let trackHeaderWidth: CGFloat = 128
    private let horizontalPadding: CGFloat = 12
    private let rulerHeight: CGFloat = 30
    private let trackHeight: CGFloat = 82
    private let minimumPixelsPerSecond: CGFloat = 4
    private let defaultPixelsPerSecond: CGFloat = 56
    private let maximumPixelsPerSecond: CGFloat = 260
    private let maximumContentWidth: CGFloat = 64_000
    private let playheadAnchorID = "recordingTimelinePlayheadAnchor"

    @State private var pixelsPerSecond: CGFloat = 48
    @State private var lastTimelineViewportWidth: CGFloat = 0
    @State private var isPlayheadSelected = false
    @State private var playheadDragBaseTime: Double?

    private func t(_ english: String) -> String {
        interfaceLanguage.text(english)
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                ControlGroup {
                    Button {
                        session.addCut()
                    } label: {
                        Label(t("Add Cut"), systemImage: "scissors")
                    }
                    .labelStyle(.iconOnly)
                    .help(t("Add Cut at Playhead"))
                    .accessibilityLabel(t("Add Cut"))

                    Button {
                        session.mergeSelectedCut()
                    } label: {
                        Label(t("Merge Cut"), systemImage: "link")
                    }
                    .labelStyle(.iconOnly)
                    .disabled(!session.canMergeSelectedCut)
                    .help(t("Merge Cut"))
                    .accessibilityLabel(t("Merge Cut"))
                }
                .controlSize(.small)

                Label(t("Main Timeline"), systemImage: "film.stack")
                    .font(.system(size: 12, weight: .semibold))
                Text("\(timeString(session.playheadTime)) / \(timeString(session.duration))")
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
                Spacer()

                timelineZoomControls
            }
            .padding(.horizontal, horizontalPadding)
            .frame(height: 40)

            Divider()

            GeometryReader { geometry in
                let duration = max(session.duration, 0.1)
                let viewportWidth = max(geometry.size.width - trackHeaderWidth - horizontalPadding * 2, 1)
                let desiredContentWidth = max(viewportWidth, CGFloat(duration) * pixelsPerSecond)
                let contentWidth = min(desiredContentWidth, max(viewportWidth, maximumContentWidth))
                let effectivePixelsPerSecond = contentWidth / CGFloat(duration)
                let playheadX = contentWidth * CGFloat(session.playheadTime / duration)

                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        trackGutter
                            .frame(width: trackHeaderWidth, height: rulerHeight + trackHeight)

                        ScrollViewReader { scrollProxy in
                            ScrollView(.horizontal, showsIndicators: true) {
                                ZStack(alignment: .topLeading) {
                                    playheadScrollAnchor(x: playheadX, width: contentWidth)

                                    timelineRuler(width: contentWidth, duration: duration, pixelsPerSecond: effectivePixelsPerSecond)
                                        .frame(width: contentWidth, height: rulerHeight)
                                        .gesture(timelineScrubGesture(width: contentWidth, duration: duration))

                                    timelineTrack(width: contentWidth, duration: duration, pixelsPerSecond: effectivePixelsPerSecond)
                                        .frame(width: contentWidth, height: trackHeight)
                                        .offset(y: rulerHeight)

                                    playhead(height: rulerHeight + trackHeight, contentWidth: contentWidth, duration: duration)
                                        .offset(x: playheadX - 12, y: 0)
                                }
                                .frame(width: contentWidth, height: rulerHeight + trackHeight, alignment: .topLeading)
                            }
                            .onChange(of: pixelsPerSecond) { _, _ in
                                withAnimation(.easeOut(duration: 0.16)) {
                                    scrollProxy.scrollTo(playheadAnchorID, anchor: .center)
                                }
                            }
                        }
                    }
                    .background(Color(nsColor: .controlBackgroundColor))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .strokeBorder(Color.secondary.opacity(0.12), lineWidth: 1)
                    }
                    .padding(.horizontal, horizontalPadding)

                    Spacer(minLength: 0)
                }
                .padding(.top, 8)
                .onAppear {
                    updateTimelineViewport(width: viewportWidth)
                    pixelsPerSecond = clampedPixelsPerSecond(pixelsPerSecond == defaultPixelsPerSecond ? defaultPixelsPerSecond : pixelsPerSecond)
                }
                .onChange(of: viewportWidth) { _, newWidth in
                    updateTimelineViewport(width: newWidth)
                }
            }
        }
        .padding(.bottom, 8)
        .background(Color(nsColor: .windowBackgroundColor))
    }

    private var timelineZoomControls: some View {
        HStack(spacing: 8) {
            ControlGroup {
                Button {
                    zoomOut()
                } label: {
                    Label(t("Zoom Out"), systemImage: "minus.magnifyingglass")
                }
                .labelStyle(.iconOnly)
                .keyboardShortcut("-", modifiers: .command)
                .disabled(pixelsPerSecond <= minimumPixelsPerSecond + 0.01)
                .help(t("Zoom Out"))

                Button {
                    zoomToFit()
                } label: {
                    Label(t("Zoom to Fit"), systemImage: "arrow.left.and.right")
                }
                .labelStyle(.iconOnly)
                .keyboardShortcut("0", modifiers: .command)
                .help(t("Zoom to Fit"))

                Button {
                    zoomIn()
                } label: {
                    Label(t("Zoom In"), systemImage: "plus.magnifyingglass")
                }
                .labelStyle(.iconOnly)
                .keyboardShortcut("+", modifiers: .command)
                .disabled(pixelsPerSecond >= maximumPixelsPerSecond - 0.01)
                .help(t("Zoom In"))
            }
            .controlSize(.small)

            Slider(value: timelineZoomBinding, in: Double(minimumPixelsPerSecond)...Double(maximumPixelsPerSecond)) {
                Text(t("Zoom"))
            }
            .controlSize(.small)
            .frame(width: 92)
            .help(t("Zoom"))
        }
    }

    private var timelineZoomBinding: Binding<Double> {
        Binding {
            Double(pixelsPerSecond)
        } set: { value in
            pixelsPerSecond = clampedPixelsPerSecond(CGFloat(value))
        }
    }

    private func updateTimelineViewport(width: CGFloat) {
        lastTimelineViewportWidth = max(width, 1)
    }

    private func zoomIn() {
        pixelsPerSecond = clampedPixelsPerSecond(pixelsPerSecond * 1.24)
    }

    private func zoomOut() {
        pixelsPerSecond = clampedPixelsPerSecond(pixelsPerSecond / 1.24)
    }

    private func zoomToFit() {
        let duration = max(session.duration, 0.1)
        let viewportWidth = max(lastTimelineViewportWidth, 1)
        pixelsPerSecond = clampedPixelsPerSecond(viewportWidth / CGFloat(duration))
    }

    private func clampedPixelsPerSecond(_ value: CGFloat) -> CGFloat {
        min(max(value, minimumPixelsPerSecond), maximumPixelsPerSecond)
    }

    private var trackGutter: some View {
        VStack(spacing: 0) {
            HStack {
                Text("TC")
                    .font(.system(size: 10, weight: .semibold, design: .monospaced))
                    .foregroundStyle(.tertiary)
                Spacer()
            }
            .padding(.horizontal, 10)
            .frame(height: rulerHeight)
            .background(Color.primary.opacity(0.035))

            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(Color.accentColor)
                    .frame(width: 8, height: 8)

                VStack(alignment: .leading, spacing: 2) {
                    Text(t("Cut Track"))
                        .font(.system(size: 10, weight: .bold))
                        .textCase(.uppercase)
                        .lineLimit(1)
                    Text("\(session.cuts.count) \(t("Cuts"))")
                        .font(.system(size: 9, design: .monospaced))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 10)
            .frame(height: trackHeight)
            .background(Color.primary.opacity(0.025))
        }
        .overlay(alignment: .trailing) {
            Rectangle()
                .fill(Color.secondary.opacity(0.18))
                .frame(width: 1)
        }
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.secondary.opacity(0.14))
                .frame(height: 1)
        }
    }

    private func timelineRuler(width: CGFloat, duration: Double, pixelsPerSecond: CGFloat) -> some View {
        let majorTicks = rulerTicks(for: duration, pixelsPerSecond: pixelsPerSecond)
        let majorInterval = tickInterval(for: duration, pixelsPerSecond: pixelsPerSecond)

        return ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(Color.primary.opacity(0.025))
                .contentShape(Rectangle())

            ForEach(minorTicks(for: duration, majorInterval: majorInterval), id: \.self) { tick in
                let x = width * CGFloat(tick / duration)
                Rectangle()
                    .fill(Color.secondary.opacity(0.14))
                    .frame(width: 1, height: 5)
                    .offset(x: x, y: -1)
            }

            ForEach(majorTicks, id: \.self) { tick in
                let x = width * CGFloat(tick / duration)
                VStack(spacing: 4) {
                    Text(timeString(tick, showsFractions: majorInterval < 1))
                        .font(.caption2.monospacedDigit())
                        .foregroundStyle(.secondary)
                        .fixedSize()
                    Rectangle()
                        .fill(Color.secondary.opacity(0.34))
                        .frame(width: 1, height: 7)
                }
                .offset(x: x)
            }

            Rectangle()
                .fill(Color.secondary.opacity(0.18))
                .frame(height: 1)
        }
    }

    private func timelineTrack(width: CGFloat, duration: Double, pixelsPerSecond: CGFloat) -> some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(Color.primary.opacity(0.032))
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(Color.secondary.opacity(0.14))
                        .frame(height: 1)
                }
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(Color.secondary.opacity(0.14))
                        .frame(height: 1)
                }
                .contentShape(Rectangle())
                .gesture(timelineScrubGesture(width: width, duration: duration))

            ForEach(rulerTicks(for: duration, pixelsPerSecond: pixelsPerSecond), id: \.self) { tick in
                let x = width * CGFloat(tick / duration)
                Rectangle()
                    .fill(Color.secondary.opacity(0.08))
                    .frame(width: 1, height: trackHeight)
                    .offset(x: x)
            }

            ForEach(Array(session.cuts.enumerated()), id: \.element.id) { index, cut in
                let x = width * CGFloat(cut.startTime / duration)
                let segmentWidth = max(28, width * CGFloat(cut.duration / duration))

                RecordingTimelineCutSegment(
                    index: index,
                    cut: cut,
                    isSelected: session.selectedCutID == cut.id,
                    width: segmentWidth,
                    duration: duration,
                    trackWidth: width,
                    onSelect: {
                        isPlayheadSelected = false
                        session.selectCut(cut.id, seek: true)
                    },
                    onTrimStart: { nextStart in
                        session.updateCut(id: cut.id) { selected in
                            selected.startTime = nextStart
                        }
                    },
                    onTrimEnd: { nextEnd in
                        session.updateCut(id: cut.id) { selected in
                            selected.endTime = nextEnd
                        }
                    }
                )
                .offset(x: x, y: 17)
            }
        }
    }

    private func playhead(height: CGFloat, contentWidth: CGFloat, duration: Double) -> some View {
        let isActive = isPlayheadSelected || playheadDragBaseTime != nil

        return VStack(spacing: 0) {
            ZStack {
                if isActive {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(Color.accentColor.opacity(0.20))
                        .overlay {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .strokeBorder(Color.accentColor.opacity(0.55), lineWidth: 1)
                        }
                        .frame(width: 20, height: 16)
                }

                Image(systemName: "triangle.fill")
                    .font(.system(size: 8, weight: .bold))
                    .foregroundStyle(Color.red)
                    .rotationEffect(Angle(degrees: 180))
                    .frame(width: 12, height: 10)
                    .shadow(color: Color.black.opacity(0.20), radius: 3, y: 1)
            }
            .frame(width: 24, height: 16)

            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [Color.red, Color.red.opacity(0.62), Color.red.opacity(0.18)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: isActive ? 2.5 : 2, height: max(height - 16, 0))
        }
        .frame(width: 24, height: height, alignment: .top)
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if playheadDragBaseTime == nil {
                        playheadDragBaseTime = session.playheadTime
                        isPlayheadSelected = true
                        session.pause()
                    }

                    let baseTime = playheadDragBaseTime ?? session.playheadTime
                    let deltaSeconds = Double(value.translation.width / max(contentWidth, 1)) * duration
                    session.seek(to: baseTime + deltaSeconds, selectingCut: true)
                }
                .onEnded { _ in
                    playheadDragBaseTime = nil
                    isPlayheadSelected = true
                }
        )
        .help(t("Drag Playhead"))
        .accessibilityLabel(t("Playhead"))
        .accessibilityValue(timeString(session.playheadTime))
    }

    private func playheadScrollAnchor(x: CGFloat, width: CGFloat) -> some View {
        let clampedX = min(max(x, 0), max(width - 1, 0))

        return HStack(spacing: 0) {
            Color.clear
                .frame(width: clampedX)
            Color.clear
                .frame(width: 1, height: 1)
                .id(playheadAnchorID)
            Spacer(minLength: 0)
        }
        .frame(width: width, height: 1, alignment: .leading)
        .allowsHitTesting(false)
    }

    private func timelineScrubGesture(width: CGFloat, duration: Double) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                seekFromTimelineLocation(value.location.x, width: width, duration: duration)
            }
            .onEnded { value in
                seekFromTimelineLocation(value.location.x, width: width, duration: duration)
            }
    }

    private func seekFromTimelineLocation(_ x: CGFloat, width: CGFloat, duration: Double) {
        let fraction = min(max(x / max(width, 1), 0), 1)
        isPlayheadSelected = true
        session.seek(to: Double(fraction) * duration, selectingCut: true)
    }

    private func tickInterval(for duration: Double, pixelsPerSecond: CGFloat) -> Double {
        let targetSeconds = max(0.05, Double(86 / max(pixelsPerSecond, 1)))
        let candidates: [Double] = [0.1, 0.25, 0.5, 1, 2, 5, 10, 15, 30, 60, 120, 300, 600]
        if duration <= candidates[0] {
            return candidates[0]
        }
        return candidates.first { $0 >= targetSeconds } ?? 600
    }

    private func rulerTicks(for duration: Double, pixelsPerSecond: CGFloat) -> [Double] {
        let interval = tickInterval(for: duration, pixelsPerSecond: pixelsPerSecond)
        let tickCount = max(Int(ceil(duration / interval)), 1)
        return (0...tickCount).map { index in
            min(Double(index) * interval, duration)
        }
    }

    private func minorTicks(for duration: Double, majorInterval: Double) -> [Double] {
        let divisions = majorInterval <= 0.5 ? 2.0 : 5.0
        let minorInterval = max(majorInterval / divisions, 0.05)
        let tickCount = max(Int(ceil(duration / minorInterval)), 1)
        return (0...tickCount)
            .map { min(Double($0) * minorInterval, duration) }
            .filter { tick in
                let remainder = tick.truncatingRemainder(dividingBy: majorInterval)
                return remainder > 0.001 && abs(remainder - majorInterval) > 0.001
            }
    }

    private func timeString(_ seconds: Double, showsFractions: Bool = false) -> String {
        let safeSeconds = max(0, seconds)
        if showsFractions && safeSeconds < 3600 {
            let minutes = Int(safeSeconds) / 60
            let secondsValue = safeSeconds.truncatingRemainder(dividingBy: 60)
            return String(format: "%02d:%04.1f", minutes, secondsValue)
        }

        let hours = Int(safeSeconds) / 3600
        let minutes = (Int(safeSeconds) / 60) % 60
        let wholeSeconds = Int(safeSeconds) % 60
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, wholeSeconds)
        }
        return String(format: "%02d:%02d", minutes, wholeSeconds)
    }
}

private struct RecordingTimelineCutSegment: View {
    @ObservedObject private var interfaceLanguage = InterfaceLanguageSettings.shared
    let index: Int
    let cut: RecordingEditCut
    let isSelected: Bool
    let width: CGFloat
    let duration: Double
    let trackWidth: CGFloat
    let onSelect: () -> Void
    let onTrimStart: (Double) -> Void
    let onTrimEnd: (Double) -> Void

    @State private var trimBase: (start: Double, end: Double)?
    @State private var isHovered = false

    private func t(_ english: String) -> String {
        interfaceLanguage.text(english)
    }

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 7, style: .continuous)
                .fill(segmentColor.opacity(isSelected ? 0.94 : (isHovered ? 0.84 : 0.72)))
                .overlay {
                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .strokeBorder(
                            isSelected ? Color.white.opacity(0.94) : Color.white.opacity(isHovered ? 0.36 : 0.18),
                            lineWidth: isSelected ? 1.5 : 1
                        )
                }
                .overlay(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .fill(Color.white.opacity(0.24))
                        .frame(width: 4)
                }
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(Color.white.opacity(isSelected ? 0.22 : 0.14))
                        .frame(height: 1)
                        .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                }
                .shadow(color: .black.opacity(isSelected ? 0.24 : 0.10), radius: isSelected ? 8 : 3, y: 3)

            HStack(spacing: 8) {
                if width > 64 {
                    Image(systemName: cut.layoutMode.systemImage)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.88))
                }

                if width > 112 {
                    VStack(alignment: .leading, spacing: 1) {
                        Text("\(t("Cut")) \(index + 1)")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.white)
                            .lineLimit(1)
                        Text("\(t(cut.layoutMode.shortLabel)) · \(timeString(cut.duration))")
                            .font(.caption2.monospacedDigit())
                            .foregroundStyle(.white.opacity(0.72))
                            .lineLimit(1)
                    }
                }
            }
            .padding(.horizontal, 12)

            trimHandle(.start)
                .frame(maxWidth: .infinity, alignment: .leading)
            trimHandle(.end)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(width: width, height: 48)
        .contentShape(Rectangle())
        .onTapGesture(perform: onSelect)
        .onHover { isHovered = $0 }
        .accessibilityLabel("\(t("Cut")) \(index + 1), \(t(cut.layoutMode.shortLabel))")
    }

    private var segmentColor: Color {
        switch cut.layoutMode {
        case .cameraFullScreen:
            return Color.purple
        case .screenFullScreen:
            return Color.accentColor
        case .screenWithCamera:
            return Color.teal
        }
    }

    private enum TrimEdge {
        case start
        case end
    }

    private func trimHandle(_ edge: TrimEdge) -> some View {
        Rectangle()
            .fill(Color.clear)
            .frame(width: 24, height: 48)
            .overlay {
                Capsule()
                    .fill(Color.white.opacity(isSelected || isHovered ? 0.86 : 0.28))
                    .frame(width: 3, height: 28)
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if trimBase == nil {
                            trimBase = (cut.startTime, cut.endTime)
                            onSelect()
                        }
                        guard let trimBase else { return }
                        let deltaSeconds = Double(value.translation.width / max(trackWidth, 1)) * duration
                        switch edge {
                        case .start:
                            let nextStart = min(max(0, trimBase.start + deltaSeconds), trimBase.end - 0.1)
                            onTrimStart(nextStart)
                        case .end:
                            let nextEnd = max(min(duration, trimBase.end + deltaSeconds), trimBase.start + 0.1)
                            onTrimEnd(nextEnd)
                        }
                    }
                    .onEnded { _ in
                        trimBase = nil
                    }
            )
            .help(edge == .start ? t("Trim Start") : t("Trim End"))
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
    @State private var resizeStartFrame: RecordingEditNormalizedRect?
    @State private var isCameraFrameSelected = false

    private func t(_ english: String) -> String {
        interfaceLanguage.text(english)
    }

    private enum CameraResizeCorner: CaseIterable, Identifiable {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight

        var id: Self { self }
    }

    var body: some View {
        GeometryReader { geometry in
            let fittedSize = aspectFit(session.videoSize, in: geometry.size)

            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.black)
                    .onTapGesture {
                        isCameraFrameSelected = false
                    }

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
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    isCameraFrameSelected = false
                                }
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
        .onChange(of: session.selectedCutID) { _, _ in
            isCameraFrameSelected = false
        }
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

        return ZStack {
            RecordingCameraPreviewSurface(player: session.cameraPlayer, shape: cut.cameraShape)
                .contentShape(Rectangle())
                .gesture(cameraMoveGesture(startingFrom: frame, canvasSize: canvasSize))

            if isCameraFrameSelected {
                ForEach(CameraResizeCorner.allCases) { corner in
                    cameraResizeHandle
                        .position(cameraResizeHandlePosition(corner: corner, width: width, height: height))
                        .gesture(cameraResizeGesture(startingFrom: frame, canvasSize: canvasSize, corner: corner))
                }
            }
        }
        .frame(width: width, height: height)
        .position(x: x, y: y)
        .onTapGesture {
            isCameraFrameSelected = true
        }
        .accessibilityLabel(t("Camera Frame"))
    }

    private var cameraResizeHandle: some View {
        Circle()
            .fill(.black.opacity(0.54))
            .frame(width: 18, height: 18)
            .overlay {
                Circle()
                    .strokeBorder(.white.opacity(0.90), lineWidth: 1.5)
            }
            .shadow(color: .black.opacity(0.25), radius: 4, y: 1)
            .padding(5)
            .contentShape(Rectangle())
            .help(t("Resize Camera Frame"))
    }

    private func cameraResizeHandlePosition(
        corner: CameraResizeCorner,
        width: CGFloat,
        height: CGFloat
    ) -> CGPoint {
        switch corner {
        case .topLeft:
            return CGPoint(x: 0, y: 0)
        case .topRight:
            return CGPoint(x: width, y: 0)
        case .bottomLeft:
            return CGPoint(x: 0, y: height)
        case .bottomRight:
            return CGPoint(x: width, y: height)
        }
    }

    private func cameraMoveGesture(
        startingFrom frame: RecordingEditNormalizedRect,
        canvasSize: CGSize
    ) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                if dragStartFrame == nil {
                    dragStartFrame = frame
                    isCameraFrameSelected = true
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
    }

    private func cameraResizeGesture(
        startingFrom frame: RecordingEditNormalizedRect,
        canvasSize: CGSize,
        corner: CameraResizeCorner
    ) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                if resizeStartFrame == nil {
                    resizeStartFrame = frame
                    isCameraFrameSelected = true
                }
                guard let base = resizeStartFrame else { return }

                let next = resizedCameraFrame(
                    from: base,
                    translation: value.translation,
                    canvasSize: canvasSize,
                    corner: corner
                )
                session.updateSelectedCut { cut in
                    cut.cameraFrame = next
                }
            }
            .onEnded { _ in
                resizeStartFrame = nil
            }
    }

    private func resizedCameraFrame(
        from base: RecordingEditNormalizedRect,
        translation: CGSize,
        canvasSize: CGSize,
        corner: CameraResizeCorner
    ) -> RecordingEditNormalizedRect {
        let dx = Double(translation.width / max(canvasSize.width, 1))
        let dy = Double(translation.height / max(canvasSize.height, 1))
        let minimumSize = 0.08

        var left = base.x
        var top = base.y
        var right = base.x + base.width
        var bottom = base.y + base.height

        switch corner {
        case .topLeft:
            left = min(max(left + dx, 0), right - minimumSize)
            top = min(max(top + dy, 0), bottom - minimumSize)
        case .topRight:
            right = max(min(right + dx, 1), left + minimumSize)
            top = min(max(top + dy, 0), bottom - minimumSize)
        case .bottomLeft:
            left = min(max(left + dx, 0), right - minimumSize)
            bottom = max(min(bottom + dy, 1), top + minimumSize)
        case .bottomRight:
            right = max(min(right + dx, 1), left + minimumSize)
            bottom = max(min(bottom + dy, 1), top + minimumSize)
        }

        var next = RecordingEditNormalizedRect(
            x: left,
            y: top,
            width: right - left,
            height: bottom - top
        )
        next.clamp()
        return next
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
