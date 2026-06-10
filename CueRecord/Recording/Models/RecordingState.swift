import Combine
import CoreGraphics
import Foundation

// MARK: - 导入音频相关模块
// 注意：AudioManager会在后续集成时导入

struct WindowRecordingTarget {
    let windowID: CGWindowID
    let frame: CGRect
    let title: String
    let ownerName: String

    var displayName: String {
        if title.isEmpty {
            return ownerName
        }
        return "\(ownerName) - \(title)"
    }
}

struct ScreenRecordingDisplayTarget: Identifiable, Hashable {
    let id: CGDirectDisplayID
    let frame: CGRect
    let name: String
    let index: Int

    var shortName: String {
        "Display \(index + 1)"
    }

    var displayName: String {
        name.isEmpty ? shortName : name
    }
}

enum RecordingMode {
    case fullScreen
    case selectedArea(CGRect)
    case selectedWindow(WindowRecordingTarget)
}

enum RecordingCaptureMode: CaseIterable, Hashable {
    case fullScreen
    case selectedArea
    case selectedWindow

    var displayName: String {
        switch self {
        case .fullScreen:
            return "Full"
        case .selectedArea:
            return "Area"
        case .selectedWindow:
            return "Window"
        }
    }
}

enum CameraOverlayPosition: CaseIterable, Hashable {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight

    var displayName: String {
        switch self {
        case .topLeft:
            return "Top Left"
        case .topRight:
            return "Top Right"
        case .bottomLeft:
            return "Bottom Left"
        case .bottomRight:
            return "Bottom Right"
        }
    }
}

enum CameraOverlaySize: CaseIterable, Hashable {
    case small   // 180x180
    case medium  // 280x280
    case large   // 400x400
    
    var size: CGSize {
        switch self {
        case .small:
            return CGSize(width: 180, height: 180)
        case .medium:
            return CGSize(width: 280, height: 280)
        case .large:
            return CGSize(width: 400, height: 400)
        }
    }
    
    var displayName: String {
        switch self {
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        }
    }
}

enum CameraOverlayShape: CaseIterable, Hashable {
    case circle
    case roundedSquare
    case roundedBox

    var displayName: String {
        switch self {
        case .circle:
            return "Circle"
        case .roundedSquare:
            return "Rounded Rectangle"
        case .roundedBox:
            return "Rounded Square"
        }
    }
}

enum AreaAspectRatioPreset: CaseIterable, Hashable {
    case sixteenByNine
    case fourByThree
    case threeByFour
    case nineBySixteen
    case square
    case custom

    var title: String {
        switch self {
        case .sixteenByNine:
            return "16:9"
        case .fourByThree:
            return "4:3"
        case .threeByFour:
            return "3:4"
        case .nineBySixteen:
            return "9:16"
        case .square:
            return "1:1"
        case .custom:
            return "Custom"
        }
    }

    var subtitle: String {
        switch self {
        case .sixteenByNine:
            return "YouTube"
        case .fourByThree:
            return "Classic"
        case .threeByFour:
            return "RedNote"
        case .nineBySixteen:
            return "TikTok"
        case .square:
            return "Square"
        case .custom:
            return "Free"
        }
    }

    var aspectRatio: CGFloat? {
        switch self {
        case .sixteenByNine:
            return 16.0 / 9.0
        case .fourByThree:
            return 4.0 / 3.0
        case .threeByFour:
            return 3.0 / 4.0
        case .nineBySixteen:
            return 9.0 / 16.0
        case .square:
            return 1.0
        case .custom:
            return nil
        }
    }
}

struct CameraOverlaySnapshot {
    let frame: CGRect
    let shape: CameraOverlayShape
    let size: CameraOverlaySize
}

@MainActor
class RecordingState: ObservableObject {
    @Published var isRecording = false
    @Published var recordingMode: RecordingMode = .fullScreen
    @Published var selectedArea: CGRect = .zero
    @Published var selectedWindowTarget: WindowRecordingTarget?
    @Published var selectedDisplayID: CGDirectDisplayID?
    
    // 音频设置
    @Published var microphoneEnabled = true
    @Published var systemAudioEnabled = true

    // 录制模式设置
    @Published var captureMode: RecordingCaptureMode = .fullScreen

    // 区域录制比例
    @Published var areaAspectRatioPreset: AreaAspectRatioPreset = .custom
    
    // 摄像头叠加层设置
    @Published var cameraOverlayEnabled = true
    @Published var cameraOverlayPosition: CameraOverlayPosition = .topRight
    @Published var cameraOverlaySize: CameraOverlaySize = .medium
    @Published var cameraOverlayShape: CameraOverlayShape = .circle
    @Published var customCameraOverlayFrame: CGRect?
    
    // 输出设置
    @Published var outputDirectory = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first ?? URL(fileURLWithPath: NSHomeDirectory())
    @Published var outputSessionName = ""
    
    // 录制状态
    @Published var recordingDuration: TimeInterval = 0
    @Published var recordingStartTime: Date?
    private var activeOutputSessionDirectory: URL?
    private var activeOutputTimestamp: String?
    
    private var outputTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        if let activeOutputTimestamp {
            return activeOutputTimestamp
        }
        return formatter.string(from: recordingStartTime ?? Date())
    }

    var outputSessionFolderName: String {
        let sanitizedName = sanitizedPathComponent(outputSessionName)
        if !sanitizedName.isEmpty {
            return sanitizedName
        }

        switch recordingMode {
        case .fullScreen:
            return "ScreenRecord_\(outputTimestamp)"
        case .selectedArea(_):
            return "AreaRecord_\(outputTimestamp)"
        case .selectedWindow(_):
            return "WindowRecord_\(outputTimestamp)"
        }
    }

    var outputSessionDirectory: URL {
        if let activeOutputSessionDirectory {
            return activeOutputSessionDirectory
        }

        let directory = uniqueOutputSessionDirectory()
        activeOutputSessionDirectory = directory
        return directory
    }

    // 生成输出文件名
    var outputFileName: String {
        switch recordingMode {
        case .fullScreen:
            return "ScreenRecord_\(outputTimestamp).mov"
        case .selectedArea(_):
            return "AreaRecord_\(outputTimestamp).mov"
        case .selectedWindow(_):
            return "WindowRecord_\(outputTimestamp).mov"
        }
    }
    
    var outputURL: URL {
        let sessionDirectory = outputSessionDirectory
        try? FileManager.default.createDirectory(at: sessionDirectory, withIntermediateDirectories: true)
        return sessionDirectory.appendingPathComponent(outputFileName)
    }
    
    func startRecording() {
        recordingStartTime = Date()
        activeOutputTimestamp = outputTimestamp
        activeOutputSessionDirectory = uniqueOutputSessionDirectory()
        try? FileManager.default.createDirectory(at: outputSessionDirectory, withIntermediateDirectories: true)
        isRecording = true
        recordingDuration = 0
        print("🎬 开始录制: \(outputFileName)")
    }
    
    func stopRecording() {
        isRecording = false
        activeOutputSessionDirectory = nil
        activeOutputTimestamp = nil
        print("⏹️  停止录制，时长: \(String(format: "%.1f", recordingDuration))秒")
    }
    
    func updateRecordingDuration() {
        guard let startTime = recordingStartTime else { return }
        recordingDuration = Date().timeIntervalSince(startTime)
    }

    private func uniqueOutputSessionDirectory() -> URL {
        let baseName = outputSessionFolderName
        var candidate = outputDirectory.appendingPathComponent(baseName, isDirectory: true)
        var suffix = 2

        while FileManager.default.fileExists(atPath: candidate.path) {
            candidate = outputDirectory.appendingPathComponent("\(baseName) \(suffix)", isDirectory: true)
            suffix += 1
        }

        return candidate
    }

    private func sanitizedPathComponent(_ value: String) -> String {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return "" }

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
            return ""
        }

        return String(collapsed.prefix(80))
    }
}
