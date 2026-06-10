import Cocoa
import CoreGraphics

@MainActor
final class WindowSelector: NSObject {
    private var overlayWindow: NSWindow?
    private var selectionView: WindowSelectionView?
    private var completion: ((WindowRecordingTarget?) -> Void)?
    private var candidates: [WindowRecordingTarget] = []
    private var localKeyMonitor: Any?
    private var globalKeyMonitor: Any?

    func selectWindow(completion: @escaping (WindowRecordingTarget?) -> Void) {
        print("🪟 启动窗口选择...")
        self.completion = completion

        guard let screen = screenWithMouse() ?? NSScreen.main else {
            print("❌ 无法获取屏幕")
            completion(nil)
            return
        }

        let screenFrame = screen.frame
        candidates = loadCandidateWindows(on: screen)
        print("🪟 可选择窗口数量: \(candidates.count)")

        let overlayWindow = WindowSelectionOverlayWindow(
            contentRect: screenFrame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        overlayWindow.backgroundColor = .clear
        overlayWindow.isOpaque = false
        overlayWindow.level = .screenSaver + 1
        overlayWindow.ignoresMouseEvents = false
        overlayWindow.acceptsMouseMovedEvents = true
        overlayWindow.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]

        let selectionView = WindowSelectionView(
            frame: CGRect(origin: .zero, size: screenFrame.size),
            screenFrame: screenFrame
        )
        selectionView.autoresizingMask = [.width, .height]
        selectionView.windowProvider = { [weak self] point in
            self?.window(at: point, on: screen)
        }
        selectionView.onSelect = { [weak self] target in
            self?.finishSelection(target: target)
        }

        overlayWindow.contentView = selectionView
        overlayWindow.makeKeyAndOrderFront(nil)
        selectionView.window?.makeFirstResponder(selectionView)
        NSApp.activate(ignoringOtherApps: true)

        self.overlayWindow = overlayWindow
        self.selectionView = selectionView
        startEscapeMonitoring()

        print("✅ 窗口选择界面已显示")
    }

    func refreshedTarget(_ target: WindowRecordingTarget) -> WindowRecordingTarget? {
        guard let windowInfoList = CGWindowListCopyWindowInfo(
            [.optionIncludingWindow],
            target.windowID
        ) as? [[String: Any]] else {
            return nil
        }

        return windowInfoList.compactMap { info in
            windowTarget(from: info, on: nil, excludingCurrentProcess: false)
        }.first
    }

    private func finishSelection(target: WindowRecordingTarget?) {
        guard overlayWindow != nil || completion != nil else { return }

        print("🪟 窗口选择完成: \(target?.displayName ?? "已取消")")

        stopEscapeMonitoring()
        overlayWindow?.orderOut(nil)
        overlayWindow = nil
        selectionView = nil
        candidates = []

        completion?(target)
        completion = nil
    }

    private func startEscapeMonitoring() {
        stopEscapeMonitoring()

        localKeyMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.keyCode == 53 {
                Task { @MainActor in
                    self?.finishSelection(target: nil)
                }
                return nil
            }

            return event
        }

        globalKeyMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.keyCode == 53 {
                Task { @MainActor in
                    self?.finishSelection(target: nil)
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

    private func screenWithMouse() -> NSScreen? {
        let mouseLocation = NSEvent.mouseLocation
        return NSScreen.screens.first { screen in
            NSMouseInRect(mouseLocation, screen.frame, false)
        }
    }

    private func window(at point: CGPoint, on screen: NSScreen) -> WindowRecordingTarget? {
        candidates.first { target in
            target.frame.contains(point)
        }
    }

    private func loadCandidateWindows(on screen: NSScreen) -> [WindowRecordingTarget] {
        guard let windowInfoList = CGWindowListCopyWindowInfo(
            [.optionOnScreenOnly, .excludeDesktopElements],
            kCGNullWindowID
        ) as? [[String: Any]] else {
            return []
        }

        return windowInfoList.compactMap { info in
            windowTarget(from: info, on: screen, excludingCurrentProcess: true)
        }
    }

    private func windowTarget(
        from info: [String: Any],
        on screen: NSScreen?,
        excludingCurrentProcess: Bool
    ) -> WindowRecordingTarget? {
        guard
            let windowNumber = info[kCGWindowNumber as String] as? NSNumber,
            let layer = info[kCGWindowLayer as String] as? NSNumber,
            layer.intValue == 0,
            let ownerPID = info[kCGWindowOwnerPID as String] as? NSNumber,
            let boundsDictionary = info[kCGWindowBounds as String] as? NSDictionary,
            let cgBounds = CGRect(dictionaryRepresentation: boundsDictionary)
        else {
            return nil
        }

        if excludingCurrentProcess && ownerPID.int32Value == NSRunningApplication.current.processIdentifier {
            return nil
        }

        let alpha = (info[kCGWindowAlpha as String] as? NSNumber)?.doubleValue ?? 1
        guard alpha > 0 else { return nil }

        let frame = appKitRect(fromCGWindowBounds: cgBounds)
        guard frame.width >= 80, frame.height >= 60 else { return nil }
        if let screen, !frame.intersects(screen.frame) {
            return nil
        }

        let ownerName = info[kCGWindowOwnerName as String] as? String ?? ""
        guard !ownerName.isEmpty, ownerName != "Window Server" else { return nil }

        let title = info[kCGWindowName as String] as? String ?? ""

        return WindowRecordingTarget(
            windowID: CGWindowID(windowNumber.uint32Value),
            frame: frame,
            title: title,
            ownerName: ownerName
        )
    }

    private func appKitRect(fromCGWindowBounds bounds: CGRect) -> CGRect {
        let primaryDisplayMaxY = NSScreen.screens.first?.frame.maxY ?? NSScreen.main?.frame.maxY ?? 0
        return CGRect(
            x: bounds.origin.x,
            y: primaryDisplayMaxY - bounds.origin.y - bounds.height,
            width: bounds.width,
            height: bounds.height
        )
    }
}

private final class WindowSelectionOverlayWindow: NSWindow {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
}

private final class WindowSelectionView: NSView {
    let screenFrame: CGRect
    var windowProvider: ((CGPoint) -> WindowRecordingTarget?)?
    var onSelect: ((WindowRecordingTarget?) -> Void)?

    private let cancelButton = NSButton(title: "Cancel", target: nil, action: nil)
    private var trackingArea: NSTrackingArea?
    private var hoveredWindow: WindowRecordingTarget? {
        didSet {
            if hoveredWindow?.windowID != oldValue?.windowID {
                needsDisplay = true
            }
        }
    }

    init(frame frameRect: NSRect, screenFrame: CGRect) {
        self.screenFrame = screenFrame
        super.init(frame: frameRect)
        wantsLayer = true
        setupCancelButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var acceptsFirstResponder: Bool { true }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        if let trackingArea {
            removeTrackingArea(trackingArea)
        }

        let trackingArea = NSTrackingArea(
            rect: bounds,
            options: [.mouseMoved, .activeAlways, .inVisibleRect],
            owner: self,
            userInfo: nil
        )
        addTrackingArea(trackingArea)
        self.trackingArea = trackingArea
    }

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        window?.makeFirstResponder(self)
        updateHover()
    }

    override func mouseMoved(with event: NSEvent) {
        updateHover(with: event)
    }

    override func mouseExited(with event: NSEvent) {
        hoveredWindow = nil
    }

    override func mouseDown(with event: NSEvent) {
        updateHover(with: event)
        if let hoveredWindow {
            onSelect?(hoveredWindow)
        }
    }

    override func rightMouseDown(with event: NSEvent) {
        onSelect?(nil)
    }

    override func keyDown(with event: NSEvent) {
        if event.keyCode == 53 {
            onSelect?(nil)
        } else {
            super.keyDown(with: event)
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSColor.black.withAlphaComponent(0.12).setFill()
        bounds.fill()

        drawInstruction()

        guard let hoveredWindow else { return }

        let localRect = hoveredWindow.frame.offsetBy(
            dx: -screenFrame.minX,
            dy: -screenFrame.minY
        )

        NSColor.systemBlue.withAlphaComponent(0.16).setFill()
        NSBezierPath(roundedRect: localRect, xRadius: 10, yRadius: 10).fill()

        NSColor.systemBlue.setStroke()
        let path = NSBezierPath(roundedRect: localRect.insetBy(dx: 2, dy: 2), xRadius: 10, yRadius: 10)
        path.lineWidth = 4
        path.stroke()

        drawWindowLabel(hoveredWindow, in: localRect)
    }

    private func updateHover() {
        hoveredWindow = windowProvider?(NSEvent.mouseLocation)
    }

    private func updateHover(with event: NSEvent) {
        let localPoint = convert(event.locationInWindow, from: nil)
        let globalPoint = CGPoint(
            x: localPoint.x + screenFrame.minX,
            y: localPoint.y + screenFrame.minY
        )
        hoveredWindow = windowProvider?(globalPoint)
    }

    private func setupCancelButton() {
        cancelButton.target = self
        cancelButton.action = #selector(cancelSelection)
        cancelButton.bezelStyle = .rounded
        cancelButton.controlSize = .regular
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(cancelButton)

        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: topAnchor, constant: 52),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -52),
            cancelButton.widthAnchor.constraint(equalToConstant: 72)
        ])
    }

    @objc private func cancelSelection() {
        onSelect?(nil)
    }

    private func drawInstruction() {
        let text = "Click a window to record. Press ESC or right-click to cancel."
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 16, weight: .semibold),
            .foregroundColor: NSColor.white
        ]
        let textSize = text.size(withAttributes: attributes)
        let padding = CGSize(width: 18, height: 10)
        let rect = CGRect(
            x: (bounds.width - textSize.width - padding.width * 2) / 2,
            y: bounds.height - textSize.height - padding.height * 2 - 48,
            width: textSize.width + padding.width * 2,
            height: textSize.height + padding.height * 2
        )

        NSColor.black.withAlphaComponent(0.72).setFill()
        NSBezierPath(roundedRect: rect, xRadius: 10, yRadius: 10).fill()
        text.draw(
            at: CGPoint(x: rect.minX + padding.width, y: rect.minY + padding.height),
            withAttributes: attributes
        )
    }

    private func drawWindowLabel(_ target: WindowRecordingTarget, in rect: CGRect) {
        let label = target.displayName
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 13, weight: .semibold),
            .foregroundColor: NSColor.white
        ]
        let maxWidth = max(120, min(rect.width - 24, 360))
        let textRect = NSString(string: label).boundingRect(
            with: CGSize(width: maxWidth, height: 40),
            options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine],
            attributes: attributes
        )
        let labelRect = CGRect(
            x: rect.minX + 12,
            y: rect.maxY - textRect.height - 18,
            width: textRect.width + 16,
            height: textRect.height + 8
        )

        guard labelRect.minY >= bounds.minY else { return }

        NSColor.systemBlue.withAlphaComponent(0.9).setFill()
        NSBezierPath(roundedRect: labelRect, xRadius: 7, yRadius: 7).fill()

        NSString(string: label).draw(
            in: labelRect.insetBy(dx: 8, dy: 4),
            withAttributes: attributes
        )
    }
}
