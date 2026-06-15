//
//  CueRecordVaultRepairer.swift
//  CueRecord
//

import Foundation

struct CueRecordVaultRepairReport: Equatable {
    var scannedProjects: Int = 0
    var createdManifests: Int = 0
    var repairedManifests: Int = 0
    var removedMissingFileRecords: Int = 0

    var changedProjects: Int {
        createdManifests + repairedManifests
    }
}

final class CueRecordVaultRepairer {
    private let fileManager: FileManager

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }

    @discardableResult
    func repairVault(at vaultURL: URL) throws -> CueRecordVaultRepairReport {
        var report = CueRecordVaultRepairReport()
        let projectURLs = try projectDirectories(in: vaultURL)

        for projectURL in projectURLs {
            let store = CueRecordProjectStore(projectURL: projectURL, fileManager: fileManager)
            let markdownURLs = store.markdownFiles()
            guard !markdownURLs.isEmpty else { continue }

            report.scannedProjects += 1

            let manifestExists = fileManager.fileExists(atPath: store.manifestURL.path)
            let previousManifest = store.loadManifest()
            let wasCorrupt = manifestExists && previousManifest == nil
            let previousFileCount = previousManifest?.files.count ?? 0
            let loaded = loadMarkdownFiles(markdownURLs)
            let missingFileRecords = previousManifest.map {
                missingFileRecordCount(in: $0, markdownURLs: markdownURLs, store: store)
            } ?? 0
            let needsRepair = previousManifest.map {
                manifestNeedsRepair(
                    $0,
                    markdownURLs: markdownURLs,
                    titles: loaded.titles,
                    pages: loaded.pages,
                    store: store
                )
            } ?? true

            guard needsRepair || wasCorrupt || !manifestExists else {
                continue
            }

            let repairedManifest = try store.syncManifest(
                markdownURLs: markdownURLs,
                titles: loaded.titles,
                pages: loaded.pages,
                selectedURL: nil
            )

            if !manifestExists {
                report.createdManifests += 1
            } else if wasCorrupt || previousManifest != repairedManifest {
                report.repairedManifests += 1
            }

            if previousFileCount > repairedManifest.files.count {
                report.removedMissingFileRecords += max(
                    missingFileRecords,
                    previousFileCount - repairedManifest.files.count
                )
            }
        }

        return report
    }

    private func projectDirectories(in vaultURL: URL) throws -> [URL] {
        try fileManager.contentsOfDirectory(
            at: vaultURL,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles]
        )
        .filter { url in
            let isDirectory = (try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) ?? false
            return isDirectory
        }
        .sorted { lhs, rhs in
            lhs.lastPathComponent.localizedStandardCompare(rhs.lastPathComponent) == .orderedAscending
        }
    }

    private func loadMarkdownFiles(_ markdownURLs: [URL]) -> (pages: [String], titles: [String]) {
        let pages = markdownURLs.map { url in
            (try? String(contentsOf: url, encoding: .utf8)) ?? ""
        }
        let titles = markdownURLs.map { url in
            let title = url.deletingPathExtension().lastPathComponent.trimmingCharacters(in: .whitespacesAndNewlines)
            return title.isEmpty ? "Untitled" : title
        }
        return (pages, titles)
    }

    private func missingFileRecordCount(
        in manifest: CueRecordProjectManifest,
        markdownURLs: [URL],
        store: CueRecordProjectStore
    ) -> Int {
        let existingPaths = Set(markdownURLs.map(store.relativePath(for:)))
        return manifest.files.filter { !existingPaths.contains($0.relativePath) }.count
    }

    private func manifestNeedsRepair(
        _ manifest: CueRecordProjectManifest,
        markdownURLs: [URL],
        titles: [String],
        pages: [String],
        store: CueRecordProjectStore
    ) -> Bool {
        guard manifest.files.count == markdownURLs.count else { return true }

        for (index, markdownURL) in markdownURLs.enumerated() {
            let expectedRelativePath = store.relativePath(for: markdownURL)
            let expectedTitle = index < titles.count ? titles[index] : markdownURL.deletingPathExtension().lastPathComponent
            let expectedPage = index < pages.count ? pages[index] : ""
            let expectedHash = CueRecordPathPolicy.contentHash(expectedPage)
            let record = manifest.files[index]

            if record.relativePath != expectedRelativePath ||
                record.title != expectedTitle ||
                record.kind != "markdown" ||
                record.contentHash != expectedHash {
                return true
            }
        }

        if let selectedFileID = manifest.selectedFileID,
           !manifest.files.contains(where: { $0.id == selectedFileID }) {
            return true
        }

        return false
    }
}
