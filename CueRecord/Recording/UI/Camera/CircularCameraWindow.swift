import Cocoa
import Combine
import SwiftUI
import AVFoundation

@MainActor
private final class CameraOverlayWindow: NSWindow {
    weak var cameraWindowController: CircularCameraWindow?

    override func mouseDown(with event: NSEvent) {
        guard event.type == .leftMouseDown else {
            super.mouseDown(with: event)
            return
        }

        cameraWindowController?.beginCameraDrag(mouseLocation: NSEvent.mouseLocation)
    }

    override func mouseDragged(with event: NSEvent) {
        guard event.type == .leftMouseDragged else {
            super.mouseDragged(with: event)
            return
        }

        cameraWindowController?.dragCamera(to: NSEvent.mouseLocation)
    }

    override func mouseUp(with event: NSEvent) {
        cameraWindowController?.endCameraDrag()
        super.mouseUp(with: event)
    }
}

private enum CameraOverlayMetrics {
    static let circleRenderOutset: CGFloat = 4
    static let roundedRenderOutset: CGFloat = 12

    static func renderOutset(for shape: CameraOverlayShape) -> CGFloat {
        switch shape {
        case .circle:
            return circleRenderOutset
        case .roundedSquare, .roundedBox:
            return roundedRenderOutset
        }
    }

    static func cornerRadius(for shape: CameraOverlayShape, side: CGFloat) -> CGFloat {
        switch shape {
        case .circle:
            return 0
        case .roundedSquare:
            return min(max(18, side * 0.16), side * 0.24)
        case .roundedBox:
            return min(max(18, side * 0.16), side * 0.24)
        }
    }
}

@MainActor
class CircularCameraWindow: NSObject {
    private var cameraWindow: CameraOverlayWindow?
    private let cameraManager: CameraManager
    private var cameraSize: CameraOverlaySize = .medium
    private var cameraShape: CameraOverlayShape = .circle
    private var cameraPosition: CameraOverlayPosition = .topRight
    private var currentRecordingRect: CGRect?
    private var onFrameChange: ((CGRect) -> Void)?
    private var dragStartOrigin: NSPoint?
    private var dragStartMouseLocation: NSPoint?
    private let fallbackCameraAspectRatio: CGFloat = 16.0 / 9.0
    private let overlayWindowLevel: NSWindow.Level = .screenSaver + 2
    
    init(cameraManager: CameraManager) {
        self.cameraManager = cameraManager
        super.init()
    }

    var currentWindowSize: NSSize {
        cameraWindow?.frame.size ?? NSSize(width: CameraOverlaySize.medium.size.width, height: CameraOverlaySize.medium.size.height)
    }

    func metadataSnapshot() -> CameraOverlaySnapshot? {
        guard let window = cameraWindow else { return nil }
        return CameraOverlaySnapshot(frame: visibleOverlayFrame(for: window.frame), shape: cameraShape, size: cameraSize)
    }
    
    func show(
        at position: CameraOverlayPosition,
        size: CameraOverlaySize,
        shape: CameraOverlayShape,
        recordingRect: CGRect? = nil,
        customFrame: CGRect? = nil,
        onFrameChange: ((CGRect) -> Void)? = nil
    ) {
        print("🎥 显示摄像头窗口: \(shape.displayName)...")
        let previousSize = cameraWindow?.frame.size
        let previousShape = cameraShape
        cameraSize = size
        cameraShape = shape
        cameraPosition = position
        currentRecordingRect = recordingRect
        self.onFrameChange = onFrameChange
        
        // 计算窗口位置和大小
        let windowSize = constrainedOverlayWindowSize(for: size, shape: shape, recordingRect: recordingRect)
        let windowOrigin = resolvedWindowOrigin(
            for: position,
            windowSize: windowSize,
            recordingRect: recordingRect,
            customFrame: customFrame
        )
        let windowRect = NSRect(origin: windowOrigin, size: windowSize)

        if let window = cameraWindow {
            window.level = overlayWindowLevel
            window.isMovableByWindowBackground = false
            window.ignoresMouseEvents = false
            window.setFrame(windowRect, display: true, animate: false)

            if previousShape != shape || !sizesMatch(previousSize, windowSize) {
                updateContentView(size: windowSize, shape: shape)
            }

            window.orderFrontRegardless()
            print("✅ 摄像头窗口已更新 - 位置: \(position), 大小: \(windowSize), 形状: \(shape.displayName)")
            return
        }
        
        // 创建窗口
        cameraWindow = CameraOverlayWindow(
            contentRect: windowRect,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        guard let window = cameraWindow else { return }
        window.cameraWindowController = self
        
        // Keep the camera above the editable region frame so it receives drag events.
        window.level = overlayWindowLevel
        window.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        window.isMovableByWindowBackground = false
        window.backgroundColor = .clear
        window.isOpaque = false
        window.hasShadow = false
        window.ignoresMouseEvents = false
        window.isReleasedWhenClosed = false
        window.sharingType = .none
        
        updateContentView(size: windowSize, shape: shape)
        
        // 显示窗口
        window.orderFrontRegardless()
        
        print("✅ 摄像头窗口已显示 - 位置: \(position), 大小: \(windowSize), 形状: \(shape.displayName)")
    }
    
    func hide() {
        print("🎥 隐藏圆形摄像头窗口...")
        cameraWindow?.close()
        cameraWindow = nil
        dragStartOrigin = nil
        dragStartMouseLocation = nil
        onFrameChange = nil
    }
    
    func resizeWindow(to size: CameraOverlaySize) {
        guard let window = cameraWindow else { return }
        
        print("🔄 调整摄像头窗口大小为: \(size)")
        cameraSize = size
        
        let newSize = constrainedOverlayWindowSize(for: size, shape: cameraShape, recordingRect: currentRecordingRect)
        let currentFrame = window.frame
        
        // 保持窗口中心位置不变
        let centeredOrigin = NSPoint(
            x: currentFrame.midX - newSize.width / 2,
            y: currentFrame.midY - newSize.height / 2
        )
        let newOrigin = clampedOriginForCurrentBounds(centeredOrigin, windowSize: newSize)
        
        let newFrame = NSRect(origin: newOrigin, size: NSSize(width: newSize.width, height: newSize.height))
        window.setFrame(newFrame, display: true, animate: true)
        notifyFrameChange(visibleOverlayFrame(for: newFrame))
        
        updateContentView(size: newSize, shape: cameraShape)
    }

    func updateShape(to shape: CameraOverlayShape) {
        guard let window = cameraWindow else { return }

        print("🔄 调整摄像头窗口形状为: \(shape.displayName)")
        cameraShape = shape

        let currentFrame = window.frame
        let newSize = constrainedOverlayWindowSize(for: cameraSize, shape: shape, recordingRect: currentRecordingRect)
        let centeredOrigin = NSPoint(
            x: currentFrame.midX - newSize.width / 2,
            y: currentFrame.midY - newSize.height / 2
        )
        let newOrigin = clampedOriginForCurrentBounds(centeredOrigin, windowSize: newSize)
        let newFrame = NSRect(origin: newOrigin, size: newSize)
        window.setFrame(newFrame, display: true, animate: true)
        notifyFrameChange(visibleOverlayFrame(for: newFrame))

        updateContentView(size: newSize, shape: shape)
    }

    func updateAspectRatioIfNeeded(to aspectRatio: CGFloat) {
        guard cameraShape == .roundedSquare, let window = cameraWindow else { return }

        let newSize = constrainedOverlayWindowSize(
            for: cameraSize,
            shape: cameraShape,
            aspectRatio: aspectRatio,
            recordingRect: currentRecordingRect
        )
        let currentSize = window.frame.size
        let currentAspect = currentSize.width / max(currentSize.height, 1)
        let expectedAspect = newSize.width / max(newSize.height, 1)

        guard abs(currentAspect - expectedAspect) > 0.03 else { return }

        let currentFrame = window.frame
        let centeredOrigin = NSPoint(
            x: currentFrame.midX - newSize.width / 2,
            y: currentFrame.midY - newSize.height / 2
        )
        let newOrigin = clampedOriginForCurrentBounds(centeredOrigin, windowSize: newSize)
        let newFrame = NSRect(origin: newOrigin, size: newSize)
        window.setFrame(newFrame, display: true, animate: false)
        notifyFrameChange(visibleOverlayFrame(for: newFrame))

        updateContentView(size: newSize, shape: cameraShape)
    }

    func beginCameraDrag(mouseLocation: NSPoint = NSEvent.mouseLocation) {
        dragStartOrigin = cameraWindow?.frame.origin
        dragStartMouseLocation = mouseLocation
    }

    func dragCamera(to mouseLocation: NSPoint = NSEvent.mouseLocation) {
        guard let window = cameraWindow else { return }

        if dragStartOrigin == nil || dragStartMouseLocation == nil {
            dragStartOrigin = window.frame.origin
            dragStartMouseLocation = mouseLocation
        }

        let startOrigin = dragStartOrigin ?? window.frame.origin
        let startMouseLocation = dragStartMouseLocation ?? mouseLocation
        let proposedOrigin = NSPoint(
            x: startOrigin.x + mouseLocation.x - startMouseLocation.x,
            y: startOrigin.y + mouseLocation.y - startMouseLocation.y
        )
        let clamped = clampedOriginForCurrentBounds(proposedOrigin, windowSize: window.frame.size)
        let newFrame = NSRect(origin: clamped, size: window.frame.size)
        window.setFrame(newFrame, display: true, animate: false)
        notifyFrameChange(visibleOverlayFrame(for: newFrame))
    }

    func endCameraDrag() {
        dragStartOrigin = nil
        dragStartMouseLocation = nil
    }

    private func updateContentView(size: NSSize, shape: CameraOverlayShape) {
        guard let window = cameraWindow else { return }

        let contentView = NSHostingView(
            rootView: CameraOverlayView(cameraManager: cameraManager, windowController: self, shape: cameraShape)
                .frame(width: size.width, height: size.height)
        )
        contentView.layer?.backgroundColor = NSColor.clear.cgColor
        window.contentView = contentView
    }

    private func overlayContentSize(for size: CameraOverlaySize, shape: CameraOverlayShape, aspectRatio: CGFloat? = nil) -> NSSize {
        let baseSide = size.size.width

        guard shape == .roundedSquare else {
            return NSSize(width: baseSide, height: baseSide)
        }

        let rawAspectRatio = aspectRatio ?? cameraManager.currentFrameAspectRatio ?? fallbackCameraAspectRatio
        let cameraAspectRatio = min(max(rawAspectRatio, 0.75), 2.20)

        if cameraAspectRatio >= 1 {
            return NSSize(width: round(baseSide * cameraAspectRatio), height: baseSide)
        } else {
            return NSSize(width: baseSide, height: round(baseSide / cameraAspectRatio))
        }
    }

    private func constrainedOverlayWindowSize(
        for size: CameraOverlaySize,
        shape: CameraOverlayShape,
        aspectRatio: CGFloat? = nil,
        recordingRect: CGRect?
    ) -> NSSize {
        let desiredContentSize = overlayContentSize(for: size, shape: shape, aspectRatio: aspectRatio)
        let outset = CameraOverlayMetrics.renderOutset(for: shape)
        guard let recordingRect else {
            return NSSize(
                width: desiredContentSize.width + outset * 2,
                height: desiredContentSize.height + outset * 2
            )
        }

        let margin = cameraMargin(for: recordingRect)
        let maxWidth = max(24, recordingRect.width - margin * 2 - outset * 2)
        let maxHeight = max(24, recordingRect.height - margin * 2 - outset * 2)
        let scale = min(1, maxWidth / desiredContentSize.width, maxHeight / desiredContentSize.height)

        return NSSize(
            width: max(1, floor(desiredContentSize.width * scale + outset * 2)),
            height: max(1, floor(desiredContentSize.height * scale + outset * 2))
        )
    }

    private func resolvedWindowOrigin(
        for position: CameraOverlayPosition,
        windowSize: NSSize,
        recordingRect: CGRect?,
        customFrame: CGRect?
    ) -> NSPoint {
        if let customFrame {
            let centeredOrigin = NSPoint(
                x: customFrame.midX - windowSize.width / 2,
                y: customFrame.midY - windowSize.height / 2
            )
            return clampedOriginForCurrentBounds(centeredOrigin, windowSize: windowSize)
        }

        return calculateWindowOrigin(for: position, windowSize: windowSize, recordingRect: recordingRect)
    }
    
    private func calculateWindowOrigin(for position: CameraOverlayPosition, windowSize: NSSize, recordingRect: CGRect?) -> NSPoint {
        // 如果是区域录制，基于录制区域定位
        if let recordingRect = recordingRect {
            let margin = cameraMargin(for: recordingRect)
            print("🎯 基于录制区域定位摄像头: \(recordingRect)")

            let proposedOrigin: NSPoint
            switch position {
            case .topLeft:
                proposedOrigin = NSPoint(
                    x: recordingRect.minX + margin,
                    y: recordingRect.maxY - windowSize.height - margin
                )
            case .topRight:
                proposedOrigin = NSPoint(
                    x: recordingRect.maxX - windowSize.width - margin,
                    y: recordingRect.maxY - windowSize.height - margin
                )
            case .bottomLeft:
                proposedOrigin = NSPoint(
                    x: recordingRect.minX + margin,
                    y: recordingRect.minY + margin
                )
            case .bottomRight:
                proposedOrigin = NSPoint(
                    x: recordingRect.maxX - windowSize.width - margin,
                    y: recordingRect.minY + margin
                )
            }

            return clampedOrigin(proposedOrigin, windowSize: windowSize, inside: recordingRect, margin: margin)
        } else {
            // 全屏录制，基于整个屏幕定位
            guard let screen = NSScreen.main else {
                return NSPoint(x: 100, y: 100)
            }
            
            let margin: CGFloat = 20
            let screenFrame = screen.frame
            
            switch position {
            case .topLeft:
                return NSPoint(
                    x: screenFrame.minX + margin,
                    y: screenFrame.maxY - windowSize.height - margin - 30  // 留出菜单栏空间
                )
            case .topRight:
                return NSPoint(
                    x: screenFrame.maxX - windowSize.width - margin,
                    y: screenFrame.maxY - windowSize.height - margin - 30
                )
            case .bottomLeft:
                return NSPoint(
                    x: screenFrame.minX + margin,
                    y: screenFrame.minY + margin
                )
            case .bottomRight:
                return NSPoint(
                    x: screenFrame.maxX - windowSize.width - margin,
                    y: screenFrame.minY + margin
                )
            }
        }
    }

    private func clampedOriginForCurrentBounds(_ origin: NSPoint, windowSize: NSSize) -> NSPoint {
        if let currentRecordingRect {
            return clampedOrigin(origin, windowSize: windowSize, inside: currentRecordingRect, margin: 0)
        }

        guard let screen = NSScreen.screens.first(where: { $0.frame.contains(origin) }) ?? NSScreen.main else {
            return origin
        }
        return clampedOrigin(origin, windowSize: windowSize, inside: screen.frame, margin: 0)
    }

    private func clampedOrigin(_ origin: NSPoint, windowSize: NSSize, inside rect: CGRect, margin: CGFloat) -> NSPoint {
        let minX = rect.minX + margin
        let maxX = rect.maxX - margin - windowSize.width
        let minY = rect.minY + margin
        let maxY = rect.maxY - margin - windowSize.height

        let x = min(max(origin.x, minX), max(minX, maxX))
        let y = min(max(origin.y, minY), max(minY, maxY))
        return NSPoint(x: x, y: y)
    }

    private func cameraMargin(for recordingRect: CGRect) -> CGFloat {
        min(20, max(4, min(recordingRect.width, recordingRect.height) * 0.08))
    }

    private func visibleOverlayFrame(for windowFrame: CGRect) -> CGRect {
        let desiredOutset = CameraOverlayMetrics.renderOutset(for: cameraShape)
        let maxOutset = max(0, min(windowFrame.width, windowFrame.height) / 2 - 1)
        let outset = min(desiredOutset, maxOutset)
        return windowFrame.insetBy(dx: outset, dy: outset)
    }

    private func sizesMatch(_ lhs: NSSize?, _ rhs: NSSize) -> Bool {
        guard let lhs else { return false }
        return abs(lhs.width - rhs.width) < 0.5 && abs(lhs.height - rhs.height) < 0.5
    }

    private func notifyFrameChange(_ frame: CGRect) {
        onFrameChange?(frame)
    }
}

// MARK: - 摄像头叠加视图
struct CameraOverlayView: View {
    @ObservedObject var cameraManager: CameraManager
    weak var windowController: CircularCameraWindow?
    let shape: CameraOverlayShape
    @State private var updateTimer = Timer.publish(every: 0.033, on: .main, in: .common).autoconnect() // 30fps
    @State private var currentImage: NSImage?
    @State private var showSizeMenu = false

    private var roundedShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: roundedCornerRadius, style: .continuous)
    }

    private var roundedCornerRadius: CGFloat {
        guard shape != .circle else { return 0 }

        return CameraOverlayMetrics.cornerRadius(for: shape, side: currentContentMinSide)
    }

    private var currentContentMinSide: CGFloat {
        let windowSize = windowController?.currentWindowSize ?? NSSize(width: CameraOverlaySize.medium.size.width, height: CameraOverlaySize.medium.size.height)
        let inset = CameraOverlayMetrics.renderOutset(for: shape)
        return max(1, min(windowSize.width, windowSize.height) - inset * 2)
    }

    private var currentContentSize: CGSize {
        let windowSize = windowController?.currentWindowSize ?? NSSize(width: CameraOverlaySize.medium.size.width, height: CameraOverlaySize.medium.size.height)
        let inset = CameraOverlayMetrics.renderOutset(for: shape)

        return CGSize(
            width: max(1, windowSize.width - inset * 2),
            height: max(1, windowSize.height - inset * 2)
        )
    }

    private var renderOutset: CGFloat {
        CameraOverlayMetrics.renderOutset(for: shape)
    }
    
    var body: some View {
        ZStack {
            // 透明背景
            Color.clear
            
            cameraSurface
            
            // 右键菜单提示
            contextMenuHitArea
        }
        .contentShape(Rectangle())
        .onReceive(updateTimer) { _ in
            updateCameraImage()
        }
    }

    @ViewBuilder
    private var cameraSurface: some View {
        switch shape {
        case .circle:
            cameraContent
                .frame(width: currentContentSize.width, height: currentContentSize.height)
                .contentShape(Circle())
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                )
                .padding(renderOutset)
        case .roundedSquare, .roundedBox:
            cameraContent
                .frame(width: currentContentSize.width, height: currentContentSize.height)
                .contentShape(roundedShape)
                .clipShape(roundedShape)
                .overlay(roundedInnerStroke)
                .shadow(color: .black.opacity(0.24), radius: 7, x: 0, y: 3)
                .padding(renderOutset)
        }
    }

    @ViewBuilder
    private var cameraContent: some View {
        if let image = currentImage {
            let imageAspectRatio = image.size.width / max(image.size.height, 1)
            Image(nsImage: image)
                .resizable()
                .aspectRatio(imageAspectRatio.isFinite && imageAspectRatio > 0 ? imageAspectRatio : 1, contentMode: .fill)
                .frame(width: currentContentSize.width, height: currentContentSize.height)
                .clipped()
        } else {
            Color.black
                .overlay(placeholderContent)
                .frame(width: currentContentSize.width, height: currentContentSize.height)
        }
    }

    private var placeholderContent: some View {
        VStack {
            Image(systemName: "camera.fill")
                .font(.largeTitle)
                .foregroundColor(.gray)
            Text(uiText("Camera"))
                .foregroundColor(.gray)
                .font(.caption)
        }
    }

    @ViewBuilder
    private var contextMenuHitArea: some View {
        switch shape {
        case .circle:
            Circle()
                .fill(Color.clear)
                .contentShape(Circle())
                .cameraContextMenu(windowController: windowController)
                .padding(renderOutset)
        case .roundedSquare:
            roundedShape
                .fill(Color.clear)
                .contentShape(roundedShape)
                .cameraContextMenu(windowController: windowController)
                .padding(renderOutset)
        case .roundedBox:
            roundedShape
                .fill(Color.clear)
                .contentShape(roundedShape)
                .cameraContextMenu(windowController: windowController)
                .padding(renderOutset)
        }
    }

    private var roundedInnerStroke: some View {
        roundedShape
            .strokeBorder(Color.white.opacity(0.14), lineWidth: 1)
    }
    
    private func updateCameraImage() {
        guard cameraManager.isCapturing,
              let pixelBuffer = cameraManager.getCurrentFrame() else {
            return
        }

        let processedImage = CameraFrameProcessor.mirroredVisibleImage(from: pixelBuffer)

        if shape == .roundedSquare {
            let aspectRatio = processedImage.extent.width / max(processedImage.extent.height, 1)
            if aspectRatio.isFinite, aspectRatio > 0 {
                windowController?.updateAspectRatioIfNeeded(to: aspectRatio)
            }
        }
        
        // 转换CVPixelBuffer到NSImage
        let context = CIContext()
        if let cgImage = context.createCGImage(processedImage.image, from: processedImage.extent) {
            currentImage = NSImage(cgImage: cgImage, size: processedImage.extent.size)
        }
    }
}

private extension View {
    func cameraContextMenu(windowController: CircularCameraWindow?) -> some View {
        self.contextMenu {
            Button(uiText("Small")) {
                windowController?.resizeWindow(to: .small)
            }
            Button(uiText("Medium")) {
                windowController?.resizeWindow(to: .medium)
            }
            Button(uiText("Large")) {
                windowController?.resizeWindow(to: .large)
            }
            Divider()
            Button(uiText("Circle")) {
                windowController?.updateShape(to: .circle)
            }
            Button(uiText("Rounded Rectangle")) {
                windowController?.updateShape(to: .roundedSquare)
            }
            Button(uiText("Rounded Square")) {
                windowController?.updateShape(to: .roundedBox)
            }
        }
    }
}
