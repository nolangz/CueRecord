import Foundation
import Security

enum AIScriptModel: String, CaseIterable, Identifiable {
    case deepSeekV4Flash = "deepseek-v4-flash"
    case deepSeekV4Pro = "deepseek-v4-pro"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .deepSeekV4Flash:
            return "DeepSeek V4 Flash"
        case .deepSeekV4Pro:
            return "DeepSeek V4 Pro"
        }
    }

    var shortDescription: String {
        switch self {
        case .deepSeekV4Flash:
            return "Fast draft and low latency"
        case .deepSeekV4Pro:
            return "Stronger reasoning and structure"
        }
    }
}

enum AIScriptDuration: String, CaseIterable, Identifiable {
    case thirtySeconds
    case oneMinute
    case ninetySeconds
    case threeMinutes
    case custom

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .thirtySeconds: return "30 sec"
        case .oneMinute: return "1 min"
        case .ninetySeconds: return "90 sec"
        case .threeMinutes: return "3 min"
        case .custom: return "Custom"
        }
    }

    var promptValue: String {
        switch self {
        case .thirtySeconds:
            return "about 30 seconds, roughly 70-90 spoken English words"
        case .oneMinute:
            return "about 1 minute, roughly 130-170 spoken English words"
        case .ninetySeconds:
            return "about 90 seconds, roughly 200-240 spoken English words"
        case .threeMinutes:
            return "about 3 minutes, roughly 420-500 spoken English words"
        case .custom:
            return ""
        }
    }
}

enum AIScriptAudience: String, CaseIterable, Identifiable {
    case general
    case customers
    case investors
    case internalTeam
    case developers
    case custom

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .general: return "General viewers"
        case .customers: return "Customers"
        case .investors: return "Investors"
        case .internalTeam: return "Internal team"
        case .developers: return "Developers"
        case .custom: return "Custom"
        }
    }
}

enum AIScriptStyle: String, CaseIterable, Identifiable {
    case direct
    case storytelling
    case tutorial
    case productDemo
    case executive
    case social
    case custom

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .direct: return "Direct & clear"
        case .storytelling: return "Storytelling"
        case .tutorial: return "Tutorial"
        case .productDemo: return "Product demo"
        case .executive: return "Executive"
        case .social: return "Social video"
        case .custom: return "Custom"
        }
    }
}

struct AIScriptGenerationRequest {
    var sourceMarkdown: String
    var duration: String
    var audience: String
    var style: String
    var customPrompt: String
    var model: AIScriptModel
}

enum AIScriptError: LocalizedError {
    case invalidAPIKey
    case emptySource
    case invalidResponse
    case apiError(String)

    var errorDescription: String? {
        switch self {
        case .invalidAPIKey:
            return "Enter a DeepSeek API key."
        case .emptySource:
            return "Write or select a markdown draft before using AI Script."
        case .invalidResponse:
            return "DeepSeek returned an unexpected response."
        case .apiError(let message):
            return message
        }
    }
}

final class DeepSeekAPIKeyStore {
    static let shared = DeepSeekAPIKeyStore()

    private let service = "com.nolanlai.cuerecord.deepseek"
    private let account = "api-key"

    private init() {}

    var hasAPIKey: Bool {
        loadAPIKey()?.isEmpty == false
    }

    func loadAPIKey() -> String? {
        var query = baseQuery()
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess, let data = item as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    func saveAPIKey(_ apiKey: String) throws {
        let trimmed = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { throw AIScriptError.invalidAPIKey }
        let data = Data(trimmed.utf8)

        var query = baseQuery()
        let attributes: [String: Any] = [
            kSecValueData as String: data
        ]

        let updateStatus = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        if updateStatus == errSecSuccess {
            return
        }

        guard updateStatus == errSecItemNotFound else {
            throw keychainError(status: updateStatus)
        }

        query[kSecValueData as String] = data
        query[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlock
        let addStatus = SecItemAdd(query as CFDictionary, nil)
        guard addStatus == errSecSuccess else {
            throw keychainError(status: addStatus)
        }
    }

    func deleteAPIKey() throws {
        let status = SecItemDelete(baseQuery() as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw keychainError(status: status)
        }
    }

    private func baseQuery() -> [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
    }

    private func keychainError(status: OSStatus) -> Error {
        let message = SecCopyErrorMessageString(status, nil) as String? ?? "Keychain error \(status)."
        return AIScriptError.apiError(message)
    }
}

struct DeepSeekChatClient {
    private let endpoint = URL(string: "https://api.deepseek.com/chat/completions")!
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func generateScript(request generationRequest: AIScriptGenerationRequest, apiKey: String) async throws -> String {
        let trimmedKey = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedKey.isEmpty else { throw AIScriptError.invalidAPIKey }

        let source = generationRequest.sourceMarkdown.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !source.isEmpty else { throw AIScriptError.emptySource }

        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(trimmedKey)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 120

        let body = DeepSeekChatRequest(
            model: generationRequest.model.rawValue,
            messages: [
                .init(role: "system", content: systemPrompt),
                .init(role: "user", content: userPrompt(for: generationRequest))
            ],
            temperature: 0.6,
            maxTokens: 3200,
            stream: false
        )
        urlRequest.httpBody = try JSONEncoder.deepSeekEncoder.encode(body)

        let (data, response) = try await session.data(for: urlRequest)
        if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
            if let errorResponse = try? JSONDecoder().decode(DeepSeekErrorResponse.self, from: data) {
                throw AIScriptError.apiError(errorResponse.error.message)
            }
            let message = String(data: data, encoding: .utf8) ?? "Request failed."
            throw AIScriptError.apiError("DeepSeek request failed (\(httpResponse.statusCode)): \(message)")
        }

        let decoded = try JSONDecoder().decode(DeepSeekChatResponse.self, from: data)
        guard let content = decoded.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines),
              !content.isEmpty
        else {
            throw AIScriptError.invalidResponse
        }
        return content
    }

    private var systemPrompt: String {
        """
        You are CueRecord's script editor. Transform rough markdown notes into a polished spoken script for screen recording or camera narration.
        Return only markdown. Do not wrap the answer in code fences. Do not mention that you are an AI.
        Preserve factual meaning, avoid inventing unsupported claims, and make the script easy to read aloud.
        Use short paragraphs, clear transitions, and natural spoken language.
        """
    }

    private func userPrompt(for request: AIScriptGenerationRequest) -> String {
        """
        Rewrite the markdown below into a spoken script.

        Target duration: \(request.duration)
        Audience: \(request.audience)
        Style: \(request.style)

        Extra instructions from the user:
        \(request.customPrompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "None." : request.customPrompt)

        Output requirements:
        - Start with a concise H1 title.
        - Use markdown headings only where they help the speaker scan the script.
        - Keep sentences natural for spoken delivery.
        - Remove duplicated or unfinished notes.
        - Keep the output focused on the source material.

        Source markdown:
        ---
        \(request.sourceMarkdown)
        ---
        """
    }
}

private struct DeepSeekChatRequest: Encodable {
    let model: String
    let messages: [DeepSeekChatMessage]
    let temperature: Double
    let maxTokens: Int
    let stream: Bool

    enum CodingKeys: String, CodingKey {
        case model
        case messages
        case temperature
        case maxTokens = "max_tokens"
        case stream
    }
}

private struct DeepSeekChatMessage: Codable {
    let role: String
    let content: String
}

private struct DeepSeekChatResponse: Decodable {
    let choices: [Choice]

    struct Choice: Decodable {
        let message: DeepSeekChatMessage
    }
}

private struct DeepSeekErrorResponse: Decodable {
    let error: APIError

    struct APIError: Decodable {
        let message: String
    }
}

private extension JSONEncoder {
    static var deepSeekEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = []
        return encoder
    }
}
