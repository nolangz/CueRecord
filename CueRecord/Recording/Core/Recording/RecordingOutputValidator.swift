import AVFoundation
import Foundation

nonisolated struct RecordingOutputValidation: Codable, Equatable, Sendable {
    let health: RecordingOutputHealth
    let issues: [String]
    let fileSize: Int64?
    let durationSeconds: Double?
}

nonisolated enum RecordingOutputValidator {
    static func validate(
        outputURL: URL,
        expectedMinimumDuration: TimeInterval = 0.5
    ) -> RecordingOutputValidation {
        var issues: [String] = []
        let fileSize = (try? FileManager.default.attributesOfItem(atPath: outputURL.path)[.size] as? NSNumber)?
            .int64Value

        guard FileManager.default.fileExists(atPath: outputURL.path) else {
            return RecordingOutputValidation(
                health: .damaged,
                issues: ["Output file does not exist"],
                fileSize: nil,
                durationSeconds: nil
            )
        }

        if (fileSize ?? 0) <= 0 {
            return RecordingOutputValidation(
                health: .damaged,
                issues: ["Output file is empty"],
                fileSize: fileSize,
                durationSeconds: nil
            )
        }

        let asset = AVURLAsset(url: outputURL)
        let videoTracks = asset.tracks(withMediaType: .video)
        let audioTracks = asset.tracks(withMediaType: .audio)
        let durationSeconds = asset.duration.isValid ? asset.duration.seconds : nil

        if videoTracks.isEmpty {
            issues.append("Output has no video track")
        }

        if let durationSeconds {
            if durationSeconds < expectedMinimumDuration {
                issues.append(String(format: "Output duration is short: %.2fs", durationSeconds))
            }
        } else {
            issues.append("Output duration is unavailable")
        }

        if audioTracks.count > 2 {
            issues.append("Output has more than two audio tracks; mixdown may be needed")
        }

        let health: RecordingOutputHealth
        if videoTracks.isEmpty {
            health = .damaged
        } else if issues.isEmpty {
            health = .healthy
        } else {
            health = .degraded
        }

        return RecordingOutputValidation(
            health: health,
            issues: issues,
            fileSize: fileSize,
            durationSeconds: durationSeconds
        )
    }
}
