import AppKit
@preconcurrency import AVFoundation
import CoreAudio
import CoreImage
import SwiftUI

enum AppSetupPreferences {
    private static let completedKey = "cueRecord.initialSetupCompleted"

    static var initialSetupCompleted: Bool {
        get { UserDefaults.standard.bool(forKey: completedKey) }
        set { UserDefaults.standard.set(newValue, forKey: completedKey) }
    }
}

private enum AppSetupStep: Int, CaseIterable {
    case permissions
    case workspace

    var title: String {
        switch self {
        case .permissions:
            return "Permissions"
        case .workspace:
            return "Workspace"
        }
    }
}

private enum SetupPermissionPage: Int, CaseIterable {
    case microphone
    case camera
    case screen

    var title: String {
        switch self {
        case .microphone:
            return "Microphone"
        case .camera:
            return "Camera"
        case .screen:
            return "Screen"
        }
    }

    var systemImage: String {
        switch self {
        case .microphone:
            return "mic.fill"
        case .camera:
            return "camera.fill"
        case .screen:
            return "rectangle.dashed"
        }
    }
}

struct AppSetupView: View {
    @ObservedObject var service: CueRecordService
    @ObservedObject var controller: RecordingController
    @ObservedObject var permissionsManager: PermissionsManager
    @ObservedObject var audioManager: AudioManager
    @ObservedObject var cameraManager: CameraManager

    let onComplete: () -> Void

    @State private var currentStep: AppSetupStep = .permissions
    @State private var currentPermissionPage: SetupPermissionPage = .microphone
    @State private var selectedVaultURL: URL?
    @State private var isCheckingPermissions = false
    @State private var isRequestingPermission = false

    var body: some View {
        VStack(spacing: 0) {
            setupHeader

            Divider()

            Group {
                switch currentStep {
                case .permissions:
                    permissionsStep
                case .workspace:
                    workspaceStep
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

            Divider()

            footer
        }
        .frame(width: 620, height: 430)
        .background(Color(nsColor: .windowBackgroundColor))
        .task {
            selectedVaultURL = service.vaultURL
            await refreshPermissions()
            if permissionsManager.allPermissionsGranted {
                currentStep = .workspace
            } else {
                currentPermissionPage = firstIncompletePermissionPage ?? .microphone
            }
        }
    }

    private var setupHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                CueRecordLogoView(cornerRadius: 8)
                    .frame(width: 34, height: 34)

                Text("Set Up CueRecord")
                    .font(.title3)
                    .fontWeight(.semibold)

                Spacer()
            }

            HStack(spacing: 10) {
                ForEach(AppSetupStep.allCases, id: \.self) { step in
                    StepPill(
                        title: step.title,
                        index: step.rawValue + 1,
                        isActive: currentStep == step,
                        isComplete: step.rawValue < currentStep.rawValue
                    )

                    if step != AppSetupStep.allCases.last {
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                }

                Spacer()
            }
        }
        .padding(.top, 18)
        .padding(.horizontal, 26)
        .padding(.bottom, 14)
    }

    private var permissionsStep: some View {
        VStack(alignment: .leading, spacing: 12) {
            PermissionStepBar(
                currentPage: currentPermissionPage,
                permissionsManager: permissionsManager
            )

            Group {
                switch currentPermissionPage {
                case .microphone:
                    MicrophonePermissionPreview(
                        permissionsManager: permissionsManager,
                        audioManager: audioManager
                    )
                case .camera:
                    CameraPermissionPreview(
                        permissionsManager: permissionsManager,
                        cameraManager: cameraManager
                    )
                case .screen:
                    ScreenPermissionPreview(
                        permissionsManager: permissionsManager,
                        isBusy: isRequestingPermission || isCheckingPermissions
                    ) {
                        await requestPermission {
                            await permissionsManager.requestScreenRecordingPermission()
                        }
                    }
                }
            }
            .groupedPanelStyle()

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 26)
        .padding(.top, 20)
        .padding(.bottom, 12)
    }

    private var workspaceStep: some View {
        VStack(alignment: .leading, spacing: 12) {
            DirectorySetupRow(
                selectedDirectory: selectedVaultURL,
                onSelect: selectVault
            )
            .groupedPanelStyle()

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 26)
        .padding(.top, 26)
        .padding(.bottom, 12)
    }

    private var footer: some View {
        HStack(spacing: 10) {
            if currentStep == .permissions {
                Button {
                    Task {
                        await refreshPermissions()
                    }
                } label: {
                    Label(isCheckingPermissions ? "Checking" : "Recheck", systemImage: "arrow.clockwise")
                        .frame(minWidth: 104)
                }
                .disabled(isCheckingPermissions || isRequestingPermission)
            } else {
                Button {
                    currentStep = .permissions
                } label: {
                    Label("Back", systemImage: "arrow.left")
                        .frame(minWidth: 88)
                }
            }

            Spacer()

            if currentStep == .permissions {
                Button {
                    if permissionsManager.allPermissionsGranted {
                        currentStep = .workspace
                    } else {
                        advancePermissionPage()
                    }
                } label: {
                    Label(permissionsManager.allPermissionsGranted ? "Choose Workspace" : "Next", systemImage: "arrow.right")
                        .frame(minWidth: permissionsManager.allPermissionsGranted ? 150 : 92)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isCurrentPermissionGranted)
            } else {
                Button {
                    finishSetup()
                } label: {
                    Label("Finish Setup", systemImage: "checkmark")
                        .frame(minWidth: 118)
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectedVaultURL == nil)
            }
        }
        .frame(height: 54)
        .padding(.horizontal, 26)
    }

    private func requestPermission(_ action: @escaping () async -> Void) async {
        isRequestingPermission = true
        await action()
        await refreshPermissions()
        isRequestingPermission = false
    }

    private func refreshPermissions() async {
        isCheckingPermissions = true
        await permissionsManager.checkAllPermissions()
        isCheckingPermissions = false
    }

    private var isCurrentPermissionGranted: Bool {
        isGranted(currentPermissionPage)
    }

    private var firstIncompletePermissionPage: SetupPermissionPage? {
        SetupPermissionPage.allCases.first { !isGranted($0) }
    }

    private func advancePermissionPage() {
        guard let currentIndex = SetupPermissionPage.allCases.firstIndex(of: currentPermissionPage) else {
            currentPermissionPage = firstIncompletePermissionPage ?? .microphone
            return
        }

        let remainingPages = SetupPermissionPage.allCases.dropFirst(currentIndex + 1)
        currentPermissionPage = remainingPages.first(where: { !isGranted($0) })
            ?? firstIncompletePermissionPage
            ?? .microphone
    }

    private func isGranted(_ page: SetupPermissionPage) -> Bool {
        switch page {
        case .microphone:
            return permissionsManager.microphoneAuthorized
        case .camera:
            return permissionsManager.cameraAuthorized
        case .screen:
            return permissionsManager.screenRecordingAuthorized
        }
    }

    private func selectVault() {
        let panel = NSOpenPanel()
        panel.title = "Choose CueRecord Workspace"
        panel.prompt = "Choose"
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.canCreateDirectories = true
        panel.allowsMultipleSelection = false
        panel.directoryURL = selectedVaultURL ?? service.vaultURL

        if panel.runModal() == .OK, let url = panel.url {
            selectedVaultURL = url
            service.setVaultFolder(url)
            if let projectURL = service.currentProjectDirectoryURL() {
                controller.recordingState.outputDirectory = projectURL
            }
        }
    }

    private func finishSetup() {
        guard let selectedVaultURL else { return }

        service.setVaultFolder(selectedVaultURL)
        if let projectURL = service.currentProjectDirectoryURL() {
            controller.recordingState.outputDirectory = projectURL
        }
        AppSetupPreferences.initialSetupCompleted = true
        onComplete()
    }
}

private struct StepPill: View {
    let title: String
    let index: Int
    let isActive: Bool
    let isComplete: Bool

    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(indicatorColor)
                    .frame(width: 24, height: 24)

                if isComplete {
                    Image(systemName: "checkmark")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                } else {
                    Text("\(index)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(isActive ? .white : .secondary)
                }
            }

            Text(title)
                .font(.callout)
                .fontWeight(isActive ? .semibold : .regular)
                .foregroundStyle(isActive ? .primary : .secondary)
        }
    }

    private var indicatorColor: Color {
        if isComplete {
            return .green
        }
        return isActive ? Color.accentColor : Color(nsColor: .separatorColor)
    }
}

private struct PermissionStepBar: View {
    let currentPage: SetupPermissionPage
    @ObservedObject var permissionsManager: PermissionsManager

    var body: some View {
        HStack(spacing: 8) {
            ForEach(SetupPermissionPage.allCases, id: \.self) { page in
                HStack(spacing: 7) {
                    Image(systemName: page.systemImage)
                        .font(.caption)

                    Text(page.title)
                        .font(.caption)
                        .fontWeight(.medium)

                    if isGranted(page) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption2)
                            .foregroundStyle(.green)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 32)
                .foregroundStyle(currentPage == page ? .primary : .secondary)
                .background(
                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .fill(currentPage == page ? Color(nsColor: .controlAccentColor).opacity(0.18) : Color.clear)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .stroke(currentPage == page ? Color.accentColor.opacity(0.45) : Color(nsColor: .separatorColor), lineWidth: 1)
                )
            }
        }
    }

    private func isGranted(_ page: SetupPermissionPage) -> Bool {
        switch page {
        case .microphone:
            return permissionsManager.microphoneAuthorized
        case .camera:
            return permissionsManager.cameraAuthorized
        case .screen:
            return permissionsManager.screenRecordingAuthorized
        }
    }
}

private struct DirectorySetupRow: View {
    let selectedDirectory: URL?
    let onSelect: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "folder.fill")
                .font(.title3)
                .foregroundStyle(Color.accentColor)
                .frame(width: 30, height: 30)

            VStack(alignment: .leading, spacing: 4) {
                Text(selectedDirectory?.lastPathComponent ?? "Workspace")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(1)

                Text(selectedDirectory?.path ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .truncationMode(.middle)
            }

            Spacer(minLength: 12)

            Button("Choose") {
                onSelect()
            }
            .frame(width: 82)
        }
        .frame(minHeight: 72)
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
    }
}

private extension View {
    func groupedPanelStyle() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color(nsColor: .controlBackgroundColor))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(nsColor: .separatorColor), lineWidth: 1)
            )
    }
}
