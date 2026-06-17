import Foundation
import Security

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
            return "››  ｜  --"
        case .clean:
            return "↵"
        }
    }

    var promptInstructions: String {
        switch self {
        case .marked:
            return """
            - Return the same script with explicit rhythm markers where they help delivery.
            - Optimize for high tempo contrast: use fast, normal, and slow passages to increase the standard deviation of speaking speed.
            - Avoid making every line the same pace; an output with flat rhythm is bad.
            - Use " ｜" at natural breath points so the cut is visible and editable.
            - Use a line-leading "›› " before short bridge lines or low-importance lines that should be read faster.
            - Use "-- " immediately before important concepts, dense professional terms, or key claims that should be read slower.
            - Use real newline characters for paragraph boundaries, markdown headings, and list items.
            - CueRecord treats "|" and "｜" as forced teleprompter line breaks; prefer the full-width "｜" form in AI output.
            - Do not overuse "››" or "--"; only mark real pacing changes.
            """
        case .clean:
            return """
            - Return the same script with real newline characters inserted at natural breath points.
            - Do not include "|", "｜", "››", or "--" in the output.
            - Use real newline characters for paragraph boundaries, markdown headings, list items, and breath cuts.
            """
        }
    }
}

struct AIBreathCutRequest {
    var sourceMarkdown: String
    var customPrompt: String
    var model: AIChatModelConfiguration
    var markerMode: AIBreathMarkerMode
}

struct AIBreathCutSubmission {
    var request: AIBreathCutRequest
    var apiKey: String?
    var generatedTitle: String
}

enum AIScriptError: LocalizedError {
    case invalidAPIKey
    case invalidEndpoint
    case invalidModelID
    case emptySource
    case invalidResponse
    case apiError(String)

    var errorDescription: String? {
        switch self {
        case .invalidAPIKey:
            return "Enter an API key."
        case .invalidEndpoint:
            return "Enter a valid OpenAI-compatible base URL."
        case .invalidModelID:
            return "Enter a model ID."
        case .emptySource:
            return "Write or select a script before using AI Breath Cuts."
        case .invalidResponse:
            return "The provider returned an unexpected response."
        case .apiError(let message):
            return message
        }
    }
}

final class AIProviderAPIKeyStore {
    static let shared = AIProviderAPIKeyStore()

    private let service = "com.nolanlai.cuerecord.ai-provider"
    private let legacyDeepSeekService = "com.nolanlai.cuerecord.deepseek"
    private let legacyDeepSeekAccount = "api-key"

    private init() {}

    func hasAPIKey(for account: String) -> Bool {
        loadAPIKey(for: account)?.isEmpty == false
    }

    func loadAPIKey(for account: String) -> String? {
        if let key = loadAPIKey(account: account, service: service) {
            return key
        }

        if account == "deepseek" {
            return loadAPIKey(account: legacyDeepSeekAccount, service: legacyDeepSeekService)
        }

        return nil
    }

    private func loadAPIKey(account: String, service: String) -> String? {
        var query = baseQuery(account: account, service: service)
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess, let data = item as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    func saveAPIKey(_ apiKey: String, for account: String) throws {
        let trimmed = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { throw AIScriptError.invalidAPIKey }
        let data = Data(trimmed.utf8)

        var query = baseQuery(account: account, service: service)
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

    func deleteAPIKey(for account: String) throws {
        let status = SecItemDelete(baseQuery(account: account, service: service) as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw keychainError(status: status)
        }
    }

    private func baseQuery(account: String, service: String) -> [String: Any] {
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

struct AIChatCompletionsClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func generateBreathCuts(request generationRequest: AIBreathCutRequest, apiKey: String?) async throws -> String {
        let source = generationRequest.sourceMarkdown.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !source.isEmpty else { throw AIScriptError.emptySource }

        let configuration = generationRequest.model
        let trimmedKey = apiKey?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if configuration.requiresAPIKey && trimmedKey.isEmpty {
            throw AIScriptError.invalidAPIKey
        }

        var urlRequest = URLRequest(url: configuration.endpoint)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if !trimmedKey.isEmpty {
            urlRequest.setValue("Bearer \(trimmedKey)", forHTTPHeaderField: "Authorization")
        }
        urlRequest.timeoutInterval = 120

        let body = ChatCompletionsRequest(
            model: configuration.modelID,
            messages: [
                .init(role: "system", content: systemPrompt),
                .init(role: "user", content: userPrompt(for: generationRequest))
            ],
            temperature: 0.25,
            stream: false
        )
        urlRequest.httpBody = try JSONEncoder.chatCompletionsEncoder.encode(body)

        let (data, response) = try await session.data(for: urlRequest)
        if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
            if let errorResponse = try? JSONDecoder().decode(ChatCompletionsErrorResponse.self, from: data) {
                throw AIScriptError.apiError(errorResponse.error.message)
            }
            let message = String(data: data, encoding: .utf8) ?? "Request failed."
            throw AIScriptError.apiError("\(configuration.providerDisplayName) request failed (\(httpResponse.statusCode)): \(message)")
        }

        let decoded: ChatCompletionsResponse
        do {
            decoded = try JSONDecoder().decode(ChatCompletionsResponse.self, from: data)
        } catch {
            throw AIScriptError.apiError("\(configuration.providerDisplayName) returned an unexpected response format: \(responseSnippet(from: data))")
        }

        guard let choice = decoded.choices.first else {
            throw AIScriptError.apiError("\(configuration.providerDisplayName) returned no choices: \(responseSnippet(from: data))")
        }

        if choice.finishReason?.caseInsensitiveCompare("length") == .orderedSame {
            throw AIScriptError.apiError("\(configuration.providerDisplayName) stopped because the response hit its length limit. No draft was created. Try a shorter source script or split it into sections.")
        }

        let content = sanitizeMarkdownResponse(choice.message.content ?? "")
        guard !content.isEmpty else {
            let reason = choice.finishReason.map { " Finish reason: \($0)." } ?? ""
            throw AIScriptError.apiError("\(configuration.providerDisplayName) returned an empty draft.\(reason) Response: \(responseSnippet(from: data))")
        }
        return content
    }

    private var systemPrompt: String {
        """
        You are CueRecord's breath-cut editor for teleprompter scripts.
        Return only the updated markdown draft. Do not wrap the answer in code fences. Do not mention that you are an AI.
        Preserve the original factual meaning, order, headings, and list structure as much as possible.
        Your job is to add speaker-friendly breath cuts, rhythm cues, and pacing spaces, not to rewrite or expand the script.
        A strong result has visible tempo contrast and a high speaking-speed standard deviation.
        """
    }

    private func userPrompt(for request: AIBreathCutRequest) -> String {
        """
        Add natural breath cuts to the markdown below.

        Extra instructions from the user:
        \(request.customPrompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "None." : request.customPrompt)

        Output requirements:
        - The entire response will be saved directly as a new .md file.
        - Return only the updated script body. Do not include JSON, labels, comments, analysis, explanations, before/after sections, or validation notes.
        \(request.markerMode.promptInstructions)
        - Keep each spoken line short enough to read comfortably in a teleprompter.
        - For Chinese, prefer roughly 8-16 characters per spoken line unless meaning requires otherwise.
        - For English, prefer roughly 4-8 spoken words per line unless meaning requires otherwise.
        - For dense professional terms, technical acronyms, product/API names, and important concepts that should be spoken more slowly, insert small internal spaces where natural, for example "大模型" -> "大 模 型", "AIGC" -> "A I G C", and "ScreenCaptureKit" -> "Screen Capture Kit".
        - Do not over-space common words or make names ambiguous.
        - Preserve markdown headings and list markers.
        - Do not add new claims, examples, titles, summaries, or explanations.
        - Do not delete meaningful content.
        - Do not include delimiter lines such as "---".

        Source markdown begins on the next line. Do not include this label in the output.
        \(request.sourceMarkdown)
        """
    }

    private func sanitizeMarkdownResponse(_ content: String) -> String {
        let unfenced = removeWrappingCodeFence(from: content)
        return removeWrappingDelimiterRules(from: unfenced)
    }

    private func removeWrappingCodeFence(from content: String) -> String {
        let trimmed = content.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.hasPrefix("```") else { return trimmed }

        var lines = trimmed.components(separatedBy: .newlines)
        guard lines.count >= 2,
              lines.first?.hasPrefix("```") == true,
              lines.last?.trimmingCharacters(in: .whitespacesAndNewlines) == "```"
        else {
            return trimmed
        }

        lines.removeFirst()
        lines.removeLast()
        return lines.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func removeWrappingDelimiterRules(from content: String) -> String {
        var lines = content.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)

        while let first = lines.first, isPromptDelimiterLine(first) {
            lines.removeFirst()
        }

        while let last = lines.last, isPromptDelimiterLine(last) {
            lines.removeLast()
        }

        return lines.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func isPromptDelimiterLine(_ line: String) -> Bool {
        line.trimmingCharacters(in: .whitespaces) == "---"
    }

    private func responseSnippet(from data: Data) -> String {
        let raw = String(data: data, encoding: .utf8) ?? "<non-UTF8 response>"
        let collapsed = raw.replacingOccurrences(of: "\n", with: " ")
        let limit = 500
        if collapsed.count > limit {
            return "\(collapsed.prefix(limit))..."
        }
        return collapsed
    }
}

private struct ChatCompletionsRequest: Encodable {
    let model: String
    let messages: [ChatCompletionsMessage]
    let temperature: Double
    let stream: Bool

    enum CodingKeys: String, CodingKey {
        case model
        case messages
        case temperature
        case stream
    }
}

private struct ChatCompletionsMessage: Codable {
    let role: String
    let content: String?
}

private struct ChatCompletionsResponse: Decodable {
    let choices: [Choice]

    struct Choice: Decodable {
        let message: ChatCompletionsMessage
        let finishReason: String?

        enum CodingKeys: String, CodingKey {
            case message
            case finishReason = "finish_reason"
        }
    }
}

private struct ChatCompletionsErrorResponse: Decodable {
    let error: APIError

    struct APIError: Decodable {
        let message: String
    }
}

private extension JSONEncoder {
    static var chatCompletionsEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = []
        return encoder
    }
}
