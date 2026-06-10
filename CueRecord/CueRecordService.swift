//
//  CueRecordService.swift
//  CueRecord
//
//

import AppKit
import Combine
import CoreServices
import SwiftUI
import UniformTypeIdentifiers

private struct CueRecordDocument: Codable {
    let version: Int?
    let pages: [String]
    let pageTitles: [String]?
}

struct CueRecordProject: Identifiable, Hashable {
    let id: URL
    var url: URL
    var title: String
    var markdownURLs: [URL]
    var markdownTitles: [String]
    var markdownPreviews: [String]
    var modifiedDates: [Date?]
}

class CueRecordService: NSObject, ObservableObject {
    static let shared = CueRecordService()
    private static let vaultPathDefaultsKey = "cueRecordVaultPath"
    private static let legacyAppVaultPathDefaultsKey = "takeOneVaultPath"
    private static let legacyVaultPathDefaultsKey = "cueShotVaultPath"
    private static let supportedLegacyDocumentExtensions: Set<String> = ["cuerecord", "takeone", "cueshot"]
    private static let supportedURLSchemes: Set<String> = ["cuerecord", "takeone", "cueshot"]
    let overlayController = NotchOverlayController()
    let externalDisplayController = ExternalDisplayController()
    let browserServer = BrowserServer()
    let directorServer = DirectorServer()
    var onOverlayDismissed: (() -> Void)?
    var launchedExternally = false
    @Published var directorIsReading = false

    @Published var pages: [String] = [""]
    @Published var pageTitles: [String] = ["Untitled"]
    @Published var currentPageIndex: Int = 0
    @Published var readPages: Set<Int> = []
    @Published var vaultURL: URL?
    @Published var projects: [CueRecordProject] = []
    @Published var currentProjectIndex: Int = 0
    @Published var pageMarkdownURLs: [URL] = []
    @Published var currentFileURL: URL?
    @Published var savedPages: [String] = [""]
    @Published var savedPageTitles: [String] = ["Untitled"]
    private var vaultEventStream: FSEventStreamRef?
    private var watchedVaultURL: URL?
    private var vaultRefreshWorkItem: DispatchWorkItem?
    private var ignoreVaultEventsUntil: Date = .distantPast

    override init() {
        super.init()
        let defaults = UserDefaults.standard
        let currentPath = defaults.string(forKey: Self.vaultPathDefaultsKey)
        let legacyAppPath = defaults.string(forKey: Self.legacyAppVaultPathDefaultsKey)
        let legacyCueShotPath = defaults.string(forKey: Self.legacyVaultPathDefaultsKey)

        if let path = currentPath, !path.isEmpty {
            vaultURL = URL(fileURLWithPath: path)
        } else if let path = legacyAppPath, !path.isEmpty {
            vaultURL = URL(fileURLWithPath: path)
            defaults.set(path, forKey: Self.vaultPathDefaultsKey)
        } else if let path = legacyCueShotPath, !path.isEmpty {
            vaultURL = URL(fileURLWithPath: path)
            defaults.set(path, forKey: Self.vaultPathDefaultsKey)
        }
    }

    deinit {
        stopVaultFileWatcher()
        vaultRefreshWorkItem?.cancel()
    }

    var hasNextPage: Bool {
        for i in (currentPageIndex + 1)..<pages.count {
            if !pages[i].trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return true
            }
        }
        return false
    }

    var currentPageText: String {
        guard currentPageIndex < pages.count else { return "" }
        return pages[currentPageIndex]
    }

    var vaultDisplayName: String {
        let name = vaultURL?.lastPathComponent.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        return name.isEmpty ? "Vault" : name
    }

    var projectDisplayName: String {
        guard currentProjectIndex >= 0, currentProjectIndex < projects.count else { return "Project" }
        return projects[currentProjectIndex].title
    }

    func currentMarkdownFileURL() -> URL? {
        guard currentPageIndex >= 0, currentPageIndex < pageMarkdownURLs.count else { return nil }
        return pageMarkdownURLs[currentPageIndex]
    }

    func currentProjectDirectoryURL() -> URL? {
        guard currentProjectIndex >= 0, currentProjectIndex < projects.count else { return nil }
        return projects[currentProjectIndex].url
    }

    func currentRecordingSessionName() -> String {
        "\(projectDisplayName) - \(pageTitle(at: currentPageIndex))"
    }

    func selectProject(at index: Int) {
        guard index >= 0, index < projects.count else { return }
        persistAllPages()
        loadProject(at: index)
    }

    func selectMarkdown(projectIndex: Int, markdownIndex: Int) {
        guard projectIndex >= 0, projectIndex < projects.count else { return }
        guard markdownIndex >= 0, markdownIndex < projects[projectIndex].markdownURLs.count else { return }
        persistAllPages()
        if projectIndex != currentProjectIndex {
            loadProject(at: projectIndex, preferredMarkdownURL: projects[projectIndex].markdownURLs[markdownIndex])
        }
        guard markdownIndex >= 0, markdownIndex < pages.count else { return }
        currentPageIndex = markdownIndex
        updatePageInfo()
    }

    @discardableResult
    func addProject(title: String = "Untitled Project") -> Int? {
        guard let vaultURL else { return nil }

        do {
            ignoreOwnVaultChanges()
            let projectURL = uniqueProjectDirectory(in: vaultURL, title: title)
            try FileManager.default.createDirectory(at: projectURL, withIntermediateDirectories: true)
            let markdownURL = uniqueMarkdownFile(in: projectURL, title: "Untitled")
            try "".write(to: markdownURL, atomically: true, encoding: .utf8)

            refreshProjects(selecting: projectURL)
            guard let index = projects.firstIndex(where: { $0.url == projectURL }) else { return nil }
            loadProject(at: index, preferredMarkdownURL: markdownURL)
            return index
        } catch {
            showFileError(title: "Failed to create project", error: error)
            return nil
        }
    }

    func removeProject(at index: Int) {
        guard index >= 0, index < projects.count else { return }
        persistAllPages()

        let removedProjectURL = projects[index].url
        let currentProjectURL = currentProjectDirectoryURL()
        let selectedURL: URL?
        if let currentProjectURL,
           currentProjectURL.standardizedFileURL != removedProjectURL.standardizedFileURL {
            selectedURL = currentProjectURL
        } else if projects.count > 1 {
            let nextIndex = index < projects.count - 1 ? index + 1 : index - 1
            selectedURL = projects[nextIndex].url
        } else {
            selectedURL = nil
        }

        trashOrRemoveFile(removedProjectURL)
        refreshProjects(selecting: selectedURL)

        guard !projects.isEmpty else {
            clearLoadedPages()
            return
        }

        loadProject(at: currentProjectIndex)
    }

    func pageTitle(at index: Int) -> String {
        guard index >= 0, index < pages.count else { return "Untitled" }
        if index < pageTitles.count {
            let title = pageTitles[index].trimmingCharacters(in: .whitespacesAndNewlines)
            if !title.isEmpty {
                return title
            }
        }
        return defaultPageTitle(for: index)
    }

    func renamePage(at index: Int, to title: String) {
        guard index >= 0, index < pages.count else { return }
        normalizePageTitles()
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let nextTitle = trimmed.isEmpty ? "Untitled" : trimmed

        if let projectURL = currentProjectDirectoryURL(), index < pageMarkdownURLs.count {
            let oldMarkdown = pageMarkdownURLs[index]
            let newMarkdown = uniqueMarkdownFile(in: projectURL, title: nextTitle, excluding: oldMarkdown)
            let resolvedTitle = markdownTitle(from: newMarkdown)

            do {
                ignoreOwnVaultChanges()
                if oldMarkdown != newMarkdown {
                    if FileManager.default.fileExists(atPath: oldMarkdown.path) {
                        try FileManager.default.moveItem(at: oldMarkdown, to: newMarkdown)
                    } else {
                        try pages[index].write(to: newMarkdown, atomically: true, encoding: .utf8)
                    }
                }

                pageMarkdownURLs[index] = newMarkdown
                pageTitles[index] = resolvedTitle
            } catch {
                showFileError(title: "Failed to rename markdown file", error: error)
                pageTitles[index] = nextTitle
            }
        } else {
            pageTitles[index] = nextTitle
        }

        persistPage(at: index)
        refreshCurrentProjectMetadata()
        updatePageInfo()
    }

    @discardableResult
    func addPage(text: String = "", title: String? = "Untitled") -> Int {
        let rawTitle = title ?? "Untitled"
        let requestedTitle = rawTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Untitled" : rawTitle
        let pageInfo = createPageStorage(title: requestedTitle, text: text)

        pages.append(text)
        pageTitles.append(pageInfo.title)
        if let markdownURL = pageInfo.markdownURL {
            pageMarkdownURLs.append(markdownURL)
        }

        let newIndex = pages.count - 1
        currentPageIndex = newIndex
        refreshCurrentProjectMetadata()
        updatePageInfo()
        return newIndex
    }

    @discardableResult
    func addMarkdown(toProjectAt projectIndex: Int, text: String = "", title: String? = "Untitled") -> Int? {
        guard projectIndex >= 0, projectIndex < projects.count else { return nil }
        persistAllPages()

        let projectURL = projects[projectIndex].url
        let rawTitle = title ?? "Untitled"
        let requestedTitle = rawTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Untitled" : rawTitle

        do {
            ignoreOwnVaultChanges()
            try FileManager.default.createDirectory(at: projectURL, withIntermediateDirectories: true)
            let markdownURL = uniqueMarkdownFile(in: projectURL, title: requestedTitle)
            try text.write(to: markdownURL, atomically: true, encoding: .utf8)

            refreshProjects(selecting: projectURL)
            guard let refreshedProjectIndex = projects.firstIndex(where: { $0.url.standardizedFileURL == projectURL.standardizedFileURL }) else {
                return nil
            }
            loadProject(at: refreshedProjectIndex, preferredMarkdownURL: markdownURL)
            return currentPageIndex
        } catch {
            showFileError(title: "Failed to create markdown file", error: error)
            return nil
        }
    }

    func removePage(at index: Int) {
        guard pages.count > 1, index >= 0, index < pages.count else { return }
        if index < pageMarkdownURLs.count {
            trashOrRemoveFile(pageMarkdownURLs[index])
            pageMarkdownURLs.remove(at: index)
        }
        pages.remove(at: index)
        if index < pageTitles.count {
            pageTitles.remove(at: index)
        }
        normalizePageTitles()

        let adjustedReadPages = readPages.compactMap { readIndex -> Int? in
            if readIndex == index {
                return nil
            }
            return readIndex > index ? readIndex - 1 : readIndex
        }
        readPages = Set(adjustedReadPages)

        if currentPageIndex >= pages.count {
            currentPageIndex = pages.count - 1
        } else if currentPageIndex > index {
            currentPageIndex -= 1
        }
        refreshCurrentProjectMetadata()
        updatePageInfo()
    }

    func replacePages(_ newPages: [String], titles: [String]? = nil, markSaved: Bool = false, persistToVault: Bool = true) {
        let previousMarkdownURLs = pageMarkdownURLs
        pages = newPages.isEmpty ? [""] : newPages
        pageTitles = CueRecordService.normalizedPageTitles(for: pages, titles: titles)
        currentPageIndex = 0
        readPages.removeAll()
        pageMarkdownURLs.removeAll()

        if markSaved {
            savedPages = pages
            savedPageTitles = pageTitles
        }
        if persistToVault, vaultURL != nil {
            rebuildVaultPagesFromCurrentState(replacing: previousMarkdownURLs)
        }
        updatePageInfo()
    }

    func updatePageText(at index: Int, to text: String) {
        guard index >= 0, index < pages.count else { return }
        pages[index] = text
        ensureMarkdownStorageExists(for: index)
        persistPage(at: index)
        refreshCurrentProjectMetadata()
        updatePageInfo()
    }

    func readText(_ text: String, hidesMainWindow: Bool = true) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        if hidesMainWindow {
            launchedExternally = true
            hideMainWindow()
        }

        overlayController.show(text: trimmed, hasNextPage: hasNextPage) { [weak self] in
            self?.externalDisplayController.dismiss()
            self?.browserServer.hideContent()
            self?.onOverlayDismissed?()
        }
        updatePageInfo()

        // Also show on external display if configured (same parsing as overlay)
        let words = splitTextIntoWords(trimmed)
        let totalCharCount = words.joined(separator: " ").count
        externalDisplayController.show(
            speechRecognizer: overlayController.speechRecognizer,
            words: words,
            totalCharCount: totalCharCount,
            hasNextPage: hasNextPage
        )

        if browserServer.isRunning {
            browserServer.showContent(
                speechRecognizer: overlayController.speechRecognizer,
                words: words,
                totalCharCount: totalCharCount,
                hasNextPage: hasNextPage
            )
        }
    }

    func readCurrentPage(hidesMainWindow: Bool = true) {
        let trimmed = currentPageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        readPages.insert(currentPageIndex)
        readText(trimmed, hidesMainWindow: hidesMainWindow)
    }

    func showCurrentPageForRecordingPreview() {
        let trimmed = currentPageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        overlayController.showPreview(text: trimmed, hasNextPage: hasNextPage)
        updatePageInfo()
    }

    func hideRecordingPreviewPrompt() {
        overlayController.hidePreview()
    }

    func advanceToNextPage() {
        // Skip empty pages
        var nextIndex = currentPageIndex + 1
        while nextIndex < pages.count {
            let text = pages[nextIndex].trimmingCharacters(in: .whitespacesAndNewlines)
            if !text.isEmpty { break }
            nextIndex += 1
        }
        guard nextIndex < pages.count else { return }
        jumpToPage(index: nextIndex)
    }

    func jumpToPage(index: Int) {
        guard index >= 0 && index < pages.count else { return }
        let text = pages[index].trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        // Mute mic before switching page content
        let wasListening = overlayController.speechRecognizer.isListening
        if wasListening {
            overlayController.speechRecognizer.stop()
        }

        currentPageIndex = index
        readPages.insert(currentPageIndex)

        let trimmed = currentPageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        // Update content in-place without recreating the panel
        overlayController.updateContent(text: trimmed, hasNextPage: hasNextPage)
        updatePageInfo()

        // Also update external display content in-place
        let words = splitTextIntoWords(trimmed)
        externalDisplayController.overlayContent.words = words
        externalDisplayController.overlayContent.totalCharCount = words.joined(separator: " ").count
        externalDisplayController.overlayContent.hasNextPage = hasNextPage

        if browserServer.isRunning {
            browserServer.updateContent(
                words: words,
                totalCharCount: words.joined(separator: " ").count,
                hasNextPage: hasNextPage
            )
        }

        // Unmute after new page content is loaded
        if wasListening {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.overlayController.speechRecognizer.resume()
            }
        }
    }

    func updatePageInfo() {
        let content = overlayController.overlayContent
        content.pageCount = pages.count
        content.currentPageIndex = currentPageIndex
        content.pagePreviews = pages.enumerated().map { (i, text) in
            let title = pageTitle(at: i)
            let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty { return title }
            let preview = String(trimmed.prefix(40))
            return title + " · " + preview + (trimmed.count > 40 ? "…" : "")
        }
    }

    func startAllPages(hidesMainWindow: Bool = true) {
        readPages.removeAll()
        currentPageIndex = 0
        readCurrentPage(hidesMainWindow: hidesMainWindow)
    }

    func hideMainWindow() {
        DispatchQueue.main.async {
            for window in NSApp.windows where !(window is NSPanel) {
                window.makeFirstResponder(nil)
                window.orderOut(nil)
            }
        }
    }

    // MARK: - File Operations

    func prepareInitialDocument() {
        guard pages == [""], pageTitles == ["Untitled"], pageMarkdownURLs.isEmpty else { return }
        guard let vaultURL else { return }
        loadVaultDirectory(in: vaultURL)
    }

    func chooseVaultFolder() {
        let panel = NSOpenPanel()
        panel.message = "Choose CueRecord Workspace"
        panel.prompt = "Choose"
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        panel.canCreateDirectories = true

        panel.begin { [weak self] response in
            guard response == .OK, let url = panel.url else { return }
            self?.setVaultFolder(url)
        }
    }

    func setVaultFolder(_ url: URL) {
        vaultURL = url
        currentFileURL = nil
        UserDefaults.standard.set(url.path, forKey: Self.vaultPathDefaultsKey)
        loadVaultDirectory(in: url)
    }

    private func loadVaultDirectory(in folderURL: URL) {
        do {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
            startVaultFileWatcher(for: folderURL)
            try migrateLooseMarkdownFiles(in: folderURL)

            let legacyURLs = legacyDocumentURLs(in: folderURL)
            if projectDirectories(in: folderURL).isEmpty,
               let legacyURL = legacyURLs.first,
               let legacyDocument = try? loadLegacyDocument(from: legacyURL) {
                let projectURL = uniqueProjectDirectory(in: folderURL, title: markdownTitle(from: legacyURL))
                try FileManager.default.createDirectory(at: projectURL, withIntermediateDirectories: true)

                projects = [
                    CueRecordProject(
                        id: projectURL,
                        url: projectURL,
                        title: projectURL.lastPathComponent,
                        markdownURLs: [],
                        markdownTitles: [],
                        markdownPreviews: [],
                        modifiedDates: []
                    )
                ]
                currentProjectIndex = 0
                pages = legacyDocument.pages
                pageTitles = legacyDocument.titles
                rebuildVaultPagesFromCurrentState()
                trashOrRemoveFile(legacyURL)
            }

            refreshProjects()
            if projects.isEmpty {
                _ = addProject()
                return
            }

            currentProjectIndex = min(currentProjectIndex, max(projects.count - 1, 0))
            loadProject(at: currentProjectIndex)
        } catch {
            let alert = NSAlert()
            alert.messageText = "Failed to open CueRecord workspace"
            alert.informativeText = error.localizedDescription
            alert.runModal()
        }
    }

    func saveFile() {
        persistAllPages()
    }

    func saveFileAs() {
        chooseVaultFolder()
    }

    private func saveToURL(_ url: URL) {
        do {
            normalizePageTitles()
            let document = CueRecordDocument(version: 2, pages: pages, pageTitles: pageTitles)
            let data = try JSONEncoder().encode(document)
            try data.write(to: url, options: .atomic)
            currentFileURL = url
            savedPages = pages
            savedPageTitles = pageTitles
            NSDocumentController.shared.noteNewRecentDocumentURL(url)
        } catch {
            let alert = NSAlert()
            alert.messageText = "Failed to save file"
            alert.informativeText = error.localizedDescription
            alert.runModal()
        }
    }

    var hasUnsavedChanges: Bool {
        false
    }

    func openFile() {
        chooseVaultFolder()
    }

    func importPresentation(from url: URL) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                let notes = try PresentationNotesExtractor.extractNotes(from: url)
                DispatchQueue.main.async {
                    self?.replacePages(notes, markSaved: true, persistToVault: true)
                }
            } catch {
                DispatchQueue.main.async {
                    let alert = NSAlert()
                    alert.messageText = "Import Error"
                    alert.informativeText = error.localizedDescription
                    alert.runModal()
                }
            }
        }
    }

    /// Returns true if it's safe to proceed (saved, discarded, or no changes).
    /// Returns false if the user cancelled.
    func confirmDiscardIfNeeded() -> Bool {
        persistAllPages()
        return true
    }

    func openFileAtURL(_ url: URL) {
        if url.hasDirectoryPath {
            setVaultFolder(url)
            return
        }

        if Self.supportedLegacyDocumentExtensions.contains(url.pathExtension.lowercased()) {
            let folderURL = url.deletingLastPathComponent()
            setVaultFolder(folderURL)
            return
        }

        if url.pathExtension.lowercased() == "md" {
            let projectURL = url.deletingLastPathComponent()
            let vaultURL = projectURL.deletingLastPathComponent()
            setVaultFolder(vaultURL)
            if let projectIndex = projects.firstIndex(where: { $0.url.standardizedFileURL == projectURL.standardizedFileURL }) {
                loadProject(at: projectIndex, preferredMarkdownURL: url)
            }
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let loadedPages: [String]
            let loadedTitles: [String]
            if let document = try? JSONDecoder().decode(CueRecordDocument.self, from: data) {
                loadedPages = document.pages
                loadedTitles = CueRecordService.normalizedPageTitles(for: document.pages, titles: document.pageTitles)
            } else {
                loadedPages = try JSONDecoder().decode([String].self, from: data)
                loadedTitles = CueRecordService.normalizedPageTitles(for: loadedPages)
            }
            guard !loadedPages.isEmpty else { return }
            pages = loadedPages
            pageTitles = loadedTitles
            savedPages = loadedPages
            savedPageTitles = loadedTitles
            currentPageIndex = 0
            readPages.removeAll()
            currentFileURL = url
            NSDocumentController.shared.noteNewRecentDocumentURL(url)
        } catch {
            let alert = NSAlert()
            alert.messageText = "Failed to open file"
            alert.informativeText = error.localizedDescription
            alert.runModal()
        }
    }

    private func legacyDocumentURLs(in folderURL: URL) -> [URL] {
        let files = (try? FileManager.default.contentsOfDirectory(
            at: folderURL,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles]
        )) ?? []

        return files.filter { Self.supportedLegacyDocumentExtensions.contains($0.pathExtension.lowercased()) }
    }

    private func loadLegacyDocument(from url: URL) throws -> (pages: [String], titles: [String]) {
        let data = try Data(contentsOf: url)
        let loadedPages: [String]
        let loadedTitles: [String]
        if let document = try? JSONDecoder().decode(CueRecordDocument.self, from: data) {
            loadedPages = document.pages
            loadedTitles = CueRecordService.normalizedPageTitles(for: document.pages, titles: document.pageTitles)
        } else {
            loadedPages = try JSONDecoder().decode([String].self, from: data)
            loadedTitles = CueRecordService.normalizedPageTitles(for: loadedPages)
        }
        return (loadedPages.isEmpty ? [""] : loadedPages, loadedTitles.isEmpty ? ["Untitled"] : loadedTitles)
    }

    private func refreshProjects(selecting selectedURL: URL? = nil) {
        guard let vaultURL else {
            projects = []
            currentProjectIndex = 0
            return
        }

        let selected = selectedURL ?? currentProjectDirectoryURL()
        projects = projectDirectories(in: vaultURL).compactMap(projectMetadata(for:))

        if let selected,
           let index = projects.firstIndex(where: { $0.url.standardizedFileURL == selected.standardizedFileURL }) {
            currentProjectIndex = index
        } else {
            currentProjectIndex = min(currentProjectIndex, max(projects.count - 1, 0))
        }
    }

    private func refreshVaultFromDisk() {
        guard let vaultURL else { return }
        guard FileManager.default.fileExists(atPath: vaultURL.path) else {
            stopVaultFileWatcher()
            self.vaultURL = nil
            projects = []
            clearLoadedPages()
            return
        }

        let selectedProjectURL = currentProjectDirectoryURL()
        let selectedMarkdownURL = currentMarkdownFileURL()
        refreshProjects(selecting: selectedProjectURL)

        guard !projects.isEmpty else {
            clearLoadedPages()
            return
        }

        loadProject(at: currentProjectIndex, preferredMarkdownURL: selectedMarkdownURL)
    }

    private func clearLoadedPages() {
        pages = [""]
        pageTitles = ["Untitled"]
        pageMarkdownURLs = []
        currentProjectIndex = 0
        currentPageIndex = 0
        readPages.removeAll()
        savedPages = pages
        savedPageTitles = pageTitles
        updatePageInfo()
    }

    private func refreshCurrentProjectMetadata() {
        guard currentProjectIndex >= 0, currentProjectIndex < projects.count else {
            refreshProjects()
            return
        }

        let projectURL = projects[currentProjectIndex].url
        if let project = projectMetadata(for: projectURL) {
            projects[currentProjectIndex] = project
        } else {
            refreshProjects()
        }
    }

    private func loadProject(at index: Int, preferredMarkdownURL: URL? = nil) {
        guard index >= 0, index < projects.count else { return }

        currentProjectIndex = index
        let project = projects[index]
        let loaded = loadMarkdownFiles(project.markdownURLs)
        pages = loaded.pages.isEmpty ? [""] : loaded.pages
        pageTitles = CueRecordService.normalizedPageTitles(for: pages, titles: loaded.titles)
        pageMarkdownURLs = project.markdownURLs

        if let preferredMarkdownURL,
           let markdownIndex = pageMarkdownURLs.firstIndex(where: { $0.standardizedFileURL == preferredMarkdownURL.standardizedFileURL }) {
            currentPageIndex = markdownIndex
        } else {
            currentPageIndex = min(currentPageIndex, max(pages.count - 1, 0))
        }

        readPages.removeAll()
        savedPages = pages
        savedPageTitles = pageTitles
        updatePageInfo()
    }

    private func projectMetadata(for projectURL: URL) -> CueRecordProject? {
        let markdownURLs = markdownFiles(in: projectURL)
        let loaded = loadMarkdownFiles(markdownURLs)
        return CueRecordProject(
            id: projectURL,
            url: projectURL,
            title: projectURL.lastPathComponent,
            markdownURLs: markdownURLs,
            markdownTitles: loaded.titles,
            markdownPreviews: loaded.pages.map(markdownPreview),
            modifiedDates: markdownURLs.map(modifiedDate)
        )
    }

    private func projectDirectories(in vaultURL: URL) -> [URL] {
        ((try? FileManager.default.contentsOfDirectory(
            at: vaultURL,
            includingPropertiesForKeys: [.isDirectoryKey, .contentModificationDateKey],
            options: [.skipsHiddenFiles]
        )) ?? [])
        .filter { url in
            let isDirectory = (try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) ?? false
            return isDirectory
        }
        .sorted { lhs, rhs in
            lhs.lastPathComponent.localizedStandardCompare(rhs.lastPathComponent) == .orderedAscending
        }
    }

    private func migrateLooseMarkdownFiles(in vaultURL: URL) throws {
        let looseMarkdownFiles = markdownFiles(in: vaultURL)
        guard !looseMarkdownFiles.isEmpty else { return }

        ignoreOwnVaultChanges()
        let projectURL = uniqueProjectDirectory(in: vaultURL, title: "Imported Markdown")
        try FileManager.default.createDirectory(at: projectURL, withIntermediateDirectories: true)

        for markdownURL in looseMarkdownFiles {
            let destinationURL = uniqueMarkdownFile(in: projectURL, title: markdownTitle(from: markdownURL))
            try FileManager.default.moveItem(at: markdownURL, to: destinationURL)
        }
    }

    private func createPageStorage(title: String, text: String) -> (title: String, markdownURL: URL?) {
        guard let projectURL = currentProjectDirectoryURL() else {
            return (title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Untitled" : title, nil)
        }

        do {
            ignoreOwnVaultChanges()
            try FileManager.default.createDirectory(at: projectURL, withIntermediateDirectories: true)
            let markdownURL = uniqueMarkdownFile(in: projectURL, title: title)
            let resolvedTitle = markdownTitle(from: markdownURL)
            try text.write(to: markdownURL, atomically: true, encoding: .utf8)
            return (resolvedTitle, markdownURL)
        } catch {
            showFileError(title: "Failed to create markdown file", error: error)
            return (title, nil)
        }
    }

    private func rebuildVaultPagesFromCurrentState(replacing previousMarkdownURLs: [URL] = []) {
        guard let projectURL = currentProjectDirectoryURL() else { return }

        do {
            ignoreOwnVaultChanges()
            for markdownURL in previousMarkdownURLs {
                trashOrRemoveFile(markdownURL)
            }
            pageMarkdownURLs.removeAll()
            try FileManager.default.createDirectory(at: projectURL, withIntermediateDirectories: true)

            let currentPages = pages
            let currentTitles = pageTitles
            for index in currentPages.indices {
                let title = index < currentTitles.count ? currentTitles[index] : "Untitled"
                let storage = createPageStorage(title: title, text: currentPages[index])
                if let markdownURL = storage.markdownURL {
                    pageMarkdownURLs.append(markdownURL)
                    pageTitles[index] = storage.title
                }
            }
        } catch {
            showFileError(title: "Failed to update CueRecord project", error: error)
        }
        refreshCurrentProjectMetadata()
    }

    private func persistPage(at index: Int) {
        guard index >= 0, index < pages.count else { return }
        guard index < pageMarkdownURLs.count else { return }

        do {
            ignoreOwnVaultChanges()
            try pages[index].write(to: pageMarkdownURLs[index], atomically: true, encoding: .utf8)
            savedPages = pages
            savedPageTitles = pageTitles
        } catch {
            showFileError(title: "Failed to save markdown file", error: error)
        }
    }

    private func ensureMarkdownStorageExists(for index: Int) {
        guard index >= 0, index < pages.count else { return }
        guard index >= pageMarkdownURLs.count else { return }
        guard currentProjectDirectoryURL() != nil else { return }

        while pageMarkdownURLs.count < index {
            let fillerIndex = pageMarkdownURLs.count
            let fillerTitle = fillerIndex < pageTitles.count ? pageTitles[fillerIndex] : "Untitled"
            let fillerText = fillerIndex < pages.count ? pages[fillerIndex] : ""
            let storage = createPageStorage(title: fillerTitle, text: fillerText)
            guard let markdownURL = storage.markdownURL else { return }
            pageMarkdownURLs.append(markdownURL)
            if fillerIndex < pageTitles.count {
                pageTitles[fillerIndex] = storage.title
            }
        }

        let title = index < pageTitles.count ? pageTitles[index] : "Untitled"
        let storage = createPageStorage(title: title, text: pages[index])
        guard let markdownURL = storage.markdownURL else { return }
        pageMarkdownURLs.append(markdownURL)
        if index < pageTitles.count {
            pageTitles[index] = storage.title
        }
    }

    private func persistAllPages() {
        for index in pages.indices {
            persistPage(at: index)
        }
    }

    private func markdownFileURL(in directoryURL: URL, preferredTitle: String) -> URL? {
        let preferred = directoryURL.appendingPathComponent("\(preferredTitle).md")
        if FileManager.default.fileExists(atPath: preferred.path) {
            return preferred
        }

        let markdownFiles = (try? FileManager.default.contentsOfDirectory(
            at: directoryURL,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles]
        ))?
        .filter { $0.pathExtension.lowercased() == "md" }
        .sorted { $0.lastPathComponent.localizedStandardCompare($1.lastPathComponent) == .orderedAscending }

        return markdownFiles?.first
    }

    private func markdownFiles(in projectURL: URL) -> [URL] {
        ((try? FileManager.default.contentsOfDirectory(
            at: projectURL,
            includingPropertiesForKeys: [.isDirectoryKey, .contentModificationDateKey],
            options: [.skipsHiddenFiles]
        )) ?? [])
        .filter { url in
            let isDirectory = (try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) ?? false
            return !isDirectory && url.pathExtension.lowercased() == "md"
        }
        .sorted { lhs, rhs in
            lhs.lastPathComponent.localizedStandardCompare(rhs.lastPathComponent) == .orderedAscending
        }
    }

    private func loadMarkdownFiles(_ markdownFiles: [URL]) -> (pages: [String], titles: [String]) {
        let loadedPages = markdownFiles.map { url in
            (try? String(contentsOf: url, encoding: .utf8)) ?? ""
        }
        let loadedTitles = markdownFiles.map(markdownTitle(from:))
        return (loadedPages, loadedTitles)
    }

    private func loadLegacyPageDirectories(in projectURL: URL) -> (pages: [String], titles: [String]) {
        let pageDirectories = ((try? FileManager.default.contentsOfDirectory(
            at: projectURL,
            includingPropertiesForKeys: [.isDirectoryKey, .creationDateKey, .contentModificationDateKey],
            options: [.skipsHiddenFiles]
        )) ?? [])
        .filter { url in
            (try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true
        }
        .sorted { lhs, rhs in
            lhs.lastPathComponent.localizedStandardCompare(rhs.lastPathComponent) == .orderedAscending
        }

        var loadedPages: [String] = []
        var loadedTitles: [String] = []

        for directoryURL in pageDirectories {
            let title = directoryURL.lastPathComponent
            guard let markdownURL = markdownFileURL(in: directoryURL, preferredTitle: title) else { continue }
            let text = (try? String(contentsOf: markdownURL, encoding: .utf8)) ?? ""
            loadedPages.append(text)
            loadedTitles.append(markdownTitle(from: markdownURL))
        }

        return (loadedPages, loadedTitles)
    }

    private func uniqueMarkdownFile(in vaultURL: URL, title: String, excluding excludedURL: URL? = nil) -> URL {
        let baseName = sanitizedPagePathComponent(title)
        var candidate = vaultURL.appendingPathComponent("\(baseName).md")
        var suffix = 2

        while FileManager.default.fileExists(atPath: candidate.path), excludedURL.map({ candidate == $0 }) != true {
            candidate = vaultURL.appendingPathComponent("\(baseName) \(suffix).md")
            suffix += 1
        }

        return candidate
    }

    private func uniqueProjectDirectory(in vaultURL: URL, title: String, excluding excludedURL: URL? = nil) -> URL {
        let baseName = sanitizedPagePathComponent(title)
        var candidate = vaultURL.appendingPathComponent(baseName, isDirectory: true)
        var suffix = 2

        while FileManager.default.fileExists(atPath: candidate.path), excludedURL.map({ candidate == $0 }) != true {
            candidate = vaultURL.appendingPathComponent("\(baseName) \(suffix)", isDirectory: true)
            suffix += 1
        }

        return candidate
    }

    private func markdownTitle(from url: URL) -> String {
        let title = url.deletingPathExtension().lastPathComponent.trimmingCharacters(in: .whitespacesAndNewlines)
        return title.isEmpty ? "Untitled" : title
    }

    private func markdownPreview(from text: String) -> String {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return "Empty" }
        let words = trimmed.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
        let preview = words.prefix(6).joined(separator: " ")
        return preview.count > 34 ? String(preview.prefix(34)) + "…" : preview
    }

    private func modifiedDate(for url: URL) -> Date? {
        (try? url.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate)
    }

    private func sanitizedPagePathComponent(_ value: String) -> String {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        let source = trimmed.isEmpty ? "Untitled" : trimmed
        let illegalCharacters = CharacterSet(charactersIn: "/:\\?%*|\"<>")
            .union(.controlCharacters)
            .union(.newlines)

        let sanitized = source.unicodeScalars
            .map { illegalCharacters.contains($0) ? "-" : String($0) }
            .joined()
            .trimmingCharacters(in: CharacterSet(charactersIn: ". "))

        return sanitized.isEmpty ? "Untitled" : sanitized
    }

    private func trashOrRemoveFile(_ url: URL) {
        guard FileManager.default.fileExists(atPath: url.path) else { return }

        do {
            ignoreOwnVaultChanges()
            var resultingURL: NSURL?
            try FileManager.default.trashItem(at: url, resultingItemURL: &resultingURL)
        } catch {
            try? FileManager.default.removeItem(at: url)
        }
    }

    private func ignoreOwnVaultChanges() {
        ignoreVaultEventsUntil = Date().addingTimeInterval(1.0)
    }

    private func startVaultFileWatcher(for folderURL: URL) {
        let standardizedURL = folderURL.standardizedFileURL
        if watchedVaultURL?.standardizedFileURL == standardizedURL, vaultEventStream != nil {
            return
        }

        stopVaultFileWatcher()

        var context = FSEventStreamContext(
            version: 0,
            info: UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()),
            retain: nil,
            release: nil,
            copyDescription: nil
        )

        let callback: FSEventStreamCallback = { _, info, eventCount, eventPaths, eventFlags, _ in
            guard let info else { return }
            let service = Unmanaged<CueRecordService>.fromOpaque(info).takeUnretainedValue()
            let paths = unsafeBitCast(eventPaths, to: NSArray.self) as? [String] ?? []
            let flags = (0..<eventCount).map { eventFlags[$0] }

            DispatchQueue.main.async {
                service.handleVaultFileEvents(paths: paths, flags: flags)
            }
        }

        let flags = FSEventStreamCreateFlags(
            kFSEventStreamCreateFlagUseCFTypes |
            kFSEventStreamCreateFlagFileEvents |
            kFSEventStreamCreateFlagNoDefer
        )

        guard let stream = FSEventStreamCreate(
            kCFAllocatorDefault,
            callback,
            &context,
            [folderURL.path] as CFArray,
            FSEventStreamEventId(kFSEventStreamEventIdSinceNow),
            0.35,
            flags
        ) else {
            watchedVaultURL = nil
            return
        }

        FSEventStreamSetDispatchQueue(stream, DispatchQueue.global(qos: .utility))
        FSEventStreamStart(stream)
        vaultEventStream = stream
        watchedVaultURL = standardizedURL
    }

    private func stopVaultFileWatcher() {
        guard let stream = vaultEventStream else {
            watchedVaultURL = nil
            return
        }

        FSEventStreamStop(stream)
        FSEventStreamInvalidate(stream)
        FSEventStreamRelease(stream)
        vaultEventStream = nil
        watchedVaultURL = nil
    }

    private func handleVaultFileEvents(paths: [String], flags: [FSEventStreamEventFlags]) {
        guard vaultURL != nil else { return }
        guard Date() >= ignoreVaultEventsUntil else { return }

        let hasRelevantChange = zip(paths, flags).contains { _, flag in
            let event = FSEventStreamEventFlags(flag)
            return event & FSEventStreamEventFlags(kFSEventStreamEventFlagItemCreated) != 0 ||
                event & FSEventStreamEventFlags(kFSEventStreamEventFlagItemRemoved) != 0 ||
                event & FSEventStreamEventFlags(kFSEventStreamEventFlagItemRenamed) != 0 ||
                event & FSEventStreamEventFlags(kFSEventStreamEventFlagItemModified) != 0 ||
                event & FSEventStreamEventFlags(kFSEventStreamEventFlagItemChangeOwner) != 0 ||
                event & FSEventStreamEventFlags(kFSEventStreamEventFlagRootChanged) != 0 ||
                event & FSEventStreamEventFlags(kFSEventStreamEventFlagMustScanSubDirs) != 0 ||
                event & FSEventStreamEventFlags(kFSEventStreamEventFlagUserDropped) != 0 ||
                event & FSEventStreamEventFlags(kFSEventStreamEventFlagKernelDropped) != 0
        }
        guard hasRelevantChange else { return }

        scheduleVaultRefreshFromDisk()
    }

    private func scheduleVaultRefreshFromDisk() {
        vaultRefreshWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            self?.refreshVaultFromDisk()
        }
        vaultRefreshWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: workItem)
    }

    private func showFileError(title: String, error: Error) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = error.localizedDescription
        alert.runModal()
    }

    // MARK: - Browser Server

    func updateBrowserServer() {
        if NotchSettings.shared.browserServerEnabled {
            if !browserServer.isRunning {
                browserServer.start()
            }
        } else {
            browserServer.stop()
        }
    }

    // MARK: - Director Server

    func updateDirectorServer() {
        if NotchSettings.shared.directorModeEnabled {
            if !directorServer.isRunning {
                directorServer.start()
                wireDirectorCallbacks()
            }
        } else {
            directorServer.stop()
            if directorIsReading {
                overlayController.dismiss()
                directorIsReading = false
            }
        }
    }

    private func wireDirectorCallbacks() {
        directorServer.onSetText = { [weak self] text in
            self?.setTextFromDirector(text)
        }
        directorServer.onUpdateText = { [weak self] text, readCharCount in
            self?.updateTextFromDirector(text, readCharCount: readCharCount)
        }
        directorServer.onStop = { [weak self] in
            self?.stopDirectorReading()
        }
    }

    func setTextFromDirector(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        // Director mode is single page
        replacePages([trimmed], titles: ["Director"], persistToVault: false)

        // Force word tracking mode for director
        let savedMode = NotchSettings.shared.listeningMode
        NotchSettings.shared.listeningMode = .wordTracking

        directorIsReading = true

        overlayController.show(text: trimmed, hasNextPage: false) { [weak self] in
            self?.directorIsReading = false
            self?.directorServer.hideContent()
            self?.externalDisplayController.dismiss()
            self?.browserServer.hideContent()
            // Restore listening mode
            NotchSettings.shared.listeningMode = savedMode
        }

        // Feed director server with speech recognizer
        let words = splitTextIntoWords(trimmed)
        let totalCharCount = words.joined(separator: " ").count
        directorServer.showContent(
            speechRecognizer: overlayController.speechRecognizer,
            words: words,
            totalCharCount: totalCharCount
        )

        // Also show on external display & browser if configured
        externalDisplayController.show(
            speechRecognizer: overlayController.speechRecognizer,
            words: words,
            totalCharCount: totalCharCount,
            hasNextPage: false
        )
        if browserServer.isRunning {
            browserServer.showContent(
                speechRecognizer: overlayController.speechRecognizer,
                words: words,
                totalCharCount: totalCharCount,
                hasNextPage: false
            )
        }
    }

    func updateTextFromDirector(_ text: String, readCharCount: Int) {
        guard directorIsReading else { return }
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        replacePages([trimmed], titles: pageTitles.isEmpty ? ["Director"] : [pageTitle(at: 0)], persistToVault: false)

        // Preserve read progress: only update unread portion
        let preservedCharCount = overlayController.speechRecognizer.recognizedCharCount

        let words = splitTextIntoWords(trimmed)
        let totalCharCount = words.joined(separator: " ").count

        // Update overlay content without resetting speech progress
        overlayController.overlayContent.words = words
        overlayController.overlayContent.totalCharCount = totalCharCount
        overlayController.overlayContent.hasNextPage = false

        // Update the speech recognizer with new full text but keep char count
        overlayController.speechRecognizer.updateText(trimmed, preservingCharCount: preservedCharCount)

        // Update director server
        directorServer.updateContent(words: words, totalCharCount: totalCharCount)

        // Update external display & browser
        externalDisplayController.overlayContent.words = words
        externalDisplayController.overlayContent.totalCharCount = totalCharCount
        if browserServer.isRunning {
            browserServer.updateContent(
                words: words,
                totalCharCount: totalCharCount,
                hasNextPage: false
            )
        }
    }

    func stopDirectorReading() {
        guard directorIsReading else { return }
        overlayController.dismiss()
        directorIsReading = false
    }

    // macOS Services handler
    @objc func readInCueRecord(_ pboard: NSPasteboard, userData: String, error: AutoreleasingUnsafeMutablePointer<NSString?>) {
        guard let text = pboard.string(forType: .string) else {
            error.pointee = "No text found on pasteboard" as NSString
            return
        }
        readText(text)
    }

    // URL scheme handler: cuerecord://read?text=Hello%20World. Legacy takeone:// links still work.
    func handleURL(_ url: URL) {
        guard Self.supportedURLSchemes.contains(url.scheme?.lowercased() ?? "") else { return }

        if url.host == "read" || url.path == "/read" {
            if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
               let textParam = components.queryItems?.first(where: { $0.name == "text" })?.value {
                readText(textParam)
            }
        }
    }

    func normalizePageTitles() {
        pageTitles = CueRecordService.normalizedPageTitles(for: pages, titles: pageTitles)
    }

    private func defaultPageTitle(for index: Int) -> String {
        CueRecordService.defaultPageTitle(for: index)
    }

    private static func defaultPageTitle(for index: Int) -> String {
        index == 0 ? "Untitled" : "Untitled \(index + 1)"
    }

    static func normalizedPageTitles(for pages: [String], titles: [String]? = nil) -> [String] {
        pages.indices.map { index in
            if let titles, index < titles.count {
                let title = titles[index].trimmingCharacters(in: .whitespacesAndNewlines)
                if !title.isEmpty {
                    return title
                }
            }
            return defaultPageTitle(for: index)
        }
    }
}
