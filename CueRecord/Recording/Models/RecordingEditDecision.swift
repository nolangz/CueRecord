import CoreGraphics
import Foundation

nonisolated enum RecordingEditLayoutMode: String, CaseIterable, Codable, Equatable, Sendable {
    case cameraFullScreen
    case screenFullScreen
    case screenWithCamera

    var label: String {
        switch self {
        case .cameraFullScreen:
            return "Person"
        case .screenFullScreen:
            return "Screen"
        case .screenWithCamera:
            return "Screen + Camera"
        }
    }

    var shortLabel: String {
        switch self {
        case .cameraFullScreen:
            return "Person"
        case .screenFullScreen:
            return "Screen"
        case .screenWithCamera:
            return "Combo"
        }
    }

    var systemImage: String {
        switch self {
        case .cameraFullScreen:
            return "person.crop.rectangle.fill"
        case .screenFullScreen:
            return "rectangle.fill"
        case .screenWithCamera:
            return "rectangle.inset.filled.and.person.filled"
        }
    }

    var requiresCamera: Bool {
        switch self {
        case .cameraFullScreen, .screenWithCamera:
            return true
        case .screenFullScreen:
            return false
        }
    }
}

nonisolated struct RecordingEditNormalizedRect: Codable, Equatable, Sendable {
    var x: Double
    var y: Double
    var width: Double
    var height: Double

    static let defaultCameraFrame = RecordingEditNormalizedRect(x: 0.68, y: 0.08, width: 0.24, height: 0.24)

    init(x: Double, y: Double, width: Double, height: Double) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }

    init(videoRect: CGRect, in outputExtent: CGRect) {
        let normalizedWidth = Double(videoRect.width / max(outputExtent.width, 1))
        let normalizedHeight = Double(videoRect.height / max(outputExtent.height, 1))
        x = Double((videoRect.minX - outputExtent.minX) / max(outputExtent.width, 1))
        y = Double((outputExtent.maxY - videoRect.maxY) / max(outputExtent.height, 1))
        width = normalizedWidth
        height = normalizedHeight
        clamp()
    }

    mutating func clamp() {
        width = min(max(width, 0.08), 0.72)
        height = min(max(height, 0.08), 0.72)
        x = min(max(x, 0), max(0, 1 - width))
        y = min(max(y, 0), max(0, 1 - height))
    }

    func clamped() -> RecordingEditNormalizedRect {
        var copy = self
        copy.clamp()
        return copy
    }

    func videoRect(in outputExtent: CGRect) -> CGRect {
        let clampedRect = clamped()
        let rectWidth = CGFloat(clampedRect.width) * outputExtent.width
        let rectHeight = CGFloat(clampedRect.height) * outputExtent.height
        let rectX = outputExtent.minX + CGFloat(clampedRect.x) * outputExtent.width
        let rectY = outputExtent.maxY - CGFloat(clampedRect.y) * outputExtent.height - rectHeight

        return CGRect(x: rectX, y: rectY, width: rectWidth, height: rectHeight)
    }
}

nonisolated struct RecordingEditCut: Identifiable, Codable, Equatable, Sendable {
    var id: UUID
    var startTime: Double
    var endTime: Double
    var layoutMode: RecordingEditLayoutMode
    var cameraFrame: RecordingEditNormalizedRect
    var cameraShape: CameraOverlayShape

    init(
        id: UUID = UUID(),
        startTime: Double,
        endTime: Double,
        layoutMode: RecordingEditLayoutMode,
        cameraFrame: RecordingEditNormalizedRect,
        cameraShape: CameraOverlayShape
    ) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.layoutMode = layoutMode
        self.cameraFrame = cameraFrame.clamped()
        self.cameraShape = cameraShape
    }

    var duration: Double {
        max(0, endTime - startTime)
    }
}

nonisolated struct RecordingEditDecision: Codable, Equatable, Sendable {
    var cuts: [RecordingEditCut]

    init(cuts: [RecordingEditCut]) {
        self.cuts = cuts
    }
}
