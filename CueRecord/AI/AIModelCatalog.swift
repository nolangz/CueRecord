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

    static let providers: [AIScriptProvider] = [
        AIScriptProvider(
            id: "deepseek",
            displayName: "DeepSeek",
            shortDescription: "Fast OpenAI-compatible Chinese and English editing",
            baseURLString: "https://api.deepseek.com",
            apiKeyLabel: "DeepSeek API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "Fast breath cutting"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "More careful pacing"
                ),
                AIScriptModelPreset(
                    id: "deepseek-chat",
                    displayName: "DeepSeek Chat",
                    shortDescription: "General chat model"
                ),
                AIScriptModelPreset(
                    id: "deepseek-reasoner",
                    displayName: "DeepSeek Reasoner",
                    shortDescription: "Slower reasoning model"
                )
            ]
        ),
        AIScriptProvider(
            id: "openai",
            displayName: "OpenAI",
            shortDescription: "OpenAI Chat Completions endpoint",
            baseURLString: "https://api.openai.com/v1",
            apiKeyLabel: "OpenAI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "gpt-4o-mini",
                    displayName: "GPT-4o mini",
                    shortDescription: "Fast OpenAI preset"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1-mini",
                    displayName: "GPT-4.1 mini",
                    shortDescription: "Balanced OpenAI preset"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "Stronger OpenAI preset"
                )
            ]
        ),
        AIScriptProvider(
            id: "openrouter",
            displayName: "OpenRouter",
            shortDescription: "Use many hosted models through one OpenAI-compatible API",
            baseURLString: "https://openrouter.ai/api/v1",
            apiKeyLabel: "OpenRouter API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini",
                    displayName: "OpenAI GPT-4o mini",
                    shortDescription: "Fast hosted model"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-3.5-sonnet",
                    displayName: "Claude 3.5 Sonnet",
                    shortDescription: "Careful hosted model"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "Fast Gemini preset"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-chat",
                    displayName: "DeepSeek Chat",
                    shortDescription: "DeepSeek through OpenRouter"
                )
            ]
        ),
        AIScriptProvider(
            id: "gemini",
            displayName: "Google Gemini",
            shortDescription: "Gemini OpenAI-compatible endpoint",
            baseURLString: "https://generativelanguage.googleapis.com/v1beta/openai",
            apiKeyLabel: "Gemini API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "Fast Gemini model"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "Stronger Gemini model"
                )
            ]
        ),
        AIScriptProvider(
            id: "groq",
            displayName: "Groq",
            shortDescription: "Low-latency OpenAI-compatible endpoint",
            baseURLString: "https://api.groq.com/openai/v1",
            apiKeyLabel: "Groq API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "llama-3.3-70b-versatile",
                    displayName: "Llama 3.3 70B Versatile",
                    shortDescription: "Fast open-weight preset"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1-distill-llama-70b",
                    displayName: "DeepSeek R1 Distill 70B",
                    shortDescription: "Reasoning-oriented preset"
                )
            ]
        ),
        AIScriptProvider(
            id: "xai",
            displayName: "xAI",
            shortDescription: "xAI OpenAI-compatible endpoint",
            baseURLString: "https://api.x.ai/v1",
            apiKeyLabel: "xAI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "grok-3-mini",
                    displayName: "Grok 3 mini",
                    shortDescription: "Fast xAI preset"
                ),
                AIScriptModelPreset(
                    id: "grok-3",
                    displayName: "Grok 3",
                    shortDescription: "Stronger xAI preset"
                )
            ]
        ),
        AIScriptProvider(
            id: "ollama",
            displayName: "Ollama",
            shortDescription: "Local OpenAI-compatible server",
            baseURLString: "http://localhost:11434/v1",
            apiKeyLabel: "Ollama API Key",
            requiresAPIKey: false,
            modelPresets: [
                AIScriptModelPreset(
                    id: "llama3.1",
                    displayName: "Llama 3.1",
                    shortDescription: "Local Ollama preset"
                ),
                AIScriptModelPreset(
                    id: "qwen2.5-coder:7b",
                    displayName: "Qwen2.5 Coder 7B",
                    shortDescription: "Local Qwen preset"
                )
            ]
        ),
        AIScriptProvider(
            id: "lmstudio",
            displayName: "LM Studio",
            shortDescription: "Local LM Studio OpenAI-compatible server",
            baseURLString: "http://127.0.0.1:1234/v1",
            apiKeyLabel: "LM Studio API Key",
            requiresAPIKey: false,
            modelPresets: []
        ),
        AIScriptProvider(
            id: customProviderID,
            displayName: "Custom OpenAI-Compatible",
            shortDescription: "Use any OpenAI-compatible endpoint",
            baseURLString: nil,
            apiKeyLabel: "API Key",
            requiresAPIKey: false,
            modelPresets: []
        )
    ]

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
