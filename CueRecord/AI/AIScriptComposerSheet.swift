import SwiftUI

struct AIScriptComposerSheet: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var interfaceLanguage = InterfaceLanguageSettings.shared

    let sourceTitle: String
    let sourceMarkdown: String
    let onSubmit: (AIBreathCutSubmission) -> Void

    @State private var selectedProviderID = AIScriptModelSelectionStorage.selectedProviderID()
    @State private var selectedModelID = AIScriptModelSelectionStorage.selectedModelID()
    @State private var customProviderName = AIScriptModelSelectionStorage.customProviderName()
    @State private var customBaseURL = AIScriptModelSelectionStorage.customBaseURL()
    @State private var customModelID = AIScriptModelSelectionStorage.customModelID()
    @State private var customProviderRequiresAPIKey = AIScriptModelSelectionStorage.customProviderRequiresAPIKey()
    @State private var breathMarkerMode: AIBreathMarkerMode = .marked
    @State private var customPrompt = ""
    @State private var apiKey = ""
    @State private var isEditingAPIKey = false
    @State private var shouldSaveAPIKey = true
    @State private var errorMessage: String?

    private let keyStore = AIProviderAPIKeyStore.shared

    private var selectedProvider: AIScriptProvider {
        AIScriptProviderCatalog.provider(for: selectedProviderID)
    }

    private var usesCustomProvider: Bool {
        selectedProviderID == AIScriptProviderCatalog.customProviderID
    }

    private var usesCustomModel: Bool {
        usesCustomProvider || selectedModelID == AIScriptProviderCatalog.customModelID
    }

    private var selectedModelPreset: AIScriptModelPreset? {
        selectedProvider.modelPreset(for: selectedModelID)
    }

    private var activeRequiresAPIKey: Bool {
        usesCustomProvider ? customProviderRequiresAPIKey : selectedProvider.requiresAPIKey
    }

    private var activeKeychainAccount: String {
        guard usesCustomProvider else { return selectedProvider.id }
        let normalizedBaseURL = customBaseURL
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        guard !normalizedBaseURL.isEmpty else { return AIScriptProviderCatalog.customProviderID }
        return "\(AIScriptProviderCatalog.customProviderID):\(normalizedBaseURL)"
    }

    private var activeAPIKeyLabel: String {
        let label = t(selectedProvider.apiKeyLabel)
        return activeRequiresAPIKey ? label : "\(label) (\(t("optional")))"
    }

    private var selectedModelDescription: String {
        if usesCustomModel {
            return t(AIScriptProviderCatalog.customModelPreset.shortDescription)
        }
        return selectedModelPreset?.localizedShortDescription ?? ""
    }

    private var hasSavedAPIKey: Bool {
        keyStore.hasAPIKey(for: activeKeychainAccount)
    }

    private var requiresAPIKeyInput: Bool {
        !hasSavedAPIKey || isEditingAPIKey
    }

    private var canGenerate: Bool {
        !sourceMarkdown.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && (try? makeModelConfiguration()) != nil
            && (!activeRequiresAPIKey || !requiresAPIKeyInput || !apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

    private func t(_ english: String) -> String {
        interfaceLanguage.text(english)
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
        .frame(width: 560, height: 640)
        .background(.ultraThinMaterial)
        .onAppear {
            refreshAPIKeyEditingState()
        }
        .onChange(of: selectedProviderID) { _, _ in
            selectedModelID = AIScriptProviderCatalog.defaultModelID(for: selectedProvider)
            refreshAPIKeyEditingState()
        }
        .onChange(of: customBaseURL) { _, _ in
            refreshAPIKeyEditingState()
        }
        .onChange(of: customProviderRequiresAPIKey) { _, _ in
            refreshAPIKeyEditingState()
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
                Text(t("AI Breath Cuts"))
                    .font(.system(size: 18, weight: .semibold))
                Text(interfaceLanguage.format("Add natural teleprompter line breaks to \"%@\"", sourceTitle))
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 5) {
                Text(t("Breath Marks"))
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(.secondary)

                Picker(t("Breath Marks"), selection: $breathMarkerMode) {
                    ForEach(AIBreathMarkerMode.allCases) { mode in
                        Text(mode.localizedLabel).tag(mode)
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
            Text(t("Provider"))
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.secondary)

            Picker(t("Provider"), selection: $selectedProviderID) {
                ForEach(AIScriptProviderCatalog.providers) { provider in
                    Text(t(provider.displayName)).tag(provider.id)
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity, alignment: .leading)

            Text(t(selectedProvider.shortDescription))
                .font(.system(size: 11))
                .foregroundStyle(.tertiary)

            if usesCustomProvider {
                customProviderSection
            } else {
                Text(t("Model"))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)

                Picker(t("Model"), selection: $selectedModelID) {
                    ForEach(selectedProvider.modelPresets) { model in
                        Text(model.displayName).tag(model.id)
                    }
                    Divider()
                    Text(t(AIScriptProviderCatalog.customModelPreset.displayName))
                        .tag(AIScriptProviderCatalog.customModelID)
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            if usesCustomModel {
                TextField(t("Model ID"), text: $customModelID)
                    .textFieldStyle(.roundedBorder)
            }

            Text(selectedModelDescription)
                .font(.system(size: 11))
                .foregroundStyle(.tertiary)
        }
    }

    private var customProviderSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField(t("Provider Name"), text: $customProviderName)
                .textFieldStyle(.roundedBorder)

            TextField(t("Base URL"), text: $customBaseURL)
                .textFieldStyle(.roundedBorder)

            Toggle(t("API key required"), isOn: $customProviderRequiresAPIKey)
                .font(.system(size: 12))
        }
        .padding(.top, 4)
    }

    private var outputSection: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(t("Output"))
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 8) {
                Image(systemName: "text.line.first.and.arrowtriangle.forward")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color.accentColor)

                Text(t("Create new markdown"))
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
            Text(t("Notes"))
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
                        Text(t("Optional instructions, e.g. shorter lines, preserve paragraph shape, or cut more aggressively."))
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
                Text(activeAPIKeyLabel)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.secondary)

                Spacer()

                if hasSavedAPIKey {
                    Button(isEditingAPIKey ? t("Use Saved Key") : t("Replace Key")) {
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
                SecureField(activeRequiresAPIKey ? "sk-..." : t("Optional"), text: $apiKey)
                    .textFieldStyle(.roundedBorder)

                Toggle(t("Save key in Keychain"), isOn: $shouldSaveAPIKey)
                    .font(.system(size: 12))
            } else {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(.green)
                    Text(t("Saved key in Keychain"))
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
            Button(t("Cancel")) {
                dismiss()
            }
            .keyboardShortcut(.cancelAction)

            Spacer()

            Button {
                submit()
            } label: {
                Label(t("Create Draft"), systemImage: "sparkles")
            }
            .buttonStyle(.borderedProminent)
            .keyboardShortcut(.defaultAction)
            .disabled(!canGenerate)
        }
        .padding(20)
    }

    @MainActor
    private func submit() {
        guard canGenerate else { return }
        errorMessage = nil

        do {
            let modelConfiguration = try makeModelConfiguration()
            let resolvedAPIKey: String?
            if requiresAPIKeyInput {
                let trimmed = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
                if modelConfiguration.requiresAPIKey && trimmed.isEmpty {
                    throw AIScriptError.invalidAPIKey
                }

                if !trimmed.isEmpty, shouldSaveAPIKey {
                    try keyStore.saveAPIKey(trimmed, for: modelConfiguration.keychainAccount)
                }
                resolvedAPIKey = trimmed.isEmpty ? nil : trimmed
            } else if let savedKey = keyStore.loadAPIKey(for: modelConfiguration.keychainAccount) {
                resolvedAPIKey = savedKey
            } else if !modelConfiguration.requiresAPIKey {
                resolvedAPIKey = nil
            } else {
                isEditingAPIKey = true
                throw AIScriptError.invalidAPIKey
            }

            let request = AIBreathCutRequest(
                sourceMarkdown: sourceMarkdown,
                customPrompt: customPrompt,
                model: modelConfiguration,
                markerMode: breathMarkerMode
            )
            saveModelSelection()
            onSubmit(AIBreathCutSubmission(
                request: request,
                apiKey: resolvedAPIKey,
                generatedTitle: generatedTitle
            ))
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func saveModelSelection() {
        AIScriptModelSelectionStorage.save(
            providerID: selectedProviderID,
            modelID: selectedModelID,
            customProviderName: customProviderName.trimmingCharacters(in: .whitespacesAndNewlines),
            customBaseURL: customBaseURL.trimmingCharacters(in: .whitespacesAndNewlines),
            customModelID: customModelID.trimmingCharacters(in: .whitespacesAndNewlines),
            customProviderRequiresAPIKey: customProviderRequiresAPIKey
        )
    }

    private func makeModelConfiguration() throws -> AIChatModelConfiguration {
        let provider = selectedProvider
        let providerName = customProviderName.trimmingCharacters(in: .whitespacesAndNewlines)
        let providerDisplayName = usesCustomProvider && !providerName.isEmpty ? providerName : provider.displayName
        let endpoint: URL?

        if usesCustomProvider {
            endpoint = AIChatEndpoint.chatCompletionsURL(from: customBaseURL)
        } else {
            endpoint = provider.endpointURL
        }

        guard let endpoint else { throw AIScriptError.invalidEndpoint }

        let trimmedCustomModelID = customModelID.trimmingCharacters(in: .whitespacesAndNewlines)
        let modelID = usesCustomModel ? trimmedCustomModelID : selectedModelID
        guard !modelID.isEmpty else { throw AIScriptError.invalidModelID }

        let modelDisplayName = usesCustomModel ? modelID : selectedModelPreset?.displayName ?? modelID

        return AIChatModelConfiguration(
            providerID: provider.id,
            providerDisplayName: providerDisplayName,
            modelID: modelID,
            modelDisplayName: modelDisplayName,
            endpoint: endpoint,
            apiKeyLabel: provider.apiKeyLabel,
            requiresAPIKey: activeRequiresAPIKey,
            keychainAccount: activeKeychainAccount
        )
    }

    @MainActor
    private func refreshAPIKeyEditingState() {
        apiKey = ""
        shouldSaveAPIKey = true
        isEditingAPIKey = !hasSavedAPIKey
    }

    private var generatedTitle: String {
        let trimmedSourceTitle = sourceTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let base = trimmedSourceTitle.isEmpty ? t("Untitled") : trimmedSourceTitle
        return "\(t("AI Breath Cuts")) - \(base)"
    }
}
