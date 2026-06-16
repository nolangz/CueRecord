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
            return "Fast breath cutting"
        case .deepSeekV4Pro:
            return "More careful pacing"
        }
    }
}

enum AIBreathMarkerMode: String, CaseIterable, Identifiable {
    case marked
    case clean

    var id: String { rawValue }

    var label: String {
        switch self {
        case .marked:
            return "Marked"
        case .clean:
            return "Clean"
        }
    }

    var outputSummary: String {
        switch self {
        case .marked:
            return "｜  +  ↵"
        case .clean:
            return "↵"
        }
    }

    var promptInstructions: String {
        switch self {
        case .marked:
            return """
            - Return the same script with explicit breath markers at natural breath points.
            - Inside paragraphs, prefer inserting " ｜" at breath points so the cut is visible and editable.
            - Use real newline characters for paragraph boundaries, markdown headings, and list items.
            - CueRecord treats "|" and "｜" as forced teleprompter line breaks; prefer the full-width "｜" form in AI output.
            """
        case .clean:
            return """
            - Return the same script with real newline characters inserted at natural breath points.
            - Do not include "|" or "｜" in the output.
            - Use real newline characters for paragraph boundaries, markdown headings, list items, and breath cuts.
            """
        }
    }
}

struct AIBreathCutRequest {
    var sourceMarkdown: String
    var customPrompt: String
    var model: AIScriptModel
    var markerMode: AIBreathMarkerMode
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
            return "Write or select a script before using AI Breath Cuts."
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

    func generateBreathCuts(request generationRequest: AIBreathCutRequest, apiKey: String) async throws -> String {
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
            temperature: 0.25,
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
        You are CueRecord's breath-cut editor for teleprompter scripts.
        Return only markdown. Do not wrap the answer in code fences. Do not mention that you are an AI.
        Preserve the original factual meaning, order, headings, and list structure as much as possible.
        Your job is to add speaker-friendly breath cuts and pacing spaces, not to rewrite or expand the script.
        """
    }

    private func userPrompt(for request: AIBreathCutRequest) -> String {
        """
        Add natural breath cuts to the markdown below.

        Extra instructions from the user:
        \(request.customPrompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "None." : request.customPrompt)

        Output requirements:
        \(request.markerMode.promptInstructions)
        - Keep each spoken line short enough to read comfortably in a teleprompter.
        - For Chinese, prefer roughly 8-16 characters per spoken line unless meaning requires otherwise.
        - For English, prefer roughly 4-8 spoken words per line unless meaning requires otherwise.
        - For dense professional terms, technical acronyms, product/API names, and important concepts that should be spoken more slowly, insert small internal spaces where natural, for example "大模型" -> "大 模 型", "AIGC" -> "A I G C", and "ScreenCaptureKit" -> "Screen Capture Kit".
        - Do not over-space common words or make names ambiguous.
        - Preserve markdown headings and list markers.
        - Do not add new claims, examples, titles, summaries, or explanations.
        - Do not delete meaningful content.

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
