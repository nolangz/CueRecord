import SwiftUI

struct AIScriptComposerSheet: View {
    @Environment(\.dismiss) private var dismiss

    let sourceTitle: String
    let sourceMarkdown: String
    let onGenerated: (String) -> Void

    @State private var selectedModel: AIScriptModel = .deepSeekV4Flash
    @State private var breathMarkerMode: AIBreathMarkerMode = .marked
    @State private var customPrompt = ""
    @State private var apiKey = ""
    @State private var isEditingAPIKey = false
    @State private var shouldSaveAPIKey = true
    @State private var isGenerating = false
    @State private var errorMessage: String?

    private let keyStore = DeepSeekAPIKeyStore.shared
    private let client = DeepSeekChatClient()

    private var hasSavedAPIKey: Bool {
        keyStore.hasAPIKey
    }

    private var requiresAPIKeyInput: Bool {
        !hasSavedAPIKey || isEditingAPIKey
    }

    private var canGenerate: Bool {
        !isGenerating
            && !sourceMarkdown.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && (!requiresAPIKeyInput || !apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header

            Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    modelSection
                    outputSection
                    promptSection
                    apiKeySection

                    if let errorMessage {
                        Text(errorMessage)
                            .font(.system(size: 12))
                            .foregroundStyle(.red)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(20)
            }

            Divider()

            footer
        }
        .frame(width: 520, height: 520)
        .background(.ultraThinMaterial)
        .onAppear {
            isEditingAPIKey = !hasSavedAPIKey
        }
    }

    private var header: some View {
        HStack(spacing: 12) {
            Image(systemName: "sparkles")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.accentColor)
                .frame(width: 34, height: 34)
                .background(Color.accentColor.opacity(0.12), in: RoundedRectangle(cornerRadius: 8, style: .continuous))

            VStack(alignment: .leading, spacing: 3) {
                Text("AI Breath Cuts")
                    .font(.system(size: 18, weight: .semibold))
                Text("Add natural teleprompter line breaks to \"\(sourceTitle)\"")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 5) {
                Text("Breath Marks")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(.secondary)

                Picker("Breath Marks", selection: $breathMarkerMode) {
                    ForEach(AIBreathMarkerMode.allCases) { mode in
                        Text(mode.label).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .frame(width: 142)
            }
        }
        .padding(20)
    }

    private var modelSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Model")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.secondary)

            Picker("Model", selection: $selectedModel) {
                ForEach(AIScriptModel.allCases) { model in
                    Text(model.displayName).tag(model)
                }
            }
            .pickerStyle(.segmented)

            Text(selectedModel.shortDescription)
                .font(.system(size: 11))
                .foregroundStyle(.tertiary)
        }
    }

    private var outputSection: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("Output")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 8) {
                Image(systemName: "text.line.first.and.arrowtriangle.forward")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color.accentColor)

                Text("Update current markdown")
                    .font(.system(size: 13, weight: .medium))

                Spacer()

                Text(breathMarkerMode.outputSummary)
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 32)
            .padding(.horizontal, 10)
            .background(Color.primary.opacity(0.06), in: RoundedRectangle(cornerRadius: 7, style: .continuous))
        }
    }

    private var promptSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Notes")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.secondary)

            TextEditor(text: $customPrompt)
                .font(.system(size: 13))
                .scrollContentBackground(.hidden)
                .padding(8)
                .frame(minHeight: 96)
                .background(Color.primary.opacity(0.05), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .overlay(alignment: .topLeading) {
                    if customPrompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text("Optional instructions, e.g. shorter lines, preserve paragraph shape, or cut more aggressively.")
                            .font(.system(size: 12))
                            .foregroundStyle(.tertiary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 16)
                            .allowsHitTesting(false)
                    }
                }
        }
    }

    private var apiKeySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("DeepSeek API Key")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.secondary)

                Spacer()

                if hasSavedAPIKey {
                    Button(isEditingAPIKey ? "Use Saved Key" : "Replace Key") {
                        isEditingAPIKey.toggle()
                        if !isEditingAPIKey {
                            apiKey = ""
                        }
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 12, weight: .medium))
                }
            }

            if requiresAPIKeyInput {
                SecureField("sk-...", text: $apiKey)
                    .textFieldStyle(.roundedBorder)

                Toggle("Save key in Keychain", isOn: $shouldSaveAPIKey)
                    .font(.system(size: 12))
            } else {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(.green)
                    Text("Saved key in Keychain")
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                .padding(.horizontal, 10)
                .frame(height: 30)
                .background(Color.primary.opacity(0.05), in: RoundedRectangle(cornerRadius: 7, style: .continuous))
            }
        }
    }

    private var footer: some View {
        HStack {
            Button("Cancel") {
                dismiss()
            }
            .keyboardShortcut(.cancelAction)

            Spacer()

            Button {
                Task {
                    await generate()
                }
            } label: {
                if isGenerating {
                    HStack(spacing: 8) {
                        ProgressView()
                            .controlSize(.small)
                        Text("Generating")
                    }
                } else {
                    Label("Apply Cuts", systemImage: "sparkles")
                }
            }
            .buttonStyle(.borderedProminent)
            .keyboardShortcut(.defaultAction)
            .disabled(!canGenerate)
        }
        .padding(20)
    }

    @MainActor
    private func generate() async {
        guard canGenerate else { return }
        errorMessage = nil
        isGenerating = true

        do {
            let resolvedAPIKey: String
            if requiresAPIKeyInput {
                let trimmed = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else { throw AIScriptError.invalidAPIKey }
                if shouldSaveAPIKey {
                    try keyStore.saveAPIKey(trimmed)
                }
                resolvedAPIKey = trimmed
            } else if let savedKey = keyStore.loadAPIKey() {
                resolvedAPIKey = savedKey
            } else {
                isEditingAPIKey = true
                throw AIScriptError.invalidAPIKey
            }

            let request = AIBreathCutRequest(
                sourceMarkdown: sourceMarkdown,
                customPrompt: customPrompt,
                model: selectedModel,
                markerMode: breathMarkerMode
            )
            let script = try await client.generateBreathCuts(request: request, apiKey: resolvedAPIKey)
            onGenerated(script)
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }

        isGenerating = false
    }
}
