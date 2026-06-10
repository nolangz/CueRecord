import CoreVideo
import Foundation

nonisolated enum ScreenCapturePixelFormat: String, CaseIterable, Sendable {
    case bgra
    case yuv420VideoRange
    case yuv420FullRange

    var osType: OSType {
        switch self {
        case .bgra:
            return kCVPixelFormatType_32BGRA
        case .yuv420VideoRange:
            return kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange
        case .yuv420FullRange:
            return kCVPixelFormatType_420YpCbCr8BiPlanarFullRange
        }
    }

    var displayName: String {
        switch self {
        case .bgra:
            return "BGRA"
        case .yuv420VideoRange:
            return "420v"
        case .yuv420FullRange:
            return "420f"
        }
    }
}

nonisolated enum RecordingPixelFormatPolicy {
    static let userDefaultsKey = "recording.capturePixelFormat"
    static let environmentKey = "CUERECORD_CAPTURE_PIXEL_FORMAT"
    static let defaultFormat: ScreenCapturePixelFormat = .bgra

    static func selectedFormat(
        defaults: UserDefaults = .standard,
        environment: [String: String] = ProcessInfo.processInfo.environment
    ) -> ScreenCapturePixelFormat {
        if let value = environment[environmentKey],
           let format = format(from: value) {
            return format
        }

        if let storedValue = defaults.string(forKey: userDefaultsKey),
           let format = format(from: storedValue) {
            return format
        }

        return defaultFormat
    }

    static func format(from value: String) -> ScreenCapturePixelFormat? {
        let normalizedValue = value
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        switch normalizedValue {
        case "bgra", "32bgra":
            return .bgra
        case "420v", "nv12", "yuv420", "yuv420videorange", "video-range":
            return .yuv420VideoRange
        case "420f", "yuv420fullrange", "full-range":
            return .yuv420FullRange
        default:
            return ScreenCapturePixelFormat(rawValue: normalizedValue)
        }
    }
}
