//
//  CueRecordPathPolicy.swift
//  CueRecord
//

import CryptoKit
import Foundation

enum CueRecordPathPolicy {
    nonisolated private static let maximumComponentLength = 120

    nonisolated static func sanitizedPathComponent(_ value: String, fallback: String = "Untitled") -> String {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        let source = trimmed.isEmpty ? fallback : trimmed
        let illegalCharacters = CharacterSet(charactersIn: "/\\:?%*|\"<>")
            .union(.controlCharacters)
            .union(.newlines)

        var sanitized = source.unicodeScalars
            .map { illegalCharacters.contains($0) ? "-" : String($0) }
            .joined()
            .trimmingCharacters(in: CharacterSet(charactersIn: ". "))

        while sanitized.contains("--") {
            sanitized = sanitized.replacingOccurrences(of: "--", with: "-")
        }

        if sanitized.isEmpty {
            sanitized = fallback
        }

        if isWindowsReservedName(sanitized) {
            sanitized = "_\(sanitized)"
        }

        if sanitized.count > maximumComponentLength {
            sanitized = String(sanitized.prefix(maximumComponentLength))
                .trimmingCharacters(in: CharacterSet(charactersIn: ". "))
        }

        return sanitized.isEmpty ? fallback : sanitized
    }

    nonisolated static func uniqueFileURL(
        in directoryURL: URL,
        title: String,
        pathExtension: String,
        excluding excludedURL: URL? = nil,
        fileManager: FileManager = .default
    ) -> URL {
        let baseName = sanitizedPathComponent(title)
        let normalizedExtension = pathExtension.trimmingCharacters(in: CharacterSet(charactersIn: "."))
        var candidate = directoryURL.appendingPathComponent(baseName).appendingPathExtension(normalizedExtension)
        var suffix = 2

        while fileManager.fileExists(atPath: candidate.path),
              !isSameFileURL(candidate, excludedURL) {
            candidate = directoryURL
                .appendingPathComponent("\(baseName) \(suffix)")
                .appendingPathExtension(normalizedExtension)
            suffix += 1
        }

        return candidate
    }

    nonisolated static func uniqueDirectoryURL(
        in directoryURL: URL,
        title: String,
        excluding excludedURL: URL? = nil,
        fileManager: FileManager = .default
    ) -> URL {
        let baseName = sanitizedPathComponent(title, fallback: "Untitled Project")
        var candidate = directoryURL.appendingPathComponent(baseName, isDirectory: true)
        var suffix = 2

        while fileManager.fileExists(atPath: candidate.path),
              !isSameFileURL(candidate, excludedURL) {
            candidate = directoryURL.appendingPathComponent("\(baseName) \(suffix)", isDirectory: true)
            suffix += 1
        }

        return candidate
    }

    nonisolated static func contentHash(_ text: String) -> String {
        contentHash(Data(text.utf8))
    }

    nonisolated static func contentHash(_ data: Data) -> String {
        SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
    }

    nonisolated static func isSameFileURL(_ lhs: URL, _ rhs: URL?) -> Bool {
        guard let rhs else { return false }
        return lhs.standardizedFileURL.path == rhs.standardizedFileURL.path
    }

    nonisolated private static func isWindowsReservedName(_ component: String) -> Bool {
        let stem = component.split(separator: ".", maxSplits: 1, omittingEmptySubsequences: false)
            .first
            .map(String.init) ?? component
        let lowercasedStem = stem.lowercased()

        if ["con", "prn", "aux", "nul"].contains(lowercasedStem) {
            return true
        }

        if lowercasedStem.count == 4,
           let prefix = lowercasedStem.first,
           prefix == "l" || prefix == "c" {
            let expectedPrefix = prefix == "l" ? "lpt" : "com"
            guard lowercasedStem.hasPrefix(expectedPrefix),
                  let digit = lowercasedStem.last,
                  ("1"..."9").contains(String(digit)) else {
                return false
            }
            return true
        }

        return false
    }
}
