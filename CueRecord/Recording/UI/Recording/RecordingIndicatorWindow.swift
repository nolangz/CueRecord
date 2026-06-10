import Cocoa
import SwiftUI

@MainActor
class RecordingIndicatorWindow: NSObject {
    private var indicatorWindow: NSWindow?
    private var mousePassthroughTimer: Timer?

    func showInteractiveIndicator(
        for recordingRect: CGRect,
        aspectRatio: CGFloat?,
        onChange: @escaping (CGRect) -> Void
    ) {
        showIndicator(for: recordingRect, isInteractive: true, aspectRatio: aspectRatio, onChange: onChange)
    }
    
    func showIndicator(for recordingRect: CGRect) {
        showIndicator(for: recordingRect, isInteractive: false, aspectRatio: nil, onChange: nil)
    }

    private func showIndicator(
        for recordingRect: CGRect,
        isInteractive: Bool,
        aspectRatio: CGFloat?,
        onChange: ((CGRect) -> Void)?
    ) {
        print("📐 显示录制区域指示器...")
        
        // 如果窗口已存在，先关闭
        hideIndicator()
        
        // 创建比录制区域大一些的窗口，这样边框就在录制区域外
        let lineWidth: CGFloat = 2  // 边框线条宽度
        let safeMargin: CGFloat = 3  // 安全边距
        let margin: CGFloat = isInteractive
            ? InteractiveRecordingIndicatorView.interactionOutset
            : lineWidth + safeMargin
        let indicatorRect = CGRect(
            x: recordingRect.origin.x - margin,
            y: recordingRect.origin.y - margin,
            width: recordingRect.width + margin * 2,
            height: recordingRect.height + margin * 2
        )
        
        // 创建窗口
        indicatorWindow = NSWindow(
            contentRect: indicatorRect,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        guard let window = indicatorWindow else { return }
        
        // Keep the selection frame above the teleprompter preview so region adjustments stay visible.
        window.level = .screenSaver + 1
        window.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        window.isMovableByWindowBackground = false
        window.backgroundColor = .clear
        window.isOpaque = false
        window.hasShadow = false
        window.ignoresMouseEvents = !isInteractive
        window.acceptsMouseMovedEvents = isInteractive
        window.isReleasedWhenClosed = false
        window.sharingType = .none
        
        if isInteractive {
            let contentView = InteractiveRecordingIndicatorView(
                frame: CGRect(origin: .zero, size: indicatorRect.size),
                recordingRect: recordingRect,
                margin: margin,
                aspectRatio: aspectRatio,
                onChange: onChange ?? { _ in }
            )
            contentView.autoresizingMask = [.width, .height]
            window.contentView = contentView
            updateMousePassthrough(for: window, view: contentView)
            startMousePassthroughTracking(for: window, view: contentView)
        } else {
            let contentView = NSHostingView(
                rootView: RecordingIndicatorView(recordingRect: recordingRect, margin: margin)
                    .frame(width: indicatorRect.width, height: indicatorRect.height)
            )
            contentView.layer?.backgroundColor = NSColor.clear.cgColor
            window.contentView = contentView
        }
        
        // 显示窗口
        window.orderFrontRegardless()
        
        print("✅ 录制区域指示器已显示: \(recordingRect)")
    }
    
    func hideIndicator() {
        print("📐 隐藏录制区域指示器...")
        mousePassthroughTimer?.invalidate()
        mousePassthroughTimer = nil
        indicatorWindow?.close()
        indicatorWindow = nil
    }
    
    func bringToFront() {
        // 确保指示器窗口在最前面
        indicatorWindow?.orderFrontRegardless()
    }

    private func startMousePassthroughTracking(for window: NSWindow, view: InteractiveRecordingIndicatorView) {
        mousePassthroughTimer?.invalidate()
        let timer = Timer(timeInterval: 1.0 / 60.0, repeats: true) { [weak self, weak window, weak view] _ in
            guard let self, let window, let view else { return }
            Task { @MainActor in
                self.updateMousePassthrough(for: window, view: view)
            }
        }

        mousePassthroughTimer = timer
        RunLoop.main.add(timer, forMode: .common)
    }

    private func updateMousePassthrough(for window: NSWindow, view: InteractiveRecordingIndicatorView) {
        let windowPoint = window.convertPoint(fromScreen: NSEvent.mouseLocation)
        let viewPoint = view.convert(windowPoint, from: nil)
        window.ignoresMouseEvents = !view.shouldHandleMouse(at: viewPoint)
    }
}

// MARK: - 录制指示器视图
struct RecordingIndicatorView: View {
    let recordingRect: CGRect
    let margin: CGFloat
    @State private var animationPhase: Double = 0
    
    var body: some View {
        ZStack {
            Color.clear
            
            // 虚线边框 - 绘制比录制区域稍大的矩形，确保边框在区域外
            let borderRect = CGRect(
                x: 0, y: 0,
                width: recordingRect.width + margin * 2,
                height: recordingRect.height + margin * 2
            )
            
            Rectangle()
                .strokeBorder(
                    Color.blue.opacity(0.8),
                    lineWidth: 2
                )
                .background(Color.clear)
                .frame(width: borderRect.width, height: borderRect.height)
                .overlay(
                    // 手动实现虚线效果
                    DashedRectangle(dashPhase: animationPhase)
                        .stroke(Color.blue.opacity(0.8), lineWidth: 2)
                        .frame(width: borderRect.width, height: borderRect.height)
                )
        }
        .onAppear {
            // 虚线动画效果
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                animationPhase = 12
            }
        }
    }
}

// 手动实现的虚线矩形
struct DashedRectangle: Shape {
    let dashPhase: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let dashLength: CGFloat = 8
        let gapLength: CGFloat = 4
        let _ = dashLength + gapLength
        
        // 顶边
        var currentX: CGFloat = 0
        var shouldDraw = true
        while currentX < rect.width {
            let nextX = min(currentX + (shouldDraw ? dashLength : gapLength), rect.width)
            if shouldDraw {
                path.move(to: CGPoint(x: currentX, y: 0))
                path.addLine(to: CGPoint(x: nextX, y: 0))
            }
            currentX = nextX
            shouldDraw.toggle()
        }
        
        // 简化版本：只画边框轮廓
        path.addRect(rect)
        return path
    }
}

private final class InteractiveRecordingIndicatorView: NSView {
    private enum DragMode {
        case none
        case moving
        case resizing(ResizeHandle)
    }

    private enum ResizeHandle: CaseIterable {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }

    private var recordingRect: CGRect
    private let margin: CGFloat
    private let aspectRatio: CGFloat?
    private let onChange: (CGRect) -> Void

    private var dragMode: DragMode = .none
    private var dragStartScreenPoint: CGPoint = .zero
    private var dragStartRect: CGRect = .zero

    static let interactionOutset: CGFloat = 34

    private let handleRadius: CGFloat = 3
    private let handleHitRadius: CGFloat = 20
    private let dragHandleSize: CGFloat = 26
    private let minimumSize: CGFloat = 80

    init(
        frame frameRect: NSRect,
        recordingRect: CGRect,
        margin: CGFloat,
        aspectRatio: CGFloat?,
        onChange: @escaping (CGRect) -> Void
    ) {
        self.recordingRect = recordingRect
        self.margin = margin
        self.aspectRatio = aspectRatio
        self.onChange = onChange
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor.clear.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var acceptsFirstResponder: Bool { true }

    override func resetCursorRects() {
        let rect = localRecordingRect
        addCursorRect(dragHandleRect(for: rect), cursor: .openHand)

        for handle in ResizeHandle.allCases {
            let center = handleCenter(for: handle, in: rect)
            addCursorRect(
                CGRect(
                    x: center.x - handleHitRadius,
                    y: center.y - handleHitRadius,
                    width: handleHitRadius * 2,
                    height: handleHitRadius * 2
                ),
                cursor: cursor(for: handle)
            )
        }
    }

    override func hitTest(_ point: NSPoint) -> NSView? {
        if shouldHandleMouse(at: point) {
            return self
        }

        return nil
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let rect = localRecordingRect
        NSColor.clear.setFill()
        dirtyRect.fill()

        let borderPath = NSBezierPath(rect: rect)
        borderPath.lineWidth = 2
        borderPath.setLineDash([8, 4], count: 2, phase: 0)
        NSColor.systemBlue.withAlphaComponent(0.9).setStroke()
        borderPath.stroke()

        drawDragHandle(for: rect)
        drawResizeHandles(in: rect)
    }

    override func mouseDown(with event: NSEvent) {
        guard let window else { return }

        let point = convert(event.locationInWindow, from: nil)
        if let handle = resizeHandle(at: point) {
            dragMode = .resizing(handle)
            NSCursor.closedHand.push()
        } else if dragHandleRect(for: localRecordingRect).contains(point) {
            dragMode = .moving
            NSCursor.closedHand.push()
        } else {
            dragMode = .none
            return
        }

        dragStartScreenPoint = window.convertPoint(toScreen: event.locationInWindow)
        dragStartRect = recordingRect
    }

    override func mouseDragged(with event: NSEvent) {
        guard let window else { return }
        if case .none = dragMode { return }

        let screenPoint = window.convertPoint(toScreen: event.locationInWindow)
        let nextRect: CGRect

        switch dragMode {
        case .none:
            return
        case .moving:
            nextRect = movedRect(from: dragStartRect, to: screenPoint)
        case .resizing(let handle):
            nextRect = resizedRect(from: dragStartRect, handle: handle, to: screenPoint)
        }

        applyRecordingRect(nextRect)
    }

    override func mouseUp(with event: NSEvent) {
        if case .none = dragMode {
            return
        } else {
            NSCursor.pop()
        }
        dragMode = .none
    }

    func shouldHandleMouse(at point: CGPoint) -> Bool {
        if case .none = dragMode {
            let rect = localRecordingRect
            return dragHandleRect(for: rect).contains(point) || resizeHandle(at: point) != nil
        }

        return true
    }

    private var localRecordingRect: CGRect {
        bounds.insetBy(dx: margin, dy: margin)
    }

    private func drawResizeHandles(in rect: CGRect) {
        for handle in ResizeHandle.allCases {
            let center = handleCenter(for: handle, in: rect)
            let handleRect = CGRect(
                x: center.x - handleRadius,
                y: center.y - handleRadius,
                width: handleRadius * 2,
                height: handleRadius * 2
            )
            let path = NSBezierPath(ovalIn: handleRect)
            NSColor.white.setFill()
            path.fill()
            NSColor.systemBlue.setStroke()
            path.lineWidth = 2
            path.stroke()
        }
    }

    private func drawDragHandle(for rect: CGRect) {
        let handleRect = dragHandleRect(for: rect)
        let path = NSBezierPath(roundedRect: handleRect, xRadius: 8, yRadius: 8)
        NSColor.systemBlue.withAlphaComponent(0.92).setFill()
        path.fill()

        NSColor.white.withAlphaComponent(0.95).setFill()
        let dotSize: CGFloat = 3
        let xOffsets: [CGFloat] = [-5, 0, 5]
        let yOffsets: [CGFloat] = [-4, 4]
        for xOffset in xOffsets {
            for yOffset in yOffsets {
                let dotRect = CGRect(
                    x: handleRect.midX + xOffset - dotSize / 2,
                    y: handleRect.midY + yOffset - dotSize / 2,
                    width: dotSize,
                    height: dotSize
                )
                NSBezierPath(ovalIn: dotRect).fill()
            }
        }
    }

    private func resizeHandle(at point: CGPoint) -> ResizeHandle? {
        let rect = localRecordingRect
        return ResizeHandle.allCases.first { handle in
            let center = handleCenter(for: handle, in: rect)
            return hypot(point.x - center.x, point.y - center.y) <= handleHitRadius
        }
    }

    private func dragHandleRect(for rect: CGRect) -> CGRect {
        CGRect(
            x: rect.minX + 6,
            y: rect.maxY - dragHandleSize - 6,
            width: dragHandleSize,
            height: dragHandleSize
        )
    }

    private func handleCenter(for handle: ResizeHandle, in rect: CGRect) -> CGPoint {
        switch handle {
        case .topLeft:
            return CGPoint(x: rect.minX, y: rect.maxY)
        case .topRight:
            return CGPoint(x: rect.maxX, y: rect.maxY)
        case .bottomLeft:
            return CGPoint(x: rect.minX, y: rect.minY)
        case .bottomRight:
            return CGPoint(x: rect.maxX, y: rect.minY)
        }
    }

    private func oppositeCorner(for handle: ResizeHandle, in rect: CGRect) -> CGPoint {
        switch handle {
        case .topLeft:
            return CGPoint(x: rect.maxX, y: rect.minY)
        case .topRight:
            return CGPoint(x: rect.minX, y: rect.minY)
        case .bottomLeft:
            return CGPoint(x: rect.maxX, y: rect.maxY)
        case .bottomRight:
            return CGPoint(x: rect.minX, y: rect.maxY)
        }
    }

    private func proposedCorner(from screenPoint: CGPoint, handle: ResizeHandle, opposite: CGPoint) -> CGPoint {
        switch handle {
        case .topLeft:
            return CGPoint(x: min(screenPoint.x, opposite.x - minimumSize), y: max(screenPoint.y, opposite.y + minimumSize))
        case .topRight:
            return CGPoint(x: max(screenPoint.x, opposite.x + minimumSize), y: max(screenPoint.y, opposite.y + minimumSize))
        case .bottomLeft:
            return CGPoint(x: min(screenPoint.x, opposite.x - minimumSize), y: min(screenPoint.y, opposite.y - minimumSize))
        case .bottomRight:
            return CGPoint(x: max(screenPoint.x, opposite.x + minimumSize), y: min(screenPoint.y, opposite.y - minimumSize))
        }
    }

    private func recordingRect(from opposite: CGPoint, moving corner: CGPoint) -> CGRect {
        CGRect(
            x: min(opposite.x, corner.x),
            y: min(opposite.y, corner.y),
            width: abs(corner.x - opposite.x),
            height: abs(corner.y - opposite.y)
        )
    }

    private func cursor(for handle: ResizeHandle) -> NSCursor {
        switch handle {
        case .topLeft, .bottomRight:
            return .resizeLeftRight
        case .topRight, .bottomLeft:
            return .resizeUpDown
        }
    }

    private func adjustedCorner(_ corner: CGPoint, opposite: CGPoint, handle: ResizeHandle, aspectRatio: CGFloat) -> CGPoint {
        let dx = corner.x - opposite.x
        let dy = corner.y - opposite.y
        let width = max(abs(dx), minimumSize)
        let height = max(abs(dy), minimumSize)
        let xDirection: CGFloat = dx >= 0 ? 1 : -1
        let yDirection: CGFloat = dy >= 0 ? 1 : -1

        let resolvedWidth: CGFloat
        let resolvedHeight: CGFloat
        if width / max(height, 1) > aspectRatio {
            resolvedHeight = height
            resolvedWidth = height * aspectRatio
        } else {
            resolvedWidth = width
            resolvedHeight = width / aspectRatio
        }

        return CGPoint(
            x: opposite.x + xDirection * max(resolvedWidth, minimumSize),
            y: opposite.y + yDirection * max(resolvedHeight, minimumSize)
        )
    }

    private func clampedCorner(_ corner: CGPoint, opposite: CGPoint, handle: ResizeHandle, aspectRatio: CGFloat, in bounds: CGRect) -> CGPoint {
        let xLimit = corner.x >= opposite.x ? bounds.maxX - opposite.x : opposite.x - bounds.minX
        let yLimit = corner.y >= opposite.y ? bounds.maxY - opposite.y : opposite.y - bounds.minY
        let maxWidth = max(minimumSize, min(abs(xLimit), abs(yLimit) * aspectRatio))
        let xDirection: CGFloat = corner.x >= opposite.x ? 1 : -1
        let yDirection: CGFloat = corner.y >= opposite.y ? 1 : -1

        let requestedWidth = abs(corner.x - opposite.x)
        let requestedHeight = abs(corner.y - opposite.y)
        let widthFromPointer = min(max(requestedWidth, requestedHeight * aspectRatio), maxWidth)
        let height = widthFromPointer / aspectRatio
        let width = height * aspectRatio

        return CGPoint(
            x: opposite.x + xDirection * width,
            y: opposite.y + yDirection * height
        )
    }

    private func movedRect(from rect: CGRect, to screenPoint: CGPoint) -> CGRect {
        let delta = CGPoint(
            x: screenPoint.x - dragStartScreenPoint.x,
            y: screenPoint.y - dragStartScreenPoint.y
        )
        var moved = rect
        moved.origin.x += delta.x
        moved.origin.y += delta.y
        return clampedRect(moved)
    }

    private func resizedRect(from rect: CGRect, handle: ResizeHandle, to screenPoint: CGPoint) -> CGRect {
        let ratio = aspectRatio ?? max(rect.width / max(rect.height, 1), 0.1)
        let opposite = oppositeCorner(for: handle, in: rect)
        let proposed = proposedCorner(from: screenPoint, handle: handle, opposite: opposite)
        let adjusted = adjustedCorner(proposed, opposite: opposite, handle: handle, aspectRatio: ratio)
        let clamped = clampedCorner(adjusted, opposite: opposite, handle: handle, aspectRatio: ratio, in: screenBounds(for: rect))
        return recordingRect(from: opposite, moving: clamped).integral
    }

    private func clampedRect(_ rect: CGRect) -> CGRect {
        let bounds = screenBounds(for: rect)
        var clamped = rect
        clamped.size.width = min(max(clamped.width, minimumSize), bounds.width)
        clamped.size.height = min(max(clamped.height, minimumSize), bounds.height)
        clamped.origin.x = min(max(clamped.minX, bounds.minX), bounds.maxX - clamped.width)
        clamped.origin.y = min(max(clamped.minY, bounds.minY), bounds.maxY - clamped.height)
        return clamped.integral
    }

    private func screenBounds(for rect: CGRect) -> CGRect {
        let probe = CGPoint(x: rect.midX, y: rect.midY)
        return NSScreen.screens.first { screen in
            screen.frame.contains(probe)
        }?.frame ?? NSScreen.main?.frame ?? rect
    }

    private func applyRecordingRect(_ rect: CGRect) {
        recordingRect = rect
        let indicatorRect = rect.insetBy(dx: -margin, dy: -margin)
        window?.setFrame(indicatorRect, display: true, animate: false)
        window?.invalidateCursorRects(for: self)
        needsDisplay = true
        onChange(rect)
    }
}
