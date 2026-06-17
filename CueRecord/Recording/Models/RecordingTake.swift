import Foundation

struct RecordingTake: Identifiable {
    let takeNumber: Int
    let capturedOutput: CapturedRecordingOutput
    let createdAt: Date?
    let sessionDirectoryName: String

    var id: String {
        capturedOutput.outputURL.standardizedFileURL.path
    }
}

enum RecordingTakeDiscovery {
    static func takes(
        projectURL: URL,
        projectTitle: String,
        markdownTitle: String,
        fileManager: FileManager = .default
    ) -> [RecordingTake] {
        let expectedSessionName = sanitizedRecordingPathComponent("\(projectTitle) - \(markdownTitle)")
        let expectedPageSuffix = " - \(sanitizedRecordingPathComponent(markdownTitle))"

        let sessionDirectories = ((try? fileManager.contentsOfDirectory(
            at: projectURL,
            includingPropertiesForKeys: [.isDirectoryKey, .creationDateKey, .contentModificationDateKey],
            options: [.skipsHiddenFiles]
        )) ?? [])
        .filter { url in
            let values = try? url.resourceValues(forKeys: [.isDirectoryKey])
            guard values?.isDirectory == true else { return false }
            return matchesSessionDirectory(
                name: url.lastPathComponent,
                expectedSessionName: expectedSessionName,
                expectedPageSuffix: expectedPageSuffix
            )
        }

        var discovered: [(output: CapturedRecordingOutput, createdAt: Date?, sessionName: String)] = []
        var seenPaths = Set<String>()

        for sessionDirectory in sessionDirectories {
            let rawDataDirectory = sessionDirectory.appendingPathComponent(
                RecordingArtifactOrganizer.rawDataDirectoryName,
                isDirectory: true
            )
            for directory in [rawDataDirectory, sessionDirectory] {
                for outputURL in primaryScreenRecordingURLs(in: directory, fileManager: fileManager) {
                    let path = outputURL.standardizedFileURL.path
                    guard !seenPaths.contains(path),
                          let output = CapturedRecordingOutput(discovering: outputURL, fileManager: fileManager)
                    else {
                        continue
                    }

                    seenPaths.insert(path)
                    discovered.append((
                        output: output,
                        createdAt: creationDate(for: outputURL),
                        sessionName: sessionDirectory.lastPathComponent
                    ))
                }
            }
        }

        let chronological = discovered.sorted { lhs, rhs in
            switch (lhs.createdAt, rhs.createdAt) {
            case let (lhsDate?, rhsDate?):
                return lhsDate < rhsDate
            case (_?, nil):
                return true
            case (nil, _?):
                return false
            case (nil, nil):
                return lhs.output.outputURL.path.localizedStandardCompare(rhs.output.outputURL.path) == .orderedAscending
            }
        }

        return chronological
            .enumerated()
            .map { index, item in
                RecordingTake(
                    takeNumber: index + 1,
                    capturedOutput: item.output,
                    createdAt: item.createdAt,
                    sessionDirectoryName: item.sessionName
                )
            }
            .sorted { lhs, rhs in
                switch (lhs.createdAt, rhs.createdAt) {
                case let (lhsDate?, rhsDate?):
                    return lhsDate > rhsDate
                case (_?, nil):
                    return true
                case (nil, _?):
                    return false
                case (nil, nil):
                    return lhs.takeNumber > rhs.takeNumber
                }
            }
    }

    private static func primaryScreenRecordingURLs(in directory: URL, fileManager: FileManager) -> [URL] {
        guard fileManager.fileExists(atPath: directory.path) else { return [] }

        return ((try? fileManager.contentsOfDirectory(
            at: directory,
            includingPropertiesForKeys: [.isRegularFileKey, .creationDateKey, .contentModificationDateKey],
            options: [.skipsHiddenFiles]
        )) ?? [])
        .filter { isPrimaryScreenRecordingFile($0) }
        .sorted { lhs, rhs in
            let lhsDate = creationDate(for: lhs) ?? .distantPast
            let rhsDate = creationDate(for: rhs) ?? .distantPast
            if lhsDate != rhsDate {
                return lhsDate < rhsDate
            }
            return lhs.lastPathComponent.localizedStandardCompare(rhs.lastPathComponent) == .orderedAscending
        }
    }

    private static func isPrimaryScreenRecordingFile(_ url: URL) -> Bool {
        guard url.pathExtension.lowercased() == "mov" else { return false }

        let stem = url.deletingPathExtension().lastPathComponent
        guard stem.hasPrefix("ScreenRecord_")
            || stem.hasPrefix("AreaRecord_")
            || stem.hasPrefix("WindowRecord_")
        else {
            return false
        }

        let generatedSuffixes = [
            "_camera",
            "_camera_only",
            "_composited",
            "_composited_video_tmp",
            "_edited",
            "_edited_video_tmp"
        ]

        return !generatedSuffixes.contains { stem.hasSuffix($0) }
    }

    private static func matchesSessionDirectory(
        name: String,
        expectedSessionName: String,
        expectedPageSuffix: String
    ) -> Bool {
        let baseName = removingNumericSuffix(from: name)
        if baseName == expectedSessionName {
            return true
        }

        return baseName.hasSuffix(expectedPageSuffix)
    }

    private static func removingNumericSuffix(from name: String) -> String {
        guard let range = name.range(of: #" \d+$"#, options: .regularExpression) else {
            return name
        }

        return String(name[..<range.lowerBound])
    }

    private static func creationDate(for url: URL) -> Date? {
        let values = try? url.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
        return values?.creationDate ?? values?.contentModificationDate
    }

    private static func sanitizedRecordingPathComponent(_ value: String) -> String {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return "Untitled" }

        let illegalCharacters = CharacterSet(charactersIn: "/:\\?%*|\"<>")
            .union(.controlCharacters)
            .union(.newlines)

        let sanitizedScalars = trimmed.unicodeScalars.map { scalar -> String in
            illegalCharacters.contains(scalar) ? "-" : String(scalar)
        }

        let collapsed = sanitizedScalars
            .joined()
            .replacingOccurrences(of: "--+", with: "-", options: .regularExpression)
            .trimmingCharacters(in: CharacterSet(charactersIn: ". "))

        if collapsed.isEmpty {
            return "Untitled"
        }

        return String(collapsed.prefix(80))
    }
}
