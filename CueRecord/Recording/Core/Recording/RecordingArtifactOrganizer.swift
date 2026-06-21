import CoreGraphics
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

nonisolated enum RecordingExportResolutionPreset: String, CaseIterable, Identifiable, Sendable {
    case p720
    case p1080
    case p4K

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .p720:
            return "720p"
        case .p1080:
            return "1080p"
        case .p4K:
            return "4K"
        }
    }

    private var maxLongEdge: CGFloat {
        switch self {
        case .p720:
            return 1280
        case .p1080:
            return 1920
        case .p4K:
            return 3840
        }
    }

    func outputSize(for sourceSize: CGSize) -> CGSize {
        let sourceWidth = max(abs(sourceSize.width), 2)
        let sourceHeight = max(abs(sourceSize.height), 2)
        let sourceLongEdge = max(sourceWidth, sourceHeight)
        let scale = sourceLongEdge > maxLongEdge ? maxLongEdge / sourceLongEdge : 1

        return CGSize(
            width: Self.evenPixelDimension(sourceWidth * scale),
            height: Self.evenPixelDimension(sourceHeight * scale)
        )
    }

    private static func evenPixelDimension(_ value: CGFloat) -> Int {
        max(2, Int(value.rounded(.toNearestOrAwayFromZero)) / 2 * 2)
    }
}

nonisolated enum RecordingExportBitRatePreset: String, CaseIterable, Identifiable, Sendable {
    case low
    case medium
    case high

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }

    var compressionQuality: Double {
        switch self {
        case .low:
            return 0.76
        case .medium:
            return 0.86
        case .high:
            return 0.94
        }
    }

    func averageBitRate(for outputSize: CGSize) -> Int {
        let totalPixels = max(Int(outputSize.width * outputSize.height), 1)
        let bitsPerPixel: Double
        let minimumBitRate: Int

        switch self {
        case .low:
            bitsPerPixel = 2.0
            minimumBitRate = 2_500_000
        case .medium:
            bitsPerPixel = 3.0
            minimumBitRate = 4_000_000
        case .high:
            bitsPerPixel = 5.0
            minimumBitRate = 8_000_000
        }

        return max(minimumBitRate, Int(Double(totalPixels) * bitsPerPixel))
    }
}

nonisolated struct RecordingExportSettings: Equatable, Sendable {
    var resolutionPreset: RecordingExportResolutionPreset
    var bitRatePreset: RecordingExportBitRatePreset

    static let `default` = RecordingExportSettings(
        resolutionPreset: .p4K,
        bitRatePreset: .medium
    )

    func outputSize(for sourceSize: CGSize) -> CGSize {
        resolutionPreset.outputSize(for: sourceSize)
    }

    func averageBitRate(for outputSize: CGSize) -> Int {
        bitRatePreset.averageBitRate(for: outputSize)
    }

    func outputDimensionsText(for sourceSize: CGSize) -> String {
        let outputSize = outputSize(for: sourceSize)
        return "\(Int(outputSize.width)) x \(Int(outputSize.height))"
    }
}

nonisolated struct CapturedRecordingOutput: Sendable {
    let outputURL: URL
    let cameraURL: URL?
    let overlayMetadataURL: URL?

    init(outputURL: URL, cameraURL: URL?, overlayMetadataURL: URL?) {
        self.outputURL = outputURL
        self.cameraURL = cameraURL
        self.overlayMetadataURL = overlayMetadataURL
    }

    init?(discovering outputURL: URL, fileManager: FileManager = .default) {
        guard fileManager.fileExists(atPath: outputURL.path) else { return nil }

        let basePath = outputURL.deletingPathExtension().path
        let fileExtension = outputURL.pathExtension
        let cameraURL = URL(fileURLWithPath: "\(basePath)_camera.\(fileExtension)")
        let overlayURL = URL(fileURLWithPath: "\(basePath)_overlay.json")

        self.init(
            outputURL: outputURL,
            cameraURL: fileManager.fileExists(atPath: cameraURL.path) ? cameraURL : nil,
            overlayMetadataURL: fileManager.fileExists(atPath: overlayURL.path) ? overlayURL : nil
        )
    }

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
        let outputDirectory = capturedOutput.outputURL.deletingLastPathComponent()
        let sessionDirectory = outputDirectory.lastPathComponent == rawDataDirectoryName
            ? outputDirectory.deletingLastPathComponent()
            : outputDirectory
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
