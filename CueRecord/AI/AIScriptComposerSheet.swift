import SwiftUI

struct AIScriptComposerSheet: View {
    @Environment(\.dismiss) private var dismiss

    let sourceTitle: String
    let sourceMarkdown: String
    let onGenerated: (String, String) -> Void

    @State private var selectedModel: AIScriptModel = .deepSeekV4Flash
    @State private var selectedDuration: AIScriptDuration = .oneMinute
    @State private var customDuration = ""
    @State private var selectedAudience: AIScriptAudience = .general
    @State private var customAudience = ""
    @State private var selectedStyle: AIScriptStyle = .direct
    @State private var customStyle = ""
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
                    optionGrid
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
        .frame(width: 560, height: 640)
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
                Text("AI Script")
                    .font(.system(size: 18, weight: .semibold))
                Text("Create a new markdown script from \"\(sourceTitle)\"")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()
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

    private var optionGrid: some View {
        VStack(alignment: .leading, spacing: 10) {
            Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 14) {
                GridRow {
                    optionPicker(
                        title: "Duration",
                        selection: $selectedDuration,
                        options: AIScriptDuration.allCases
                    )

                    optionPicker(
                        title: "Audience",
                        selection: $selectedAudience,
                        options: AIScriptAudience.allCases
                    )
                }

                GridRow {
                    optionPicker(
                        title: "Style",
                        selection: $selectedStyle,
                        options: AIScriptStyle.allCases
                    )

                    VStack(alignment: .leading, spacing: 7) {
                        Text("Output")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.secondary)

                        Text("New markdown file")
                            .font(.system(size: 13, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 28)
                            .padding(.horizontal, 10)
                            .background(Color.primary.opacity(0.06), in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                    }
                }
            }

            if selectedDuration == .custom {
                TextField("Custom duration, e.g. 2 minutes or 800 words", text: $customDuration)
                    .textFieldStyle(.roundedBorder)
            }

            if selectedAudience == .custom {
                TextField("Custom audience", text: $customAudience)
                    .textFieldStyle(.roundedBorder)
            }

            if selectedStyle == .custom {
                TextField("Custom style", text: $customStyle)
                    .textFieldStyle(.roundedBorder)
            }
        }
    }

    private func optionPicker<Option: Identifiable & CaseIterable & Hashable>(
        title: String,
        selection: Binding<Option>,
        options: Option.AllCases
    ) -> some View where Option.AllCases: RandomAccessCollection, Option: DisplayNamedOption {
        VStack(alignment: .leading, spacing: 7) {
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.secondary)

            Picker(title, selection: selection) {
                ForEach(Array(options), id: \.self) { option in
                    Text(option.displayName).tag(option)
                }
            }
            .labelsHidden()
            .frame(maxWidth: .infinity)
        }
    }

    private var promptSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Custom Prompt")
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
                        Text("Optional instructions, e.g. keep the intro punchy, include a call to action, or make it founder-led.")
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
                    Label("Create Script", systemImage: "sparkles")
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

            let request = AIScriptGenerationRequest(
                sourceMarkdown: sourceMarkdown,
                duration: resolvedDuration,
                audience: resolvedAudience,
                style: resolvedStyle,
                customPrompt: customPrompt,
                model: selectedModel
            )
            let script = try await client.generateScript(request: request, apiKey: resolvedAPIKey)
            onGenerated(script, generatedTitle)
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }

        isGenerating = false
    }

    private var resolvedDuration: String {
        if selectedDuration == .custom {
            let trimmed = customDuration.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty ? "the length that best fits the source" : trimmed
        }
        return selectedDuration.promptValue
    }

    private var resolvedAudience: String {
        if selectedAudience == .custom {
            let trimmed = customAudience.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty ? "general viewers" : trimmed
        }
        return selectedAudience.displayName
    }

    private var resolvedStyle: String {
        if selectedStyle == .custom {
            let trimmed = customStyle.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty ? "direct and clear" : trimmed
        }
        return selectedStyle.displayName
    }

    private var generatedTitle: String {
        let trimmedSourceTitle = sourceTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let base = trimmedSourceTitle.isEmpty ? "Untitled" : trimmedSourceTitle
        return "AI Script - \(base)"
    }
}

protocol DisplayNamedOption {
    var displayName: String { get }
}

extension AIScriptDuration: DisplayNamedOption {}
extension AIScriptAudience: DisplayNamedOption {}
extension AIScriptStyle: DisplayNamedOption {}
