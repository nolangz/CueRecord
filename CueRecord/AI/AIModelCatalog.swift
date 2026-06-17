import Foundation

struct AIScriptModelPreset: Identifiable, Hashable {
    let id: String
    let displayName: String
    let shortDescription: String
}

struct AIScriptProvider: Identifiable, Hashable {
    let id: String
    let displayName: String
    let shortDescription: String
    let baseURLString: String?
    let apiKeyLabel: String
    let requiresAPIKey: Bool
    let modelPresets: [AIScriptModelPreset]

    var endpointURL: URL? {
        guard let baseURLString else { return nil }
        return AIChatEndpoint.chatCompletionsURL(from: baseURLString)
    }

    func modelPreset(for modelID: String) -> AIScriptModelPreset? {
        modelPresets.first { $0.id == modelID }
    }
}

enum AIScriptProviderCatalog {
    static let customProviderID = "custom-openai-compatible"
    static let customModelID = "__custom_model_id__"

    static let customModelPreset = AIScriptModelPreset(
        id: customModelID,
        displayName: "Custom model ID",
        shortDescription: "Use any OpenAI-compatible model ID"
    )

    static let customProvider = AIScriptProvider(
        id: customProviderID,
        displayName: "Custom OpenAI-Compatible",
        shortDescription: "Use any OpenAI-compatible endpoint",
        baseURLString: nil,
        apiKeyLabel: "API Key",
        requiresAPIKey: false,
        modelPresets: []
    )

    static let providers: [AIScriptProvider] = modelsDevProviders + [customProvider]

    static let defaultProviderID = "deepseek"
    static let defaultModelID = "deepseek-v4-flash"

    static func provider(for providerID: String) -> AIScriptProvider {
        providers.first { $0.id == providerID } ?? providers[0]
    }

    static func defaultModelID(for provider: AIScriptProvider) -> String {
        provider.modelPresets.first?.id ?? customModelID
    }
}

struct AIChatModelConfiguration: Hashable {
    let providerID: String
    let providerDisplayName: String
    let modelID: String
    let modelDisplayName: String
    let endpoint: URL
    let apiKeyLabel: String
    let requiresAPIKey: Bool
    let keychainAccount: String
}

enum AIChatEndpoint {
    static func chatCompletionsURL(from baseURLString: String) -> URL? {
        let trimmed = baseURLString.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, var components = URLComponents(string: trimmed) else { return nil }
        guard components.scheme?.isEmpty == false, components.host?.isEmpty == false else { return nil }

        let normalizedPath = components.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        if normalizedPath.hasSuffix("chat/completions") {
            return components.url
        }

        components.path = "/" + ([normalizedPath, "chat/completions"].filter { !$0.isEmpty }.joined(separator: "/"))
        return components.url
    }
}

enum AIScriptModelSelectionStorage {
    private static let providerIDKey = "cueRecord.ai.providerID"
    private static let modelIDKey = "cueRecord.ai.modelID"
    private static let customProviderNameKey = "cueRecord.ai.customProviderName"
    private static let customBaseURLKey = "cueRecord.ai.customBaseURL"
    private static let customModelIDKey = "cueRecord.ai.customModelID"
    private static let customProviderRequiresAPIKeyKey = "cueRecord.ai.customProviderRequiresAPIKey"

    static func selectedProviderID() -> String {
        let saved = UserDefaults.standard.string(forKey: providerIDKey) ?? AIScriptProviderCatalog.defaultProviderID
        guard AIScriptProviderCatalog.providers.contains(where: { $0.id == saved }) else {
            return AIScriptProviderCatalog.defaultProviderID
        }
        return saved
    }

    static func selectedModelID() -> String {
        let provider = AIScriptProviderCatalog.provider(for: selectedProviderID())
        let saved = UserDefaults.standard.string(forKey: modelIDKey) ?? AIScriptProviderCatalog.defaultModelID(for: provider)
        if saved == AIScriptProviderCatalog.customModelID || provider.modelPreset(for: saved) != nil {
            return saved
        }
        return AIScriptProviderCatalog.defaultModelID(for: provider)
    }

    static func customProviderName() -> String {
        UserDefaults.standard.string(forKey: customProviderNameKey) ?? ""
    }

    static func customBaseURL() -> String {
        UserDefaults.standard.string(forKey: customBaseURLKey) ?? ""
    }

    static func customModelID() -> String {
        UserDefaults.standard.string(forKey: customModelIDKey) ?? ""
    }

    static func customProviderRequiresAPIKey() -> Bool {
        if UserDefaults.standard.object(forKey: customProviderRequiresAPIKeyKey) == nil {
            return true
        }
        return UserDefaults.standard.bool(forKey: customProviderRequiresAPIKeyKey)
    }

    static func save(
        providerID: String,
        modelID: String,
        customProviderName: String,
        customBaseURL: String,
        customModelID: String,
        customProviderRequiresAPIKey: Bool
    ) {
        let defaults = UserDefaults.standard
        defaults.set(providerID, forKey: providerIDKey)
        defaults.set(modelID, forKey: modelIDKey)
        defaults.set(customProviderName, forKey: customProviderNameKey)
        defaults.set(customBaseURL, forKey: customBaseURLKey)
        defaults.set(customModelID, forKey: customModelIDKey)
        defaults.set(customProviderRequiresAPIKey, forKey: customProviderRequiresAPIKeyKey)
    }
}
