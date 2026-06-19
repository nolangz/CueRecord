//
//  NotchSettings.swift
//  CueRecord
//
//

import SwiftUI

// MARK: - Font Size Preset

enum FontSizePreset: String, CaseIterable, Identifiable {
    case xs, sm, lg, xl

    var id: String { rawValue }

    var label: String {
        switch self {
        case .xs: return "XS"
        case .sm: return "SM"
        case .lg: return "LG"
        case .xl: return "XL"
        }
    }

    var pointSize: CGFloat {
        switch self {
        case .xs: return 14
        case .sm: return 16
        case .lg: return 20
        case .xl: return 24
        }
    }
}

// MARK: - Font Family Preset

enum FontFamilyPreset: String, CaseIterable, Identifiable {
    case sans, serif, mono, dyslexia

    var id: String { rawValue }

    var label: String {
        switch self {
        case .sans:     return "Sans"
        case .serif:    return "Serif"
        case .mono:     return "Mono"
        case .dyslexia: return "Dyslexia"
        }
    }

    var sampleText: String {
        switch self {
        case .sans:     return "Aa"
        case .serif:    return "Aa"
        case .mono:     return "Aa"
        case .dyslexia: return "Aa"
        }
    }

    func font(size: CGFloat, weight: NSFont.Weight = .semibold) -> NSFont {
        let base = NSFont.systemFont(ofSize: size, weight: weight)
        let descriptor = base.fontDescriptor
        switch self {
        case .sans:
            return base
        case .serif:
            if let designed = descriptor.withDesign(.serif) {
                return NSFont(descriptor: designed, size: size) ?? base
            }
            return base
        case .mono:
            if let designed = descriptor.withDesign(.monospaced) {
                return NSFont(descriptor: designed, size: size) ?? base
            }
            return NSFont.monospacedSystemFont(ofSize: size, weight: weight)
        case .dyslexia:
            if let dyslexicFont = NSFont(name: "OpenDyslexic3", size: size) {
                return dyslexicFont
            }
            // Fallback to rounded system font if OpenDyslexic not available
            if let designed = descriptor.withDesign(.rounded) {
                return NSFont(descriptor: designed, size: size) ?? base
            }
            return base
        }
    }
}

// MARK: - Font Color Preset

enum FontColorPreset: String, CaseIterable, Identifiable {
    case white, yellow, green, blue, pink, orange

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .white:  return .white
        case .yellow: return Color(red: 1.0, green: 0.84, blue: 0.04)
        case .green:  return Color(red: 0.2, green: 0.84, blue: 0.29)
        case .blue:   return Color(red: 0.31, green: 0.55, blue: 1.0)
        case .pink:   return Color(red: 1.0, green: 0.38, blue: 0.57)
        case .orange: return Color(red: 1.0, green: 0.62, blue: 0.04)
        }
    }

    var label: String {
        switch self {
        case .white:  return "White"
        case .yellow: return "Yellow"
        case .green:  return "Green"
        case .blue:   return "Blue"
        case .pink:   return "Pink"
        case .orange: return "Orange"
        }
    }

    var cssColor: String {
        switch self {
        case .white:  return "#ffffff"
        case .yellow: return "rgb(255,214,10)"
        case .green:  return "rgb(51,214,74)"
        case .blue:   return "rgb(79,140,255)"
        case .pink:   return "rgb(255,97,145)"
        case .orange: return "rgb(255,158,10)"
        }
    }
}

// MARK: - Cue Brightness

enum CueBrightness: String, CaseIterable, Identifiable {
    case dim, low, medium, bright

    var id: String { rawValue }

    var label: String {
        switch self {
        case .dim:    return "Dim"
        case .low:    return "Low"
        case .medium: return "Medium"
        case .bright: return "Bright"
        }
    }

    /// Opacity for unread annotations
    var unreadOpacity: Double {
        switch self {
        case .dim:    return 0.2
        case .low:    return 0.35
        case .medium: return 0.5
        case .bright: return 0.8
        }
    }

    /// Opacity for already-read annotations
    var readOpacity: Double {
        switch self {
        case .dim:    return 0.5
        case .low:    return 0.6
        case .medium: return 0.7
        case .bright: return 1.0
        }
    }
}

// MARK: - Overlay Mode

enum OverlayMode: String, CaseIterable, Identifiable {
    case pinned, floating, fullscreen

    var id: String { rawValue }

    var label: String {
        switch self {
        case .pinned:     return "Pinned to Notch"
        case .floating:   return "Floating Window"
        case .fullscreen: return "Fullscreen"
        }
    }

    var description: String {
        switch self {
        case .pinned:     return "Anchored below the notch at the top of your screen."
        case .floating:   return "A draggable window you can place anywhere. Always on top."
        case .fullscreen: return "Fullscreen teleprompter on the selected display. Press Esc to stop."
        }
    }

    var icon: String {
        switch self {
        case .pinned:     return "rectangle.topthird.inset.filled"
        case .floating:   return "macwindow.on.rectangle"
        case .fullscreen: return "rectangle.fill"
        }
    }
}

// MARK: - Notch Display Mode

enum NotchDisplayMode: String, CaseIterable, Identifiable {
    case followMouse, fixedDisplay

    var id: String { rawValue }

    var label: String {
        switch self {
        case .followMouse:  return "Follow Mouse"
        case .fixedDisplay: return "Fixed Display"
        }
    }

    var description: String {
        switch self {
        case .followMouse:  return "The notch moves to whichever display your mouse is on."
        case .fixedDisplay: return "The notch stays on the selected display."
        }
    }
}

// MARK: - External Display Mode

enum ExternalDisplayMode: String, CaseIterable, Identifiable {
    case off, teleprompter, mirror

    var id: String { rawValue }

    var label: String {
        switch self {
        case .off:          return "Off"
        case .teleprompter: return "Teleprompter"
        case .mirror:       return "Mirror"
        }
    }

    var description: String {
        switch self {
        case .off:          return "No external display output."
        case .teleprompter: return "Fullscreen teleprompter on the selected display."
        case .mirror:       return "Horizontally flipped for use with a prompter mirror rig."
        }
    }
}

// MARK: - Mirror Axis

enum MirrorAxis: String, CaseIterable, Identifiable {
    case horizontal, vertical, both

    var id: String { rawValue }

    var label: String {
        switch self {
        case .horizontal: return "Horizontal"
        case .vertical:   return "Vertical"
        case .both:       return "Both"
        }
    }

    var description: String {
        switch self {
        case .horizontal: return "Flipped left-to-right. Standard for prompter mirror rigs."
        case .vertical:   return "Flipped top-to-bottom."
        case .both:       return "Flipped on both axes (rotated 180°)."
        }
    }

    var scaleX: CGFloat {
        switch self {
        case .horizontal, .both: return -1
        case .vertical: return 1
        }
    }

    var scaleY: CGFloat {
        switch self {
        case .vertical, .both: return -1
        case .horizontal: return 1
        }
    }
}

// MARK: - Listening Mode

enum ListeningMode: String, CaseIterable, Identifiable {
    case wordTracking, classic, silencePaused

    var id: String { rawValue }

    var label: String {
        switch self {
        case .classic:        return "Classic"
        case .silencePaused:  return "Voice-Activated"
        case .wordTracking:   return "Word Tracking"
        }
    }

    var description: String {
        switch self {
        case .classic:        return "Auto-scrolls at a constant speed. No microphone needed."
        case .silencePaused:  return "Scrolls while you speak, pauses when you're silent."
        case .wordTracking:   return "Tracks each word you say and highlights it in real time."
        }
    }

    var icon: String {
        switch self {
        case .classic:        return "arrow.down.circle"
        case .silencePaused:  return "waveform.circle"
        case .wordTracking:   return "text.word.spacing"
        }
    }
}

// MARK: - Audience Face

enum AudienceFace: String, CaseIterable, Identifiable {
    case off, male, female, customImage

    var id: String { rawValue }

    var label: String {
        switch self {
        case .off: return "Off"
        case .male: return "Male"
        case .female: return "Female"
        case .customImage: return "Custom Image"
        }
    }

    var assetName: String? {
        switch self {
        case .off, .customImage: return nil
        case .male: return "AudienceFaceMale"
        case .female: return "AudienceFaceFemale"
        }
    }
}

struct AudienceFaceBackdropView: View {
    let face: AudienceFace
    var opacity: Double = 0.18
    var verticalPosition: CGFloat = 0.62

    var body: some View {
        GeometryReader { geometry in
            if let assetName = face.assetName {
                let side = max(geometry.size.width * 1.12, geometry.size.height * 1.9)

                Image(assetName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: side, height: side)
                    .position(x: geometry.size.width / 2, y: geometry.size.height * verticalPosition)
                    .opacity(opacity)
                    .saturation(0.9)
            }
        }
        .clipped()
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }
}

struct CustomTeleprompterBackgroundImageView: View {
    let imageURL: URL?
    let opacity: Double
    let scale: Double
    let horizontalOffset: Double
    let verticalOffset: Double

    @State private var image: NSImage?

    var body: some View {
        GeometryReader { geometry in
            if let image {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width * max(scale, 1),
                        height: geometry.size.height * max(scale, 1)
                    )
                    .position(
                        x: geometry.size.width / 2 + geometry.size.width * horizontalOffset,
                        y: geometry.size.height / 2 + geometry.size.height * verticalOffset
                    )
                    .opacity(opacity)
            }
        }
        .clipped()
        .allowsHitTesting(false)
        .accessibilityHidden(true)
        .onAppear(perform: loadImage)
        .onChange(of: imageURL) { _, _ in loadImage() }
    }

    private func loadImage() {
        guard let imageURL else {
            image = nil
            return
        }

        let didAccess = imageURL.startAccessingSecurityScopedResource()
        defer {
            if didAccess {
                imageURL.stopAccessingSecurityScopedResource()
            }
        }

        image = NSImage(contentsOf: imageURL)
    }
}

struct TeleprompterBackdropView: View {
    @Bindable var settings: NotchSettings
    var audienceFaceOpacity: Double = 0.18
    var audienceFaceVerticalPosition: CGFloat = 0.62

    var body: some View {
        switch settings.audienceFace {
        case .off:
            EmptyView()
        case .customImage:
            CustomTeleprompterBackgroundImageView(
                imageURL: settings.customBackgroundImageURL,
                opacity: settings.customBackgroundImageOpacity,
                scale: settings.customBackgroundImageScale,
                horizontalOffset: settings.customBackgroundImageHorizontalOffset,
                verticalOffset: settings.customBackgroundImageVerticalOffset
            )
        case .male, .female:
            AudienceFaceBackdropView(
                face: settings.audienceFace,
                opacity: audienceFaceOpacity,
                verticalPosition: audienceFaceVerticalPosition
            )
        }
    }
}

// MARK: - Settings

@Observable
class NotchSettings {
    static let shared = NotchSettings()
    private static let customBackgroundImageBookmarkKey = "customBackgroundImageBookmark"
    private static let customBackgroundImagePathKey = "customBackgroundImagePath"

    var notchWidth: CGFloat {
        didSet { UserDefaults.standard.set(Double(notchWidth), forKey: "notchWidth") }
    }
    var textAreaHeight: CGFloat {
        didSet { UserDefaults.standard.set(Double(textAreaHeight), forKey: "textAreaHeight") }
    }

    var speechLocale: String {
        didSet { UserDefaults.standard.set(speechLocale, forKey: "speechLocale") }
    }

    var fontSizePreset: FontSizePreset {
        didSet {
            UserDefaults.standard.set(fontSizePreset.rawValue, forKey: "fontSizePreset")
        }
    }

    var fontFamilyPreset: FontFamilyPreset {
        didSet {
            UserDefaults.standard.set(fontFamilyPreset.rawValue, forKey: "fontFamilyPreset")
        }
    }

    var fontColorPreset: FontColorPreset {
        didSet { UserDefaults.standard.set(fontColorPreset.rawValue, forKey: "fontColorPreset") }
    }

    var cueColorPreset: FontColorPreset {
        didSet { UserDefaults.standard.set(cueColorPreset.rawValue, forKey: "cueColorPreset") }
    }

    var cueBrightness: CueBrightness {
        didSet { UserDefaults.standard.set(cueBrightness.rawValue, forKey: "cueBrightness") }
    }

    var audienceFace: AudienceFace {
        didSet { UserDefaults.standard.set(audienceFace.rawValue, forKey: "audienceFace") }
    }

    var customBackgroundImageBookmark: Data? {
        didSet {
            if let customBackgroundImageBookmark {
                UserDefaults.standard.set(customBackgroundImageBookmark, forKey: Self.customBackgroundImageBookmarkKey)
            } else {
                UserDefaults.standard.removeObject(forKey: Self.customBackgroundImageBookmarkKey)
            }
        }
    }

    var customBackgroundImagePath: String {
        didSet { UserDefaults.standard.set(customBackgroundImagePath, forKey: Self.customBackgroundImagePathKey) }
    }

    var customBackgroundImageOpacity: Double {
        didSet { UserDefaults.standard.set(customBackgroundImageOpacity, forKey: "customBackgroundImageOpacity") }
    }

    var customBackgroundImageScale: Double {
        didSet { UserDefaults.standard.set(customBackgroundImageScale, forKey: "customBackgroundImageScale") }
    }

    var customBackgroundImageHorizontalOffset: Double {
        didSet { UserDefaults.standard.set(customBackgroundImageHorizontalOffset, forKey: "customBackgroundImageHorizontalOffset") }
    }

    var customBackgroundImageVerticalOffset: Double {
        didSet { UserDefaults.standard.set(customBackgroundImageVerticalOffset, forKey: "customBackgroundImageVerticalOffset") }
    }

    var overlayMode: OverlayMode {
        didSet { UserDefaults.standard.set(overlayMode.rawValue, forKey: "overlayMode") }
    }

    var notchDisplayMode: NotchDisplayMode {
        didSet { UserDefaults.standard.set(notchDisplayMode.rawValue, forKey: "notchDisplayMode") }
    }

    var pinnedScreenID: UInt32 {
        didSet { UserDefaults.standard.set(Int(pinnedScreenID), forKey: "pinnedScreenID") }
    }

    var floatingGlassEffect: Bool {
        didSet { UserDefaults.standard.set(floatingGlassEffect, forKey: "floatingGlassEffect") }
    }

    var glassOpacity: Double {
        didSet { UserDefaults.standard.set(glassOpacity, forKey: "glassOpacity") }
    }

    var overlayTransparency: Bool {
        didSet { UserDefaults.standard.set(overlayTransparency, forKey: "overlayTransparency") }
    }

    var overlayTransparencyOpacity: Double {
        didSet { UserDefaults.standard.set(overlayTransparencyOpacity, forKey: "overlayTransparencyOpacity") }
    }

    var followCursorWhenUndocked: Bool {
        didSet { UserDefaults.standard.set(followCursorWhenUndocked, forKey: "followCursorWhenUndocked") }
    }

    var externalDisplayMode: ExternalDisplayMode {
        didSet { UserDefaults.standard.set(externalDisplayMode.rawValue, forKey: "externalDisplayMode") }
    }

    var externalScreenID: UInt32 {
        didSet { UserDefaults.standard.set(Int(externalScreenID), forKey: "externalScreenID") }
    }

    var mirrorAxis: MirrorAxis {
        didSet { UserDefaults.standard.set(mirrorAxis.rawValue, forKey: "mirrorAxis") }
    }

    var listeningMode: ListeningMode {
        didSet { UserDefaults.standard.set(listeningMode.rawValue, forKey: "listeningMode") }
    }

    /// Words per second for classic and silence-paused modes
    var scrollSpeed: Double {
        didSet { UserDefaults.standard.set(scrollSpeed, forKey: "scrollSpeed") }
    }

    var hideFromScreenShare: Bool {
        didSet { UserDefaults.standard.set(hideFromScreenShare, forKey: "hideFromScreenShare") }
    }

    var showElapsedTime: Bool {
        didSet { UserDefaults.standard.set(showElapsedTime, forKey: "showElapsedTime") }
    }

    var selectedMicUID: String {
        didSet { UserDefaults.standard.set(selectedMicUID, forKey: "selectedMicUID") }
    }

    var autoNextPage: Bool {
        didSet { UserDefaults.standard.set(autoNextPage, forKey: "autoNextPage") }
    }

    var autoNextPageDelay: Int {
        didSet { UserDefaults.standard.set(autoNextPageDelay, forKey: "autoNextPageDelay") }
    }

    var fullscreenScreenID: UInt32 {
        didSet { UserDefaults.standard.set(Int(fullscreenScreenID), forKey: "fullscreenScreenID") }
    }

    var browserServerEnabled: Bool {
        didSet {
            UserDefaults.standard.set(browserServerEnabled, forKey: "browserServerEnabled")
            CueRecordService.shared.updateBrowserServer()
        }
    }

    var browserServerPort: UInt16 {
        didSet { UserDefaults.standard.set(Int(browserServerPort), forKey: "browserServerPort") }
    }

    var directorModeEnabled: Bool {
        didSet {
            UserDefaults.standard.set(directorModeEnabled, forKey: "directorModeEnabled")
            CueRecordService.shared.updateDirectorServer()
        }
    }

    var directorServerPort: UInt16 {
        didSet { UserDefaults.standard.set(Int(directorServerPort), forKey: "directorServerPort") }
    }

    var font: NSFont {
        fontFamilyPreset.font(size: fontSizePreset.pointSize)
    }

    var customBackgroundImageURL: URL? {
        if let customBackgroundImageBookmark {
            var isStale = false
            if let url = try? URL(
                resolvingBookmarkData: customBackgroundImageBookmark,
                options: [.withSecurityScope],
                relativeTo: nil,
                bookmarkDataIsStale: &isStale
            ) {
                return url
            }
        }

        guard !customBackgroundImagePath.isEmpty else { return nil }
        return URL(fileURLWithPath: customBackgroundImagePath)
    }

    var customBackgroundImageDisplayName: String? {
        customBackgroundImageURL?.lastPathComponent
    }

    var hasCustomBackgroundImage: Bool {
        customBackgroundImageURL != nil
    }

    var hasCustomBackgroundImageFramingAdjustments: Bool {
        abs(customBackgroundImageScale - Self.defaultCustomBackgroundImageScale) > 0.0001 ||
            abs(customBackgroundImageHorizontalOffset - Self.defaultCustomBackgroundImageHorizontalOffset) > 0.0001 ||
            abs(customBackgroundImageVerticalOffset - Self.defaultCustomBackgroundImageVerticalOffset) > 0.0001
    }

    func setCustomBackgroundImageURL(_ url: URL) {
        customBackgroundImagePath = url.path
        customBackgroundImageBookmark = try? url.bookmarkData(
            options: [.withSecurityScope],
            includingResourceValuesForKeys: nil,
            relativeTo: nil
        )
        audienceFace = .customImage
    }

    func clearCustomBackgroundImage() {
        customBackgroundImageBookmark = nil
        customBackgroundImagePath = ""
    }

    func resetCustomBackgroundImageFraming() {
        customBackgroundImageScale = Self.defaultCustomBackgroundImageScale
        customBackgroundImageHorizontalOffset = Self.defaultCustomBackgroundImageHorizontalOffset
        customBackgroundImageVerticalOffset = Self.defaultCustomBackgroundImageVerticalOffset
    }

    static let defaultWidth: CGFloat = 340
    static let defaultHeight: CGFloat = 150
    static let defaultLocale: String = Locale.current.identifier
    static let defaultCustomBackgroundImageOpacity = 0.24
    static let defaultCustomBackgroundImageScale = 1.0
    static let defaultCustomBackgroundImageHorizontalOffset = 0.0
    static let defaultCustomBackgroundImageVerticalOffset = 0.0

    static let minWidth: CGFloat = 310
    static let maxWidth: CGFloat = 500
    static let minHeight: CGFloat = 50
    static let maxHeight: CGFloat = 400

    init() {
        let savedWidth = UserDefaults.standard.double(forKey: "notchWidth")
        let savedHeight = UserDefaults.standard.double(forKey: "textAreaHeight")
        let initialFontSizePreset = FontSizePreset(rawValue: UserDefaults.standard.string(forKey: "fontSizePreset") ?? "") ?? .lg
        let initialFontFamilyPreset = FontFamilyPreset(rawValue: UserDefaults.standard.string(forKey: "fontFamilyPreset") ?? "") ?? .sans

        self.notchWidth = savedWidth > 0 ? CGFloat(savedWidth) : Self.defaultWidth
        self.textAreaHeight = savedHeight > 0 ? CGFloat(savedHeight) : Self.defaultHeight
        self.speechLocale = UserDefaults.standard.string(forKey: "speechLocale") ?? Self.defaultLocale
        self.fontSizePreset = initialFontSizePreset
        self.fontFamilyPreset = initialFontFamilyPreset
        self.fontColorPreset = FontColorPreset(rawValue: UserDefaults.standard.string(forKey: "fontColorPreset") ?? "") ?? .white
        self.cueColorPreset = FontColorPreset(rawValue: UserDefaults.standard.string(forKey: "cueColorPreset") ?? "") ?? .white
        self.cueBrightness = CueBrightness(rawValue: UserDefaults.standard.string(forKey: "cueBrightness") ?? "") ?? .dim
        self.audienceFace = AudienceFace(rawValue: UserDefaults.standard.string(forKey: "audienceFace") ?? "") ?? .off
        self.customBackgroundImageBookmark = UserDefaults.standard.data(forKey: Self.customBackgroundImageBookmarkKey)
        self.customBackgroundImagePath = UserDefaults.standard.string(forKey: Self.customBackgroundImagePathKey) ?? ""
        let savedCustomBackgroundImageOpacity = UserDefaults.standard.double(forKey: "customBackgroundImageOpacity")
        self.customBackgroundImageOpacity = savedCustomBackgroundImageOpacity > 0 ? savedCustomBackgroundImageOpacity : Self.defaultCustomBackgroundImageOpacity
        let savedCustomBackgroundImageScale = UserDefaults.standard.double(forKey: "customBackgroundImageScale")
        self.customBackgroundImageScale = savedCustomBackgroundImageScale > 0 ? savedCustomBackgroundImageScale : Self.defaultCustomBackgroundImageScale
        self.customBackgroundImageHorizontalOffset =
            UserDefaults.standard.object(forKey: "customBackgroundImageHorizontalOffset") == nil
            ? Self.defaultCustomBackgroundImageHorizontalOffset
            : UserDefaults.standard.double(forKey: "customBackgroundImageHorizontalOffset")
        self.customBackgroundImageVerticalOffset =
            UserDefaults.standard.object(forKey: "customBackgroundImageVerticalOffset") == nil
            ? Self.defaultCustomBackgroundImageVerticalOffset
            : UserDefaults.standard.double(forKey: "customBackgroundImageVerticalOffset")
        self.overlayMode = OverlayMode(rawValue: UserDefaults.standard.string(forKey: "overlayMode") ?? "") ?? .pinned
        self.notchDisplayMode = NotchDisplayMode(rawValue: UserDefaults.standard.string(forKey: "notchDisplayMode") ?? "") ?? .followMouse
        let savedPinnedScreenID = UserDefaults.standard.integer(forKey: "pinnedScreenID")
        self.pinnedScreenID = UInt32(savedPinnedScreenID)
        self.floatingGlassEffect = UserDefaults.standard.object(forKey: "floatingGlassEffect") as? Bool ?? false
        let savedOpacity = UserDefaults.standard.double(forKey: "glassOpacity")
        self.glassOpacity = savedOpacity > 0 ? savedOpacity : 0.15
        self.overlayTransparency = UserDefaults.standard.object(forKey: "overlayTransparency") as? Bool ?? false
        let savedTransparencyOpacity = UserDefaults.standard.double(forKey: "overlayTransparencyOpacity")
        self.overlayTransparencyOpacity = savedTransparencyOpacity > 0 ? savedTransparencyOpacity : 0.85
        self.followCursorWhenUndocked = UserDefaults.standard.object(forKey: "followCursorWhenUndocked") as? Bool ?? false
        self.externalDisplayMode = ExternalDisplayMode(rawValue: UserDefaults.standard.string(forKey: "externalDisplayMode") ?? "") ?? .off
        let savedScreenID = UserDefaults.standard.integer(forKey: "externalScreenID")
        self.externalScreenID = UInt32(savedScreenID)
        self.mirrorAxis = MirrorAxis(rawValue: UserDefaults.standard.string(forKey: "mirrorAxis") ?? "") ?? .horizontal
        self.listeningMode = ListeningMode(rawValue: UserDefaults.standard.string(forKey: "listeningMode") ?? "") ?? .wordTracking
        let savedSpeed = UserDefaults.standard.double(forKey: "scrollSpeed")
        self.scrollSpeed = savedSpeed > 0 ? savedSpeed : 3
        self.hideFromScreenShare = UserDefaults.standard.object(forKey: "hideFromScreenShare") as? Bool ?? true
        self.showElapsedTime = UserDefaults.standard.object(forKey: "showElapsedTime") as? Bool ?? true
        self.selectedMicUID = UserDefaults.standard.string(forKey: "selectedMicUID") ?? ""
        self.autoNextPage = UserDefaults.standard.object(forKey: "autoNextPage") as? Bool ?? false
        let savedDelay = UserDefaults.standard.integer(forKey: "autoNextPageDelay")
        self.autoNextPageDelay = savedDelay > 0 ? savedDelay : 3
        let savedFullscreenScreenID = UserDefaults.standard.integer(forKey: "fullscreenScreenID")
        self.fullscreenScreenID = UInt32(savedFullscreenScreenID)
        self.browserServerEnabled = UserDefaults.standard.object(forKey: "browserServerEnabled") as? Bool ?? false
        let savedPort = UserDefaults.standard.integer(forKey: "browserServerPort")
        self.browserServerPort = savedPort > 0 ? UInt16(savedPort) : 7373
        self.directorModeEnabled = UserDefaults.standard.object(forKey: "directorModeEnabled") as? Bool ?? false
        let savedDirectorPort = UserDefaults.standard.integer(forKey: "directorServerPort")
        self.directorServerPort = savedDirectorPort > 0 ? UInt16(savedDirectorPort) : 7575
    }
}
