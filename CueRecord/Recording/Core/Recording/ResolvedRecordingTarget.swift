import CoreGraphics
import Foundation

nonisolated struct RecordingDisplayGeometry: Equatable, Sendable {
    let id: CGDirectDisplayID
    let frame: CGRect
    let name: String
    let index: Int

    init(id: CGDirectDisplayID, frame: CGRect, name: String = "", index: Int = 0) {
        self.id = id
        self.frame = frame
        self.name = name
        self.index = index
    }
}

nonisolated struct ResolvedRecordingTarget: Equatable, Sendable {
    enum Kind: String, Sendable {
        case display
        case area
        case window
    }

    let kind: Kind
    let displayID: CGDirectDisplayID?
    let displayFrame: CGRect
    let captureFrame: CGRect
    let modeName: String

    var interfaceFrame: CGRect {
        displayFrame.isEmpty ? captureFrame : displayFrame
    }

    var overlayFrame: CGRect {
        captureFrame.isEmpty ? interfaceFrame : captureFrame
    }

    static func display(_ display: RecordingDisplayGeometry) -> ResolvedRecordingTarget {
        ResolvedRecordingTarget(
            kind: .display,
            displayID: display.id,
            displayFrame: display.frame,
            captureFrame: display.frame,
            modeName: "fullScreen"
        )
    }

    static func area(
        _ rect: CGRect,
        displays: [RecordingDisplayGeometry],
        fallbackDisplay: RecordingDisplayGeometry?
    ) -> ResolvedRecordingTarget {
        let display = displayContaining(rect, in: displays) ?? fallbackDisplay
        return ResolvedRecordingTarget(
            kind: .area,
            displayID: display?.id,
            displayFrame: display?.frame ?? rect,
            captureFrame: rect,
            modeName: "selectedArea"
        )
    }

    static func window(
        _ target: WindowRecordingTarget,
        displays: [RecordingDisplayGeometry],
        fallbackDisplay: RecordingDisplayGeometry?
    ) -> ResolvedRecordingTarget {
        let display = displayContaining(target.frame, in: displays) ?? fallbackDisplay
        return ResolvedRecordingTarget(
            kind: .window,
            displayID: display?.id,
            displayFrame: display?.frame ?? target.frame,
            captureFrame: target.frame,
            modeName: "selectedWindow"
        )
    }

    static func resolve(
        mode: RecordingMode,
        selectedDisplayID: CGDirectDisplayID?,
        displays: [RecordingDisplayGeometry]
    ) -> ResolvedRecordingTarget? {
        let selectedDisplay = selectedDisplayID.flatMap { id in displays.first { $0.id == id } }
        let fallbackDisplay = selectedDisplay ?? displays.first

        switch mode {
        case .fullScreen:
            guard let display = fallbackDisplay else { return nil }
            return .display(display)
        case .selectedArea(let rect):
            return .area(rect, displays: displays, fallbackDisplay: fallbackDisplay)
        case .selectedWindow(let target):
            return .window(target, displays: displays, fallbackDisplay: fallbackDisplay)
        }
    }

    static func displayContaining(
        _ rect: CGRect,
        in displays: [RecordingDisplayGeometry]
    ) -> RecordingDisplayGeometry? {
        displays
            .filter { !$0.frame.intersection(rect).isNull }
            .max { lhs, rhs in
                lhs.frame.intersection(rect).recordingArea < rhs.frame.intersection(rect).recordingArea
            }
    }

    func floatingControlFrame(size: CGSize, margin: CGFloat = 24) -> CGRect {
        let bounds = interfaceFrame
        return CGRect(
            x: bounds.maxX - size.width - margin,
            y: bounds.minY + margin,
            width: size.width,
            height: size.height
        )
    }

    func previewBarFrame(size: CGSize, bottomOffset: CGFloat = 112) -> CGRect {
        let bounds = interfaceFrame
        return CGRect(
            x: bounds.midX - size.width / 2,
            y: bounds.minY + bottomOffset,
            width: size.width,
            height: size.height
        )
    }
}

private extension CGRect {
    var recordingArea: CGFloat {
        guard !isNull else { return 0 }
        return max(0, width) * max(0, height)
    }
}
