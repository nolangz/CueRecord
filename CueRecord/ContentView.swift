//
//  ContentView.swift
//  CueRecord
//
//

import SwiftUI
import UniformTypeIdentifiers
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @ObservedObject private var service = CueRecordService.shared
    @ObservedObject private var recordingController = RecordingController.shared
    @State private var isRunning = false
    @State private var isDictating = false
    @State private var dictation = DictationManager()
    @State private var dictationHighlightRange: NSRange? = nil
    @State private var dictationCaretPosition: Int? = nil
    @State private var editorCaretPosition: Int = 0
    @State private var isDroppingPresentation = false
    @State private var dropError: String?
    @State private var dropAlertTitle: String = "Import Error"
    @State private var showSettings = false
    @State private var settingsInitialTab: SettingsTab = .appearance
    @State private var showAbout = false
    @State private var showAIScriptComposer = false
    @State private var setupCompleted = AppSetupPreferences.initialSetupCompleted
    @State private var recordingPreviewBarWindow = RecordingPreviewBarWindow()
    @State private var hidesMainUIForRecordingPreview = false
    @State private var mainWindowsHiddenForRecordingPreview: [NSWindow] = []
    @State private var isShowingPostRecordingOptions = false
    @State private var editingProjectURL: URL?
    @State private var editingProjectTitleText = ""
    @State private var editingPageTitleIndex: Int?
    @State private var editingPageTitleText = ""
    @State private var hoveredProjectURL: URL?
    @State private var hoveredMarkdownURL: URL?
    @FocusState private var isTextFocused: Bool
    @FocusState private var focusedProjectURL: URL?
    @FocusState private var focusedPageTitleIndex: Int?

    private var currentText: Binding<String> {
        Binding(
            get: {
                guard service.currentPageIndex < service.pages.count else { return "" }
                return service.pages[service.currentPageIndex]
            },
            set: { newValue in
                guard service.currentPageIndex < service.pages.count else { return }
                service.updatePageText(at: service.currentPageIndex, to: newValue)
            }
        )
    }

    private var currentPageHasContent: Bool {
        !service.currentPageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var shouldShowVaultPicker: Bool {
        service.vaultURL == nil && !service.launchedExternally
    }

    private var shouldShowSetupWizard: Bool {
        !service.launchedExternally
            && !NotchSettings.shared.directorModeEnabled
            && !setupCompleted
    }

    @ViewBuilder
    private var waveformPill: some View {
        let pill = AudioWaveformView(levels: dictation.audioLevels, color: .red)
            .frame(height: 34)
            .frame(maxWidth: 240)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)

        #if compiler(>=6.2)
        if #available(macOS 26.0, *) {
            pill
                .glassEffect(in: .capsule)
        } else {
            pill
                .background(.ultraThinMaterial, in: Capsule())
                .shadow(color: .black.opacity(0.15), radius: 12, y: 4)
        }
        #else
        pill
            .background(.ultraThinMaterial, in: Capsule())
            .shadow(color: .black.opacity(0.15), radius: 12, y: 4)
        #endif
    }

    private var exportProgressBar: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(recordingController.exportStatusText ?? "Finishing recording")
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(.secondary)

            ProgressView()
                .progressViewStyle(.linear)
                .controlSize(.small)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 4)
    }

    @State private var highlightClearTimer: Timer?

    // Segment tracking: each recognition session is a "segment"
    @State private var segmentStart: Int = 0
    @State private var segmentLength: Int = 0
    @State private var segmentNeedsSeparator: Bool = false
    // How many chars of the raw recognition result to skip (already committed before cursor move)
    @State private var spokenSkipOffset: Int = 0
    @State private var lastRawSpokenLength: Int = 0

    private func beginNewSegment() {
        let pageIndex = service.currentPageIndex
        guard pageIndex < service.pages.count else { return }
        let text = service.pages[pageIndex]
        let caret = min(editorCaretPosition, text.count)

        // Skip everything already recognized up to this point
        spokenSkipOffset = lastRawSpokenLength

        // Check if we need a space before the new segment
        let charBefore = caret > 0 ? text[text.index(text.startIndex, offsetBy: caret - 1)] : "\n"
        segmentNeedsSeparator = !(charBefore == " " || charBefore == "\n" || caret == 0)
        segmentStart = caret
        segmentLength = 0
    }

    private func startDictation() {
        lastRawSpokenLength = 0
        spokenSkipOffset = 0
        beginNewSegment()

        dictation.onNewSegment = { [self] in
            // Recognition restarted — raw counter resets to 0
            lastRawSpokenLength = 0
            spokenSkipOffset = 0
            beginNewSegment()
        }

        dictation.onTextUpdate = { [self] spokenText in
            lastRawSpokenLength = spokenText.count

            // Only use the portion after the skip offset
            let effectiveText: String
            if spokenSkipOffset < spokenText.count {
                effectiveText = String(spokenText.suffix(spokenText.count - spokenSkipOffset))
            } else {
                effectiveText = ""
            }
            guard !effectiveText.isEmpty else { return }

            let pageIndex = service.currentPageIndex
            guard pageIndex < service.pages.count else { return }
            var text = service.pages[pageIndex]

            // Remove the old segment text
            let safeStart = min(segmentStart, text.count)
            let removeStart = text.index(text.startIndex, offsetBy: safeStart)
            let safeLen = min(segmentLength, text.count - safeStart)
            let removeEnd = text.index(removeStart, offsetBy: safeLen)
            text.removeSubrange(removeStart..<removeEnd)

            // Build the new segment content
            let sep = segmentNeedsSeparator ? " " : ""
            let newSegment = sep + effectiveText
            text.insert(contentsOf: newSegment, at: text.index(text.startIndex, offsetBy: min(segmentStart, text.count)))

            let prevLen = segmentLength
            segmentLength = newSegment.count
            service.updatePageText(at: pageIndex, to: text)

            // Highlight only the newly added characters
            let newChars = segmentLength - prevLen
            if newChars > 0 {
                let highlightStart = segmentStart + prevLen
                dictationHighlightRange = NSRange(location: highlightStart, length: newChars)
            }

            // Move caret to end of segment
            dictationCaretPosition = segmentStart + segmentLength

            // Clear highlight after 1s of silence
            highlightClearTimer?.invalidate()
            highlightClearTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                DispatchQueue.main.async {
                    dictationHighlightRange = nil
                }
            }
        }
        dictation.start()
        isDictating = true
    }

    private func stopDictation() {
        highlightClearTimer?.invalidate()
        highlightClearTimer = nil
        dictationHighlightRange = nil
        dictation.stop()
        dictation.onTextUpdate = nil
        dictation.onNewSegment = nil
        isDictating = false
    }

    private var pageTitleHeader: some View {
        let index = service.currentPageIndex

        return HStack(alignment: .top, spacing: 12) {
            if editingPageTitleIndex == index {
                TextField("", text: $editingPageTitleText)
                    .textFieldStyle(.plain)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.primary)
                    .focused($focusedPageTitleIndex, equals: index)
                    .onSubmit {
                        finishRenamingPage()
                    }
            } else {
                Text(service.pageTitle(at: index))
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .contentShape(Rectangle())
                    .onTapGesture(count: 2) {
                        beginRenamingPage(at: index)
                    }
            }

            Spacer(minLength: 0)

            Button {
                showAIScriptComposer = true
            } label: {
                Label("AI Script", systemImage: "sparkles")
                    .font(.system(size: 12, weight: .semibold))
            }
            .buttonStyle(.bordered)
            .controlSize(.small)
            .disabled(!currentPageHasContent || isRunning || isDictating || recordingController.isRecording || recordingController.isPreviewing)
            .help("Create an AI-polished spoken script")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 32)
        .padding(.bottom, 6)
    }

    private var mainContent: some View {
        VStack(spacing: 0) {
            pageTitleHeader

            ZStack(alignment: .topTrailing) {
                HighlightingTextEditor(
                    text: currentText,
                    font: .systemFont(ofSize: 16, weight: .regular).rounded,
                    highlightRange: dictationHighlightRange,
                    caretPosition: $dictationCaretPosition,
                    editorCaretPosition: $editorCaretPosition
                )
                .onChange(of: editorCaretPosition) { _, newPos in
                    guard isDictating else { return }
                    // If caret moved away from end of current segment, user clicked elsewhere
                    let segmentEnd = segmentStart + segmentLength
                    if newPos != segmentEnd {
                        beginNewSegment()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 8)
                .mask(
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .white, location: 0.03),
                            .init(color: .white, location: 0.93),
                            .init(color: .clear, location: 1.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

                // Bottom bar
                VStack {
                    Spacer()

                    ZStack {
                        // Waveform pill centered to full width
                        if isDictating {
                            waveformPill
                                .transition(.scale(scale: 0.8).combined(with: .opacity))
                        }

                        // Buttons pinned right
                        HStack(spacing: 10) {
                            Spacer()

                            Button {
                                if isDictating {
                                    stopDictation()
                                } else {
                                    startDictation()
                                }
                            } label: {
                                Image(systemName: isDictating ? "pause.fill" : "mic.fill")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.2), radius: 8, y: 4)
                            }
                            .buttonStyle(.plain)
                            .disabled(isRunning)
                            .opacity(isRunning ? 0.4 : 1)

                            Button {
                                if isRunning || recordingController.isRecording {
                                    stopRecordedTeleprompter()
                                } else if recordingController.isPreviewing {
                                    cancelRecordingPreview()
                                } else {
                                    presentRecordingPreview()
                                }
                            } label: {
                                Group {
                                    if isRunning || recordingController.isRecording {
                                        Image(systemName: "stop.fill")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(.white)
                                    } else if recordingController.isPreviewing {
                                        Image(systemName: "xmark")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(.white)
                                    } else {
                                        RecordGlyph(outerDiameter: 15, innerDiameter: 6)
                                    }
                                }
                                    .frame(width: 44, height: 44)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.2), radius: 8, y: 4)
                            }
                            .buttonStyle(.plain)
                            .disabled(isDictating || recordingController.isStarting || recordingController.isStopping)
                            .opacity(isDictating || recordingController.isStarting || recordingController.isStopping ? 0.4 : 1)
                        }
                    }
                    .padding(20)
                }
                .animation(.easeInOut(duration: 0.25), value: isDictating)

                // Drop zone overlay — sits on top so TextEditor doesn't steal the drop
                if isDroppingPresentation {
                VStack(spacing: 8) {
                    Image(systemName: "doc.text")
                        .font(.system(size: 28, weight: .light))
                        .foregroundStyle(Color.accentColor)
                    Text("Drop PowerPoint (.pptx) file")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.primary)
                    Text("For Keynote or Google Slides,\nexport as PPTX first.")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.accentColor, style: StrokeStyle(lineWidth: 2, dash: [8]))
                        .background(Color.accentColor.opacity(0.08).clipShape(RoundedRectangle(cornerRadius: 12)))
                )
                .padding(8)
            }

            // Invisible drop target covering entire window
            Color.clear
                .contentShape(Rectangle())
                .onDrop(of: [.fileURL], isTargeted: $isDroppingPresentation) { providers in
                    guard let provider = providers.first else { return false }
                    _ = provider.loadObject(ofClass: URL.self) { url, _ in
                        guard let url else { return }
                        let ext = url.pathExtension.lowercased()
                        if ext == "key" {
                            DispatchQueue.main.async {
                                dropAlertTitle = "Conversion Required"
                                dropError = "Keynote files can't be imported directly. Please export your Keynote presentation as PowerPoint (.pptx) first, then drop the exported file here."
                            }
                            return
                        }
                        guard ext == "pptx" else {
                            DispatchQueue.main.async {
                                dropAlertTitle = "Import Error"
                                dropError = "Unsupported file. Drop a PowerPoint (.pptx) file."
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            handlePresentationDrop(url: url)
                        }
                    }
                    return true
                }
                .allowsHitTesting(isDroppingPresentation)
            }
        }
    }

    private var vaultPicker: some View {
        VStack(spacing: 16) {
            Spacer()

            VStack(spacing: 8) {
                Text("Choose a CueRecord Workspace")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.primary)

                Text("Projects, scripts, and recordings are saved here.")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 360)
            }

            Button {
                service.chooseVaultFolder()
            } label: {
                Label("Choose Folder", systemImage: "folder")
                    .font(.system(size: 13, weight: .semibold))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 9)
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(32)
    }

    private var directorOverlay: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "megaphone.fill")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(.secondary)

            Text("Director Mode")
                .font(.system(size: 22, weight: .bold))

            Text(service.directorIsReading ? "Reading from director…" : "Waiting for director to send script…")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)

            if let ip = BrowserServer.localIPAddress() {
                let url = "http://\(ip):\(NotchSettings.shared.directorServerPort)"

                if let qrImage = generateDirectorQRCode(from: url) {
                    Image(nsImage: qrImage)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }

                HStack(spacing: 8) {
                    Text(url)
                        .font(.system(size: 13, weight: .semibold, design: .monospaced))
                        .foregroundStyle(Color.accentColor)
                        .textSelection(.enabled)

                    Button {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(url, forType: .string)
                    } label: {
                        Image(systemName: "doc.on.doc")
                            .font(.system(size: 11, weight: .medium))
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                }
            }

            Spacer()

            Button {
                showSettings = true
            } label: {
                Text("Open Settings")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func generateDirectorQRCode(from string: String) -> NSImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        filter.correctionLevel = "M"
        guard let ciImage = filter.outputImage else { return nil }
        let scale = 10.0
        let scaled = ciImage.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        guard let cgImage = context.createCGImage(scaled, from: scaled.extent) else { return nil }
        return NSImage(cgImage: cgImage, size: NSSize(width: scaled.extent.width, height: scaled.extent.height))
    }

    var body: some View {
        Group {
            if NotchSettings.shared.directorModeEnabled {
                directorOverlay
            } else if shouldShowSetupWizard {
                AppSetupView(
                    service: service,
                    controller: recordingController,
                    permissionsManager: recordingController.permissionsManager,
                    audioManager: recordingController.audioManager,
                    cameraManager: recordingController.cameraManager
                ) {
                    setupCompleted = true
                    service.prepareInitialDocument()
                    isTextFocused = true
                }
            } else if shouldShowVaultPicker {
                vaultPicker
            } else {
                NavigationSplitView {
                    pageSidebar
                        .navigationSplitViewColumnWidth(min: 210, ideal: 220, max: 260)
                } detail: {
                    mainContent
                        .ignoresSafeArea(.container, edges: .top)
                }
            }
        }
        .alert(dropAlertTitle, isPresented: Binding(get: { dropError != nil }, set: { if !$0 { dropError = nil } })) {
            Button("OK") { dropError = nil }
        } message: {
            Text(dropError ?? "")
        }
        .frame(minWidth: shouldShowSetupWizard ? 620 : 700, minHeight: shouldShowSetupWizard ? 430 : 400)
        .background(.ultraThinMaterial)
        .sheet(isPresented: $showSettings) {
            SettingsView(settings: NotchSettings.shared, initialTab: settingsInitialTab)
        }
        .sheet(isPresented: $showAbout) {
            AboutView()
        }
        .sheet(isPresented: $showAIScriptComposer) {
            AIScriptComposerSheet(
                sourceTitle: service.pageTitle(at: service.currentPageIndex),
                sourceMarkdown: service.currentPageText
            ) { generatedMarkdown, generatedTitle in
                _ = service.addPage(text: generatedMarkdown, title: generatedTitle)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .openSettings)) { _ in
            settingsInitialTab = .appearance
            showSettings = true
        }
        .onReceive(NotificationCenter.default.publisher(for: .openAbout)) { _ in
            showAbout = true
        }
	        .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in
	            // Sync button state when app is re-activated (e.g. dock click)
	            isRunning = service.overlayController.isShowing && !recordingController.isPreviewing
	        }
	        .onChange(of: focusedPageTitleIndex) { _, newValue in
	            if let editingPageTitleIndex, newValue != editingPageTitleIndex {
	                finishRenamingPage()
	            }
	        }
        .onChange(of: recordingController.hasPendingCapturedRecording) { _, hasPending in
            if hasPending {
                presentPostRecordingRenderOptions()
            } else {
                isShowingPostRecordingOptions = false
            }
        }
	        .onAppear {
            service.prepareInitialDocument()
            // Sync button state with overlay
            if service.overlayController.isShowing && !recordingController.isPreviewing {
                isRunning = true
            }
            if CueRecordService.shared.launchedExternally {
                DispatchQueue.main.async {
                    for window in NSApp.windows where !(window is NSPanel) {
                        window.orderOut(nil)
                    }
                }
            } else {
                isTextFocused = !shouldShowSetupWizard && !shouldShowVaultPicker
            }
        }
        .onDisappear {
            if !hidesMainUIForRecordingPreview {
                recordingPreviewBarWindow.hide()
                recordingController.endPreview()
            }
        }
    }

    // MARK: - Project Sidebar

    private func pagePreview(_ page: String) -> String {
        let trimmed = page.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return "Empty" }
        let words = trimmed.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
        let preview = words.prefix(5).joined(separator: " ")
        return preview.count > 30 ? String(preview.prefix(30)) + "…" : preview
    }

    private var pageSidebar: some View {
        VStack(spacing: 0) {
            projectSidebarHeader

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 8) {
                    ForEach(service.projects.indices, id: \.self) { projectIndex in
                        let project = service.projects[projectIndex]
                        projectSection(project: project, projectIndex: projectIndex)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
            }
            .scrollIndicators(.hidden)

            sidebarFooter
        }
    }

    private var sidebarFooter: some View {
        VStack(spacing: 0) {
            if recordingController.isStopping || recordingController.isExporting {
                exportProgressBar
                    .transition(.opacity)
            }

            HStack(spacing: 8) {
                Button {
                    finishRenamingPage()
                    finishRenamingProject()
                    withAnimation(.easeInOut(duration: 0.2)) {
                        if let projectIndex = service.addProject() {
                            beginRenamingProject(projectIndex: projectIndex)
                        }
                    }
                } label: {
                    Label("New Project", systemImage: "plus")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 32)
                        .padding(.leading, 16)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                Button {
                    settingsInitialTab = .appearance
                    showSettings = true
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .frame(width: 32, height: 32)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Settings")
                .disabled(isRunning || recordingController.isStarting || recordingController.isRecording || recordingController.isPreviewing)
                .opacity(isRunning || recordingController.isStarting || recordingController.isRecording || recordingController.isPreviewing ? 0.4 : 1)
                .padding(.trailing, 12)
            }
            .frame(height: 44)
        }
        .frame(maxWidth: .infinity)
        .layoutPriority(1)
    }

    private var projectSidebarHeader: some View {
        HStack(spacing: 8) {
            Text(service.vaultDisplayName)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .truncationMode(.middle)

            Spacer(minLength: 8)

            Button {
                service.chooseVaultFolder()
            } label: {
                Image(systemName: "folder.badge.plus")
                    .font(.system(size: 13, weight: .medium))
                    .frame(width: 28, height: 28)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
            .accessibilityLabel("Select Folder as Vault")
            .help("Select Folder as Vault")

            Button {
                openVaultInFinder()
            } label: {
                ZStack(alignment: .bottomTrailing) {
                    Image(systemName: "folder.fill")
                        .font(.system(size: 13, weight: .medium))

                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 7, weight: .bold))
                        .offset(x: 2, y: 1)
                }
                .frame(width: 28, height: 28)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
            .accessibilityLabel("Show Vault in Finder")
            .help("Open Vault in Finder")
            .disabled(service.vaultURL == nil)
            .opacity(service.vaultURL == nil ? 0.4 : 1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 16)
        .padding(.trailing, 12)
        .padding(.top, 2)
        .padding(.bottom, 8)
    }

    private func projectSection(project: CueRecordProject, projectIndex: Int) -> some View {
        let isCurrentProject = projectIndex == service.currentProjectIndex
        let isHovered = hoveredProjectURL == project.url

        return VStack(alignment: .leading, spacing: 3) {
            HStack(spacing: 8) {
                Image(systemName: "folder")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(isCurrentProject ? Color.primary.opacity(0.9) : Color.secondary)
                    .frame(width: 18)

                if editingProjectURL == project.url {
                    TextField("", text: $editingProjectTitleText)
                        .textFieldStyle(.plain)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.primary)
                        .focused($focusedProjectURL, equals: project.url)
                        .onSubmit {
                            finishRenamingProject()
                        }
                        .onChange(of: focusedProjectURL) { _, focusedURL in
                            if focusedURL != project.url && editingProjectURL == project.url {
                                finishRenamingProject()
                            }
                        }
                } else {
                    Text(project.title)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(isCurrentProject ? .primary : .secondary)
                        .lineLimit(1)
                        .truncationMode(.middle)
                }

                Spacer(minLength: 8)

                Button {
                    addMarkdown(projectIndex: projectIndex)
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 12, weight: .semibold))
                        .frame(width: 22, height: 22)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .foregroundStyle(.secondary)
                .opacity(isHovered ? 1 : 0)
                .allowsHitTesting(isHovered)
                .accessibilityLabel("New Markdown")
                .help("New Markdown")
            }
            .padding(.horizontal, 8)
            .frame(height: 30)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .onTapGesture {
                guard editingProjectURL != project.url else { return }
                finishRenamingProject()
                withAnimation(.easeInOut(duration: 0.15)) {
                    service.selectProject(at: projectIndex)
                }
            }
            .contextMenu {
                projectContextMenu(projectIndex: projectIndex)
            }
            .onHover { isInside in
                hoveredProjectURL = isInside ? project.url : nil
            }

            VStack(alignment: .leading, spacing: 3) {
                ForEach(project.markdownURLs.indices, id: \.self) { markdownIndex in
                    markdownRow(project: project, projectIndex: projectIndex, markdownIndex: markdownIndex)
                }
            }
            .padding(.leading, 26)
        }
    }

    @ViewBuilder
    private func projectContextMenu(projectIndex: Int) -> some View {
        Button {
            openProjectInFinder(projectIndex)
        } label: {
            Label("Show in Finder", systemImage: "folder")
        }

        Button {
            beginRenamingProject(projectIndex: projectIndex)
        } label: {
            Label("Rename Project", systemImage: "pencil")
        }

        Divider()

        Button(role: .destructive) {
            removeProject(at: projectIndex)
        } label: {
            Label("Delete Project", systemImage: "trash")
        }
    }

    private func markdownRow(project: CueRecordProject, projectIndex: Int, markdownIndex: Int) -> some View {
        let isSelected = projectIndex == service.currentProjectIndex && markdownIndex == service.currentPageIndex
        let title = markdownIndex < project.markdownTitles.count ? project.markdownTitles[markdownIndex] : "Untitled"
        let date = markdownIndex < project.modifiedDates.count ? project.modifiedDates[markdownIndex] : nil
        let markdownURL = markdownIndex < project.markdownURLs.count ? project.markdownURLs[markdownIndex] : nil
        let isHovered = markdownURL != nil && hoveredMarkdownURL == markdownURL

        return HStack(spacing: 8) {
            if isSelected && editingPageTitleIndex == markdownIndex {
                TextField("", text: $editingPageTitleText)
                    .textFieldStyle(.plain)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.primary)
                    .focused($focusedPageTitleIndex, equals: markdownIndex)
                    .onSubmit {
                        finishRenamingPage()
                    }
            } else {
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(isSelected ? .primary : .secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }

            Spacer(minLength: 8)

            if isHovered {
                markdownHoverActions(projectIndex: projectIndex, markdownIndex: markdownIndex)
            } else if let date {
                Text(relativeDateString(from: date))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.tertiary)
                    .lineLimit(1)
                    .frame(width: 44, alignment: .trailing)
            }
        }
        .padding(.leading, 8)
        .padding(.trailing, 4)
        .frame(height: 30)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            if isSelected || isHovered {
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(Color.primary.opacity(isSelected ? 0.09 : 0.06))
            }
        }
        .contentShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
        .onTapGesture {
            selectMarkdown(projectIndex: projectIndex, markdownIndex: markdownIndex)
        }
        .onHover { isInside in
            hoveredMarkdownURL = isInside ? markdownURL : nil
        }
        .contextMenu {
            markdownContextMenu(projectIndex: projectIndex, markdownIndex: markdownIndex)
        }
    }

    @ViewBuilder
    private func markdownHoverActions(projectIndex: Int, markdownIndex: Int) -> some View {
        Menu {
            markdownContextMenu(projectIndex: projectIndex, markdownIndex: markdownIndex)
        } label: {
            Image(systemName: "ellipsis")
                .font(.system(size: 12, weight: .semibold))
                .frame(width: 22, height: 22)
                .contentShape(Rectangle())
        }
        .menuStyle(.borderlessButton)
        .buttonStyle(.plain)
        .foregroundStyle(.secondary)
    }

    @ViewBuilder
    private func markdownContextMenu(projectIndex: Int, markdownIndex: Int) -> some View {
        Button {
            openMarkdownInFinder(projectIndex: projectIndex, markdownIndex: markdownIndex)
        } label: {
            Label("Show in Finder", systemImage: "folder")
        }

        Button {
            beginRenamingMarkdown(projectIndex: projectIndex, markdownIndex: markdownIndex)
        } label: {
            Label("Rename File", systemImage: "pencil")
        }

        if projectIndex == service.currentProjectIndex && service.pages.count > 1 {
            Divider()

            Button(role: .destructive) {
                removePage(at: markdownIndex)
            } label: {
                Label("Delete File", systemImage: "trash")
            }
        }
    }

    // MARK: - Actions

    private func removePage(at index: Int) {
        guard service.pages.count > 1 else { return }
        finishRenamingPage()
        finishRenamingProject()
        withAnimation(.easeInOut(duration: 0.2)) {
            service.removePage(at: index)
        }
    }

    private func removeProject(at index: Int) {
        finishRenamingPage()
        finishRenamingProject()
        withAnimation(.easeInOut(duration: 0.2)) {
            service.removeProject(at: index)
        }
    }

    private func addMarkdown(projectIndex: Int) {
        finishRenamingPage()
        finishRenamingProject()
        withAnimation(.easeInOut(duration: 0.2)) {
            _ = service.addMarkdown(toProjectAt: projectIndex)
        }
    }

    private func openVaultInFinder() {
        guard let vaultURL = service.vaultURL else { return }
        NSWorkspace.shared.open(vaultURL)
    }

    private func openProjectInFinder(_ projectIndex: Int) {
        guard projectIndex >= 0, projectIndex < service.projects.count else { return }
        NSWorkspace.shared.open(service.projects[projectIndex].url)
    }

    private func openMarkdownInFinder(projectIndex: Int, markdownIndex: Int) {
        guard projectIndex >= 0, projectIndex < service.projects.count else { return }
        let project = service.projects[projectIndex]
        guard markdownIndex >= 0, markdownIndex < project.markdownURLs.count else {
            NSWorkspace.shared.open(project.url)
            return
        }

        NSWorkspace.shared.activateFileViewerSelecting([project.markdownURLs[markdownIndex]])
    }

    private func selectMarkdown(projectIndex: Int, markdownIndex: Int) {
        if editingPageTitleIndex != markdownIndex || projectIndex != service.currentProjectIndex {
            finishRenamingPage()
        }
        if projectIndex != service.currentProjectIndex {
            finishRenamingProject()
        }

        withAnimation(.easeInOut(duration: 0.15)) {
            service.selectMarkdown(projectIndex: projectIndex, markdownIndex: markdownIndex)
        }
    }

    private func selectPage(at index: Int) {
        selectMarkdown(projectIndex: service.currentProjectIndex, markdownIndex: index)
    }

    private func beginRenamingProject(projectIndex: Int) {
        guard projectIndex >= 0, projectIndex < service.projects.count else { return }
        finishRenamingPage()
        let project = service.projects[projectIndex]
        editingProjectURL = project.url
        editingProjectTitleText = project.title
        service.selectProject(at: projectIndex)
        DispatchQueue.main.async {
            focusedProjectURL = project.url
        }
    }

    private func beginRenamingMarkdown(projectIndex: Int, markdownIndex: Int) {
        selectMarkdown(projectIndex: projectIndex, markdownIndex: markdownIndex)
        beginRenamingPage(at: markdownIndex)
    }

    private func beginRenamingPage(at index: Int) {
        guard index >= 0, index < service.pages.count else { return }
        selectPage(at: index)
        editingPageTitleIndex = index
        editingPageTitleText = service.pageTitle(at: index)
        DispatchQueue.main.async {
            focusedPageTitleIndex = index
        }
    }

    private func relativeDateString(from date: Date) -> String {
        let interval = max(0, Date().timeIntervalSince(date))
        let minute: TimeInterval = 60
        let hour: TimeInterval = minute * 60
        let day: TimeInterval = hour * 24

        if interval < hour {
            return "\(max(1, Int(interval / minute))) min"
        }
        if interval < day {
            return "\(max(1, Int(interval / hour))) hr"
        }
        return "\(max(1, Int(interval / day))) d"
    }

    private func finishRenamingProject() {
        guard let projectURL = editingProjectURL else { return }
        let title = editingProjectTitleText
        editingProjectURL = nil
        editingProjectTitleText = ""
        focusedProjectURL = nil

        if let projectIndex = service.projects.firstIndex(where: { $0.url.standardizedFileURL == projectURL.standardizedFileURL }) {
            service.renameProject(at: projectIndex, to: title)
        }
    }

    private func finishRenamingPage() {
        guard let index = editingPageTitleIndex else { return }
        service.renamePage(at: index, to: editingPageTitleText)
        editingPageTitleIndex = nil
        editingPageTitleText = ""
        focusedPageTitleIndex = nil
    }

    @discardableResult
    private func run() -> Bool {
        guard currentPageHasContent else { return false }
        // Resign text editor focus before showing the overlay to avoid ViewBridge crashes.
        isTextFocused = false
        service.onOverlayDismissed = { [self] in
            service.onOverlayDismissed = nil
            isRunning = false
            service.readPages.removeAll()
            guard !recordingController.isRecording && !recordingController.isStopping else {
                return
            }

            recordingPreviewBarWindow.hide()
            restoreMainUIAfterRecordingPreview(focusEditor: false)
        }
        service.readPages.removeAll()
        service.readCurrentPage(hidesMainWindow: false)
        isRunning = true
        return true
    }

    private func presentRecordingPreview() {
        isTextFocused = false

        recordingController.refreshDevicesAndPermissions()
        recordingController.beginPreview()
        hideMainUIForRecordingPreview()
        showPromptForRecordingPreview()
        recordingPreviewBarWindow.show(
            controller: recordingController,
            onStart: {
                startRecordedTeleprompterFromPreview()
            },
            onCancel: {
                cancelRecordingPreview()
            }
        )
    }

    private func startRecordedTeleprompterFromPreview() {
        isTextFocused = false
        prepareRecordingOutputName()
        let shouldShowTeleprompter = currentPageHasContent

        recordingController.startPreviewedRecording { started in
            guard started else {
                presentRecordingPreview()
                return
            }

            recordingPreviewBarWindow.showStopButton(
                controller: recordingController,
                onStop: {
                    stopRecordedTeleprompter()
                }
            )

            if shouldShowTeleprompter {
                if !run() {
                    stopRecordedTeleprompterAndPresentRenderOptions()
                }
            } else {
                hidePromptForRecordingPreview()
                service.readPages.removeAll()
                isRunning = false
            }
        }
    }

    private func cancelRecordingPreview() {
        recordingPreviewBarWindow.hide()
        hidePromptForRecordingPreview()
        recordingController.endPreview()
        restoreMainUIAfterRecordingPreview()
    }

    private func showPromptForRecordingPreview() {
        guard currentPageHasContent else { return }

        service.showCurrentPageForRecordingPreview()
        isRunning = false
    }

    private func hidePromptForRecordingPreview() {
        service.hideRecordingPreviewPrompt()
        isRunning = false
    }

    private func hideMainUIForRecordingPreview() {
        guard !hidesMainUIForRecordingPreview else { return }

        hidesMainUIForRecordingPreview = true
        let windowsToHide = NSApp.windows.filter { window in
            !(window is NSPanel) && window.isVisible
        }
        mainWindowsHiddenForRecordingPreview = windowsToHide

        windowsToHide.forEach { window in
            window.makeFirstResponder(nil)
            window.orderOut(nil)
        }
    }

    private func restoreMainUIAfterRecordingPreview(focusEditor: Bool = true) {
        guard hidesMainUIForRecordingPreview else {
            if focusEditor {
                isTextFocused = true
            }
            return
        }

        let windowsToRestore = mainWindowsHiddenForRecordingPreview
        mainWindowsHiddenForRecordingPreview = []
        hidesMainUIForRecordingPreview = false

        NSApp.activate(ignoringOtherApps: true)
        if let window = windowsToRestore.first {
            window.makeKeyAndOrderFront(nil)
        } else if let window = NSApp.windows.first(where: { !($0 is NSPanel) }) {
            window.makeKeyAndOrderFront(nil)
        }

        if focusEditor {
            DispatchQueue.main.async {
                isTextFocused = true
            }
        }
    }

    @State private var isImporting = false

	    private func handlePresentationDrop(url: URL) {
	        guard service.confirmDiscardIfNeeded() else { return }
        isImporting = true

        DispatchQueue.global(qos: .userInitiated).async {
            do {
	                let notes = try PresentationNotesExtractor.extractNotes(from: url)
	                DispatchQueue.main.async {
                    service.replacePages(notes, markSaved: true, persistToVault: true)
                    isImporting = false
                }
            } catch {
                DispatchQueue.main.async {
                    dropError = error.localizedDescription
                    isImporting = false
                }
            }
        }
    }

    private func stop() {
        service.onOverlayDismissed = nil
        service.overlayController.dismiss()
        service.readPages.removeAll()
        isRunning = false
    }

    private func stopRecordedTeleprompter() {
        stopRecordedTeleprompterAndPresentRenderOptions()
    }

    private func stopRecordedTeleprompterAndPresentRenderOptions() {
        recordingPreviewBarWindow.hide()
        hidePromptForRecordingPreview()
        stop()
        recordingController.stopRecording {
            presentPostRecordingRenderOptions()
        }
    }

    private func presentPostRecordingRenderOptions(retryIfNeeded: Bool = true) {
        guard recordingController.hasPendingCapturedRecording else {
            if retryIfNeeded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    presentPostRecordingRenderOptions(retryIfNeeded: false)
                }
            } else {
                restoreMainUIAfterRecordingPreview(focusEditor: false)
            }
            return
        }
        guard !isShowingPostRecordingOptions else { return }

        isShowingPostRecordingOptions = true
        restoreMainUIAfterRecordingPreview(focusEditor: false)
        DispatchQueue.main.async {
            recordingPreviewBarWindow.showRenderOptions(
                controller: recordingController,
                onDelete: {
                    isShowingPostRecordingOptions = false
                    recordingController.deletePendingCapturedRecording()
                },
                onRenderAll: {
                    isShowingPostRecordingOptions = false
                    recordingController.renderPendingCapturedRecording(mode: .all)
                },
                onRenderCameraOnly: {
                    isShowingPostRecordingOptions = false
                    recordingController.renderPendingCapturedRecording(mode: .cameraOnlyTransparent)
                }
            )
        }
    }

    private func prepareRecordingOutputName() {
        recordingController.recordingState.outputSessionName = service.currentRecordingSessionName()
        if let projectDirectoryURL = service.currentProjectDirectoryURL() {
            recordingController.recordingState.outputDirectory = projectDirectoryURL
        }
    }
}

// MARK: - About View

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss

    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    var body: some View {
        VStack(spacing: 16) {
            CueRecordLogoView(cornerRadius: 18)
                .frame(width: 80, height: 80)

            // App name & version
            VStack(spacing: 4) {
                Text("CueRecord")
                    .font(.system(size: 20, weight: .bold))
                Text("Version \(appVersion)")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }

            // Description
            Text("A recording workspace for scripted screen videos.")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)

            Divider().padding(.horizontal, 20)

            VStack(spacing: 4) {
                Text("Made by Nolan Lai")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Text("CueRecord")
                    .font(.system(size: 11))
                    .foregroundStyle(.tertiary)
            }

            Button("OK") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.small)
            .padding(.top, 4)
        }
        .padding(24)
        .frame(width: 320)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    ContentView()
}

struct RecordGlyph: View {
    let outerDiameter: CGFloat
    let innerDiameter: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: outerDiameter, height: outerDiameter)

            Circle()
                .fill(Color.red)
                .frame(width: innerDiameter, height: innerDiameter)
        }
        .frame(width: outerDiameter, height: outerDiameter, alignment: .center)
    }
}
