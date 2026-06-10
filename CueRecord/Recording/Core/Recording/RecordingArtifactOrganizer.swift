import Foundation

nonisolated struct RecordingPostProcessingResult: Sendable {
    let finalOutputURL: URL
    let didExportCompositedVideo: Bool
    let movedRawArtifactCount: Int
}

nonisolated enum RecordingPostProcessingEvent: Sendable {
    case started(outputURL: URL)
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
