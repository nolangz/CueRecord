import Cocoa

@MainActor
class AreaSelector: NSObject {
    private var overlayWindow: NSWindow?
    private var selectionView: AreaSelectionView?
    private var completion: ((CGRect?) -> Void)?
    private var localKeyMonitor: Any?
    private var globalKeyMonitor: Any?
    
    // 获取鼠标所在的屏幕
    private func getScreenWithMouse() -> NSScreen? {
        let mouseLocation = NSEvent.mouseLocation
        for screen in NSScreen.screens {
            if NSMouseInRect(mouseLocation, screen.frame, false) {
                return screen
            }
        }
        return nil
    }
    
    func selectArea(aspectRatioPreset: AreaAspectRatioPreset = .custom, completion: @escaping (CGRect?) -> Void) {
        print("🔍 启动区域选择...")
        self.completion = completion
        
        // 获取当前鼠标所在的屏幕
        guard let screen = getScreenWithMouse() ?? NSScreen.main else {
            print("❌ 无法获取屏幕")
            completion(nil)
            return
        }
        
        print("🖥️ 在屏幕上创建选择器: \(screen.localizedName)")
        
        // 创建全屏覆盖窗口
        let screenFrame = screen.frame
        overlayWindow = AreaSelectionOverlayWindow(
            contentRect: screenFrame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        guard let window = overlayWindow else {
            completion(nil)
            return
        }
        
        // 配置窗口
        window.backgroundColor = NSColor.black.withAlphaComponent(0.3)
        window.level = .screenSaver + 1
        window.ignoresMouseEvents = false
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary, .stationary]
        
        // 创建选择视图
        selectionView = AreaSelectionView(frame: screenFrame, aspectRatioPreset: aspectRatioPreset)
        selectionView?.delegate = self
        window.contentView = selectionView
        
        // 显示窗口
        window.makeKeyAndOrderFront(nil)
        window.makeFirstResponder(selectionView)
        NSApp.activate(ignoringOtherApps: true)
        startEscapeMonitoring()
        
        print("✅ 区域选择界面已显示")
    }
    
    private func finishSelection(rect: CGRect?) {
        guard overlayWindow != nil || completion != nil else { return }

        print("📐 区域选择完成: \(rect?.debugDescription ?? "已取消")")
        
        // 隐藏窗口
        stopEscapeMonitoring()
        overlayWindow?.orderOut(nil)
        overlayWindow = nil
        selectionView = nil
        
        // 调用回调
        completion?(rect)
        completion = nil
    }

    private func startEscapeMonitoring() {
        stopEscapeMonitoring()

        localKeyMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.keyCode == 53 {
                Task { @MainActor in
                    self?.finishSelection(rect: nil)
                }
                return nil
            }

            return event
        }

        globalKeyMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.keyCode == 53 {
                Task { @MainActor in
                    self?.finishSelection(rect: nil)
                }
            }
        }
    }

    private func stopEscapeMonitoring() {
        if let localKeyMonitor {
            NSEvent.removeMonitor(localKeyMonitor)
            self.localKeyMonitor = nil
        }

        if let globalKeyMonitor {
            NSEvent.removeMonitor(globalKeyMonitor)
            self.globalKeyMonitor = nil
        }
    }
}

private final class AreaSelectionOverlayWindow: NSWindow {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
}

// MARK: - AreaSelectionViewDelegate
extension AreaSelector: AreaSelectionViewDelegate {
    func areaSelectionView(_ view: AreaSelectionView, didSelectArea rect: CGRect) {
        finishSelection(rect: rect)
    }
    
    func areaSelectionViewDidCancel(_ view: AreaSelectionView) {
        finishSelection(rect: nil)
    }
}

// MARK: - 区域选择视图协议
protocol AreaSelectionViewDelegate: AnyObject {
    func areaSelectionView(_ view: AreaSelectionView, didSelectArea rect: CGRect)
    func areaSelectionViewDidCancel(_ view: AreaSelectionView)
}

// MARK: - 区域选择视图
class AreaSelectionView: NSView {
    weak var delegate: AreaSelectionViewDelegate?

    private enum DragMode {
        case none
        case creating
        case moving
        case resizing(ResizeHandle)
    }

    private enum ResizeHandle: CaseIterable {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    
    private let aspectRatioPreset: AreaAspectRatioPreset
    private var startPoint: CGPoint?
    private var endPoint: CGPoint?
    private var isSelecting = false
    private var dragMode: DragMode = .none
    private var dragStartPoint: CGPoint = .zero
    private var resizeStartRect: CGRect = .zero

    private let handleRadius: CGFloat = 3.5
    private let handleHitRadius: CGFloat = 18
    private let dragHandleSize: CGFloat = 26
    private let minimumSelectionSize: CGFloat = 44
    
    private var selectionRect: CGRect {
        guard let start = startPoint, let end = endPoint else { return .zero }
        
        let minX = min(start.x, end.x)
        let minY = min(start.y, end.y) 
        let maxX = max(start.x, end.x)
        let maxY = max(start.y, end.y)
        
        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
    
    init(frame frameRect: NSRect, aspectRatioPreset: AreaAspectRatioPreset) {
        self.aspectRatioPreset = aspectRatioPreset
        super.init(frame: frameRect)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let ratioHint = aspectRatioPreset.aspectRatio == nil ? uiText("Free") : aspectRatioPreset.title
        let instruction = InterfaceLanguageSettings.shared.format(
            "Drag to select recording area · %@ · Release to use · Press ESC to cancel",
            ratioHint
        )
        let instructionLabel = NSTextField(labelWithString: instruction)
        instructionLabel.textColor = .white
        instructionLabel.font = NSFont.systemFont(ofSize: 16)
        instructionLabel.backgroundColor = NSColor.black.withAlphaComponent(0.7)
        instructionLabel.drawsBackground = true
        instructionLabel.layer?.cornerRadius = 8
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(instructionLabel)
        
        NSLayoutConstraint.activate([
            instructionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            instructionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50)
        ])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // 绘制半透明背景
        NSColor.black.withAlphaComponent(0.3).set()
        dirtyRect.fill()
        
        // 如果有选择区域，绘制选择框
        if !selectionRect.isEmpty {
            // 清除选择区域的背景
            NSColor.clear.set()
            selectionRect.fill()
            
            // 绘制选择框边框
            NSColor.green.setStroke()
            let path = NSBezierPath(rect: selectionRect)
            path.lineWidth = 2.0
            path.stroke()
            
            // 显示尺寸信息
            drawSelectionInfo()
            drawDragHandle()
            drawResizeHandles()
        }
    }

    override func resetCursorRects() {
        let rect = selectionRect
        guard rect.width >= minimumSelectionSize, rect.height >= minimumSelectionSize else { return }

        addCursorRect(dragHandleRect(for: rect), cursor: .openHand)
    }

    private func drawResizeHandles() {
        let rect = selectionRect
        guard rect.width >= minimumSelectionSize, rect.height >= minimumSelectionSize else { return }

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
            NSColor.systemGreen.setStroke()
            path.lineWidth = 2
            path.stroke()
        }
    }

    private func drawDragHandle() {
        let rect = selectionRect
        guard rect.width >= minimumSelectionSize, rect.height >= minimumSelectionSize else { return }

        let handleRect = dragHandleRect(for: rect)
        let path = NSBezierPath(roundedRect: handleRect, xRadius: 8, yRadius: 8)
        NSColor.systemGreen.withAlphaComponent(0.94).setFill()
        path.fill()

        NSColor.white.withAlphaComponent(0.96).setFill()
        let dotSize: CGFloat = 3
        for xOffset in [-5, 0, 5] as [CGFloat] {
            for yOffset in [-4, 4] as [CGFloat] {
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
    
    private func drawSelectionInfo() {
        let rect = selectionRect
        guard rect.width > 20 && rect.height > 20 else { return }
        
        let info = selectionInfo(for: rect)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: NSColor.white,
            .backgroundColor: NSColor.black.withAlphaComponent(0.8),
            .font: NSFont.systemFont(ofSize: 12)
        ]
        
        let size = info.size(withAttributes: attributes)
        let infoRect = CGRect(
            x: rect.minX,
            y: rect.minY - size.height - 5,
            width: size.width + 8,
            height: size.height + 4
        )
        
        // 确保信息框在屏幕内
        var adjustedRect = infoRect
        if adjustedRect.minY < 0 {
            adjustedRect.origin.y = rect.maxY + 5
        }
        
        NSColor.black.withAlphaComponent(0.8).set()
        adjustedRect.fill()
        
        info.draw(at: CGPoint(x: adjustedRect.minX + 4, y: adjustedRect.minY + 2), withAttributes: attributes)
    }

    private func selectionInfo(for rect: CGRect) -> String {
        if aspectRatioPreset.aspectRatio == nil {
            return String(format: "%.0f × %.0f", rect.width, rect.height)
        }

        return String(format: "%.0f × %.0f · %@", rect.width, rect.height, aspectRatioPreset.title)
    }
    
    // MARK: - 鼠标事件
    override func mouseDown(with event: NSEvent) {
        let point = convert(event.locationInWindow, from: nil)

        if let handle = resizeHandle(at: point) {
            dragMode = .resizing(handle)
            resizeStartRect = selectionRect
            isSelecting = true
            needsDisplay = true
            return
        }

        if dragHandleRect(for: selectionRect).contains(point) {
            dragMode = .moving
            dragStartPoint = point
            resizeStartRect = selectionRect
            isSelecting = true
            needsDisplay = true
            return
        }

        dragMode = .creating
        startPoint = point
        endPoint = point
        isSelecting = true
        needsDisplay = true
    }
    
    override func mouseDragged(with event: NSEvent) {
        guard isSelecting else { return }
        
        let point = convert(event.locationInWindow, from: nil)
        switch dragMode {
        case .none:
            break
        case .creating:
            endPoint = constrainedEndpoint(from: startPoint, to: point)
        case .moving:
            setSelectionRect(movedSelectionRect(from: resizeStartRect, to: point))
        case .resizing(let handle):
            setSelectionRect(resizedSelectionRect(from: resizeStartRect, handle: handle, to: point))
        }
        needsDisplay = true
    }

    private func constrainedEndpoint(from start: CGPoint?, to point: CGPoint) -> CGPoint {
        guard let start, let aspectRatio = aspectRatioPreset.aspectRatio else { return point }

        let dx = point.x - start.x
        let dy = point.y - start.y
        let width = abs(dx)
        let height = abs(dy)

        guard width > 0 || height > 0 else { return point }

        let xDirection: CGFloat = dx >= 0 ? 1 : -1
        let yDirection: CGFloat = dy >= 0 ? 1 : -1

        let resolvedWidth: CGFloat
        let resolvedHeight: CGFloat

        if height == 0 || width / max(height, 1) <= aspectRatio {
            resolvedWidth = width
            resolvedHeight = width / aspectRatio
        } else {
            resolvedHeight = height
            resolvedWidth = height * aspectRatio
        }

        let rawEndpoint = CGPoint(
            x: start.x + xDirection * resolvedWidth,
            y: start.y + yDirection * resolvedHeight
        )

        return CGPoint(
            x: min(max(rawEndpoint.x, bounds.minX), bounds.maxX),
            y: min(max(rawEndpoint.y, bounds.minY), bounds.maxY)
        )
    }
    
    override func mouseUp(with event: NSEvent) {
        guard isSelecting else { return }
        
        isSelecting = false
        dragMode = .none
        
        // 如果选择区域太小，取消选择
        if selectionRect.width < 20 || selectionRect.height < 20 {
            startPoint = nil
            endPoint = nil
            needsDisplay = true
            return
        }
        
        delegate?.areaSelectionView(self, didSelectArea: selectionRect.integral)
        needsDisplay = true
    }

    private func resizeHandle(at point: CGPoint) -> ResizeHandle? {
        let rect = selectionRect
        guard rect.width >= minimumSelectionSize, rect.height >= minimumSelectionSize else { return nil }

        return ResizeHandle.allCases.first { handle in
            let center = handleCenter(for: handle, in: rect)
            return hypot(point.x - center.x, point.y - center.y) <= handleHitRadius
        }
    }

    private func dragHandleRect(for rect: CGRect) -> CGRect {
        return CGRect(
            x: rect.minX + 6,
            y: rect.maxY - dragHandleSize - 6,
            width: dragHandleSize,
            height: dragHandleSize
        )
    }

    private func movedSelectionRect(from rect: CGRect, to point: CGPoint) -> CGRect {
        guard !rect.isEmpty else { return rect }

        let dx = point.x - dragStartPoint.x
        let dy = point.y - dragStartPoint.y
        let proposedOrigin = CGPoint(x: rect.origin.x + dx, y: rect.origin.y + dy)
        let clampedOrigin = CGPoint(
            x: min(max(proposedOrigin.x, bounds.minX), bounds.maxX - rect.width),
            y: min(max(proposedOrigin.y, bounds.minY), bounds.maxY - rect.height)
        )

        return CGRect(origin: clampedOrigin, size: rect.size).integral
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

    private func resizedSelectionRect(from rect: CGRect, handle: ResizeHandle, to point: CGPoint) -> CGRect {
        guard !rect.isEmpty, let aspectRatio = resizeAspectRatio(for: rect) else { return rect }

        let opposite = oppositeCorner(for: handle, in: rect)
        let xDirection: CGFloat = isLeftHandle(handle) ? -1 : 1
        let yDirection: CGFloat = isTopHandle(handle) ? 1 : -1
        let requestedWidth = max((point.x - opposite.x) * xDirection, minimumSelectionSize)
        let requestedHeight = max((point.y - opposite.y) * yDirection, minimumSelectionSize)

        let resolvedWidth: CGFloat
        if requestedWidth / max(requestedHeight, 1) > aspectRatio {
            resolvedWidth = requestedHeight * aspectRatio
        } else {
            resolvedWidth = requestedWidth
        }

        let availableWidth = isLeftHandle(handle) ? opposite.x - bounds.minX : bounds.maxX - opposite.x
        let availableHeight = isTopHandle(handle) ? bounds.maxY - opposite.y : opposite.y - bounds.minY
        let maxWidth = max(minimumSelectionSize, min(availableWidth, availableHeight * aspectRatio))
        let width = min(max(resolvedWidth, minimumSelectionSize), maxWidth)
        let height = width / aspectRatio
        let movingCorner = CGPoint(
            x: opposite.x + xDirection * width,
            y: opposite.y + yDirection * height
        )

        return CGRect(
            x: min(opposite.x, movingCorner.x),
            y: min(opposite.y, movingCorner.y),
            width: abs(movingCorner.x - opposite.x),
            height: abs(movingCorner.y - opposite.y)
        ).integral
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

    private func isLeftHandle(_ handle: ResizeHandle) -> Bool {
        handle == .topLeft || handle == .bottomLeft
    }

    private func isTopHandle(_ handle: ResizeHandle) -> Bool {
        handle == .topLeft || handle == .topRight
    }

    private func resizeAspectRatio(for rect: CGRect) -> CGFloat? {
        if let aspectRatio = aspectRatioPreset.aspectRatio {
            return aspectRatio
        }

        guard rect.width > 0, rect.height > 0 else { return nil }
        return rect.width / rect.height
    }

    private func setSelectionRect(_ rect: CGRect) {
        startPoint = CGPoint(x: rect.minX, y: rect.minY)
        endPoint = CGPoint(x: rect.maxX, y: rect.maxY)
    }
    
    // MARK: - 键盘事件
    override func keyDown(with event: NSEvent) {
        if event.keyCode == 53 { // ESC 键
            delegate?.areaSelectionViewDidCancel(self)
        }
    }
    
    override var acceptsFirstResponder: Bool { return true }
}
