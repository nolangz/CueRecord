import SwiftUI

struct RecordingSettingsView: View {
    @ObservedObject private var interfaceLanguage = InterfaceLanguageSettings.shared
    @ObservedObject private var controller: RecordingController
    @ObservedObject private var recordingState: RecordingState
    @ObservedObject private var permissionsManager: PermissionsManager
    @ObservedObject private var audioManager: AudioManager
    @ObservedObject private var cameraManager: CameraManager

    @MainActor
    init() {
        self.init(controller: RecordingController.shared)
    }

    @MainActor
    init(controller: RecordingController) {
        self.controller = controller
        self.recordingState = controller.recordingState
        self.permissionsManager = controller.permissionsManager
        self.audioManager = controller.audioManager
        self.cameraManager = controller.cameraManager
    }

    private func t(_ english: String) -> String {
        interfaceLanguage.text(english)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                permissionsSection

                Divider()

                recordingControls

                if let lastError = controller.lastError {
                    Label(lastError, systemImage: "exclamationmark.triangle")
                        .font(.system(size: 11))
                        .foregroundStyle(.orange)
                }

                Divider()

                captureSettings

                Divider()

                if recordingState.captureMode == .selectedArea {
                    areaSettings

                    Divider()
                }

                cameraSettings

                Text(t("Each recording is saved in the current project folder."))
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
            }
            .padding(16)
        }
        .onAppear {
            controller.refreshDevicesAndPermissions()
            controller.beginPreview()
        }
        .onDisappear {
            controller.endPreview()
        }
        .onChange(of: recordingState.captureMode) { _, _ in
            controller.updatePreview()
        }
        .onChange(of: recordingState.areaAspectRatioPreset) { _, _ in
            controller.updatePreview()
        }
        .onChange(of: recordingState.cameraOverlayEnabled) { _, _ in
            controller.updatePreview()
        }
        .onChange(of: recordingState.cameraOverlayPosition) { _, _ in
            controller.resetCustomCameraOverlayFrame()
        }
        .onChange(of: recordingState.cameraOverlaySize) { _, _ in
            controller.updatePreview()
        }
        .onChange(of: recordingState.cameraOverlayShape) { _, _ in
            controller.updatePreview()
        }
        .onChange(of: cameraManager.selectedCameraID) { _, _ in
            controller.restartCameraPreview()
        }
    }

    private var permissionsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(t("Permissions"))
                    .font(.system(size: 13, weight: .semibold))
                Spacer()
                Button(t("Grant")) {
                    controller.requestPermissions()
                }
                .controlSize(.small)
            }

            HStack(spacing: 8) {
                permissionBadge(t("Screen"), granted: permissionsManager.screenRecordingAuthorized)
                permissionBadge(t("Mic"), granted: permissionsManager.microphoneAuthorized)
                permissionBadge(t("Camera"), granted: permissionsManager.cameraAuthorized)
            }
        }
    }

    private var recordingControls: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(recordingState.isRecording ? timeString(from: recordingState.recordingDuration) : t("Ready"))
                    .font(.system(size: 13, weight: .semibold, design: .monospaced))
                    .foregroundStyle(recordingState.isRecording ? .red : .secondary)
                Spacer()
                if controller.isStarting {
                    ProgressView()
                        .controlSize(.small)
                }
            }

            settingPicker(t("Mode"), selection: $recordingState.captureMode) {
                ForEach(RecordingCaptureMode.allCases, id: \.self) { mode in
                    Text(mode.localizedDisplayName).tag(mode)
                }
            }
            .disabled(recordingState.isRecording || controller.isStarting)
        }
    }

    private var captureSettings: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(t("Audio"))
                .font(.system(size: 13, weight: .semibold))

            Toggle(t("Microphone"), isOn: $recordingState.microphoneEnabled)
                .toggleStyle(.checkbox)

            if recordingState.microphoneEnabled {
                HStack(spacing: 8) {
                    Text(t("Input"))
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                        .frame(width: 54, alignment: .leading)

                    Picker("", selection: $audioManager.selectedMicrophone) {
                        ForEach(audioManager.availableMicrophones) { device in
                            Text(device.name).tag(device)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .disabled(audioManager.isLoading || recordingState.isRecording)

                    if audioManager.isLoading {
                        ProgressView()
                            .controlSize(.small)
                    }
                }

                Text(audioManager.getRecommendedAudioConfiguration().description)
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
            }

            Toggle(t("System Audio"), isOn: $recordingState.systemAudioEnabled)
                .toggleStyle(.checkbox)
        }
    }

    private var areaSettings: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(t("Area Ratio"))
                .font(.system(size: 13, weight: .semibold))

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                ForEach(AreaAspectRatioPreset.allCases, id: \.self) { preset in
                    Button {
                        recordingState.areaAspectRatioPreset = preset
                    } label: {
                        VStack(spacing: 2) {
                            Text(preset.localizedTitle)
                                .font(.system(size: 13, weight: .semibold))
                            Text(preset.localizedSubtitle)
                                .font(.system(size: 10))
                                .foregroundStyle(recordingState.areaAspectRatioPreset == preset ? .white.opacity(0.75) : .secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 46)
                        .contentShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(recordingState.areaAspectRatioPreset == preset ? .white : .primary)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(recordingState.areaAspectRatioPreset == preset ? Color.accentColor : Color.primary.opacity(0.04))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(recordingState.areaAspectRatioPreset == preset ? Color.accentColor : Color.primary.opacity(0.12), lineWidth: 1)
                    )
                    .disabled(recordingState.isRecording)
                }
            }
        }
    }

    private var cameraSettings: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle(t("Camera Overlay"), isOn: $recordingState.cameraOverlayEnabled)
                .toggleStyle(.checkbox)

            if recordingState.cameraOverlayEnabled {
                HStack(spacing: 8) {
                    Text(t("Camera"))
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                        .frame(width: 54, alignment: .leading)

                    Picker("", selection: $cameraManager.selectedCameraID) {
                        if cameraManager.availableCameras.isEmpty {
                            Text(t("No Camera")).tag("")
                        } else {
                            ForEach(cameraManager.availableCameras) { camera in
                                Text(camera.name).tag(camera.id)
                            }
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .disabled(cameraManager.availableCameras.isEmpty || recordingState.isRecording)
                }

                settingPicker(t("Shape"), selection: $recordingState.cameraOverlayShape) {
                    ForEach(CameraOverlayShape.allCases, id: \.self) { shape in
                        Text(shape.localizedDisplayName).tag(shape)
                    }
                }

                settingPicker(t("Position"), selection: $recordingState.cameraOverlayPosition) {
                    ForEach(CameraOverlayPosition.allCases, id: \.self) { position in
                        Text(position.localizedDisplayName).tag(position)
                    }
                }

                settingPicker(t("Size"), selection: $recordingState.cameraOverlaySize) {
                    ForEach(CameraOverlaySize.allCases, id: \.self) { size in
                        Text(size.localizedDisplayName).tag(size)
                    }
                }
            }
        }
    }

    private func permissionBadge(_ label: String, granted: Bool) -> some View {
        HStack(spacing: 5) {
            Image(systemName: granted ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
            Text(label)
        }
        .font(.system(size: 11, weight: .medium))
        .foregroundStyle(granted ? Color.green : Color.orange)
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(
            Capsule()
                .fill((granted ? Color.green : Color.orange).opacity(0.12))
        )
    }

    private func settingPicker<SelectionValue: Hashable, Content: View>(
        _ label: String,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: () -> Content
    ) -> some View {
        HStack(spacing: 8) {
            Text(label)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
                .frame(width: 54, alignment: .leading)

            Picker("", selection: selection, content: content)
                .labelsHidden()
                .pickerStyle(.segmented)
        }
    }

    private func timeString(from duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
