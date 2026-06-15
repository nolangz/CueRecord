//
//  CueRecordProjectStore.swift
//  CueRecord
//

import Foundation

struct CueRecordFileSnapshot: Equatable {
    var exists: Bool
    var modificationDate: Date?
    var fileSize: Int64?
    var contentHash: String?

    static func current(
        for url: URL,
        fileManager: FileManager = .default,
        cachedText: String? = nil
    ) -> CueRecordFileSnapshot {
        guard fileManager.fileExists(atPath: url.path) else {
            return CueRecordFileSnapshot(exists: false, modificationDate: nil, fileSize: nil, contentHash: nil)
        }

        let resourceValues = try? url.resourceValues(forKeys: [.contentModificationDateKey, .fileSizeKey])
        let data: Data?
        if let cachedText {
            data = Data(cachedText.utf8)
        } else {
            data = try? Data(contentsOf: url)
        }

        return CueRecordFileSnapshot(
            exists: true,
            modificationDate: resourceValues?.contentModificationDate,
            fileSize: data.map { Int64($0.count) } ?? resourceValues?.fileSize.map(Int64.init),
            contentHash: data.map(CueRecordPathPolicy.contentHash)
        )
    }

    func matches(_ other: CueRecordFileSnapshot) -> Bool {
        guard exists == other.exists else { return false }
        guard exists else { return true }

        if let contentHash, let otherContentHash = other.contentHash {
            return contentHash == otherContentHash
        }

        return modificationDate == other.modificationDate && fileSize == other.fileSize
    }
}

enum CueRecordFileConflictError: LocalizedError {
    case changedOnDisk(URL)

    var errorDescription: String? {
        switch self {
        case .changedOnDisk(let url):
            return "\(url.lastPathComponent) changed on disk before CueRecord could save it."
        }
    }

    var recoverySuggestion: String? {
        "CueRecord reloaded the project from disk to avoid overwriting external changes."
    }
}

final class CueRecordProjectStore {
    let projectURL: URL
    private let fileManager: FileManager

    init(projectURL: URL, fileManager: FileManager = .default) {
        self.projectURL = projectURL.standardizedFileURL
        self.fileManager = fileManager
    }

    var metadataDirectoryURL: URL {
        projectURL.appendingPathComponent(CueRecordProjectManifest.metadataDirectoryName, isDirectory: true)
    }

    var manifestURL: URL {
        metadataDirectoryURL.appendingPathComponent(CueRecordProjectManifest.fileName)
    }

    func markdownFiles() -> [URL] {
        let files = ((try? fileManager.contentsOfDirectory(
            at: projectURL,
            includingPropertiesForKeys: [.isDirectoryKey, .contentModificationDateKey],
            options: [.skipsHiddenFiles]
        )) ?? [])
        .filter { url in
            let isDirectory = (try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) ?? false
            return !isDirectory && url.pathExtension.lowercased() == "md"
        }

        return orderedMarkdownURLs(files)
    }

    func loadManifest() -> CueRecordProjectManifest? {
        guard fileManager.fileExists(atPath: manifestURL.path),
              let data = try? Data(contentsOf: manifestURL) else {
            return nil
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try? decoder.decode(CueRecordProjectManifest.self, from: data)
    }

    @discardableResult
    func syncManifest(
        markdownURLs: [URL],
        titles: [String],
        pages: [String],
        selectedURL: URL?
    ) throws -> CueRecordProjectManifest {
        var manifest = loadManifest() ?? CueRecordProjectManifest()
        let now = Date()
        let existingByPath = Dictionary(uniqueKeysWithValues: manifest.files.map { ($0.relativePath, $0) })
        var unmatchedExisting = manifest.files
        var nextFiles: [CueRecordProjectFileRecord] = []

        for (index, markdownURL) in markdownURLs.enumerated() {
            let relativePath = self.relativePath(for: markdownURL)
            let title = index < titles.count ? titles[index] : markdownURL.deletingPathExtension().lastPathComponent
            let page = index < pages.count ? pages[index] : ((try? String(contentsOf: markdownURL, encoding: .utf8)) ?? "")
            let contentHash = CueRecordPathPolicy.contentHash(page)

            let pathMatchedRecord = existingByPath[relativePath]
            if let pathMatchedRecord {
                unmatchedExisting.removeAll { $0.id == pathMatchedRecord.id }
            }

            var record = pathMatchedRecord
                ?? takeMatchingRecord(
                    from: &unmatchedExisting,
                    title: title,
                    contentHash: contentHash
                )
                ?? CueRecordProjectFileRecord(relativePath: relativePath, title: title, contentHash: contentHash)

            record.relativePath = relativePath
            record.title = title
            record.kind = "markdown"
            record.updatedAt = now
            record.contentHash = contentHash
            nextFiles.append(record)
        }

        manifest.version = max(manifest.version, 1)
        manifest.files = nextFiles
        manifest.updatedAt = now

        if let selectedURL {
            let selectedRelativePath = relativePath(for: selectedURL)
            manifest.selectedFileID = nextFiles.first(where: { $0.relativePath == selectedRelativePath })?.id
        } else if let selectedFileID = manifest.selectedFileID,
                  nextFiles.contains(where: { $0.id == selectedFileID }) {
            manifest.selectedFileID = selectedFileID
        } else {
            manifest.selectedFileID = nextFiles.first?.id
        }

        try saveManifest(manifest)
        return manifest
    }

    func selectedMarkdownURL(from markdownURLs: [URL]) -> URL? {
        guard let manifest = loadManifest(),
              let selectedFileID = manifest.selectedFileID,
              let selectedFile = manifest.files.first(where: { $0.id == selectedFileID }) else {
            return nil
        }

        let selectedURL = projectURL.appendingPathComponent(selectedFile.relativePath)
        guard markdownURLs.contains(where: { CueRecordPathPolicy.isSameFileURL($0, selectedURL) }) else {
            return nil
        }
        return selectedURL
    }

    func orderedMarkdownURLs(_ urls: [URL]) -> [URL] {
        let fallbackSorted = urls.sorted {
            $0.lastPathComponent.localizedStandardCompare($1.lastPathComponent) == .orderedAscending
        }

        guard let manifest = loadManifest(), !manifest.files.isEmpty else {
            return fallbackSorted
        }

        let order = Dictionary(uniqueKeysWithValues: manifest.files.enumerated().map { index, file in
            (file.relativePath, index)
        })

        return fallbackSorted.sorted { lhs, rhs in
            let lhsOrder = order[relativePath(for: lhs)] ?? Int.max
            let rhsOrder = order[relativePath(for: rhs)] ?? Int.max
            if lhsOrder != rhsOrder {
                return lhsOrder < rhsOrder
            }
            return lhs.lastPathComponent.localizedStandardCompare(rhs.lastPathComponent) == .orderedAscending
        }
    }

    func recordMarkdownRename(
        from oldURL: URL,
        to newURL: URL,
        title: String,
        contentHash: String?
    ) throws {
        guard var manifest = loadManifest() else { return }
        let oldRelativePath = relativePath(for: oldURL)
        let newRelativePath = relativePath(for: newURL)
        guard let index = manifest.files.firstIndex(where: { $0.relativePath == oldRelativePath }) else {
            return
        }

        manifest.files[index].relativePath = newRelativePath
        manifest.files[index].title = title
        manifest.files[index].updatedAt = Date()
        manifest.files[index].contentHash = contentHash
        manifest.updatedAt = Date()
        try saveManifest(manifest)
    }

    @discardableResult
    func writeMarkdown(
        _ text: String,
        to url: URL,
        expectedSnapshot: CueRecordFileSnapshot?
    ) throws -> CueRecordFileSnapshot {
        if let expectedSnapshot {
            let currentSnapshot = CueRecordFileSnapshot.current(for: url, fileManager: fileManager)
            guard currentSnapshot.matches(expectedSnapshot) else {
                throw CueRecordFileConflictError.changedOnDisk(url)
            }
        }

        try fileManager.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
        try text.write(to: url, atomically: true, encoding: .utf8)
        return CueRecordFileSnapshot.current(for: url, fileManager: fileManager, cachedText: text)
    }

    func uniqueMarkdownURL(title: String, excluding excludedURL: URL? = nil) -> URL {
        CueRecordPathPolicy.uniqueFileURL(
            in: projectURL,
            title: title,
            pathExtension: "md",
            excluding: excludedURL,
            fileManager: fileManager
        )
    }

    func relativePath(for url: URL) -> String {
        let standardizedPath = url.standardizedFileURL.path
        let projectPath = projectURL.standardizedFileURL.path
        guard standardizedPath.hasPrefix(projectPath + "/") else {
            return url.lastPathComponent
        }
        return String(standardizedPath.dropFirst(projectPath.count + 1))
    }

    private func saveManifest(_ manifest: CueRecordProjectManifest) throws {
        try fileManager.createDirectory(at: metadataDirectoryURL, withIntermediateDirectories: true)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        try encoder.encode(manifest).write(to: manifestURL, options: .atomic)
    }

    private func takeMatchingRecord(
        from records: inout [CueRecordProjectFileRecord],
        title: String,
        contentHash: String
    ) -> CueRecordProjectFileRecord? {
        guard let index = records.firstIndex(where: { record in
            record.kind == "markdown" &&
                record.title == title &&
                record.contentHash == contentHash
        }) else {
            return nil
        }

        return records.remove(at: index)
    }
}
