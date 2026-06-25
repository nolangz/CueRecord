//
//  CueRecordApp.swift
//  CueRecord
//
//

import SwiftUI

private let supportedCueRecordFileExtensions: Set<String> = ["md", "cuerecord", "takeone", "cueshot"]

extension Notification.Name {
    static let openSettings = Notification.Name("openSettings")
    static let openAbout = Notification.Name("openAbout")
}

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false
        let launchedByURL: Bool
        if let event = NSAppleEventManager.shared().currentAppleEvent {
            launchedByURL = event.eventClass == kInternetEventClass
        } else {
            launchedByURL = false
        }
        if launchedByURL {
            CueRecordService.shared.launchedExternally = true
            NSApp.setActivationPolicy(.accessory)
        }
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.servicesProvider = CueRecordService.shared
        NSUpdateDynamicServices()

        if CueRecordService.shared.launchedExternally {
            CueRecordService.shared.hideMainWindow()
        }

        // Silent update check on launch
        UpdateChecker.shared.checkForUpdates(silent: true)

        // Start browser server if enabled
        CueRecordService.shared.updateBrowserServer()

        // Start director server if enabled
        CueRecordService.shared.updateDirectorServer()

        // Set window delegate to intercept close, disable tabs and fullscreen
        DispatchQueue.main.async {
            for window in NSApp.windows where !(window is NSPanel) {
                window.delegate = self
                window.tabbingMode = .disallowed
                window.collectionBehavior.remove(.fullScreenPrimary)
                window.collectionBehavior.insert(.fullScreenNone)
            }
            self.removeUnwantedMenus()
        }
    }

    private func removeUnwantedMenus() {
        guard let mainMenu = NSApp.mainMenu else { return }
        // Remove View and Window menus (keep Edit for copy/paste)
        let menusToRemove = ["View", "Window"]
        for title in menusToRemove {
            if let index = mainMenu.items.firstIndex(where: { $0.title == title }) {
                mainMenu.removeItem(at: index)
            }
        }
    }

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        CueRecordService.shared.saveFile()
        NSApp.terminate(nil)
        return false
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if CueRecordService.shared.launchedExternally {
            CueRecordService.shared.launchedExternally = false
            NSApp.setActivationPolicy(.regular)
        }
        if !flag {
            // Show existing window instead of letting SwiftUI create a duplicate
            for window in NSApp.windows where !(window is NSPanel) {
                window.makeKeyAndOrderFront(nil)
                return false
            }
        }
        return true
    }

    func application(_ application: NSApplication, open urls: [URL]) {
        for url in urls {
            if url.hasDirectoryPath || supportedCueRecordFileExtensions.contains(url.pathExtension.lowercased()) {
                CueRecordService.shared.openFileAtURL(url)
                // Show the main window for file opens
                for window in NSApp.windows where !(window is NSPanel) {
                    window.makeKeyAndOrderFront(nil)
                }
                NSApp.activate(ignoringOtherApps: true)
            } else {
                let wasExternal = CueRecordService.shared.launchedExternally
                CueRecordService.shared.launchedExternally = true
                if !wasExternal {
                    NSApp.setActivationPolicy(.accessory)
                }
                CueRecordService.shared.hideMainWindow()
                CueRecordService.shared.handleURL(url)
            }
        }
    }
}

@main
struct CueRecordApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var interfaceLanguage = InterfaceLanguageSettings.shared

    init() {
        // Belt-and-suspenders for a Swift 6 / macOS 26 concurrency runtime crash.
        // The primary fix is the LSEnvironment entry in Info.plist; this also sets
        // the flag from code in case the app is launched on a path that bypasses
        // LaunchServices. Forcing the legacy, non-crashing "is current executor"
        // check avoids EXC_BAD_ACCESS in swift_task_isCurrentExecutorImpl when a
        // display/audio route change (e.g. connecting a Studio Display) leaves the
        // runtime with a corrupted SerialExecutorRef during SwiftUI button dispatch.
        setenv("SWIFT_IS_CURRENT_EXECUTOR_LEGACY_MODE_OVERRIDE", "nocrash", 0)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    if url.hasDirectoryPath || supportedCueRecordFileExtensions.contains(url.pathExtension.lowercased()) {
                        CueRecordService.shared.openFileAtURL(url)
                    } else {
                        CueRecordService.shared.handleURL(url)
                    }
                }
        }
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 740, height: 430)
        .windowResizability(.contentSize)

        .commands {
            CommandGroup(replacing: .appInfo) {
                Button(interfaceLanguage.text("About CueRecord")) {
                    NotificationCenter.default.post(name: .openAbout, object: nil)
                }
                Divider()
                Button(interfaceLanguage.text("Check for Updates…")) {
                    UpdateChecker.shared.checkForUpdates()
                }
            }
            CommandGroup(after: .appSettings) {
                Button(interfaceLanguage.text("Settings…")) {
                    NotificationCenter.default.post(name: .openSettings, object: nil)
                }
                .keyboardShortcut(",", modifiers: .command)
            }
            CommandGroup(replacing: .newItem) {
                Button(interfaceLanguage.text("Open Folder…")) {
                    CueRecordService.shared.openFile()
                }
                .keyboardShortcut("o", modifiers: .command)
            }
            CommandGroup(replacing: .saveItem) { }
            CommandGroup(replacing: .windowArrangement) { }
            CommandGroup(replacing: .help) {
                Button(interfaceLanguage.text("CueRecord Help")) {
                    if let url = URL(string: "https://github.com/nolanlai/cuerecord") {
                        NSWorkspace.shared.open(url)
                    }
                }
            }
        }
    }
}
