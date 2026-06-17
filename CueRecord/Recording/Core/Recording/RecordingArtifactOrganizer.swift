import Foundation

nonisolated enum RecordingRenderMode: Equatable, Sendable {
    case all
    case cameraOnlyTransparent
    case edited(RecordingEditDecision)

    var statusText: String {
        switch self {
        case .all:
            return "Rendering recording"
        case .cameraOnlyTransparent:
            return "Rendering camera"
        case .edited:
            return "Rendering edit"
        }
    }
}

nonisolated struct CapturedRecordingOutput: Sendable {
    let outputURL: URL
    let cameraURL: URL?
    let overlayMetadataURL: URL?

    var canRenderCameraOnly: Bool {
        guard let cameraURL, let overlayMetadataURL else { return false }
        return FileManager.default.fileExists(atPath: cameraURL.path)
            && FileManager.default.fileExists(atPath: overlayMetadataURL.path)
    }
}

nonisolated struct RecordingPostProcessingResult: Sendable {
    let finalOutputURL: URL
    let mode: RecordingRenderMode
    let didExportCompositedVideo: Bool
    let didExportCameraOnlyVideo: Bool
    let movedRawArtifactCount: Int
}

nonisolated enum RecordingPostProcessingEvent: Sendable {
    case started(outputURL: URL, mode: RecordingRenderMode)
    case completed(RecordingPostProcessingResult)
}

nonisolated enum RecordingArtifactOrganizer {
    static let rawDataDirectoryName = "raw_data"

    @discardableResult
    static func moveRawArtifacts(
        in sessionDirectory: URL,
        keeping finalOutputURL: URL,
        fileManager: FileManager = .default
    ) throws -> [URL] {
        let rawDataDirectory = sessionDirectory.appendingPathComponent(rawDataDirectoryName, isDirectory: true)
        try fileManager.createDirectory(at: rawDataDirectory, withIntermediateDirectories: true)

        let finalPath = finalOutputURL.standardizedFileURL.path
        let contents = try fileManager.contentsOfDirectory(
            at: sessionDirectory,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles]
        )

        var movedURLs: [URL] = []
        for sourceURL in contents {
            if sourceURL.lastPathComponent == rawDataDirectoryName {
                continue
            }

            if sourceURL.standardizedFileURL.path == finalPath {
                continue
            }

            let values = try? sourceURL.resourceValues(forKeys: [.isDirectoryKey])
            if values?.isDirectory == true {
                continue
            }

            let destinationURL = uniqueDestinationURL(
                for: rawDataDirectory.appendingPathComponent(sourceURL.lastPathComponent),
                fileManager: fileManager
            )
            try fileManager.moveItem(at: sourceURL, to: destinationURL)
            movedURLs.append(destinationURL)
        }

        return movedURLs
    }

    @discardableResult
    static func deleteArtifacts(
        for capturedOutput: CapturedRecordingOutput,
        fileManager: FileManager = .default
    ) throws -> [URL] {
        let sessionDirectory = capturedOutput.outputURL.deletingLastPathComponent()
        let rawDataDirectory = sessionDirectory.appendingPathComponent(rawDataDirectoryName, isDirectory: true)
        let baseName = capturedOutput.outputURL.deletingPathExtension().lastPathComponent
        var deletedURLs: [URL] = []

        func shouldDelete(_ url: URL) -> Bool {
            let fileName = url.deletingPathExtension().lastPathComponent
            return fileName == baseName || fileName.hasPrefix("\(baseName)_")
        }

        func deleteMatchingFiles(in directory: URL) throws {
            guard fileManager.fileExists(atPath: directory.path) else { return }
            let contents = try fileManager.contentsOfDirectory(
                at: directory,
                includingPropertiesForKeys: [.isDirectoryKey],
                options: [.skipsHiddenFiles]
            )

            for url in contents where shouldDelete(url) {
                let values = try? url.resourceValues(forKeys: [.isDirectoryKey])
                guard values?.isDirectory != true else { continue }
                try fileManager.removeItem(at: url)
                deletedURLs.append(url)
            }
        }

        try deleteMatchingFiles(in: sessionDirectory)
        try deleteMatchingFiles(in: rawDataDirectory)

        if fileManager.fileExists(atPath: rawDataDirectory.path),
           (try fileManager.contentsOfDirectory(atPath: rawDataDirectory.path)).isEmpty {
            try fileManager.removeItem(at: rawDataDirectory)
            deletedURLs.append(rawDataDirectory)
        }

        if fileManager.fileExists(atPath: sessionDirectory.path),
           (try fileManager.contentsOfDirectory(atPath: sessionDirectory.path)).isEmpty {
            try fileManager.removeItem(at: sessionDirectory)
            deletedURLs.append(sessionDirectory)
        }

        return deletedURLs
    }

    private static func uniqueDestinationURL(for url: URL, fileManager: FileManager) -> URL {
        guard fileManager.fileExists(atPath: url.path) else {
            return url
        }

        let directory = url.deletingLastPathComponent()
        let baseName = url.deletingPathExtension().lastPathComponent
        let pathExtension = url.pathExtension
        var suffix = 2

        while true {
            let candidateName = pathExtension.isEmpty
                ? "\(baseName) \(suffix)"
                : "\(baseName) \(suffix).\(pathExtension)"
            let candidateURL = directory.appendingPathComponent(candidateName)
            if !fileManager.fileExists(atPath: candidateURL.path) {
                return candidateURL
            }
            suffix += 1
        }
    }
}
