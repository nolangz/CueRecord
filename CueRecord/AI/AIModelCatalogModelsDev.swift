import Foundation

// Generated from https://models.dev/api.json. Keep manual behavior in AIModelCatalog.swift.
extension AIScriptProviderCatalog {
    static let modelsDevProviders: [AIScriptProvider] = [
        AIScriptProvider(
            id: "302ai",
            displayName: "302.AI",
            shortDescription: "OpenAI-compatible \u{B7} 94 text models",
            baseURLString: "https://api.302.ai/v1",
            apiKeyLabel: "302.AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "gpt-5.4-mini-2026-03-17",
                    displayName: "gpt-5.4-mini-2026-03-17",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "chatgpt-4o-latest",
                    displayName: "chatgpt-4o-latest",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-nano-2026-03-17",
                    displayName: "gpt-5.4-nano-2026-03-17",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-0905-preview",
                    displayName: "kimi-k2-0905-preview",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "grok-4.20-beta-0309-non-reasoning",
                    displayName: "grok-4.20-beta-0309-non-reasoning",
                    shortDescription: "2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-nothink",
                    displayName: "gemini-2.5-flash-nothink",
                    shortDescription: "gemini-flash \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen-plus",
                    displayName: "Qwen-Plus",
                    shortDescription: "qwen \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "glm-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b-instruct-2507",
                    displayName: "qwen3-235b-a22b-instruct-2507",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5v",
                    displayName: "GLM-4.5V",
                    shortDescription: "glm \u{B7} 64K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-5",
                    displayName: "claude-opus-4-5",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "gemini-2.5-pro",
                    shortDescription: "gemini-pro \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5",
                    displayName: "gpt-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4-5-20251001",
                    displayName: "claude-haiku-4-5-20251001",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking-turbo",
                    displayName: "kimi-k2-thinking-turbo",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-3-5-haiku-20241022",
                    displayName: "claude-3-5-haiku-20241022",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5",
                    displayName: "GLM-4.5",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-pro",
                    displayName: "gpt-5-pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4.20-beta-0309-reasoning",
                    displayName: "grok-4.20-beta-0309-reasoning",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash",
                    displayName: "gemini-2.5-flash",
                    shortDescription: "gemini-flash \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o",
                    displayName: "gpt-4o",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M2.1",
                    displayName: "MiniMax-M2.1",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-lite-preview-09-2025",
                    displayName: "gemini-2.5-flash-lite-preview-09-2025",
                    shortDescription: "1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-1-6-vision-250815",
                    displayName: "doubao-seed-1-6-vision-250815",
                    shortDescription: "256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1-20250805",
                    displayName: "claude-opus-4-1-20250805",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max-2025-09-23",
                    displayName: "qwen3-max-2025-09-23",
                    shortDescription: "258K context"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7-flashx",
                    displayName: "glm-4.7-flashx",
                    shortDescription: "glm-flash \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "glm-5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6",
                    displayName: "glm-4.6",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking",
                    displayName: "kimi-k2-thinking",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-5",
                    displayName: "claude-sonnet-4-5",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-x",
                    displayName: "glm-4.5-x",
                    shortDescription: "glm \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.2-thinking",
                    displayName: "DeepSeek-V3.2-Thinking",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-6-thinking",
                    displayName: "claude-sonnet-4-6-thinking",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-7",
                    displayName: "claude-opus-4-7",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-1-fast-non-reasoning",
                    displayName: "grok-4-1-fast-non-reasoning",
                    shortDescription: "2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-nano",
                    displayName: "gpt-5.4-nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1-20250805-thinking",
                    displayName: "claude-opus-4-1-20250805-thinking",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-airx",
                    displayName: "glm-4.5-airx",
                    shortDescription: "glm \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "grok-4.1",
                    displayName: "grok-4.1",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-preview-09-2025",
                    displayName: "gemini-2.5-flash-preview-09-2025",
                    shortDescription: "1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-5-20251101",
                    displayName: "claude-opus-4-5-20251101",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-20250514",
                    displayName: "claude-opus-4-20250514",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-for-coding",
                    displayName: "glm-for-coding",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2",
                    displayName: "gpt-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-flash",
                    displayName: "Qwen-Flash",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-6-thinking",
                    displayName: "claude-opus-4-6-thinking",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-20250514",
                    displayName: "claude-sonnet-4-20250514",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-chat-latest",
                    displayName: "gpt-5.1-chat-latest",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-chat-latest",
                    displayName: "gpt-5.2-chat-latest",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-fast-reasoning",
                    displayName: "grok-4-fast-reasoning",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1-nano",
                    displayName: "gpt-4.1-nano",
                    shortDescription: "gpt-nano \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-5-20250929-thinking",
                    displayName: "claude-sonnet-4-5-20250929-thinking",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M2.7-highspeed",
                    displayName: "MiniMax-M2.7-highspeed",
                    shortDescription: "204K context"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M2",
                    displayName: "MiniMax-M2",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b",
                    displayName: "Qwen3-235B-A22B",
                    shortDescription: "qwen \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "ministral-14b-2512",
                    displayName: "ministral-14b-2512",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6v",
                    displayName: "GLM-4.6V",
                    shortDescription: "glm \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4-5",
                    displayName: "claude-haiku-4-5",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4",
                    displayName: "gpt-5.4",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-1-6-thinking-250715",
                    displayName: "doubao-seed-1-6-thinking-250715",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-mini",
                    displayName: "gpt-5.4-mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1",
                    displayName: "gpt-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-code-preview-251028",
                    displayName: "doubao-seed-code-preview-251028",
                    shortDescription: "256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-6",
                    displayName: "claude-opus-4-6",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-480b-a35b-instruct",
                    displayName: "qwen3-coder-480b-a35b-instruct",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-5-20250929",
                    displayName: "claude-sonnet-4-5-20250929",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-reasoner",
                    displayName: "Deepseek-Reasoner",
                    shortDescription: "deepseek-thinking \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-1-fast-reasoning",
                    displayName: "grok-4-1-fast-reasoning",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-pro-preview",
                    displayName: "gemini-3-pro-preview",
                    shortDescription: "1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-thinking",
                    displayName: "gpt-5-thinking",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-mini",
                    displayName: "gpt-5-mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1-mini",
                    displayName: "gpt-4.1-mini",
                    shortDescription: "gpt-mini \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-5v-turbo",
                    displayName: "GLM-5V-Turbo",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-pro",
                    displayName: "gpt-5.4-pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-air",
                    displayName: "glm-4.5-air",
                    shortDescription: "glm-air \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-6",
                    displayName: "claude-sonnet-4-6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-fast-non-reasoning",
                    displayName: "grok-4-fast-non-reasoning",
                    shortDescription: "2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-flash-preview",
                    displayName: "gemini-3-flash-preview",
                    shortDescription: "1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-chat",
                    displayName: "Deepseek-Chat",
                    shortDescription: "deepseek \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M1",
                    displayName: "MiniMax-M1",
                    shortDescription: "minimax \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "grok-4.20-multi-agent-beta-0309",
                    displayName: "grok-4.20-multi-agent-beta-0309",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "glm-5",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-max-latest",
                    displayName: "Qwen-Max-Latest",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-large-2512",
                    displayName: "mistral-large-2512",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M2.7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "204K context"
                ),
                AIScriptModelPreset(
                    id: "claude-3-5-haiku-latest",
                    displayName: "claude-3-5-haiku-latest",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3-30b-a3b",
                    displayName: "Qwen3-30B-A3B",
                    shortDescription: "qwen \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.2",
                    displayName: "deepseek-v3.2",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-1-8-251215",
                    displayName: "doubao-seed-1-8-251215",
                    shortDescription: "224K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-5-20251101-thinking",
                    displayName: "claude-opus-4-5-20251101-thinking",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.0-flash-lite",
                    displayName: "gemini-2.0-flash-lite",
                    shortDescription: "gemini-flash-lite \u{B7} 2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-5-turbo",
                    displayName: "glm-5-turbo",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1",
                    displayName: "gpt-5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "abacus",
            displayName: "Abacus",
            shortDescription: "OpenAI-compatible \u{B7} 65 text models",
            baseURLString: "https://routellm.abacus.ai/v1",
            apiKeyLabel: "Abacus API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "o3",
                    displayName: "o3",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route-llm",
                    displayName: "Route LLM",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "grok-code-fast-1",
                    displayName: "Grok Code Fast 1",
                    shortDescription: "grok \u{B7} 256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.3-codex-xhigh",
                    displayName: "GPT-5.3 Codex XHigh",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "llama-3.3-70b-versatile",
                    displayName: "Llama 3.3 70B Versatile",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4-5-20251001",
                    displayName: "Claude Haiku 4.5",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "o4-mini",
                    displayName: "o4-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max",
                    displayName: "Qwen3 Max",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "o3-pro",
                    displayName: "o3-pro",
                    shortDescription: "o-pro \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1-20250805",
                    displayName: "Claude Opus 4.1",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-1-fast-non-reasoning",
                    displayName: "Grok 4.1 Fast (Non-Reasoning)",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-5-20251101",
                    displayName: "Claude Opus 4.5",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex",
                    displayName: "GPT-5.1 Codex",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex-max",
                    displayName: "GPT-5.1 Codex Max",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-20250514",
                    displayName: "Claude Opus 4",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.3-chat-latest",
                    displayName: "GPT-5.3 Chat Latest",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "o3-mini",
                    displayName: "o3-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-turbo-preview",
                    displayName: "Kimi K2 Turbo Preview",
                    shortDescription: "kimi-k2 \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.3-codex",
                    displayName: "GPT-5.3 Codex",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-0709",
                    displayName: "Grok 4",
                    shortDescription: "grok \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-20250514",
                    displayName: "Claude Sonnet 4",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-chat-latest",
                    displayName: "GPT-5.1 Chat Latest",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-chat-latest",
                    displayName: "GPT-5.2 Chat Latest",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1-nano",
                    displayName: "GPT-4.1 Nano",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o-2024-11-20",
                    displayName: "GPT-4o (2024-11-20)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-3-7-sonnet-20250219",
                    displayName: "Claude Sonnet 3.7",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.1-pro-preview",
                    displayName: "Gemini 3.1 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-2.5-coder-32b",
                    displayName: "Qwen 2.5 Coder 32B",
                    shortDescription: "qwen \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-5-20250929",
                    displayName: "Claude Sonnet 4.5",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-mini",
                    displayName: "GPT-5 Mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1-mini",
                    displayName: "GPT-4.1 Mini",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-nano",
                    displayName: "GPT-5 Nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-fast-non-reasoning",
                    displayName: "Grok 4 Fast (Non-Reasoning)",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-flash-preview",
                    displayName: "Gemini 3 Flash Preview",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o-mini",
                    displayName: "GPT-4o Mini",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-codex",
                    displayName: "GPT-5 Codex",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.1-flash-lite-preview",
                    displayName: "Gemini 3.1 Flash Lite Preview",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-codex",
                    displayName: "GPT-5.2 Codex",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1",
                    displayName: "GPT-5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Llama-4-Maverick-17B-128E-Instruct-FP8",
                    displayName: "Llama 4 Maverick 17B 128E Instruct FP8",
                    shortDescription: "llama \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Meta-Llama-3.1-405B-Instruct-Turbo",
                    displayName: "Llama 3.1 405B Instruct Turbo",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Meta-Llama-3.1-8B-Instruct",
                    displayName: "Llama 3.1 8B Instruct",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/qwen3-coder-480b-a35b-instruct",
                    displayName: "Qwen3 Coder 480B A35B Instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/QwQ-32B",
                    displayName: "QwQ 32B",
                    shortDescription: "qwen \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Instruct-2507",
                    displayName: "Qwen3 235B A22B Instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-32B",
                    displayName: "Qwen3 32B",
                    shortDescription: "qwen \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-72B-Instruct",
                    displayName: "Qwen 2.5 72B Instruct",
                    shortDescription: "qwen \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT-OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.5",
                    displayName: "GLM-4.5",
                    shortDescription: "glm \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.6",
                    displayName: "GLM-4.6",
                    shortDescription: "glm \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1",
                    displayName: "DeepSeek R1",
                    shortDescription: "deepseek-thinking \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1-Terminus",
                    displayName: "DeepSeek V3.1 Terminus",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "abliteration-ai",
            displayName: "abliteration.ai",
            shortDescription: "OpenAI-compatible \u{B7} 1 text models",
            baseURLString: "https://api.abliteration.ai/v1",
            apiKeyLabel: "abliteration.ai API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "abliterated-model",
                    displayName: "Abliterated Model",
                    shortDescription: "150K context \u{B7} Attachments"
                )
            ]
        ),
        AIScriptProvider(
            id: "alibaba",
            displayName: "Alibaba",
            shortDescription: "OpenAI-compatible \u{B7} 50 text models",
            baseURLString: "https://dashscope-intl.aliyuncs.com/compatible-mode/v1",
            apiKeyLabel: "Alibaba API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "qwen3-omni-flash",
                    displayName: "Qwen3-Omni Flash",
                    shortDescription: "qwen \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-plus",
                    displayName: "Qwen3 Coder Plus",
                    shortDescription: "qwen \u{B7} 1.04858M context"
                ),
                AIScriptModelPreset(
                    id: "qwen-plus",
                    displayName: "Qwen Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-30b-a3b-instruct",
                    displayName: "Qwen3-Coder 30B-A3B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-omni-flash-realtime",
                    displayName: "Qwen3-Omni Flash Realtime",
                    shortDescription: "qwen \u{B7} 65K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-32b",
                    displayName: "Qwen3 32B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-omni-turbo-realtime",
                    displayName: "Qwen-Omni Turbo Realtime",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen-plus-character-ja",
                    displayName: "Qwen Plus Character (Japanese)",
                    shortDescription: "qwen \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-next-80b-a3b-instruct",
                    displayName: "Qwen3-Next 80B-A3B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-plus",
                    displayName: "Qwen3.7 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-35b-a3b",
                    displayName: "Qwen3.6 35B-A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-max",
                    displayName: "Qwen3.7 Max",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max",
                    displayName: "Qwen3 Max",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-omni-7b",
                    displayName: "Qwen2.5-Omni 7B",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-8b",
                    displayName: "Qwen3 8B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-14b-instruct",
                    displayName: "Qwen2.5 14B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-next-80b-a3b-thinking",
                    displayName: "Qwen3-Next 80B-A3B (Thinking)",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qvq-max",
                    displayName: "QVQ Max",
                    shortDescription: "qvq \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-flash",
                    displayName: "Qwen3.6 Flash",
                    shortDescription: "qwen3.6 \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-vl-72b-instruct",
                    displayName: "Qwen2.5-VL 72B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-plus",
                    displayName: "Qwen3-VL Plus",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-vl-ocr",
                    displayName: "Qwen-VL OCR",
                    shortDescription: "qwen \u{B7} 34K context"
                ),
                AIScriptModelPreset(
                    id: "qwen-mt-turbo",
                    displayName: "Qwen-MT Turbo",
                    shortDescription: "qwen \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "qwen-mt-plus",
                    displayName: "Qwen-MT Plus",
                    shortDescription: "qwen \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-plus",
                    displayName: "Qwen3.5 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-omni-turbo",
                    displayName: "Qwen-Omni Turbo",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-72b-instruct",
                    displayName: "Qwen2.5 72B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen-flash",
                    displayName: "Qwen Flash",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-235b-a22b",
                    displayName: "Qwen3-VL 235B-A22B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-30b-a3b",
                    displayName: "Qwen3-VL 30B-A3B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-vl-max",
                    displayName: "Qwen-VL Max",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-27b",
                    displayName: "Qwen3.5 27B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-max",
                    displayName: "Qwen Max",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b",
                    displayName: "Qwen3 235B-A22B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-livetranslate-flash-realtime",
                    displayName: "Qwen3-LiveTranslate Flash Realtime",
                    shortDescription: "qwen \u{B7} 53K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-27b",
                    displayName: "Qwen3.6 27B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-35b-a3b",
                    displayName: "Qwen3.5 35B-A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-480b-a35b-instruct",
                    displayName: "Qwen3-Coder 480B-A35B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwq-plus",
                    displayName: "QwQ Plus",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-32b-instruct",
                    displayName: "Qwen2.5 32B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-397b-a17b",
                    displayName: "Qwen3.5 397B-A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-flash",
                    displayName: "Qwen3 Coder Flash",
                    shortDescription: "qwen \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-14b",
                    displayName: "Qwen3 14B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-turbo",
                    displayName: "Qwen Turbo",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-7b-instruct",
                    displayName: "Qwen2.5 7B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-vl-7b-instruct",
                    displayName: "Qwen2.5-VL 7B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-max-preview",
                    displayName: "Qwen3.6 Max Preview",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-122b-a10b",
                    displayName: "Qwen3.5 122B-A10B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-vl-plus",
                    displayName: "Qwen-VL Plus",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "alibaba-cn",
            displayName: "Alibaba (China)",
            shortDescription: "OpenAI-compatible \u{B7} 82 text models",
            baseURLString: "https://dashscope.aliyuncs.com/compatible-mode/v1",
            apiKeyLabel: "Alibaba (China) API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "qwen2-5-math-72b-instruct",
                    displayName: "Qwen2.5-Math 72B Instruct",
                    shortDescription: "qwen \u{B7} 4K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1-0528",
                    displayName: "DeepSeek R1 0528",
                    shortDescription: "deepseek-thinking \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-omni-flash",
                    displayName: "Qwen3-Omni Flash",
                    shortDescription: "qwen \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-plus",
                    displayName: "Qwen Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-30b-a3b-instruct",
                    displayName: "Qwen3-Coder 30B-A3B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-coder-7b-instruct",
                    displayName: "Qwen2.5-Coder 7B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3",
                    displayName: "DeepSeek V3",
                    shortDescription: "deepseek \u{B7} 65K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-omni-flash-realtime",
                    displayName: "Qwen3-Omni Flash Realtime",
                    shortDescription: "qwen \u{B7} 65K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1-distill-llama-70b",
                    displayName: "DeepSeek R1 Distill Llama 70B",
                    shortDescription: "deepseek-thinking \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-32b",
                    displayName: "Qwen3 32B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-omni-turbo-realtime",
                    displayName: "Qwen-Omni Turbo Realtime",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-math-7b-instruct",
                    displayName: "Qwen2.5-Math 7B Instruct",
                    shortDescription: "qwen \u{B7} 4K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-next-80b-a3b-instruct",
                    displayName: "Qwen3-Next 80B-A3B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-plus",
                    displayName: "Qwen3.7 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-max",
                    displayName: "Qwen3.7 Max",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-long",
                    displayName: "Qwen Long",
                    shortDescription: "qwen \u{B7} 10M context"
                ),
                AIScriptModelPreset(
                    id: "qwen-math-turbo",
                    displayName: "Qwen Math Turbo",
                    shortDescription: "qwen \u{B7} 4K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max",
                    displayName: "Qwen3 Max",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-omni-7b",
                    displayName: "Qwen2.5-Omni 7B",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-8b",
                    displayName: "Qwen3 8B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-14b-instruct",
                    displayName: "Qwen2.5 14B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-next-80b-a3b-thinking",
                    displayName: "Qwen3-Next 80B-A3B (Thinking)",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qvq-max",
                    displayName: "QVQ Max",
                    shortDescription: "qvq \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-plus-character",
                    displayName: "Qwen Plus Character",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking",
                    displayName: "Moonshot Kimi K2 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1",
                    displayName: "DeepSeek R1",
                    shortDescription: "deepseek-thinking \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-flash",
                    displayName: "Qwen3.5 Flash",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-flash",
                    displayName: "Qwen3.6 Flash",
                    shortDescription: "qwen3.6 \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-vl-72b-instruct",
                    displayName: "Qwen2.5-VL 72B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-plus",
                    displayName: "Qwen3-VL Plus",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-vl-ocr",
                    displayName: "Qwen-VL OCR",
                    shortDescription: "qwen \u{B7} 34K context"
                ),
                AIScriptModelPreset(
                    id: "qwen-mt-turbo",
                    displayName: "Qwen-MT Turbo",
                    shortDescription: "qwen \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "qwen-math-plus",
                    displayName: "Qwen Math Plus",
                    shortDescription: "qwen \u{B7} 4K context"
                ),
                AIScriptModelPreset(
                    id: "qwen-mt-plus",
                    displayName: "Qwen-MT Plus",
                    shortDescription: "qwen \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-plus",
                    displayName: "Qwen3.5 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-omni-turbo",
                    displayName: "Qwen-Omni Turbo",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-72b-instruct",
                    displayName: "Qwen2.5 72B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1-distill-qwen-7b",
                    displayName: "DeepSeek R1 Distill Qwen 7B",
                    shortDescription: "qwen \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3-1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-coder-32b-instruct",
                    displayName: "Qwen2.5-Coder 32B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen-flash",
                    displayName: "Qwen Flash",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3-2-exp",
                    displayName: "DeepSeek V3.2 Exp",
                    shortDescription: "deepseek \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "moonshot-kimi-k2-instruct",
                    displayName: "Moonshot Kimi K2 Instruct",
                    shortDescription: "kimi-k2 \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1-distill-qwen-14b",
                    displayName: "DeepSeek R1 Distill Qwen 14B",
                    shortDescription: "qwen \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-235b-a22b",
                    displayName: "Qwen3-VL 235B-A22B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-deep-research",
                    displayName: "Qwen Deep Research",
                    shortDescription: "qwen \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Moonshot Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-30b-a3b",
                    displayName: "Qwen3-VL 30B-A3B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-vl-max",
                    displayName: "Qwen-VL Max",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1-distill-qwen-1-5b",
                    displayName: "DeepSeek R1 Distill Qwen 1.5B",
                    shortDescription: "qwen \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-max",
                    displayName: "Qwen Max",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b",
                    displayName: "Qwen3 235B-A22B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1-distill-llama-8b",
                    displayName: "DeepSeek R1 Distill Llama 8B",
                    shortDescription: "deepseek-thinking \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "Moonshot Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-480b-a35b-instruct",
                    displayName: "Qwen3-Coder 480B-A35B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwq-plus",
                    displayName: "QwQ Plus",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-32b-instruct",
                    displayName: "Qwen2.5 32B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-397b-a17b",
                    displayName: "Qwen3.5 397B-A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "tongyi-intent-detect-v3",
                    displayName: "Tongyi Intent Detect V3",
                    shortDescription: "yi \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-flash",
                    displayName: "Qwen3 Coder Flash",
                    shortDescription: "qwen \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1-distill-qwen-32b",
                    displayName: "DeepSeek R1 Distill Qwen 32B",
                    shortDescription: "qwen \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwq-32b",
                    displayName: "QwQ 32B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-14b",
                    displayName: "Qwen3 14B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-doc-turbo",
                    displayName: "Qwen Doc Turbo",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-turbo",
                    displayName: "Qwen Turbo",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-7b-instruct",
                    displayName: "Qwen2.5 7B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-vl-7b-instruct",
                    displayName: "Qwen2.5-VL 7B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-max-preview",
                    displayName: "Qwen3.6 Max Preview",
                    shortDescription: "qwen \u{B7} 245K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-vl-plus",
                    displayName: "Qwen-VL Plus",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMax/MiniMax-M2.7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi/kimi-k2.5",
                    displayName: "kimi/kimi-k2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "siliconflow/deepseek-r1-0528",
                    displayName: "siliconflow/deepseek-r1-0528",
                    shortDescription: "deepseek-thinking \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "siliconflow/deepseek-v3.1-terminus",
                    displayName: "siliconflow/deepseek-v3.1-terminus",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "siliconflow/deepseek-v3-0324",
                    displayName: "siliconflow/deepseek-v3-0324",
                    shortDescription: "deepseek \u{B7} 163K context"
                ),
                AIScriptModelPreset(
                    id: "siliconflow/deepseek-v3.2",
                    displayName: "siliconflow/deepseek-v3.2",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-plus",
                    displayName: "Qwen3 Coder Plus",
                    shortDescription: "qwen \u{B7} 1.04858M context"
                )
            ]
        ),
        AIScriptProvider(
            id: "alibaba-coding-plan",
            displayName: "Alibaba Coding Plan",
            shortDescription: "OpenAI-compatible \u{B7} 12 text models",
            baseURLString: "https://coding-intl.dashscope.aliyuncs.com/v1",
            apiKeyLabel: "Alibaba Coding Plan API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "qwen3-coder-plus",
                    displayName: "Qwen3 Coder Plus",
                    shortDescription: "qwen \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-plus",
                    displayName: "Qwen3.7 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-max",
                    displayName: "Qwen3.7 Max",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-flash",
                    displayName: "Qwen3.6 Flash",
                    shortDescription: "qwen3.6 \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max-2026-01-23",
                    displayName: "Qwen3 Max",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-plus",
                    displayName: "Qwen3.5 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-next",
                    displayName: "Qwen3 Coder Next",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "alibaba-coding-plan-cn",
            displayName: "Alibaba Coding Plan (China)",
            shortDescription: "OpenAI-compatible \u{B7} 12 text models",
            baseURLString: "https://coding.dashscope.aliyuncs.com/v1",
            apiKeyLabel: "Alibaba Coding Plan (China) API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "qwen3-coder-plus",
                    displayName: "Qwen3 Coder Plus",
                    shortDescription: "qwen \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-plus",
                    displayName: "Qwen3.7 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-max",
                    displayName: "Qwen3.7 Max",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-flash",
                    displayName: "Qwen3.6 Flash",
                    shortDescription: "qwen3.6 \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max-2026-01-23",
                    displayName: "Qwen3 Max",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-plus",
                    displayName: "Qwen3.5 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-next",
                    displayName: "Qwen3 Coder Next",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "alibaba-token-plan",
            displayName: "Alibaba Token Plan",
            shortDescription: "OpenAI-compatible \u{B7} 12 text models",
            baseURLString: "https://token-plan.ap-southeast-1.maas.aliyuncs.com/compatible-mode/v1",
            apiKeyLabel: "Alibaba Token Plan API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-plus",
                    displayName: "Qwen3.7 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-max",
                    displayName: "Qwen3.7 Max",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-flash",
                    displayName: "Qwen3.6 Flash",
                    shortDescription: "qwen3.6 \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "alibaba-token-plan-cn",
            displayName: "Alibaba Token Plan (China)",
            shortDescription: "OpenAI-compatible \u{B7} 12 text models",
            baseURLString: "https://token-plan.cn-beijing.maas.aliyuncs.com/compatible-mode/v1",
            apiKeyLabel: "Alibaba Token Plan (China) API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-plus",
                    displayName: "Qwen3.7 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-max",
                    displayName: "Qwen3.7 Max",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-flash",
                    displayName: "Qwen3.6 Flash",
                    shortDescription: "qwen3.6 \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "ambient",
            displayName: "Ambient",
            shortDescription: "OpenAI-compatible \u{B7} 3 text models",
            baseURLString: "https://api.ambient.xyz/v1",
            apiKeyLabel: "Ambient API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.7-code",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1-FP8",
                    displayName: "GLM 5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "anyapi",
            displayName: "AnyAPI",
            shortDescription: "OpenAI-compatible \u{B7} 30 text models",
            baseURLString: "https://api.anyapi.ai/v1",
            apiKeyLabel: "AnyAPI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "xai/grok-4.3",
                    displayName: "Grok 4.3",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash-lite",
                    displayName: "Gemini 2.5 Flash-Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-pro-preview",
                    displayName: "Gemini 3 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-flash-preview",
                    displayName: "Gemini 3 Flash Preview",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o3",
                    displayName: "o3",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini",
                    displayName: "o4-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-mini",
                    displayName: "o3-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-mini",
                    displayName: "GPT-5 Mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-mini",
                    displayName: "GPT-4.1 mini",
                    shortDescription: "gpt-mini \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1",
                    displayName: "GPT-5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistralai/devstral-2512",
                    displayName: "Devstral 2",
                    shortDescription: "devstral \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-large-2512",
                    displayName: "Mistral Large 3",
                    shortDescription: "mistral-large \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4-5",
                    displayName: "Claude Sonnet 4.5 (latest)",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4-7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-haiku-4-5",
                    displayName: "Claude Haiku 4.5 (latest)",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4-6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4-6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "cohere/command-r-plus-08-2024",
                    displayName: "Command R+",
                    shortDescription: "command-r \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "perplexity/sonar-reasoning-pro",
                    displayName: "Sonar Reasoning Pro",
                    shortDescription: "sonar-reasoning \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "perplexity/sonar-pro",
                    displayName: "Sonar Pro",
                    shortDescription: "sonar-pro \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1",
                    displayName: "DeepSeek Reasoner",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-chat",
                    displayName: "DeepSeek Chat",
                    shortDescription: "deepseek \u{B7} 1M context \u{B7} Attachments"
                )
            ]
        ),
        AIScriptProvider(
            id: "atomic-chat",
            displayName: "Atomic Chat",
            shortDescription: "OpenAI-compatible \u{B7} 5 text models",
            baseURLString: "http://127.0.0.1:1337/v1",
            apiKeyLabel: "Atomic Chat API Key",
            requiresAPIKey: false,
            modelPresets: [
                AIScriptModelPreset(
                    id: "gemma-4-E4B-it-IQ4_XS",
                    displayName: "Gemma 4 E4B Instruct (IQ4_XS)",
                    shortDescription: "gemma \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "Meta-Llama-3_1-8B-Instruct-GGUF",
                    displayName: "Meta Llama 3.1 8B Instruct (GGUF)",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3_5-9B-MLX-4bit",
                    displayName: "Qwen 3.5 9B (MLX 4-bit)",
                    shortDescription: "qwen \u{B7} 32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-E4B-it-MLX-4bit",
                    displayName: "Gemma 4 E4B Instruct (MLX 4-bit)",
                    shortDescription: "gemma \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3_5-9B-Q4_K_M",
                    displayName: "Qwen 3.5 9B (Q4_K_M)",
                    shortDescription: "qwen \u{B7} 32K context \u{B7} Attachments"
                )
            ]
        ),
        AIScriptProvider(
            id: "auriko",
            displayName: "Auriko",
            shortDescription: "OpenAI-compatible \u{B7} 15 text models",
            baseURLString: "https://api.auriko.ai/v1",
            apiKeyLabel: "Auriko API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4.3",
                    displayName: "Grok 4.3",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2-7-highspeed",
                    displayName: "MiniMax-M2.7-highspeed",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2-7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-3.6-plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.1-pro-preview",
                    displayName: "Gemini 3.1 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "bailing",
            displayName: "Bailing",
            shortDescription: "OpenAI-compatible \u{B7} 2 text models",
            baseURLString: "https://api.tbox.cn/api/llm/v1/chat/completions",
            apiKeyLabel: "Bailing API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "Ring-1T",
                    displayName: "Ring-1T",
                    shortDescription: "ring \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Ling-1T",
                    displayName: "Ling-1T",
                    shortDescription: "ling \u{B7} 128K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "baseten",
            displayName: "Baseten",
            shortDescription: "OpenAI-compatible \u{B7} 13 text models",
            baseURLString: "https://inference.baseten.co/v1",
            apiKeyLabel: "Baseten API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.7-Code",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "OpenAI GPT 120B",
                    shortDescription: "gpt-oss \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/Nemotron-120B-A12B",
                    displayName: "Nemotron Super",
                    shortDescription: "nemotron \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/NVIDIA-Nemotron-3-Ultra-550B-A55B",
                    displayName: "Nemotron Ultra",
                    shortDescription: "nemotron \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5",
                    displayName: "GLM 5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.7",
                    displayName: "GLM 4.7",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.2",
                    displayName: "GLM-5.2",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1",
                    displayName: "GLM 5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V4-Pro",
                    displayName: "Deepseek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "berget",
            displayName: "Berget.AI",
            shortDescription: "OpenAI-compatible \u{B7} 7 text models",
            baseURLString: "https://api.berget.ai/v1",
            apiKeyLabel: "Berget.AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.3-70B-Instruct",
                    displayName: "Llama 3.3 70B Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31B-it",
                    displayName: "Gemma 4 31B Instruct",
                    shortDescription: "gemma \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT-OSS-120B",
                    shortDescription: "gpt-oss \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistralai/Mistral-Medium-3.5-128B",
                    displayName: "Mistral Medium 3.5 128B",
                    shortDescription: "mistral-medium \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistralai/Mistral-Small-3.2-24B-Instruct-2506",
                    displayName: "Mistral Small 3.2 24B Instruct 2506",
                    shortDescription: "mistral-small \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.7",
                    displayName: "GLM 4.7",
                    shortDescription: "glm \u{B7} 128K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "cerebras",
            displayName: "Cerebras",
            shortDescription: "OpenAI-compatible \u{B7} 2 text models",
            baseURLString: "https://api.cerebras.ai/v1",
            apiKeyLabel: "Cerebras API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-glm-4.7",
                    displayName: "Z.AI GLM-4.7",
                    shortDescription: "131K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "chutes",
            displayName: "Chutes",
            shortDescription: "OpenAI-compatible \u{B7} 39 text models",
            baseURLString: "https://llm.chutes.ai/v1",
            apiKeyLabel: "Chutes API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.6-TEE",
                    displayName: "Kimi K2.6 TEE",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.5-TEE",
                    displayName: "Kimi K2.5 TEE",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31B-turbo-TEE",
                    displayName: "gemma 4 31B turbo TEE",
                    shortDescription: "gemma \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-32B-TEE",
                    displayName: "Qwen3 32B TEE",
                    shortDescription: "qwen \u{B7} 40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-VL-32B-Instruct",
                    displayName: "Qwen2.5 VL 32B Instruct",
                    shortDescription: "qwen \u{B7} 16K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Next-80B-A3B-Instruct",
                    displayName: "Qwen3 Next 80B A3B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Instruct-2507-TEE",
                    displayName: "Qwen3 235B A22B Instruct 2507 TEE",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Thinking-2507",
                    displayName: "Qwen3 235B A22B Thinking 2507",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.6-27B-TEE",
                    displayName: "Qwen3.6 27B TEE",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3Guard-Gen-0.6B",
                    displayName: "Qwen3Guard Gen 0.6B",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-Next-TEE",
                    displayName: "Qwen3 Coder Next TEE",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-Coder-32B-Instruct",
                    displayName: "Qwen2.5 Coder 32B Instruct",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-72B-Instruct",
                    displayName: "Qwen2.5 72B Instruct",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-397B-A17B-TEE",
                    displayName: "Qwen3.5 397B A17B TEE",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-30B-A3B",
                    displayName: "Qwen3 30B A3B",
                    shortDescription: "qwen \u{B7} 40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b-TEE",
                    displayName: "gpt oss 120b TEE",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "XiaomiMiMo/MiMo-V2-Flash-TEE",
                    displayName: "MiMo V2 Flash TEE",
                    shortDescription: "mimo \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "NousResearch/Hermes-4-14B",
                    displayName: "Hermes 4 14B",
                    shortDescription: "nousresearch \u{B7} 40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "NousResearch/DeepHermes-3-Mistral-24B-Preview",
                    displayName: "DeepHermes 3 Mistral 24B Preview",
                    shortDescription: "nousresearch \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "unsloth/Llama-3.2-1B-Instruct",
                    displayName: "Llama 3.2 1B Instruct",
                    shortDescription: "unsloth \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "unsloth/gemma-3-12b-it",
                    displayName: "gemma 3 12b it",
                    shortDescription: "unsloth \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "unsloth/gemma-3-4b-it",
                    displayName: "gemma 3 4b it",
                    shortDescription: "unsloth \u{B7} 96K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "unsloth/gemma-3-27b-it",
                    displayName: "gemma 3 27b it",
                    shortDescription: "unsloth \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "unsloth/Mistral-Nemo-Instruct-2407",
                    displayName: "Mistral Nemo Instruct 2407",
                    shortDescription: "unsloth \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "unsloth/Llama-3.2-3B-Instruct",
                    displayName: "Llama 3.2 3B Instruct",
                    shortDescription: "unsloth \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "tngtech/DeepSeek-TNG-R1T2-Chimera-TEE",
                    displayName: "DeepSeek TNG R1T2 Chimera TEE",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.7-TEE",
                    displayName: "GLM 4.7 TEE",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5-TEE",
                    displayName: "GLM 5 TEE",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1-TEE",
                    displayName: "GLM 5.1 TEE",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.6V",
                    displayName: "GLM 4.6V",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5-Turbo",
                    displayName: "GLM 5 Turbo",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.7-FP8",
                    displayName: "GLM 4.7 FP8",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.2-TEE",
                    displayName: "DeepSeek V3.2 TEE",
                    shortDescription: "deepseek \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3-0324-TEE",
                    displayName: "DeepSeek V3 0324 TEE",
                    shortDescription: "deepseek \u{B7} 163K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1-TEE",
                    displayName: "DeepSeek V3.1 TEE",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1-Distill-Llama-70B",
                    displayName: "DeepSeek R1 Distill Llama 70B",
                    shortDescription: "deepseek-thinking \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1-0528-TEE",
                    displayName: "DeepSeek R1 0528 TEE",
                    shortDescription: "deepseek-thinking \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5-TEE",
                    displayName: "MiniMax M2.5 TEE",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "rednote-hilab/dots.ocr",
                    displayName: "dots.ocr",
                    shortDescription: "rednote \u{B7} 131K context \u{B7} Attachments"
                )
            ]
        ),
        AIScriptProvider(
            id: "clarifai",
            displayName: "Clarifai",
            shortDescription: "OpenAI-compatible \u{B7} 12 text models",
            baseURLString: "https://api.clarifai.com/v2/ext/openai/v1",
            apiKeyLabel: "Clarifai API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/chat-completion/models/Kimi-K2_6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimaxai/chat-completion/models/MiniMax-M2_5-high-throughput",
                    displayName: "MiniMax-M2.5 High Throughput",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/chat-completion/models/gpt-oss-120b-high-throughput",
                    displayName: "GPT OSS 120B High Throughput",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/chat-completion/models/gpt-oss-20b",
                    displayName: "GPT OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistralai/completion/models/Ministral-3-14B-Reasoning-2512",
                    displayName: "Ministral 3 14B Reasoning 2512",
                    shortDescription: "ministral \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistralai/completion/models/Ministral-3-3B-Reasoning-2512",
                    displayName: "Ministral 3 3B Reasoning 2512",
                    shortDescription: "ministral \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/deepseek-ocr/models/DeepSeek-OCR",
                    displayName: "DeepSeek OCR",
                    shortDescription: "deepseek \u{B7} 8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwenLM/models/Qwen3-30B-A3B-Thinking-2507",
                    displayName: "Qwen3 30B A3B Thinking 2507",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwenLM/models/Qwen3-30B-A3B-Instruct-2507",
                    displayName: "Qwen3 30B A3B Instruct 2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwenCoder/models/Qwen3-Coder-30B-A3B-Instruct",
                    displayName: "Qwen3 Coder 30B A3B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "arcee_ai/AFM/models/trinity-mini",
                    displayName: "Trinity Mini",
                    shortDescription: "trinity-mini \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "clarifai/main/models/mm-poly-8b",
                    displayName: "MM Poly 8B",
                    shortDescription: "mm-poly \u{B7} 32K context \u{B7} Attachments"
                )
            ]
        ),
        AIScriptProvider(
            id: "claudinio",
            displayName: "Claudinio",
            shortDescription: "OpenAI-compatible \u{B7} 1 text models",
            baseURLString: "https://api.claudin.io/v1",
            apiKeyLabel: "Claudinio API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "claudinio",
                    displayName: "Claudinio",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                )
            ]
        ),
        AIScriptProvider(
            id: "cloudferro-sherlock",
            displayName: "CloudFerro Sherlock",
            shortDescription: "OpenAI-compatible \u{B7} 5 text models",
            baseURLString: "https://api-sherlock.cloudferro.com/openai/v1/",
            apiKeyLabel: "CloudFerro Sherlock API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.3-70B-Instruct",
                    displayName: "Llama 3.3 70B Instruct",
                    shortDescription: "llama \u{B7} 70K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "OpenAI GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "speakleash/Bielik-11B-v3.0-Instruct",
                    displayName: "Bielik 11B v3.0 Instruct",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "speakleash/Bielik-11B-v2.6-Instruct",
                    displayName: "Bielik 11B v2.6 Instruct",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "cortecs",
            displayName: "Cortecs",
            shortDescription: "OpenAI-compatible \u{B7} 55 text models",
            baseURLString: "https://api.cortecs.ai/v1",
            apiKeyLabel: "Cortecs API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "deepseek-r1-0528",
                    displayName: "DeepSeek R1 0528",
                    shortDescription: "deepseek-thinking \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3-0324",
                    displayName: "DeepSeek V3 0324",
                    shortDescription: "deepseek \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "claude-opus4-7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "GLM 4.7",
                    shortDescription: "glm \u{B7} 198K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b-instruct-2507",
                    displayName: "Qwen3 235B A22B Instruct 2507",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-30b-a3b-instruct",
                    displayName: "Qwen3 Coder 30B A3B Instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.1",
                    displayName: "MiniMax-M2.1",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-32b",
                    displayName: "Qwen3 32B",
                    shortDescription: "qwen \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "claude-4-6-sonnet",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4",
                    displayName: "Claude Sonnet 4",
                    shortDescription: "claude-sonnet \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "llama-4-maverick",
                    displayName: "Llama 4 Maverick 17B Instruct",
                    shortDescription: "llama \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context"
                ),
                AIScriptModelPreset(
                    id: "claude-4-5-sonnet",
                    displayName: "Claude 4.5 Sonnet",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mixtral-8x7B-instruct-v0.1",
                    displayName: "Mixtral 8x7B Instruct v0.1",
                    shortDescription: "32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5",
                    displayName: "GLM 4.5",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-instruct",
                    displayName: "Kimi K2 Instruct",
                    shortDescription: "kimi-k2 \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "llama-3.3-70b-instruct",
                    displayName: "Llama 3.3 70B Instruct",
                    shortDescription: "llama \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus4-8",
                    displayName: "Claude Opus 4.8",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "devstral-small-2512",
                    displayName: "Devstral Small 2 2512",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-next-80b-a3b-thinking",
                    displayName: "Qwen3 Next 80B A3B Thinking",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "minimax-m3",
                    displayName: "MiniMax-M3",
                    shortDescription: "minimax \u{B7} 512K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2",
                    displayName: "MiniMax-M2",
                    shortDescription: "minimax \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.7",
                    displayName: "MiniMax-m2.7",
                    shortDescription: "minimax \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-thinking \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-120b",
                    displayName: "GPT Oss 120b",
                    shortDescription: "gpt-oss \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen-2.5-72b-instruct",
                    displayName: "Qwen2.5 72B Instruct",
                    shortDescription: "qwen \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "hermes-4-70b",
                    displayName: "Hermes 4 70B",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4-5",
                    displayName: "Claude Haiku 4.5",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-thinking \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1",
                    displayName: "GPT 4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context"
                ),
                AIScriptModelPreset(
                    id: "nova-pro-v1",
                    displayName: "Nova Pro 1.0",
                    shortDescription: "nova-pro \u{B7} 300K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-next",
                    displayName: "Qwen3 Coder Next 80B",
                    shortDescription: "qwen \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus4-5",
                    displayName: "Claude Opus 4.5",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-480b-a35b-instruct",
                    displayName: "Qwen3 Coder 480B A35B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "devstral-2512",
                    displayName: "Devstral 2 2512",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-397b-a17b",
                    displayName: "Qwen3.5 397B A17B",
                    shortDescription: "qwen \u{B7} 250K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5v-turbo",
                    displayName: "GLM-5V-Turbo",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-air",
                    displayName: "GLM 4.5 Air",
                    shortDescription: "glm-air \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7-flash",
                    displayName: "GLM-4.7-Flash",
                    shortDescription: "glm \u{B7} 203K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "intellect-3",
                    displayName: "INTELLECT 3",
                    shortDescription: "128K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "llama-3.1-405b-instruct",
                    displayName: "Llama 3.1 405B Instruct",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM 5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-large-2512",
                    displayName: "Mistral Large 3 2512",
                    shortDescription: "mistral-large \u{B7} 256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "codestral-2508",
                    displayName: "Codestral 2508",
                    shortDescription: "mistral \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-122b-a10b",
                    displayName: "Qwen3.5 122B A10B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nemotron-3-super-120b-a12b",
                    displayName: "Nemotron 3 Super 120B A12B",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5-turbo",
                    displayName: "GLM-5-Turbo",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus4-6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "crof",
            displayName: "CrofAI",
            shortDescription: "OpenAI-compatible \u{B7} 21 text models",
            baseURLString: "https://crof.ai/v1",
            apiKeyLabel: "CrofAI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 204K context"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "greg-1-super",
                    displayName: "Greg 1 Super",
                    shortDescription: "229K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro-lightning",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "greg-rp",
                    displayName: "Greg (Roleplay)",
                    shortDescription: "229K context"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-31b-it",
                    displayName: "Gemma 4 31B IT",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "greg-1",
                    displayName: "Greg 1 Normal",
                    shortDescription: "229K context"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5-lightning",
                    displayName: "Kimi K2.5 (Lightning)",
                    shortDescription: "kimi-k2 \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-27b",
                    displayName: "Qwen3.6 27B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-9b",
                    displayName: "Qwen3.5 9B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-397b-a17b",
                    displayName: "Qwen3.5 397B-A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7-flash",
                    displayName: "GLM-4.7-Flash",
                    shortDescription: "glm-flash \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2.5-pro",
                    displayName: "MiMo-V2.5-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 163K context"
                ),
                AIScriptModelPreset(
                    id: "greg-1-mini",
                    displayName: "Greg 1 Mini",
                    shortDescription: "229K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "drun",
            displayName: "D.Run (China)",
            shortDescription: "OpenAI-compatible \u{B7} 3 text models",
            baseURLString: "https://chat.d.run/v1",
            apiKeyLabel: "D.Run (China) API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "public/deepseek-v3",
                    displayName: "DeepSeek V3",
                    shortDescription: "deepseek \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "public/deepseek-r1",
                    displayName: "DeepSeek R1",
                    shortDescription: "deepseek-thinking \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "public/minimax-m25",
                    displayName: "MiniMax M2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "deepinfra",
            displayName: "Deep Infra",
            shortDescription: "OpenAI-compatible \u{B7} 25 text models",
            baseURLString: "https://api.deepinfra.com/v1/openai",
            apiKeyLabel: "Deep Infra API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "meta-llama/Llama-4-Maverick-17B-128E-Instruct-FP8",
                    displayName: "Llama 4 Maverick 17B FP8",
                    shortDescription: "llama \u{B7} 1.04858M context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Llama-4-Scout-17B-16E-Instruct",
                    displayName: "Llama 4 Scout 17B",
                    shortDescription: "llama \u{B7} 327K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.3-70B-Instruct-Turbo",
                    displayName: "Llama 3.3 70B Turbo",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31B-it",
                    displayName: "Gemma 4 31B IT",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-26B-A4B-it",
                    displayName: "Gemma 4 26B A4B IT",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.6-35B-A3B",
                    displayName: "Qwen3.6 35B A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-397B-A17B",
                    displayName: "Qwen 3.5 397B A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-480B-A35B-Instruct-Turbo",
                    displayName: "Qwen3 Coder 480B A35B Instruct Turbo",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-35B-A3B",
                    displayName: "Qwen 3.5 35B A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "GPT OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "XiaomiMiMo/MiMo-V2.5",
                    displayName: "MiMo-V2.5",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "XiaomiMiMo/MiMo-V2.5-Pro",
                    displayName: "MiMo-V2.5-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.7-Flash",
                    displayName: "GLM-4.7-Flash",
                    shortDescription: "glm-flash \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.6",
                    displayName: "GLM-4.6",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1-0528",
                    displayName: "DeepSeek-R1-0528",
                    shortDescription: "163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V4-Flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V4-Pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.2",
                    displayName: "DeepSeek-V3.2",
                    shortDescription: "163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5",
                    displayName: "MiniMax M2.5",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "deepseek",
            displayName: "DeepSeek",
            shortDescription: "OpenAI-compatible \u{B7} 4 text models",
            baseURLString: "https://api.deepseek.com",
            apiKeyLabel: "DeepSeek API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-reasoner",
                    displayName: "DeepSeek Reasoner",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-chat",
                    displayName: "DeepSeek Chat",
                    shortDescription: "deepseek \u{B7} 1M context \u{B7} Attachments"
                )
            ]
        ),
        AIScriptProvider(
            id: "digitalocean",
            displayName: "DigitalOcean",
            shortDescription: "OpenAI-compatible \u{B7} 63 text models",
            baseURLString: "https://inference.do-ai.run/v1",
            apiKeyLabel: "DigitalOcean API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "anthropic-claude-haiku-4.5",
                    displayName: "Claude Haiku 4.5",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-3-14B",
                    displayName: "Ministral 3 14B Instruct",
                    shortDescription: "ministral \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "nemotron-3-ultra-550b",
                    displayName: "Nemotron 3 Ultra",
                    shortDescription: "nemotron \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.5",
                    displayName: "MiniMax M2.5",
                    shortDescription: "minimax-m2.5 \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-5.4-nano",
                    displayName: "GPT-5.4 nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3",
                    displayName: "DeepSeek V3",
                    shortDescription: "deepseek \u{B7} 163K context"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1-distill-llama-70b",
                    displayName: "DeepSeek R1 Distill Llama 70B",
                    shortDescription: "deepseek-thinking \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-31B-it",
                    displayName: "Gemma 4 31B",
                    shortDescription: "gemma \u{B7} 256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "llama-4-maverick",
                    displayName: "Llama 4 Maverick 17B 128E Instruct",
                    shortDescription: "llama \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-3.7-sonnet",
                    displayName: "Claude 3.7 Sonnet",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-4o-mini",
                    displayName: "GPT-4o mini",
                    shortDescription: "gpt-mini \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-opus-4.7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-4-flash",
                    displayName: "Deepseek V4 Flash",
                    shortDescription: "deepseek \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-4.5-haiku",
                    displayName: "Claude Haiku 4.5",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-4.6-sonnet",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-sonnet-4",
                    displayName: "Claude Sonnet 4",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "ministral-3-8b-instruct-2512",
                    displayName: "Ministral 3 8B",
                    shortDescription: "ministral \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-4.5-sonnet",
                    displayName: "Claude Sonnet 4.5",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-opus-4.6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-oss-20b",
                    displayName: "gpt-oss-20b",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-2.5-14b-instruct",
                    displayName: "Qwen 2.5 14B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-opus-4.8",
                    displayName: "Claude Opus 4.8",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-opus-4.5",
                    displayName: "Claude Opus 4.5",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-4.1-opus",
                    displayName: "Claude Opus 4.1",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "llama3-8b-instruct",
                    displayName: "Llama 3.1 Instruct (8B)",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-5.4-pro",
                    displayName: "GPT-5.4 pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-4o",
                    displayName: "GPT-4o",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-opus-4",
                    displayName: "Claude Opus 4",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-o3-mini",
                    displayName: "o3-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "llama3.3-70b-instruct",
                    displayName: "Llama 3.3 Instruct 70B",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-5.4-mini",
                    displayName: "GPT-5.4 mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-5.5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nemotron-3-nano-30b",
                    displayName: "Nemotron 3 Nano 30B A3B",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-oss-120b",
                    displayName: "gpt-oss-120b",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-5-nano",
                    displayName: "GPT-5 nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-7b-instruct-v0.3",
                    displayName: "Mistral 7B Instruct v0.3",
                    shortDescription: "mistral \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-nemo-instruct-2407",
                    displayName: "Mistral Nemo Instruct",
                    shortDescription: "mistral \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-o1",
                    displayName: "o1",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-397b-a17b",
                    displayName: "Qwen 3.5 397B A17B",
                    shortDescription: "qwen3.5 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-flash",
                    displayName: "Qwen3 Coder Flash",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-5.3-codex",
                    displayName: "GPT-5.3 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-3.5-haiku",
                    displayName: "Claude 3.5 Haiku",
                    shortDescription: "claude-haiku \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "gpt \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "arcee-trinity-large-thinking",
                    displayName: "Trinity Large Thinking",
                    shortDescription: "trinity \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-o3",
                    displayName: "o3",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-3.5-sonnet",
                    displayName: "Claude 3.5 Sonnet",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-5-mini",
                    displayName: "GPT-5 mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia-nemotron-3-super-120b",
                    displayName: "Nemotron-3-Super-120B",
                    shortDescription: "nemotron \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM 5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-5.2-pro",
                    displayName: "GPT-5.2 pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-3-opus",
                    displayName: "Claude 3 Opus",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic-claude-fable-5",
                    displayName: "Anthropic Claude Fable 5",
                    shortDescription: "claude-fable \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nemotron-3-nano-omni",
                    displayName: "Nemotron Nano 3 Omni",
                    shortDescription: "nemotron \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "alibaba-qwen3-32b",
                    displayName: "Qwen3-32B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nemotron-nano-12b-v2-vl",
                    displayName: "Nemotron Nano 12B v2 VL",
                    shortDescription: "nemotron \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai-gpt-5.1-codex-max",
                    displayName: "GPT-5.1 Codex Max",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "dinference",
            displayName: "DInference",
            shortDescription: "OpenAI-compatible \u{B7} 5 text models",
            baseURLString: "https://api.dinference.com/v1",
            apiKeyLabel: "DInference API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "minimax-m2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "evroc",
            displayName: "evroc",
            shortDescription: "OpenAI-compatible \u{B7} 9 text models",
            baseURLString: "https://models.think.evroc.com/v1",
            apiKeyLabel: "evroc API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/Phi-4-multimodal-instruct",
                    displayName: "Phi-4 15B",
                    shortDescription: "phi \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-30B-A3B-Instruct-2507-FP8",
                    displayName: "Qwen3 30B 2507",
                    shortDescription: "qwen \u{B7} 64K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-30B-A3B-Instruct",
                    displayName: "Qwen3 VL 30B",
                    shortDescription: "qwen \u{B7} 100K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistralai/devstral-small-2-24b-instruct-2512",
                    displayName: "Devstral Small 2 24B Instruct 2512",
                    shortDescription: "devstral \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/Magistral-Small-2509",
                    displayName: "Magistral Small 1.2 24B",
                    shortDescription: "magistral-small \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/Voxtral-Small-24B-2507",
                    displayName: "Voxtral Small 24B",
                    shortDescription: "voxtral \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/Llama-3.3-70B-Instruct-FP8",
                    displayName: "Llama 3.3 70B",
                    shortDescription: "llama \u{B7} 131K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "fastrouter",
            displayName: "FastRouter",
            shortDescription: "OpenAI-compatible \u{B7} 35 text models",
            baseURLString: "https://go.fastrouter.ai/api/v1",
            apiKeyLabel: "FastRouter API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2",
                    displayName: "Kimi K2",
                    shortDescription: "kimi-k2 \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.5-flash",
                    displayName: "Gemini 3.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31b-it",
                    displayName: "Gemma 4 31B IT",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro-preview",
                    displayName: "Gemini 3.1 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.3",
                    displayName: "Grok 4.3",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4",
                    displayName: "Grok 4",
                    shortDescription: "grok \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-build-0.1",
                    displayName: "Grok Build 0.1",
                    shortDescription: "grok-build \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-nano",
                    displayName: "GPT-5.4 nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-codex",
                    displayName: "GPT-5.3 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-realtime-1.5",
                    displayName: "GPT Realtime 1.5",
                    shortDescription: "gpt \u{B7} 32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-mini",
                    displayName: "GPT-5.4 mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-mini",
                    displayName: "GPT-5 Mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-nano",
                    displayName: "GPT-5 Nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5-pro",
                    displayName: "GPT-5.5 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "GPT OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4",
                    displayName: "Claude Sonnet 4",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.8",
                    displayName: "Claude Opus 4.8",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.1",
                    displayName: "Claude Opus 4.1",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "sarvam/sarvam-105b",
                    displayName: "Sarvam 105B",
                    shortDescription: "sarvam \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "sarvam/sarvam-30b",
                    displayName: "Sarvam 30B",
                    shortDescription: "sarvam \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/deepseek-r1-distill-llama-70b",
                    displayName: "DeepSeek R1 Distill Llama 70B",
                    shortDescription: "deepseek-thinking \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder",
                    displayName: "Qwen3 Coder",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.7-highspeed",
                    displayName: "MiniMax-M2.7-highspeed",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "firepass",
            displayName: "Fireworks (Firepass)",
            shortDescription: "OpenAI-compatible \u{B7} 1 text models",
            baseURLString: "https://api.fireworks.ai/inference/v1/",
            apiKeyLabel: "Fireworks (Firepass) API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "accounts/fireworks/routers/kimi-k2p6-turbo",
                    displayName: "Kimi K2.6 Turbo",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "fireworks-ai",
            displayName: "Fireworks AI",
            shortDescription: "OpenAI-compatible \u{B7} 15 text models",
            baseURLString: "https://api.fireworks.ai/inference/v1/",
            apiKeyLabel: "Fireworks AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "accounts/fireworks/routers/kimi-k2p6-turbo",
                    displayName: "Kimi K2.6 Turbo",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/routers/kimi-k2p7-code-fast",
                    displayName: "Kimi K2.7 Code Fast",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/routers/glm-5p1-fast",
                    displayName: "GLM 5.1 Fast",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/routers/kimi-k2p6-fast",
                    displayName: "Kimi K2.6 Fast",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/models/deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/models/deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/models/minimax-m2p7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/models/minimax-m3",
                    displayName: "MiniMax-M3",
                    shortDescription: "minimax \u{B7} 512K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/models/kimi-k2p6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/models/qwen3p7-plus",
                    displayName: "Qwen 3.7 Plus",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/models/glm-5p1",
                    displayName: "GLM 5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/models/glm-5p2",
                    displayName: "GLM 5.2",
                    shortDescription: "glm \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/models/gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/models/gpt-oss-20b",
                    displayName: "GPT OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "accounts/fireworks/models/kimi-k2p7-code",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "friendli",
            displayName: "Friendli",
            shortDescription: "OpenAI-compatible \u{B7} 6 text models",
            baseURLString: "https://api.friendli.ai/serverless/v1",
            apiKeyLabel: "Friendli API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.3-70B-Instruct",
                    displayName: "Llama 3.3 70B Instruct",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.1-8B-Instruct",
                    displayName: "Llama 3.1 8B Instruct",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Instruct-2507",
                    displayName: "Qwen3 235B A22B Instruct 2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "frogbot",
            displayName: "FrogBot",
            shortDescription: "OpenAI-compatible \u{B7} 26 text models",
            baseURLString: "https://app.frogbot.ai/api/v1",
            apiKeyLabel: "FrogBot API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "minimax-m2-5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 192K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-6",
                    displayName: "Kimi-K2.6",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-glm-5-1",
                    displayName: "Z.AI GLM-5.1",
                    shortDescription: "glm \u{B7} 198K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "grok-code-fast-1",
                    displayName: "Grok 4.1 Fast (Reasoning)",
                    shortDescription: "grok \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o",
                    displayName: "GPT-4o",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen-3-6-plus",
                    displayName: "Qwen 3.6 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-3",
                    displayName: "Grok 4.3",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek v4 Pro",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-1-fast-non-reasoning",
                    displayName: "Grok 4.1 Fast (Non-Reasoning)",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2-7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "minimax \u{B7} 192K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-3-codex",
                    displayName: "GPT-5.3 Codex",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-4-nano",
                    displayName: "GPT-5.4 Nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-4-mini",
                    displayName: "GPT-5.4 Mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi-K2.5",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 272K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4-5",
                    displayName: "Claude Haiku 4.5",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-1-pro-preview",
                    displayName: "Gemini 3.1 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-1-fast-reasoning",
                    displayName: "Grok 4.1 Fast (Reasoning)",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-flash-preview",
                    displayName: "Gemini 3 Flash Preview",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-20b",
                    displayName: "GPT OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "github-copilot",
            displayName: "GitHub Copilot",
            shortDescription: "OpenAI-compatible \u{B7} 23 text models",
            baseURLString: "https://api.githubcopilot.com",
            apiKeyLabel: "GitHub Copilot API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "raptor-mini",
                    displayName: "Raptor mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4.5",
                    displayName: "Claude Sonnet 4.5 (latest)",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4",
                    displayName: "Claude Sonnet 4 (latest)",
                    shortDescription: "claude-sonnet \u{B7} 216K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4.5",
                    displayName: "Claude Haiku 4.5 (latest)",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.5-flash",
                    displayName: "Gemini 3.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-nano",
                    displayName: "GPT-5.4 nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4.7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.3-codex",
                    displayName: "GPT-5.3 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4.8",
                    displayName: "Claude Opus 4.8",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-fable-5",
                    displayName: "Claude Fable 5",
                    shortDescription: "claude-fable \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4.5",
                    displayName: "Claude Opus 4.5 (latest)",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-mini",
                    displayName: "GPT-5.4 mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.1-pro-preview",
                    displayName: "Gemini 3.1 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4.6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-mini",
                    displayName: "GPT-5 Mini",
                    shortDescription: "gpt-mini \u{B7} 264K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-flash-preview",
                    displayName: "Gemini 3 Flash Preview",
                    shortDescription: "gemini-flash \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4.6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-codex",
                    displayName: "GPT-5.2 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "github-models",
            displayName: "GitHub Models",
            shortDescription: "OpenAI-compatible \u{B7} 55 text models",
            baseURLString: "https://models.github.ai/inference",
            apiKeyLabel: "GitHub Models API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "ai21-labs/ai21-jamba-1.5-mini",
                    displayName: "AI21 Jamba 1.5 Mini",
                    shortDescription: "jamba \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "ai21-labs/ai21-jamba-1.5-large",
                    displayName: "AI21 Jamba 1.5 Large",
                    shortDescription: "jamba \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "core42/jais-30b-chat",
                    displayName: "JAIS 30b Chat",
                    shortDescription: "jais \u{B7} 8K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xai/grok-3-mini",
                    displayName: "Grok 3 Mini",
                    shortDescription: "grok \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xai/grok-3",
                    displayName: "Grok 3",
                    shortDescription: "grok \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-3.5-moe-instruct",
                    displayName: "Phi-3.5-MoE instruct (128k)",
                    shortDescription: "phi \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-3-small-128k-instruct",
                    displayName: "Phi-3-small instruct (128k)",
                    shortDescription: "phi \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-3.5-mini-instruct",
                    displayName: "Phi-3.5-mini instruct (128k)",
                    shortDescription: "phi \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-3-medium-128k-instruct",
                    displayName: "Phi-3-medium instruct (128k)",
                    shortDescription: "phi \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-3-small-8k-instruct",
                    displayName: "Phi-3-small instruct (8k)",
                    shortDescription: "phi \u{B7} 8K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-4-reasoning",
                    displayName: "Phi-4-Reasoning",
                    shortDescription: "phi \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/mai-ds-r1",
                    displayName: "MAI-DS-R1",
                    shortDescription: "mai \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-4-mini-instruct",
                    displayName: "Phi-4-mini-instruct",
                    shortDescription: "phi \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-4",
                    displayName: "Phi-4",
                    shortDescription: "phi \u{B7} 16K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-3.5-vision-instruct",
                    displayName: "Phi-3.5-vision instruct (128k)",
                    shortDescription: "phi \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-3-medium-4k-instruct",
                    displayName: "Phi-3-medium instruct (4k)",
                    shortDescription: "phi \u{B7} 4K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-4-multimodal-instruct",
                    displayName: "Phi-4-multimodal-instruct",
                    shortDescription: "phi \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-4-mini-reasoning",
                    displayName: "Phi-4-mini-reasoning",
                    shortDescription: "phi \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-3-mini-128k-instruct",
                    displayName: "Phi-3-mini instruct (128k)",
                    shortDescription: "phi \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-3-mini-4k-instruct",
                    displayName: "Phi-3-mini instruct (4k)",
                    shortDescription: "phi \u{B7} 4K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o3",
                    displayName: "OpenAI o3",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o1-mini",
                    displayName: "OpenAI o1-mini",
                    shortDescription: "o-mini \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o",
                    displayName: "GPT-4o",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini",
                    displayName: "OpenAI o4-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o1-preview",
                    displayName: "OpenAI o1-preview",
                    shortDescription: "o \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-mini",
                    displayName: "OpenAI o3-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-nano",
                    displayName: "GPT-4.1-nano",
                    shortDescription: "gpt-nano \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o1",
                    displayName: "OpenAI o1",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-mini",
                    displayName: "GPT-4.1-mini",
                    shortDescription: "gpt-mini \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini",
                    displayName: "GPT-4o mini",
                    shortDescription: "gpt-mini \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistral-ai/mistral-small-2503",
                    displayName: "Mistral Small 3.1",
                    shortDescription: "mistral-small \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-ai/mistral-nemo",
                    displayName: "Mistral Nemo",
                    shortDescription: "mistral-nemo \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-ai/mistral-medium-2505",
                    displayName: "Mistral Medium 3 (25.05)",
                    shortDescription: "mistral-medium \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-ai/mistral-large-2411",
                    displayName: "Mistral Large 24.11",
                    shortDescription: "mistral-large \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-ai/ministral-3b",
                    displayName: "Ministral 3B",
                    shortDescription: "ministral \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-ai/codestral-2501",
                    displayName: "Codestral 25.01",
                    shortDescription: "codestral \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "cohere/cohere-command-a",
                    displayName: "Cohere Command A",
                    shortDescription: "command-a \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "cohere/cohere-command-r-08-2024",
                    displayName: "Cohere Command R 08-2024",
                    shortDescription: "command-r \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "cohere/cohere-command-r-plus",
                    displayName: "Cohere Command R+",
                    shortDescription: "command-r \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "cohere/cohere-command-r-plus-08-2024",
                    displayName: "Cohere Command R+ 08-2024",
                    shortDescription: "command-r \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "cohere/cohere-command-r",
                    displayName: "Cohere Command R",
                    shortDescription: "command-r \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta/meta-llama-3-8b-instruct",
                    displayName: "Meta-Llama-3-8B-Instruct",
                    shortDescription: "llama \u{B7} 8K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.2-11b-vision-instruct",
                    displayName: "Llama-3.2-11B-Vision-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta/meta-llama-3.1-405b-instruct",
                    displayName: "Meta-Llama-3.1-405B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-4-scout-17b-16e-instruct",
                    displayName: "Llama 4 Scout 17B 16E Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.3-70b-instruct",
                    displayName: "Llama-3.3-70B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta/meta-llama-3.1-70b-instruct",
                    displayName: "Meta-Llama-3.1-70B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta/meta-llama-3.1-8b-instruct",
                    displayName: "Meta-Llama-3.1-8B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.2-90b-vision-instruct",
                    displayName: "Llama-3.2-90B-Vision-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-4-maverick-17b-128e-instruct-fp8",
                    displayName: "Llama 4 Maverick 17B 128E Instruct FP8",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta/meta-llama-3-70b-instruct",
                    displayName: "Meta-Llama-3-70B-Instruct",
                    shortDescription: "llama \u{B7} 8K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-0528",
                    displayName: "DeepSeek-R1-0528",
                    shortDescription: "deepseek-thinking \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3-0324",
                    displayName: "DeepSeek-V3-0324",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1",
                    displayName: "DeepSeek-R1",
                    shortDescription: "deepseek-thinking \u{B7} 65K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "gmicloud",
            displayName: "GMI Cloud",
            shortDescription: "OpenAI-compatible \u{B7} 8 text models",
            baseURLString: "https://api.gmi-serving.com/v1",
            apiKeyLabel: "GMI Cloud API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "claude-opus \u{B7} 409K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 409K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 409K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1-FP8",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5-FP8",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V4-Flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V4-Pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1.04858M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "google",
            displayName: "Google",
            shortDescription: "OpenAI-compatible \u{B7} 18 text models",
            baseURLString: "https://generativelanguage.googleapis.com/v1beta/openai",
            apiKeyLabel: "Google API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "gemini-3.1-flash-lite",
                    displayName: "Gemini 3.1 Flash Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.5-flash",
                    displayName: "Gemini 3.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-31b-it",
                    displayName: "Gemma 4 31B IT",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.0-flash",
                    displayName: "Gemini 2.0 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-E4B-it",
                    displayName: "Gemma 4 E4B IT",
                    shortDescription: "gemma \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.1-pro-preview-customtools",
                    displayName: "Gemini 3.1 Pro Preview Custom Tools",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-flash-lite-latest",
                    displayName: "Gemini Flash-Lite Latest",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-E2B-it",
                    displayName: "Gemma 4 E2B IT",
                    shortDescription: "gemma \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-lite",
                    displayName: "Gemini 2.5 Flash-Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.1-pro-preview",
                    displayName: "Gemini 3.1 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-26b-a4b-it",
                    displayName: "Gemma 4 26B A4B IT",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-pro-preview",
                    displayName: "Gemini 3 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-flash-preview",
                    displayName: "Gemini 3 Flash Preview",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-flash-latest",
                    displayName: "Gemini Flash Latest",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.1-flash-lite-preview",
                    displayName: "Gemini 3.1 Flash Lite Preview",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.0-flash-lite",
                    displayName: "Gemini 2.0 Flash-Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Attachments"
                )
            ]
        ),
        AIScriptProvider(
            id: "groq",
            displayName: "Groq",
            shortDescription: "OpenAI-compatible \u{B7} 11 text models",
            baseURLString: "https://api.groq.com/openai/v1",
            apiKeyLabel: "Groq API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "llama-3.3-70b-versatile",
                    displayName: "Llama 3.3 70B",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "llama-3.1-8b-instant",
                    displayName: "Llama 3.1 8B",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-prompt-guard-2-86m",
                    displayName: "Prompt Guard 2 86M",
                    shortDescription: "llama"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-prompt-guard-2-22m",
                    displayName: "Llama Prompt Guard 2 22M",
                    shortDescription: "llama"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-4-scout-17b-16e-instruct",
                    displayName: "Llama 4 Scout 17B 16E",
                    shortDescription: "llama \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-safeguard-20b",
                    displayName: "Safety GPT OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "GPT OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "groq/compound",
                    displayName: "Compound",
                    shortDescription: "groq \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "groq/compound-mini",
                    displayName: "Compound Mini",
                    shortDescription: "groq \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-32b",
                    displayName: "Qwen3-32B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "helicone",
            displayName: "Helicone",
            shortDescription: "OpenAI-compatible \u{B7} 90 text models",
            baseURLString: "https://ai-gateway.helicone.ai/v1",
            apiKeyLabel: "Helicone API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "chatgpt-4o-latest",
                    displayName: "OpenAI ChatGPT-4o",
                    shortDescription: "gpt \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1-mini-2025-04-14",
                    displayName: "OpenAI GPT-4.1 Mini",
                    shortDescription: "gpt-mini \u{B7} 1.04758M context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.1-terminus",
                    displayName: "DeepSeek V3.1 Terminus",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-3.5-haiku",
                    displayName: "Anthropic: Claude 3.5 Haiku",
                    shortDescription: "claude-haiku \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "llama-3.1-8b-instruct",
                    displayName: "Meta Llama 3.1 8B Instruct",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "o3",
                    displayName: "OpenAI o3",
                    shortDescription: "o \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "llama-prompt-guard-2-86m",
                    displayName: "Meta Llama Prompt Guard 2 86M",
                    shortDescription: "llama"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-30b-a3b-instruct",
                    displayName: "Qwen3 Coder 30B A3B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "hermes-2-pro-llama-3-8b",
                    displayName: "Hermes 2 Pro Llama 3 8B",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3",
                    displayName: "DeepSeek V3",
                    shortDescription: "deepseek \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "grok-code-fast-1",
                    displayName: "xAI Grok Code Fast 1",
                    shortDescription: "grok \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "o1-mini",
                    displayName: "OpenAI: o1-mini",
                    shortDescription: "o-mini \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1-distill-llama-70b",
                    displayName: "DeepSeek R1 Distill Llama 70B",
                    shortDescription: "deepseek-thinking \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-32b",
                    displayName: "Qwen3 32B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4",
                    displayName: "Anthropic: Claude Sonnet 4",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-next-80b-a3b-instruct",
                    displayName: "Qwen3 Next 80B A3B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "llama-4-maverick",
                    displayName: "Meta Llama 4 Maverick 17B 128E",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-nemo",
                    displayName: "Mistral Nemo",
                    shortDescription: "mistral-nemo \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "llama-3.3-70b-versatile",
                    displayName: "Meta Llama 3.3 70B Versatile",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "gemma2-9b-it",
                    displayName: "Google Gemma 2",
                    shortDescription: "gemma \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "Google Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5",
                    displayName: "OpenAI GPT-5",
                    shortDescription: "gpt \u{B7} 400K context"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4-5-20251001",
                    displayName: "Anthropic: Claude 4.5 Haiku (20251001)",
                    shortDescription: "claude-haiku \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "claude-4.5-haiku",
                    displayName: "Anthropic: Claude 4.5 Haiku",
                    shortDescription: "claude-haiku \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-pro",
                    displayName: "OpenAI: GPT-5 Pro",
                    shortDescription: "gpt-pro \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash",
                    displayName: "Google Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o",
                    displayName: "OpenAI GPT-4o",
                    shortDescription: "gpt \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "o4-mini",
                    displayName: "OpenAI o4 Mini",
                    shortDescription: "o-mini \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "llama-3.1-8b-instant",
                    displayName: "Meta Llama 3.1 8B Instant",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "llama-prompt-guard-2-22m",
                    displayName: "Meta Llama Prompt Guard 2 22M",
                    shortDescription: "llama"
                ),
                AIScriptModelPreset(
                    id: "o3-pro",
                    displayName: "OpenAI o3 Pro",
                    shortDescription: "o-pro \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "grok-3-mini",
                    displayName: "xAI Grok 3 Mini",
                    shortDescription: "grok \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1-20250805",
                    displayName: "Anthropic: Claude Opus 4.1 (20250805)",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-tng-r1t2-chimera",
                    displayName: "DeepSeek TNG R1T2 Chimera",
                    shortDescription: "deepseek-thinking \u{B7} 130K context"
                ),
                AIScriptModelPreset(
                    id: "llama-3.3-70b-instruct",
                    displayName: "Meta Llama 3.3 70B Instruct",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "sonar-reasoning-pro",
                    displayName: "Perplexity Sonar Reasoning Pro",
                    shortDescription: "sonar-reasoning \u{B7} 127K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-3",
                    displayName: "xAI Grok 3",
                    shortDescription: "grok \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6",
                    displayName: "Zai GLM-4.6",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "grok-4-1-fast-non-reasoning",
                    displayName: "xAI Grok 4.1 Fast Non-Reasoning",
                    shortDescription: "grok \u{B7} 2M context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder",
                    displayName: "Qwen3 Coder 480B A35B Instruct Turbo",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-chat-latest",
                    displayName: "OpenAI GPT-5 Chat Latest",
                    shortDescription: "gpt-codex \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex",
                    displayName: "OpenAI: GPT-5.1 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context"
                ),
                AIScriptModelPreset(
                    id: "o3-mini",
                    displayName: "OpenAI o3 Mini",
                    shortDescription: "o-mini \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-large-2411",
                    displayName: "Mistral-Large",
                    shortDescription: "mistral-large \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-lite",
                    displayName: "Google Gemini 2.5 Flash Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "llama-guard-4",
                    displayName: "Meta Llama Guard 4 12B",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1",
                    displayName: "Anthropic: Claude Opus 4.1",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-3.7-sonnet",
                    displayName: "Anthropic: Claude 3.7 Sonnet",
                    shortDescription: "claude-sonnet \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex-mini",
                    displayName: "OpenAI: GPT-5.1 Codex Mini",
                    shortDescription: "gpt-codex \u{B7} 400K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-chat-latest",
                    displayName: "OpenAI GPT-5.1 Chat",
                    shortDescription: "gpt-codex \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "claude-3-haiku-20240307",
                    displayName: "Anthropic: Claude 3 Haiku",
                    shortDescription: "claude-haiku \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "grok-4-fast-reasoning",
                    displayName: "xAI: Grok 4 Fast Reasoning",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1-nano",
                    displayName: "OpenAI GPT-4.1 Nano",
                    shortDescription: "gpt-nano \u{B7} 1.04758M context"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-120b",
                    displayName: "OpenAI GPT-OSS 120b",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "sonar",
                    displayName: "Perplexity Sonar",
                    shortDescription: "sonar \u{B7} 127K context"
                ),
                AIScriptModelPreset(
                    id: "qwen2.5-coder-7b-fast",
                    displayName: "Qwen2.5 Coder 7B fast",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "o1",
                    displayName: "OpenAI: o1",
                    shortDescription: "o \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "ernie-4.5-21b-a3b-thinking",
                    displayName: "Baidu Ernie 4.5 21B A3B Thinking",
                    shortDescription: "ernie \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "llama-4-scout",
                    displayName: "Meta Llama 4 Scout 17B 16E",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "sonar-pro",
                    displayName: "Perplexity Sonar Pro",
                    shortDescription: "sonar-pro \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1",
                    displayName: "OpenAI GPT-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-5-20250929",
                    displayName: "Anthropic: Claude Sonnet 4.5 (20250929)",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-reasoner",
                    displayName: "DeepSeek Reasoner",
                    shortDescription: "deepseek-thinking \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "grok-4-1-fast-reasoning",
                    displayName: "xAI Grok 4.1 Fast Reasoning",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-pro-preview",
                    displayName: "Google Gemini 3 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-mini",
                    displayName: "OpenAI GPT-5 Mini",
                    shortDescription: "gpt-mini \u{B7} 400K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1-mini",
                    displayName: "OpenAI GPT-4.1 Mini",
                    shortDescription: "gpt-mini \u{B7} 1.04758M context"
                ),
                AIScriptModelPreset(
                    id: "sonar-reasoning",
                    displayName: "Perplexity Sonar Reasoning",
                    shortDescription: "sonar-reasoning \u{B7} 127K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "sonar-deep-research",
                    displayName: "Perplexity Sonar Deep Research",
                    shortDescription: "sonar-deep-research \u{B7} 127K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-0905",
                    displayName: "Kimi K2 (09/05)",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-nano",
                    displayName: "OpenAI GPT-5 Nano",
                    shortDescription: "gpt-nano \u{B7} 400K context"
                ),
                AIScriptModelPreset(
                    id: "grok-4",
                    displayName: "xAI Grok 4",
                    shortDescription: "grok \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b-thinking",
                    displayName: "Qwen3 235B A22B Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4",
                    displayName: "Anthropic: Claude Opus 4",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-fast-non-reasoning",
                    displayName: "xAI Grok 4 Fast Non-Reasoning",
                    shortDescription: "grok \u{B7} 2M context"
                ),
                AIScriptModelPreset(
                    id: "claude-4.5-opus",
                    displayName: "Anthropic: Claude Opus 4.5",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-235b-a22b-instruct",
                    displayName: "Qwen3 VL 235B A22B Instruct",
                    shortDescription: "qwen \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-0711",
                    displayName: "Kimi K2 (07/11)",
                    shortDescription: "kimi-k2 \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "gemma-3-12b-it",
                    displayName: "Google Gemma 3 12B",
                    shortDescription: "gemma \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o-mini",
                    displayName: "OpenAI GPT-4o-mini",
                    shortDescription: "gpt-mini \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-20b",
                    displayName: "OpenAI GPT-OSS 20b",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-3.5-sonnet-v2",
                    displayName: "Anthropic: Claude 3.5 Sonnet v2",
                    shortDescription: "claude-sonnet \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-30b-a3b",
                    displayName: "Qwen3 30B A3B",
                    shortDescription: "qwen \u{B7} 41K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-codex",
                    displayName: "OpenAI: GPT-5 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 163K context"
                ),
                AIScriptModelPreset(
                    id: "claude-4.5-sonnet",
                    displayName: "Anthropic: Claude Sonnet 4.5",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-small",
                    displayName: "Mistral Small 3.2",
                    shortDescription: "mistral-small \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "llama-3.1-8b-instruct-turbo",
                    displayName: "Meta Llama 3.1 8B Instruct Turbo",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1",
                    displayName: "OpenAI GPT-5.1",
                    shortDescription: "gpt \u{B7} 400K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "hpc-ai",
            displayName: "HPC-AI",
            shortDescription: "OpenAI-compatible \u{B7} 3 text models",
            baseURLString: "https://api.hpc-ai.com/inference/v1",
            apiKeyLabel: "HPC-AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-5.1",
                    displayName: "GLM 5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.5",
                    displayName: "MiniMax M2.5",
                    shortDescription: "minimax-m2.5 \u{B7} 1M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "huggingface",
            displayName: "Hugging Face",
            shortDescription: "OpenAI-compatible \u{B7} 22 text models",
            baseURLString: "https://router.huggingface.co/v1",
            apiKeyLabel: "Hugging Face API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2-Thinking",
                    displayName: "Kimi-K2-Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2-Instruct-0905",
                    displayName: "Kimi-K2-Instruct-0905",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2-Instruct",
                    displayName: "Kimi-K2-Instruct",
                    shortDescription: "kimi-k2 \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.6",
                    displayName: "Kimi-K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.5",
                    displayName: "Kimi-K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-Next",
                    displayName: "Qwen3-Coder-Next",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Next-80B-A3B-Instruct",
                    displayName: "Qwen3-Next-80B-A3B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-397B-A17B",
                    displayName: "Qwen3.5-397B-A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Thinking-2507",
                    displayName: "Qwen3-235B-A22B-Thinking-2507",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-480B-A35B-Instruct",
                    displayName: "Qwen3-Coder-480B-A35B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Next-80B-A3B-Thinking",
                    displayName: "Qwen3-Next-80B-A3B-Thinking",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "XiaomiMiMo/MiMo-V2-Flash",
                    displayName: "MiMo-V2-Flash",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.7-Flash",
                    displayName: "GLM-4.7-Flash",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1-0528",
                    displayName: "DeepSeek-R1-0528",
                    shortDescription: "deepseek-thinking \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V4-Pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.2",
                    displayName: "DeepSeek-V3.2",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.1",
                    displayName: "MiniMax-M2.1",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "iflowcn",
            displayName: "iFlow",
            shortDescription: "OpenAI-compatible \u{B7} 14 text models",
            baseURLString: "https://apis.iflow.cn/v1",
            apiKeyLabel: "iFlow API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "qwen3-coder-plus",
                    displayName: "Qwen3-Coder-Plus",
                    shortDescription: "qwen \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3",
                    displayName: "DeepSeek-V3",
                    shortDescription: "deepseek \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2",
                    displayName: "Kimi-K2",
                    shortDescription: "kimi-k2 \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-32b",
                    displayName: "Qwen3-32B",
                    shortDescription: "qwen \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max-preview",
                    displayName: "Qwen3-Max-Preview",
                    shortDescription: "qwen \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max",
                    displayName: "Qwen3-Max",
                    shortDescription: "qwen \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b",
                    displayName: "Qwen3-235B-A22B",
                    shortDescription: "qwen \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6",
                    displayName: "GLM-4.6",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b-thinking-2507",
                    displayName: "Qwen3-235B-A22B-Thinking",
                    shortDescription: "qwen \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1",
                    displayName: "DeepSeek-R1",
                    shortDescription: "deepseek-thinking \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-plus",
                    displayName: "Qwen3-VL-Plus",
                    shortDescription: "qwen \u{B7} 256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b-instruct",
                    displayName: "Qwen3-235B-A22B-Instruct",
                    shortDescription: "qwen \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-0905",
                    displayName: "Kimi-K2-0905",
                    shortDescription: "kimi-k2 \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.2",
                    displayName: "DeepSeek-V3.2-Exp",
                    shortDescription: "deepseek \u{B7} 128K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "inception",
            displayName: "Inception",
            shortDescription: "OpenAI-compatible \u{B7} 2 text models",
            baseURLString: "https://api.inceptionlabs.ai/v1/",
            apiKeyLabel: "Inception API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "mercury-edit-2",
                    displayName: "Mercury Edit 2",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mercury-2",
                    displayName: "Mercury 2",
                    shortDescription: "mercury \u{B7} 128K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "inceptron",
            displayName: "Inceptron",
            shortDescription: "OpenAI-compatible \u{B7} 4 text models",
            baseURLString: "https://api.inceptron.io/v1",
            apiKeyLabel: "Inceptron API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/llama-3.3-70b-instruct-fp8",
                    displayName: "Llama 3.3 70B Instruct",
                    shortDescription: "llama \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1-FP8",
                    displayName: "GLM 5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5",
                    displayName: "MiniMax M2.5",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "inference",
            displayName: "Inference",
            shortDescription: "OpenAI-compatible \u{B7} 8 text models",
            baseURLString: "https://inference.net/v1",
            apiKeyLabel: "Inference API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "mistral/mistral-nemo-12b-instruct",
                    displayName: "Mistral Nemo 12B Instruct",
                    shortDescription: "mistral-nemo \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3",
                    displayName: "Google Gemma 3",
                    shortDescription: "gemma \u{B7} 125K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "osmosis/osmosis-structure-0.6b",
                    displayName: "Osmosis Structure 0.6B",
                    shortDescription: "osmosis \u{B7} 4K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-2.5-7b-vision-instruct",
                    displayName: "Qwen 2.5 7B Vision Instruct",
                    shortDescription: "qwen \u{B7} 125K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.1-8b-instruct",
                    displayName: "Llama 3.1 8B Instruct",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.2-1b-instruct",
                    displayName: "Llama 3.2 1B Instruct",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.2-11b-vision-instruct",
                    displayName: "Llama 3.2 11B Vision Instruct",
                    shortDescription: "llama \u{B7} 16K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.2-3b-instruct",
                    displayName: "Llama 3.2 3B Instruct",
                    shortDescription: "llama \u{B7} 16K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "io-net",
            displayName: "IO.NET",
            shortDescription: "OpenAI-compatible \u{B7} 17 text models",
            baseURLString: "https://api.intelligence.io.solutions/api/v1",
            apiKeyLabel: "IO.NET API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "meta-llama/Llama-4-Maverick-17B-128E-Instruct-FP8",
                    displayName: "Llama 4 Maverick 17B 128E Instruct",
                    shortDescription: "llama \u{B7} 430K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.3-70B-Instruct",
                    displayName: "Llama 3.3 70B Instruct",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.2-90B-Vision-Instruct",
                    displayName: "Llama 3.2 90B Vision Instruct",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2-Thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2-Instruct-0905",
                    displayName: "Kimi K2 Instruct",
                    shortDescription: "kimi-k2 \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-VL-32B-Instruct",
                    displayName: "Qwen 2.5 VL 32B Instruct",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Next-80B-A3B-Instruct",
                    displayName: "Qwen 3 Next 80B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Thinking-2507",
                    displayName: "Qwen 3 235B Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT-OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "GPT-OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 64K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/Devstral-Small-2505",
                    displayName: "Devstral Small 2505",
                    shortDescription: "devstral \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/Magistral-Small-2506",
                    displayName: "Magistral Small 2506",
                    shortDescription: "magistral-small \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/Mistral-Large-Instruct-2411",
                    displayName: "Mistral Large Instruct 2411",
                    shortDescription: "mistral-large \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/Mistral-Nemo-Instruct-2407",
                    displayName: "Mistral Nemo Instruct 2407",
                    shortDescription: "mistral-nemo \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "Intel/Qwen3-Coder-480B-A35B-Instruct-int4-mixed-ar",
                    displayName: "Qwen 3 Coder 480B",
                    shortDescription: "qwen \u{B7} 106K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.6",
                    displayName: "GLM 4.6",
                    shortDescription: "glm \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1-0528",
                    displayName: "DeepSeek R1",
                    shortDescription: "deepseek-thinking \u{B7} 128K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "jiekou",
            displayName: "Jiekou.AI",
            shortDescription: "OpenAI-compatible \u{B7} 61 text models",
            baseURLString: "https://api.jiekou.ai/openai",
            apiKeyLabel: "Jiekou.AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "o3",
                    displayName: "o3",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "grok-code-fast-1",
                    displayName: "grok-code-fast-1",
                    shortDescription: "grok \u{B7} 256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-pro",
                    displayName: "gpt-5.2-pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "gemini-2.5-pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4-5-20251001",
                    displayName: "claude-haiku-4-5-20251001",
                    shortDescription: "claude-haiku \u{B7} 20K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-pro",
                    displayName: "gpt-5-pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash",
                    displayName: "gemini-2.5-flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "o4-mini",
                    displayName: "o4-mini",
                    shortDescription: "o \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-lite-preview-09-2025",
                    displayName: "gemini-2.5-flash-lite-preview-09-2025",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1-20250805",
                    displayName: "claude-opus-4-1-20250805",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "grok-4-1-fast-non-reasoning",
                    displayName: "grok-4-1-fast-non-reasoning",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-chat-latest",
                    displayName: "gpt-5-chat-latest",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-5-20251101",
                    displayName: "claude-opus-4-5-20251101",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex",
                    displayName: "gpt-5.1-codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex-max",
                    displayName: "gpt-5.1-codex-max",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-20250514",
                    displayName: "claude-opus-4-20250514",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "o3-mini",
                    displayName: "o3-mini",
                    shortDescription: "o \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2",
                    displayName: "gpt-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "grok-4-0709",
                    displayName: "grok-4-0709",
                    shortDescription: "grok \u{B7} 256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-lite",
                    displayName: "gemini-2.5-flash-lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-20250514",
                    displayName: "claude-sonnet-4-20250514",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex-mini",
                    displayName: "gpt-5.1-codex-mini",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-fast-reasoning",
                    displayName: "grok-4-fast-reasoning",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-6",
                    displayName: "claude-opus-4-6",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-5-20250929",
                    displayName: "claude-sonnet-4-5-20250929",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "grok-4-1-fast-reasoning",
                    displayName: "grok-4-1-fast-reasoning",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-pro-preview",
                    displayName: "gemini-3-pro-preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-mini",
                    displayName: "gpt-5-mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-nano",
                    displayName: "gpt-5-nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "grok-4-fast-non-reasoning",
                    displayName: "grok-4-fast-non-reasoning",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-flash-preview",
                    displayName: "gemini-3-flash-preview",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-preview-05-20",
                    displayName: "gemini-2.5-flash-preview-05-20",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-lite-preview-06-17",
                    displayName: "gemini-2.5-flash-lite-preview-06-17",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro-preview-06-05",
                    displayName: "gemini-2.5-pro-preview-06-05",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-codex",
                    displayName: "gpt-5-codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-codex",
                    displayName: "gpt-5.2-codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1",
                    displayName: "gpt-5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-instruct",
                    displayName: "Kimi K2 Instruct",
                    shortDescription: "kimi-k2 \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-0905",
                    displayName: "Kimi K2 0905",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "minimaxai/minimax-m1-80k",
                    displayName: "MiniMax M1",
                    shortDescription: "minimax \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-vl-424b-a47b",
                    displayName: "ERNIE 4.5 VL 424B A47B",
                    shortDescription: "ernie \u{B7} 123K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-300b-a47b-paddle",
                    displayName: "ERNIE 4.5 300B A47B",
                    shortDescription: "ernie \u{B7} 123K context"
                ),
                AIScriptModelPreset(
                    id: "xiaomimimo/mimo-v2-flash",
                    displayName: "XiaomiMiMo/MiMo-V2-Flash",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.5v",
                    displayName: "GLM 4.5V",
                    shortDescription: "glmv \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.5",
                    displayName: "GLM-4.5",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7-flash",
                    displayName: "GLM-4.7-Flash",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b-instruct-2507",
                    displayName: "Qwen3 235B A22B Instruct 2507",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-next-80b-a3b-instruct",
                    displayName: "Qwen3 Next 80B A3B Instruct",
                    shortDescription: "qwen \u{B7} 65K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-next-80b-a3b-thinking",
                    displayName: "Qwen3 Next 80B A3B Thinking",
                    shortDescription: "qwen \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b-thinking-2507",
                    displayName: "Qwen3 235B A22b Thinking 2507",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-32b-fp8",
                    displayName: "Qwen3 32B",
                    shortDescription: "qwen \u{B7} 40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-30b-a3b-fp8",
                    displayName: "Qwen3 30B A3B",
                    shortDescription: "qwen \u{B7} 40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-next",
                    displayName: "qwen/qwen3-coder-next",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-480b-a35b-instruct",
                    displayName: "Qwen3 Coder 480B A35B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b-fp8",
                    displayName: "Qwen3 235B A22B",
                    shortDescription: "qwen \u{B7} 40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-0528",
                    displayName: "DeepSeek R1 0528",
                    shortDescription: "deepseek-thinking \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3-0324",
                    displayName: "DeepSeek V3 0324",
                    shortDescription: "deepseek \u{B7} 163K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.1",
                    displayName: "Minimax M2.1",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "kilo",
            displayName: "Kilo Gateway",
            shortDescription: "OpenAI-compatible \u{B7} 339 text models",
            baseURLString: "https://api.kilo.ai/api/gateway",
            apiKeyLabel: "Kilo Gateway API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "inclusionai/ling-2.6-1t",
                    displayName: "inclusionAI: Ling-2.6-1T",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "inclusionai/ring-2.6-1t",
                    displayName: "inclusionAI: Ring-2.6-1T",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "inclusionai/ling-2.6-flash",
                    displayName: "inclusionAI: Ling-2.6 Flash",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "ibm-granite/granite-4.0-h-micro",
                    displayName: "IBM: Granite 4.0 Micro",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "ibm-granite/granite-4.1-8b",
                    displayName: "IBM: Granite 4.1 8B",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.1-8b-instruct",
                    displayName: "Meta: Llama 3.1 8B Instruct",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3-70b-instruct",
                    displayName: "Meta: Llama 3 70B Instruct",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.1-70b-instruct",
                    displayName: "Meta: Llama 3.1 70B Instruct",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.2-1b-instruct",
                    displayName: "Meta: Llama 3.2 1B Instruct",
                    shortDescription: "60K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-4-maverick",
                    displayName: "Meta: Llama 4 Maverick",
                    shortDescription: "1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.2-11b-vision-instruct",
                    displayName: "Meta: Llama 3.2 11B Vision Instruct",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.3-70b-instruct",
                    displayName: "Meta: Llama 3.3 70B Instruct",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-guard-3-8b",
                    displayName: "Llama Guard 3 8B",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-guard-4-12b",
                    displayName: "Meta: Llama Guard 4 12B",
                    shortDescription: "163K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3-8b-instruct",
                    displayName: "Meta: Llama 3 8B Instruct",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-4-scout",
                    displayName: "Meta: Llama 4 Scout",
                    shortDescription: "327K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.2-3b-instruct",
                    displayName: "Meta: Llama 3.2 3B Instruct",
                    shortDescription: "80K context"
                ),
                AIScriptModelPreset(
                    id: "~anthropic/claude-haiku-latest",
                    displayName: "Anthropic: Claude Haiku Latest",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "~anthropic/claude-sonnet-latest",
                    displayName: "Anthropic: Claude Sonnet Latest",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "~anthropic/claude-opus-latest",
                    displayName: "Anthropic: Claude Opus Latest",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "kilo-auto/balanced",
                    displayName: "Kilo Auto Balanced",
                    shortDescription: "204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kilo-auto/small",
                    displayName: "Kilo Auto Small",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "kilo-auto/free",
                    displayName: "Kilo Auto Free",
                    shortDescription: "204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kilo-auto/frontier",
                    displayName: "Kilo Auto Frontier",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2",
                    displayName: "MoonshotAI: Kimi K2 0711",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-thinking",
                    displayName: "MoonshotAI: Kimi K2 Thinking",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.5",
                    displayName: "MoonshotAI: Kimi K2.5",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.6",
                    displayName: "MoonshotAI: Kimi K2.6",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-0905",
                    displayName: "MoonshotAI: Kimi K2 0905",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-300b-a47b",
                    displayName: "Baidu: ERNIE 4.5 300B A47B",
                    shortDescription: "123K context"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-vl-28b-a3b",
                    displayName: "Baidu: ERNIE 4.5 VL 28B A3B",
                    shortDescription: "30K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-vl-424b-a47b",
                    displayName: "Baidu: ERNIE 4.5 VL 424B A47B",
                    shortDescription: "123K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-21b-a3b-thinking",
                    displayName: "Baidu: ERNIE 4.5 21B A3B Thinking",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "baidu/cobuddy:free",
                    displayName: "Baidu: CoBuddy (free)",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-21b-a3b",
                    displayName: "Baidu: ERNIE 4.5 21B A3B",
                    shortDescription: "120K context"
                ),
                AIScriptModelPreset(
                    id: "baidu/qianfan-ocr-fast",
                    displayName: "Baidu: Qianfan-OCR-Fast",
                    shortDescription: "65K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "perceptron/perceptron-mk1",
                    displayName: "Perceptron: Perceptron Mk1",
                    shortDescription: "32K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "alfredpros/codellama-7b-instruct-solidity",
                    displayName: "AlfredPros: CodeLLaMa 7B Instruct Solidity",
                    shortDescription: "4K context"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-flash-lite",
                    displayName: "Google: Gemini 3.1 Flash Lite",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3n-e4b-it",
                    displayName: "Google: Gemma 3n 4B",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro",
                    displayName: "Google: Gemini 2.5 Pro",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash",
                    displayName: "Google: Gemini 2.5 Flash",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.5-flash",
                    displayName: "Google: Gemini 3.5 Flash",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.0-flash-lite-001",
                    displayName: "Google: Gemini 2.0 Flash Lite",
                    shortDescription: "1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash-lite-preview-09-2025",
                    displayName: "Google: Gemini 2.5 Flash Lite Preview 09-2025",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.0-flash-001",
                    displayName: "Google: Gemini 2.0 Flash",
                    shortDescription: "1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31b-it",
                    displayName: "Google: Gemma 4 31B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/lyria-3-clip-preview",
                    displayName: "Google: Lyria 3 Clip Preview",
                    shortDescription: "1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro-preview-customtools",
                    displayName: "Google: Gemini 3.1 Pro Preview Custom Tools",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash-lite",
                    displayName: "Google: Gemini 2.5 Flash Lite",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro-preview-05-06",
                    displayName: "Google: Gemini 2.5 Pro Preview 05-06",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro-preview",
                    displayName: "Google: Gemini 3.1 Pro Preview",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-26b-a4b-it",
                    displayName: "Google: Gemma 4 26B A4B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro-preview",
                    displayName: "Google: Gemini 2.5 Pro Preview 06-05",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-flash-preview",
                    displayName: "Google: Gemini 3 Flash Preview",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3-12b-it",
                    displayName: "Google: Gemma 3 12B",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3-4b-it",
                    displayName: "Google: Gemma 3 4B",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3-27b-it",
                    displayName: "Google: Gemma 3 27B",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/lyria-3-pro-preview",
                    displayName: "Google: Lyria 3 Pro Preview",
                    shortDescription: "1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-2-27b-it",
                    displayName: "Google: Gemma 2 27B",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-flash-lite-preview",
                    displayName: "Google: Gemini 3.1 Flash Lite Preview",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "liquid/lfm-2-24b-a2b",
                    displayName: "LiquidAI: LFM2-24B-A2B",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.20",
                    displayName: "xAI: Grok 4.20",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.3",
                    displayName: "xAI: Grok 4.3",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.20-multi-agent",
                    displayName: "xAI: Grok 4.20 Multi-Agent",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-build-0.1",
                    displayName: "xAI: Grok Build 0.1",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "~google/gemini-pro-latest",
                    displayName: "Google: Gemini Pro Latest",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "~google/gemini-flash-latest",
                    displayName: "Google: Gemini Flash Latest",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-4-mini-instruct",
                    displayName: "Microsoft: Phi 4 Mini Instruct",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-4",
                    displayName: "Microsoft: Phi 4",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "microsoft/wizardlm-2-8x22b",
                    displayName: "WizardLM-2 8x22B",
                    shortDescription: "65K context"
                ),
                AIScriptModelPreset(
                    id: "poolside/laguna-xs.2:free",
                    displayName: "Poolside: Laguna XS.2 (free)",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "poolside/laguna-m.1:free",
                    displayName: "Poolside: Laguna M.1 (free)",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "writer/palmyra-x5",
                    displayName: "Writer: Palmyra X5",
                    shortDescription: "1.04M context"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.7",
                    displayName: "Z.ai: GLM 4.7",
                    shortDescription: "202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.5v",
                    displayName: "Z.ai: GLM 4.5V",
                    shortDescription: "65K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.5",
                    displayName: "Z.ai: GLM 4.5",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5.1",
                    displayName: "Z.ai: GLM 5.1",
                    shortDescription: "202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.6",
                    displayName: "Z.ai: GLM 4.6",
                    shortDescription: "204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4-32b",
                    displayName: "Z.ai: GLM 4 32B",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.6v",
                    displayName: "Z.ai: GLM 4.6V",
                    shortDescription: "131K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5v-turbo",
                    displayName: "Z.ai: GLM 5V Turbo",
                    shortDescription: "202K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.5-air",
                    displayName: "Z.ai: GLM 4.5 Air",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.7-flash",
                    displayName: "Z.ai: GLM 4.7 Flash",
                    shortDescription: "202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5",
                    displayName: "Z.ai: GLM 5",
                    shortDescription: "202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5-turbo",
                    displayName: "Z.ai: GLM 5 Turbo",
                    shortDescription: "202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini-2024-07-18",
                    displayName: "OpenAI: GPT-4o-mini (2024-07-18)",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-safeguard-20b",
                    displayName: "OpenAI: gpt-oss-safeguard-20b",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo-instruct",
                    displayName: "OpenAI: GPT-3.5 Turbo Instruct",
                    shortDescription: "4K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-chat",
                    displayName: "OpenAI: GPT-5.2 Chat",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o3",
                    displayName: "OpenAI: o3",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini-high",
                    displayName: "OpenAI: o4 Mini High",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-audio",
                    displayName: "OpenAI: GPT Audio",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-pro",
                    displayName: "OpenAI: GPT-5.2 Pro",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini-search-preview",
                    displayName: "OpenAI: GPT-4o-mini Search Preview",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5",
                    displayName: "OpenAI: GPT-5",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-chat",
                    displayName: "OpenAI: GPT-5 Chat",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo",
                    displayName: "OpenAI: GPT-3.5 Turbo",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-pro",
                    displayName: "OpenAI: GPT-5 Pro",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o",
                    displayName: "OpenAI: GPT-4o",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4",
                    displayName: "OpenAI: GPT-4",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini",
                    displayName: "OpenAI: o4 Mini",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo-16k",
                    displayName: "OpenAI: GPT-3.5 Turbo 16k",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-pro",
                    displayName: "OpenAI: o3 Pro",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-chat",
                    displayName: "OpenAI: GPT-5.1 Chat",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-2024-05-13",
                    displayName: "OpenAI: GPT-4o (2024-05-13)",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4-0314",
                    displayName: "OpenAI: GPT-4 (older v0314)",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-nano",
                    displayName: "OpenAI: GPT-5.4 Nano",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-chat",
                    displayName: "OpenAI: GPT-5.3 Chat",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo-0613",
                    displayName: "OpenAI: GPT-3.5 Turbo (older v0613)",
                    shortDescription: "4K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex",
                    displayName: "OpenAI: GPT-5.1-Codex",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-max",
                    displayName: "OpenAI: GPT-5.1-Codex-Max",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-2024-08-06",
                    displayName: "OpenAI: GPT-4o (2024-08-06)",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-mini",
                    displayName: "OpenAI: o3 Mini",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2",
                    displayName: "OpenAI: GPT-5.2",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-codex",
                    displayName: "OpenAI: GPT-5.3-Codex",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-audio-mini",
                    displayName: "OpenAI: GPT Audio Mini",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-mini",
                    displayName: "OpenAI: GPT-5.1-Codex-Mini",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini-deep-research",
                    displayName: "OpenAI: o4 Mini Deep Research",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-nano",
                    displayName: "OpenAI: GPT-4.1 Nano",
                    shortDescription: "1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "OpenAI: gpt-oss-120b",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-2024-11-20",
                    displayName: "OpenAI: GPT-4o (2024-11-20)",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o1",
                    displayName: "OpenAI: o1",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o1-pro",
                    displayName: "OpenAI: o1-pro",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-chat-latest",
                    displayName: "OpenAI: GPT Chat Latest",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4",
                    displayName: "OpenAI: GPT-5.4",
                    shortDescription: "1.05M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-mini",
                    displayName: "OpenAI: GPT-5.4 Mini",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1",
                    displayName: "OpenAI: GPT-4.1",
                    shortDescription: "1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-audio-preview",
                    displayName: "OpenAI: GPT-4o Audio",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-deep-research",
                    displayName: "OpenAI: o3 Deep Research",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4-turbo-preview",
                    displayName: "OpenAI: GPT-4 Turbo Preview",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-mini",
                    displayName: "OpenAI: GPT-5 Mini",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-mini",
                    displayName: "OpenAI: GPT-4.1 Mini",
                    shortDescription: "1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4-turbo",
                    displayName: "OpenAI: GPT-4 Turbo",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-nano",
                    displayName: "OpenAI: GPT-5 Nano",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-pro",
                    displayName: "OpenAI: GPT-5.4 Pro",
                    shortDescription: "1.05M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-mini-high",
                    displayName: "OpenAI: o3 Mini High",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-search-preview",
                    displayName: "OpenAI: GPT-4o Search Preview",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5-pro",
                    displayName: "OpenAI: GPT-5.5 Pro",
                    shortDescription: "1.05M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini",
                    displayName: "OpenAI: GPT-4o-mini",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "OpenAI: gpt-oss-20b",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4-1106-preview",
                    displayName: "OpenAI: GPT-4 Turbo (older v1106)",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-codex",
                    displayName: "OpenAI: GPT-5 Codex",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-codex",
                    displayName: "OpenAI: GPT-5.2-Codex",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1",
                    displayName: "OpenAI: GPT-5.1",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5",
                    displayName: "OpenAI: GPT-5.5",
                    shortDescription: "1.05M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "thedrummer/cydonia-24b-v4.1",
                    displayName: "TheDrummer: Cydonia 24B V4.1",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "thedrummer/skyfall-36b-v2",
                    displayName: "TheDrummer: Skyfall 36B V2",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "thedrummer/unslopnemo-12b",
                    displayName: "TheDrummer: UnslopNemo 12B",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "thedrummer/rocinante-12b",
                    displayName: "TheDrummer: Rocinante 12B",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "bytedance/ui-tars-1.5-7b",
                    displayName: "ByteDance: UI-TARS 7B",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "rekaai/reka-flash-3",
                    displayName: "Reka Flash 3",
                    shortDescription: "65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "rekaai/reka-edge",
                    displayName: "Reka Edge",
                    shortDescription: "16K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-large-2407",
                    displayName: "Mistral Large 2407",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-small-3.2-24b-instruct",
                    displayName: "Mistral: Mistral Small 3.2 24B",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-nemo",
                    displayName: "Mistral: Mistral Nemo",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-medium-3-5",
                    displayName: "Mistral: Mistral Medium 3.5",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/ministral-8b-2512",
                    displayName: "Mistral: Ministral 3 8B 2512",
                    shortDescription: "262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/devstral-small",
                    displayName: "Mistral: Devstral Small 1.1",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-small-3.1-24b-instruct",
                    displayName: "Mistral: Mistral Small 3.1 24B",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-saba",
                    displayName: "Mistral: Saba",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-large",
                    displayName: "Mistral Large",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-medium-3.1",
                    displayName: "Mistral: Mistral Medium 3.1",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/pixtral-large-2411",
                    displayName: "Mistral: Pixtral Large 2411",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/devstral-medium",
                    displayName: "Mistral: Devstral Medium",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-small-24b-instruct-2501",
                    displayName: "Mistral: Mistral Small 3",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/ministral-3b-2512",
                    displayName: "Mistral: Ministral 3 3B 2512",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-small-2603",
                    displayName: "Mistral: Mistral Small 4",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-large-2411",
                    displayName: "Mistral Large 2411",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-7b-instruct-v0.1",
                    displayName: "Mistral: Mistral 7B Instruct v0.1",
                    shortDescription: "2K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/ministral-14b-2512",
                    displayName: "Mistral: Ministral 3 14B 2512",
                    shortDescription: "262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/devstral-2512",
                    displayName: "Mistral: Devstral 2 2512",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mixtral-8x22b-instruct",
                    displayName: "Mistral: Mixtral 8x22B Instruct",
                    shortDescription: "65K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-medium-3",
                    displayName: "Mistral: Mistral Medium 3",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/voxtral-small-24b-2507",
                    displayName: "Mistral: Voxtral Small 24B 2507",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-large-2512",
                    displayName: "Mistral: Mistral Large 3 2512",
                    shortDescription: "262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/codestral-2508",
                    displayName: "Mistral: Codestral 2508",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "morph/morph-v3-fast",
                    displayName: "Morph: Morph V3 Fast",
                    shortDescription: "81K context"
                ),
                AIScriptModelPreset(
                    id: "morph/morph-v3-large",
                    displayName: "Morph: Morph V3 Large",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "bytedance-seed/seed-1.6-flash",
                    displayName: "ByteDance Seed: Seed 1.6 Flash",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "bytedance-seed/seed-1.6",
                    displayName: "ByteDance Seed: Seed 1.6",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "bytedance-seed/seed-2.0-mini",
                    displayName: "ByteDance Seed: Seed-2.0-Mini",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "bytedance-seed/seed-2.0-lite",
                    displayName: "ByteDance Seed: Seed-2.0-Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthracite-org/magnum-v4-72b",
                    displayName: "Magnum v4 72B",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free",
                    displayName: "NVIDIA: Nemotron 3 Nano Omni (free)",
                    shortDescription: "nemotron \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-nano-30b-a3b",
                    displayName: "NVIDIA: Nemotron 3 Nano 30B A3B",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/llama-3.3-nemotron-super-49b-v1.5",
                    displayName: "NVIDIA: Llama 3.3 Nemotron Super 49B V1.5",
                    shortDescription: "nemotron \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-nano-9b-v2",
                    displayName: "NVIDIA: Nemotron Nano 9B V2",
                    shortDescription: "nemotron \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-super-120b-a12b:free",
                    displayName: "NVIDIA: Nemotron 3 Super (free)",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-super-120b-a12b",
                    displayName: "NVIDIA: Nemotron 3 Super",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2.5",
                    displayName: "Xiaomi: MiMo-V2.5",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-omni",
                    displayName: "Xiaomi: MiMo-V2-Omni",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-flash",
                    displayName: "Xiaomi: MiMo-V2-Flash",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-pro",
                    displayName: "Xiaomi: MiMo-V2-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2.5-pro",
                    displayName: "Xiaomi: MiMo V2.5 Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "inception/mercury-2",
                    displayName: "Inception: Mercury 2",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-3.5-haiku",
                    displayName: "Anthropic: Claude 3.5 Haiku",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.5",
                    displayName: "Anthropic: Claude Sonnet 4.5",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4",
                    displayName: "Anthropic: Claude Sonnet 4",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6-fast",
                    displayName: "Anthropic: Claude Opus 4.6 (Fast)",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-haiku-4.5",
                    displayName: "Anthropic: Claude Haiku 4.5",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.7-fast",
                    displayName: "Anthropic: Claude Opus 4.7 (Fast)",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.7",
                    displayName: "Anthropic: Claude Opus 4.7",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.1",
                    displayName: "Anthropic: Claude Opus 4.1",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.5",
                    displayName: "Anthropic: Claude Opus 4.5",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.6",
                    displayName: "Anthropic: Claude Sonnet 4.6",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-3-haiku",
                    displayName: "Anthropic: Claude 3 Haiku",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4",
                    displayName: "Anthropic: Claude Opus 4",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6",
                    displayName: "Anthropic: Claude Opus 4.6",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "tencent/hunyuan-a13b-instruct",
                    displayName: "Tencent: Hunyuan A13B Instruct",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "tencent/hy3-preview",
                    displayName: "Tencent: Hy3 Preview",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepcogito/cogito-v2.1-671b",
                    displayName: "Deep Cogito: Cogito v2.1 671B",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "cohere/command-a",
                    displayName: "Cohere: Command A",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "cohere/command-r-08-2024",
                    displayName: "Cohere: Command R (08-2024)",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "cohere/command-r7b-12-2024",
                    displayName: "Cohere: Command R7B (12-2024)",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "cohere/command-r-plus-08-2024",
                    displayName: "Cohere: Command R+ (08-2024)",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "gryphe/mythomax-l2-13b",
                    displayName: "MythoMax 13B",
                    shortDescription: "4K context"
                ),
                AIScriptModelPreset(
                    id: "stepfun/step-3.5-flash",
                    displayName: "StepFun: Step 3.5 Flash",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "prime-intellect/intellect-3",
                    displayName: "Prime Intellect: INTELLECT-3",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nex-agi/deepseek-v3.1-nex-n1",
                    displayName: "Nex AGI: DeepSeek V3.1 Nex N1",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "undi95/remm-slerp-l2-13b",
                    displayName: "ReMM SLERP 13B",
                    shortDescription: "6K context"
                ),
                AIScriptModelPreset(
                    id: "~openai/gpt-mini-latest",
                    displayName: "OpenAI: GPT Mini Latest",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "~openai/gpt-latest",
                    displayName: "OpenAI: GPT Latest",
                    shortDescription: "1.05M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "~moonshotai/kimi-latest",
                    displayName: "MoonshotAI: Kimi Latest",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "relace/relace-search",
                    displayName: "Relace: Relace Search",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "relace/relace-apply-3",
                    displayName: "Relace: Relace Apply 3",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "ai21/jamba-large-1.7",
                    displayName: "AI21: Jamba Large 1.7",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "arcee-ai/coder-large",
                    displayName: "Arcee AI: Coder Large",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "arcee-ai/virtuoso-large",
                    displayName: "Arcee AI: Virtuoso Large",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "arcee-ai/spotlight",
                    displayName: "Arcee AI: Spotlight",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "arcee-ai/trinity-large-thinking",
                    displayName: "Arcee AI: Trinity Large Thinking",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "arcee-ai/maestro-reasoning",
                    displayName: "Arcee AI: Maestro Reasoning",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "arcee-ai/trinity-mini",
                    displayName: "Arcee AI: Trinity Mini",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mancer/weaver",
                    displayName: "Mancer: Weaver (alpha)",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "perplexity/sonar-reasoning-pro",
                    displayName: "Perplexity: Sonar Reasoning Pro",
                    shortDescription: "128K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "perplexity/sonar",
                    displayName: "Perplexity: Sonar",
                    shortDescription: "127K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "perplexity/sonar-pro",
                    displayName: "Perplexity: Sonar Pro",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "perplexity/sonar-pro-search",
                    displayName: "Perplexity: Sonar Pro Search",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "perplexity/sonar-deep-research",
                    displayName: "Perplexity: Sonar Deep Research",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "switchpoint/router",
                    displayName: "Switchpoint Router",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openrouter/bodybuilder",
                    displayName: "Body Builder (beta)",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "openrouter/free",
                    displayName: "Free Models Router",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openrouter/owl-alpha",
                    displayName: "Owl Alpha",
                    shortDescription: "1.04876M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openrouter/pareto-code",
                    displayName: "Pareto Code Router",
                    shortDescription: "200K context"
                ),
                AIScriptModelPreset(
                    id: "openrouter/auto",
                    displayName: "Auto Router",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-plus-20260420",
                    displayName: "Qwen: Qwen3.5 Plus 2026-04-20",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-235b-a22b-thinking",
                    displayName: "Qwen: Qwen3 VL 235B A22B Thinking",
                    shortDescription: "131K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-30b-a3b-thinking",
                    displayName: "Qwen: Qwen3 VL 30B A3B Thinking",
                    shortDescription: "131K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-plus",
                    displayName: "Qwen: Qwen3 Coder Plus",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-plus",
                    displayName: "Qwen: Qwen-Plus",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-30b-a3b-instruct",
                    displayName: "Qwen: Qwen3 Coder 30B A3B Instruct",
                    shortDescription: "160K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-32b",
                    displayName: "Qwen: Qwen3 32B",
                    shortDescription: "40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-next-80b-a3b-instruct",
                    displayName: "Qwen: Qwen3 Next 80B A3B Instruct",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-8b-instruct",
                    displayName: "Qwen: Qwen3 VL 8B Instruct",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-35b-a3b",
                    displayName: "Qwen: Qwen3.6 35B A3B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.7-max",
                    displayName: "Qwen: Qwen3.7 Max",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-max",
                    displayName: "Qwen: Qwen3 Max",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-8b",
                    displayName: "Qwen: Qwen3 8B",
                    shortDescription: "40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-plus-2025-07-28",
                    displayName: "Qwen: Qwen Plus 0728",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-flash-02-23",
                    displayName: "Qwen: Qwen3.5-Flash",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-30b-a3b-instruct-2507",
                    displayName: "Qwen: Qwen3 30B A3B Instruct 2507",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-2.5-coder-32b-instruct",
                    displayName: "Qwen2.5 Coder 32B Instruct",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-next-80b-a3b-thinking",
                    displayName: "Qwen: Qwen3 Next 80B A3B Thinking",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b-thinking-2507",
                    displayName: "Qwen: Qwen3 235B A22B Thinking 2507",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-32b-instruct",
                    displayName: "Qwen: Qwen3 VL 32B Instruct",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder",
                    displayName: "Qwen: Qwen3 Coder 480B A35B",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-flash",
                    displayName: "Qwen: Qwen3.6 Flash",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-plus-02-15",
                    displayName: "Qwen: Qwen3.5 Plus 2026-02-15",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-2.5-7b-instruct",
                    displayName: "Qwen: Qwen2.5 7B Instruct",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-8b-thinking",
                    displayName: "Qwen: Qwen3 VL 8B Thinking",
                    shortDescription: "131K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-max-thinking",
                    displayName: "Qwen: Qwen3 Max Thinking",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-30b-a3b-thinking-2507",
                    displayName: "Qwen: Qwen3 30B A3B Thinking 2507",
                    shortDescription: "32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen2.5-vl-72b-instruct",
                    displayName: "Qwen: Qwen2.5 VL 72B Instruct",
                    shortDescription: "32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-27b",
                    displayName: "Qwen: Qwen3.5-27B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b",
                    displayName: "Qwen: Qwen3 235B A22B",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-2.5-72b-instruct",
                    displayName: "Qwen2.5 72B Instruct",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-plus-2025-07-28:thinking",
                    displayName: "Qwen: Qwen Plus 0728 (thinking)",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-next",
                    displayName: "Qwen: Qwen3 Coder Next",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-27b",
                    displayName: "Qwen: Qwen3.6 27B",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-35b-a3b",
                    displayName: "Qwen: Qwen3.5-35B-A3B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-9b",
                    displayName: "Qwen: Qwen3.5-9B",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-397b-a17b",
                    displayName: "Qwen: Qwen3.5 397B A17B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-30b-a3b-instruct",
                    displayName: "Qwen: Qwen3 VL 30B A3B Instruct",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b-2507",
                    displayName: "Qwen: Qwen3 235B A22B Instruct 2507",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-flash",
                    displayName: "Qwen: Qwen3 Coder Flash",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-14b",
                    displayName: "Qwen: Qwen3 14B",
                    shortDescription: "40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-235b-a22b-instruct",
                    displayName: "Qwen: Qwen3 VL 235B A22B Instruct",
                    shortDescription: "262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-30b-a3b",
                    displayName: "Qwen: Qwen3 30B A3B",
                    shortDescription: "40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-max-preview",
                    displayName: "Qwen: Qwen3.6 Max Preview",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-122b-a10b",
                    displayName: "Qwen: Qwen3.5-122B-A10B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-plus",
                    displayName: "Qwen: Qwen3.6 Plus",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-lite-v1",
                    displayName: "Amazon: Nova Lite 1.0",
                    shortDescription: "300K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-premier-v1",
                    displayName: "Amazon: Nova Premier 1.0",
                    shortDescription: "1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-pro-v1",
                    displayName: "Amazon: Nova Pro 1.0",
                    shortDescription: "300K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-micro-v1",
                    displayName: "Amazon: Nova Micro 1.0",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-2-lite-v1",
                    displayName: "Amazon: Nova 2 Lite",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-rp-llama-3.1-8b",
                    displayName: "AionLabs: Aion-RP 1.0 (8B)",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-1.0-mini",
                    displayName: "AionLabs: Aion-1.0-Mini",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-2.0",
                    displayName: "AionLabs: Aion-2.0",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-1.0",
                    displayName: "AionLabs: Aion-1.0",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "inflection/inflection-3-pi",
                    displayName: "Inflection: Inflection 3 Pi",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "inflection/inflection-3-productivity",
                    displayName: "Inflection: Inflection 3 Productivity",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "sao10k/l3.1-euryale-70b",
                    displayName: "Sao10K: Llama 3.1 Euryale 70B v2.2",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "sao10k/l3.3-euryale-70b",
                    displayName: "Sao10K: Llama 3.3 Euryale 70B",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "sao10k/l3-lunaris-8b",
                    displayName: "Sao10K: Llama 3 8B Lunaris",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "sao10k/l3-euryale-70b",
                    displayName: "Sao10k: Llama 3 Euryale 70B v2.1",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "sao10k/l3.1-70b-hanami-x1",
                    displayName: "Sao10K: Llama 3.1 70B Hanami x1",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "upstage/solar-pro-3",
                    displayName: "Upstage: Solar Pro 3",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "allenai/olmo-3-32b-think",
                    displayName: "AllenAI: Olmo 3 32B Think",
                    shortDescription: "65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "essentialai/rnj-1-instruct",
                    displayName: "EssentialAI: Rnj 1 Instruct",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-0528",
                    displayName: "DeepSeek: R1 0528",
                    shortDescription: "163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-flash",
                    displayName: "DeepSeek: DeepSeek V4 Flash",
                    shortDescription: "1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.1-terminus",
                    displayName: "DeepSeek: DeepSeek V3.1 Terminus",
                    shortDescription: "163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-distill-llama-70b",
                    displayName: "DeepSeek: R1 Distill Llama 70B",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-pro",
                    displayName: "DeepSeek: DeepSeek V4 Pro",
                    shortDescription: "1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1",
                    displayName: "DeepSeek: R1",
                    shortDescription: "64K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2-speciale",
                    displayName: "DeepSeek: DeepSeek V3.2 Speciale",
                    shortDescription: "163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2-exp",
                    displayName: "DeepSeek: DeepSeek V3.2 Exp",
                    shortDescription: "163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-chat-v3-0324",
                    displayName: "DeepSeek: DeepSeek V3 0324",
                    shortDescription: "163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-distill-qwen-32b",
                    displayName: "DeepSeek: R1 Distill Qwen 32B",
                    shortDescription: "32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-chat",
                    displayName: "DeepSeek: DeepSeek V3",
                    shortDescription: "163K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2",
                    displayName: "DeepSeek: DeepSeek V3.2",
                    shortDescription: "163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-chat-v3.1",
                    displayName: "DeepSeek: DeepSeek V3.1",
                    shortDescription: "32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.5",
                    displayName: "MiniMax: MiniMax M2.5",
                    shortDescription: "196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.1",
                    displayName: "MiniMax: MiniMax M2.1",
                    shortDescription: "196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-01",
                    displayName: "MiniMax: MiniMax-01",
                    shortDescription: "1.00019M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2",
                    displayName: "MiniMax: MiniMax M2",
                    shortDescription: "196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2-her",
                    displayName: "MiniMax: MiniMax M2-her",
                    shortDescription: "65K context"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.7",
                    displayName: "MiniMax: MiniMax M2.7",
                    shortDescription: "minimax-m2.7 \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m1",
                    displayName: "MiniMax: MiniMax M1",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "stealth/claude-opus-4.7",
                    displayName: "Stealth: Claude Opus 4.7 (20% off)",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "stealth/claude-sonnet-4.6",
                    displayName: "Stealth: Claude Sonnet 4.6 (20% off)",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "stealth/claude-opus-4.6",
                    displayName: "Stealth: Claude Opus 4.6 (20% off)",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "kwaipilot/kat-coder-pro-v2",
                    displayName: "Kwaipilot: KAT-Coder-Pro V2",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "nousresearch/hermes-2-pro-llama-3-8b",
                    displayName: "NousResearch: Hermes 2 Pro - Llama-3 8B",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "nousresearch/hermes-4-405b",
                    displayName: "Nous: Hermes 4 405B",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nousresearch/hermes-3-llama-3.1-70b",
                    displayName: "Nous: Hermes 3 70B Instruct",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "nousresearch/hermes-3-llama-3.1-405b",
                    displayName: "Nous: Hermes 3 405B Instruct",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "nousresearch/hermes-4-70b",
                    displayName: "Nous: Hermes 4 70B",
                    shortDescription: "131K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "kuae-cloud-coding-plan",
            displayName: "KUAE Cloud Coding Plan",
            shortDescription: "OpenAI-compatible \u{B7} 1 text models",
            baseURLString: "https://coding-plan-endpoint.kuaecloud.net/v1",
            apiKeyLabel: "KUAE Cloud Coding Plan API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "GLM-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "lilac",
            displayName: "Lilac",
            shortDescription: "OpenAI-compatible \u{B7} 4 text models",
            baseURLString: "https://api.getlilac.com/v1",
            apiKeyLabel: "Lilac API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimaxai/minimax-m2.7",
                    displayName: "MiniMax M2.7",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31b-it",
                    displayName: "Gemma 4 31B IT",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-5.1",
                    displayName: "GLM 5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "llama",
            displayName: "Llama",
            shortDescription: "OpenAI-compatible \u{B7} 7 text models",
            baseURLString: "https://api.llama.com/compat/v1/",
            apiKeyLabel: "Llama API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "llama-4-scout-17b-16e-instruct-fp8",
                    displayName: "Llama-4-Scout-17B-16E-Instruct-FP8",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "cerebras-llama-4-maverick-17b-128e-instruct",
                    displayName: "Cerebras-Llama-4-Maverick-17B-128E-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "llama-3.3-70b-instruct",
                    displayName: "Llama-3.3-70B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "groq-llama-4-maverick-17b-128e-instruct",
                    displayName: "Groq-Llama-4-Maverick-17B-128E-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "cerebras-llama-4-scout-17b-16e-instruct",
                    displayName: "Cerebras-Llama-4-Scout-17B-16E-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "llama-3.3-8b-instruct",
                    displayName: "Llama-3.3-8B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "llama-4-maverick-17b-128e-instruct-fp8",
                    displayName: "Llama-4-Maverick-17B-128E-Instruct-FP8",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Attachments"
                )
            ]
        ),
        AIScriptProvider(
            id: "llmgateway",
            displayName: "LLM Gateway",
            shortDescription: "OpenAI-compatible \u{B7} 194 text models",
            baseURLString: "https://api.llmgateway.io/v1",
            apiKeyLabel: "LLM Gateway API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "claude-3-7-sonnet",
                    displayName: "Claude 3.7 Sonnet",
                    shortDescription: "claude \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-coder-plus",
                    displayName: "Qwen Coder Plus",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-large-latest",
                    displayName: "Mistral Large (latest)",
                    shortDescription: "mistral-large \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-235b-a22b-thinking",
                    displayName: "Qwen3 VL 235B A22B Thinking",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1-0528",
                    displayName: "DeepSeek R1 (0528)",
                    shortDescription: "deepseek \u{B7} 64K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "devstral-small-2507",
                    displayName: "Devstral Small",
                    shortDescription: "devstral \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-30b-a3b-thinking",
                    displayName: "Qwen3 VL 30B A3B Thinking",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-plus",
                    displayName: "Qwen3 Coder Plus",
                    shortDescription: "qwen \u{B7} 1.04858M context"
                ),
                AIScriptModelPreset(
                    id: "qwen25-coder-7b",
                    displayName: "Qwen2.5 Coder 7B",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.7-highspeed",
                    displayName: "MiniMax-M2.7-highspeed",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "llama-3.1-8b-instruct",
                    displayName: "Llama 3.1 8B Instruct",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen-plus",
                    displayName: "Qwen Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "o3",
                    displayName: "o3",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nemotron-3-ultra-550b",
                    displayName: "Nemotron 3 Ultra 550B A55B",
                    shortDescription: "nemotron \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-20-beta-0309-non-reasoning",
                    displayName: "Grok 4.20 (Non-Reasoning)",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.1-flash-lite",
                    displayName: "Gemini 3.1 Flash Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b-instruct-2507",
                    displayName: "Qwen3 235B A22B Instruct (2507)",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "llama-3-70b-instruct",
                    displayName: "Llama 3 70B Instruct",
                    shortDescription: "llama \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-30b-a3b-instruct",
                    displayName: "Qwen3-Coder 30B-A3B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "seed-1-8-251228",
                    displayName: "Seed 1.8 (251228)",
                    shortDescription: "seed \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hermes-2-pro-llama-3-8b",
                    displayName: "Hermes 2 Pro Llama 3 8B",
                    shortDescription: "hermes \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2",
                    displayName: "Kimi K2",
                    shortDescription: "kimi-k2 \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "llama-3.1-70b-instruct",
                    displayName: "Llama 3.1 70B Instruct",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-pro",
                    displayName: "GPT-5.2 Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.1",
                    displayName: "MiniMax-M2.1",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-32b",
                    displayName: "Qwen3 32B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "pixtral-large-latest",
                    displayName: "Pixtral Large (latest)",
                    shortDescription: "pixtral \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4-32b-0414-128k",
                    displayName: "GLM-4 32B (0414-128k)",
                    shortDescription: "glm \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "seed-1-6-flash-250715",
                    displayName: "Seed 1.6 Flash (250715)",
                    shortDescription: "seed \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-next-80b-a3b-instruct",
                    displayName: "Qwen3-Next 80B-A3B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-8b-instruct",
                    displayName: "Qwen3 VL 8B Instruct",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o-mini-search-preview",
                    displayName: "GPT-4o Mini Search Preview",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5v",
                    displayName: "GLM-4.5V",
                    shortDescription: "glm \u{B7} 64K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-plus",
                    displayName: "Qwen3.7 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4-5-20251001",
                    displayName: "Claude Haiku 4.5",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking-turbo",
                    displayName: "Kimi K2 Thinking Turbo",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-35b-a3b",
                    displayName: "Qwen3.6 35B-A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-3.5-turbo",
                    displayName: "GPT-3.5-turbo",
                    shortDescription: "gpt \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "seed-1-6-250615",
                    displayName: "Seed 1.6 (250615)",
                    shortDescription: "seed \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-max",
                    displayName: "Qwen3.7 Max",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5",
                    displayName: "GLM-4.5",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-pro",
                    displayName: "GPT-5 Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o",
                    displayName: "GPT-4o",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "ministral-8b-2512",
                    displayName: "Ministral 8B",
                    shortDescription: "mistral \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-4",
                    displayName: "GPT-4",
                    shortDescription: "gpt \u{B7} 8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "o4-mini",
                    displayName: "o4-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max",
                    displayName: "Qwen3 Max",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-small-2506",
                    displayName: "Mistral Small 3.2",
                    shortDescription: "mistral-small \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.5-flash",
                    displayName: "Gemini 3.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-plus-latest",
                    displayName: "Qwen Plus Latest",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1-20250805",
                    displayName: "Claude Opus 4.1",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-3",
                    displayName: "Grok 4.3",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "llama-4-scout-17b-instruct",
                    displayName: "Llama 4 Scout 17B Instruct",
                    shortDescription: "llama \u{B7} 8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "llama-3.3-70b-instruct",
                    displayName: "Llama-3.3-70B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "sonar-reasoning-pro",
                    displayName: "Sonar Reasoning Pro",
                    shortDescription: "sonar-reasoning \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.0-flash",
                    displayName: "Gemini 2.0 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "grok-4-20-non-reasoning",
                    displayName: "Grok 4.20 (Non-Reasoning)",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7-flashx",
                    displayName: "GLM-4.7-FlashX",
                    shortDescription: "glm-flash \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-30b-a3b-instruct-2507",
                    displayName: "Qwen3 30B A3B Instruct (2507)",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.7-code",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-next-80b-a3b-thinking",
                    displayName: "Qwen3-Next 80B-A3B (Thinking)",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6",
                    displayName: "GLM-4.6",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen35-397b-a17b",
                    displayName: "Qwen3.5 397B-A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b-thinking-2507",
                    displayName: "Qwen3 235B A22B Thinking (2507)",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-5",
                    displayName: "Claude Sonnet 4.5 (latest)",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-pro-latest",
                    displayName: "Gemini Pro Latest",
                    shortDescription: "gemini \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemma-3-1b-it",
                    displayName: "Gemma 3 1B IT",
                    shortDescription: "gemma \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-x",
                    displayName: "GLM-4.5 X",
                    shortDescription: "glm \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-nano",
                    displayName: "GPT-5.4 nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-20-beta-0309-reasoning",
                    displayName: "Grok 4.20 (Reasoning)",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-airx",
                    displayName: "GLM-4.5 AirX",
                    shortDescription: "glm \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-chat-latest",
                    displayName: "GPT-5 Chat (latest)",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "ministral-3b-2512",
                    displayName: "Ministral 3B",
                    shortDescription: "mistral \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-vl-72b-instruct",
                    displayName: "Qwen2.5-VL 72B Instruct",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6v-flashx",
                    displayName: "GLM-4.6V FlashX",
                    shortDescription: "glm \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m3",
                    displayName: "MiniMax-M3",
                    shortDescription: "minimax \u{B7} 512K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-plus",
                    displayName: "Qwen3-VL Plus",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-5-20251101",
                    displayName: "Claude Opus 4.5",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex",
                    displayName: "GPT-5.1 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2",
                    displayName: "MiniMax-M2",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-3-5-sonnet-20241022",
                    displayName: "Claude Sonnet 3.5 v2",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-8",
                    displayName: "Claude Opus 4.8",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-20250514",
                    displayName: "Claude Opus 4",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max-2026-01-23",
                    displayName: "Qwen3 Max (2026-01-23)",
                    shortDescription: "qwen \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.3-chat-latest",
                    displayName: "GPT-5.3 Chat (latest)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-3-opus",
                    displayName: "Claude 3 Opus",
                    shortDescription: "claude \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen-omni-turbo",
                    displayName: "Qwen-Omni Turbo",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "o3-mini",
                    displayName: "o3-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-32b-fp8",
                    displayName: "Qwen3 32B FP8",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-3-5-haiku",
                    displayName: "Claude 3.5 Haiku",
                    shortDescription: "claude \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemma-3-27b",
                    displayName: "Gemma 3 27B",
                    shortDescription: "gemma \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.3-codex",
                    displayName: "GPT-5.3 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-0709",
                    displayName: "Grok 4 (0709)",
                    shortDescription: "grok \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-flash",
                    displayName: "Qwen Flash",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-4b-fp8",
                    displayName: "Qwen3 4B FP8",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-lite",
                    displayName: "Gemini 2.5 Flash-Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen2-5-vl-32b-instruct",
                    displayName: "Qwen2.5 VL 32B Instruct",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-20250514",
                    displayName: "Claude Sonnet 4",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex-mini",
                    displayName: "GPT-5.1 Codex mini",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-30b-a3b-thinking-2507",
                    displayName: "Qwen3 30B A3B Thinking (2507)",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "seed-1-6-250915",
                    displayName: "Seed 1.6 (250915)",
                    shortDescription: "seed \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-chat-latest",
                    displayName: "GPT-5.2 Chat",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-text-01",
                    displayName: "MiniMax Text 01",
                    shortDescription: "minimax \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-fast-reasoning",
                    displayName: "Grok 4 Fast Reasoning",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1-nano",
                    displayName: "GPT-4.1 nano",
                    shortDescription: "gpt-nano \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-vl-max",
                    displayName: "Qwen-VL Max",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "llama-3-8b-instruct",
                    displayName: "Llama 3 8B Instruct",
                    shortDescription: "llama \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-30b-a3b-fp8",
                    displayName: "Qwen3 30B A3B FP8",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "sonar",
                    displayName: "Sonar",
                    shortDescription: "sonar \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen-max",
                    displayName: "Qwen Max",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "claude-3-7-sonnet-20250219",
                    displayName: "Claude Sonnet 3.7",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "o1",
                    displayName: "o1",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.5-highspeed",
                    displayName: "MiniMax-M2.5-highspeed",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "llama-4-scout",
                    displayName: "Llama 4 Scout",
                    shortDescription: "llama \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "ministral-14b-2512",
                    displayName: "Ministral 14B",
                    shortDescription: "mistral \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "sonar-pro",
                    displayName: "Sonar Pro",
                    shortDescription: "sonar-pro \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6v",
                    displayName: "GLM-4.6V",
                    shortDescription: "glm \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4-5",
                    displayName: "Claude Haiku 4.5 (latest)",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.1-lightning",
                    displayName: "MiniMax M2.1 Lightning",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2.5",
                    displayName: "MiMo-V2.5",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-omni",
                    displayName: "MiMo-V2-Omni",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-mini",
                    displayName: "GPT-5.4 mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.1-pro-preview",
                    displayName: "Gemini 3.1 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-next",
                    displayName: "Qwen3 Coder Next",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "llama-4-maverick-17b-instruct",
                    displayName: "Llama 4 Maverick 17B Instruct",
                    shortDescription: "llama \u{B7} 8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-480b-a35b-instruct",
                    displayName: "Qwen3-Coder 480B-A35B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "devstral-2512",
                    displayName: "Devstral 2",
                    shortDescription: "devstral \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-5-20250929",
                    displayName: "Claude Sonnet 4.5",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwq-plus",
                    displayName: "QwQ Plus",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4-1-fast-reasoning",
                    displayName: "Grok 4.1 Fast Reasoning",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-30b-a3b-instruct",
                    displayName: "Qwen3 VL 30B A3B Instruct",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-flash",
                    displayName: "Qwen3 VL Flash",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-mini",
                    displayName: "GPT-5 Mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-flash",
                    displayName: "MiMo-V2-Flash",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1-mini",
                    displayName: "GPT-4.1 mini",
                    shortDescription: "gpt-mini \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "llama-3.1-nemotron-ultra-253b",
                    displayName: "Llama 3.1 Nemotron Ultra 253B",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-4-turbo",
                    displayName: "GPT-4 Turbo",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-flash",
                    displayName: "Qwen3 Coder Flash",
                    shortDescription: "qwen \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "gemma-2-27b-it-together",
                    displayName: "Gemma 2 27B IT",
                    shortDescription: "gemma \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "grok-build-0-1",
                    displayName: "Grok Build 0.1",
                    shortDescription: "grok-build \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-nano",
                    displayName: "GPT-5 Nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "llama-3.2-11b-instruct",
                    displayName: "Llama 3.2 11B Instruct",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-pro",
                    displayName: "GPT-5.4 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6v-flash",
                    displayName: "GLM-4.6V Flash",
                    shortDescription: "glm \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-air",
                    displayName: "GLM-4.5-Air",
                    shortDescription: "glm-air \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-flash-preview",
                    displayName: "Gemini 3 Flash Preview",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7-flash",
                    displayName: "GLM-4.7-Flash",
                    shortDescription: "glm-flash \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-235b-a22b-instruct",
                    displayName: "Qwen3 VL 235B A22B Instruct",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-pro",
                    displayName: "MiMo-V2-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o-search-preview",
                    displayName: "GPT-4o Search Preview",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "llama-3.2-3b-instruct",
                    displayName: "Llama 3.2 3B Instruct",
                    shortDescription: "llama \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2.5-pro",
                    displayName: "MiMo-V2.5-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.5-pro",
                    displayName: "GPT-5.5 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o-mini",
                    displayName: "GPT-4o mini",
                    shortDescription: "gpt-mini \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-20b",
                    displayName: "GPT OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-flash",
                    displayName: "GLM-4.5-Flash",
                    shortDescription: "glm-flash \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-max-latest",
                    displayName: "Qwen Max Latest",
                    shortDescription: "qwen \u{B7} 32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistral-large-2512",
                    displayName: "Mistral Large 3",
                    shortDescription: "mistral-large \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen-turbo",
                    displayName: "Qwen Turbo",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "custom",
                    displayName: "Custom Model",
                    shortDescription: "auto \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "grok-4-20-reasoning",
                    displayName: "Grok 4.20 (Reasoning)",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-max-preview",
                    displayName: "Qwen3.6 Max Preview",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "auto",
                    displayName: "Auto Route",
                    shortDescription: "auto \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.1-flash-lite-preview",
                    displayName: "Gemini 3.1 Flash Lite Preview",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "codestral-2508",
                    displayName: "Codestral",
                    shortDescription: "mistral \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b-fp8",
                    displayName: "Qwen3 235B A22B FP8",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-codex",
                    displayName: "GPT-5.2 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-vl-plus",
                    displayName: "Qwen-VL Plus",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.0-flash-lite",
                    displayName: "Gemini 2.0 Flash-Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1",
                    displayName: "GPT-5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "llmtr",
            displayName: "LLMTR",
            shortDescription: "OpenAI-compatible \u{B7} 6 text models",
            baseURLString: "https://llmtr.com/v1",
            apiKeyLabel: "LLMTR API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "sincap",
                    displayName: "Sincap",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "magibu-11b-v8",
                    displayName: "Magibu 11B v8",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "gemma-4",
                    displayName: "Gemma 4",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "medgemma-4b",
                    displayName: "MedGemma 4B",
                    shortDescription: "8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3-6-35b",
                    displayName: "Qwen3.6 35B-A3B",
                    shortDescription: "qwen \u{B7} 16K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "trendyol-7b",
                    displayName: "Trendyol 7B",
                    shortDescription: "qwen \u{B7} 32K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "lmstudio",
            displayName: "LMStudio",
            shortDescription: "OpenAI-compatible \u{B7} 3 text models",
            baseURLString: "http://127.0.0.1:1234/v1",
            apiKeyLabel: "LMStudio API Key",
            requiresAPIKey: false,
            modelPresets: [
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "GPT OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-30b-a3b-2507",
                    displayName: "Qwen3 30B A3B 2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-30b",
                    displayName: "Qwen3 Coder 30B",
                    shortDescription: "qwen \u{B7} 262K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "lucidquery",
            displayName: "LucidQuery AI",
            shortDescription: "OpenAI-compatible \u{B7} 2 text models",
            baseURLString: "https://lucidquery.com/api/v1",
            apiKeyLabel: "LucidQuery AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "lucidnova-rf1-100b",
                    displayName: "LucidNova RF1 100B",
                    shortDescription: "nova \u{B7} 120K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "lucidquery-nexus-coder",
                    displayName: "LucidQuery Nexus Coder",
                    shortDescription: "lucid \u{B7} 250K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "meganova",
            displayName: "Meganova",
            shortDescription: "OpenAI-compatible \u{B7} 19 text models",
            baseURLString: "https://api.meganova.ai/v1",
            apiKeyLabel: "Meganova API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.3-70B-Instruct",
                    displayName: "Llama 3.3 70B Instruct",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2-Thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-VL-32B-Instruct",
                    displayName: "Qwen2.5 VL 32B Instruct",
                    shortDescription: "qwen \u{B7} 16K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-Plus",
                    displayName: "Qwen3.5 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Instruct-2507",
                    displayName: "Qwen3 235B A22B Instruct 2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "XiaomiMiMo/MiMo-V2-Flash",
                    displayName: "MiMo V2 Flash",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistralai/Mistral-Small-3.2-24B-Instruct-2506",
                    displayName: "Mistral Small 3.2 24B Instruct",
                    shortDescription: "mistral-small \u{B7} 32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/Mistral-Nemo-Instruct-2407",
                    displayName: "Mistral Nemo Instruct 2407",
                    shortDescription: "mistral \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.6",
                    displayName: "GLM-4.6",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3-0324",
                    displayName: "DeepSeek V3 0324",
                    shortDescription: "deepseek \u{B7} 163K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1-0528",
                    displayName: "DeepSeek R1 0528",
                    shortDescription: "deepseek-thinking \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 164K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.2-Exp",
                    displayName: "DeepSeek V3.2 Exp",
                    shortDescription: "deepseek \u{B7} 164K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 164K context"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.1",
                    displayName: "MiniMax M2.1",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5",
                    displayName: "MiniMax M2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "mistral",
            displayName: "Mistral",
            shortDescription: "OpenAI-compatible \u{B7} 29 text models",
            baseURLString: "https://api.mistral.ai/v1",
            apiKeyLabel: "Mistral API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "codestral-latest",
                    displayName: "Codestral (latest)",
                    shortDescription: "codestral \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-large-latest",
                    displayName: "Mistral Large (latest)",
                    shortDescription: "mistral-large \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "open-mistral-7b",
                    displayName: "Mistral 7B",
                    shortDescription: "mistral \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "devstral-small-2507",
                    displayName: "Devstral Small",
                    shortDescription: "devstral \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "ministral-3b-latest",
                    displayName: "Ministral 3B (latest)",
                    shortDescription: "ministral \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "pixtral-large-latest",
                    displayName: "Pixtral Large (latest)",
                    shortDescription: "pixtral \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistral-nemo",
                    displayName: "Mistral Nemo",
                    shortDescription: "mistral-nemo \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-small-2506",
                    displayName: "Mistral Small 3.2",
                    shortDescription: "mistral-small \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "ministral-8b-latest",
                    displayName: "Ministral 8B (latest)",
                    shortDescription: "ministral \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "open-mixtral-8x22b",
                    displayName: "Mixtral 8x22B",
                    shortDescription: "mixtral \u{B7} 64K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-medium-latest",
                    displayName: "Mistral Medium (latest)",
                    shortDescription: "mistral-medium \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "devstral-small-2505",
                    displayName: "Devstral Small 2505",
                    shortDescription: "devstral \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "magistral-small",
                    displayName: "Magistral Small",
                    shortDescription: "magistral-small \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-medium-2604",
                    displayName: "Mistral Medium 3.5",
                    shortDescription: "mistral-medium \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-small-latest",
                    displayName: "Mistral Small (latest)",
                    shortDescription: "mistral-small \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "open-mixtral-8x7b",
                    displayName: "Mixtral 8x7B",
                    shortDescription: "mixtral \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "devstral-latest",
                    displayName: "Devstral 2",
                    shortDescription: "devstral \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-small-2603",
                    displayName: "Mistral Small 4",
                    shortDescription: "mistral-small \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-medium-2505",
                    displayName: "Mistral Medium 3",
                    shortDescription: "mistral-medium \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistral-large-2411",
                    displayName: "Mistral Large 2.1",
                    shortDescription: "mistral-large \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-medium-2508",
                    displayName: "Mistral Medium 3.1",
                    shortDescription: "mistral-medium \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "open-mistral-nemo",
                    displayName: "Open Mistral Nemo",
                    shortDescription: "mistral-nemo \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "magistral-medium-latest",
                    displayName: "Magistral Medium (latest)",
                    shortDescription: "magistral-medium \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "devstral-medium-latest",
                    displayName: "Devstral 2 (latest)",
                    shortDescription: "devstral \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "devstral-2512",
                    displayName: "Devstral 2",
                    shortDescription: "devstral \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "labs-devstral-small-2512",
                    displayName: "Devstral Small 2",
                    shortDescription: "devstral \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "pixtral-12b",
                    displayName: "Pixtral 12B",
                    shortDescription: "pixtral \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistral-large-2512",
                    displayName: "Mistral Large 3",
                    shortDescription: "mistral-large \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "devstral-medium-2507",
                    displayName: "Devstral Medium",
                    shortDescription: "devstral \u{B7} 128K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "mixlayer",
            displayName: "Mixlayer",
            shortDescription: "OpenAI-compatible \u{B7} 5 text models",
            baseURLString: "https://models.mixlayer.ai/v1",
            apiKeyLabel: "Mixlayer API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-27b",
                    displayName: "Qwen3.5 27B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-35b-a3b",
                    displayName: "Qwen3.5 35B A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-9b",
                    displayName: "Qwen3.5 9B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-397b-a17b",
                    displayName: "Qwen3.5 397B A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-122b-a10b",
                    displayName: "Qwen3.5 122B A10B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "moark",
            displayName: "Moark",
            shortDescription: "OpenAI-compatible \u{B7} 2 text models",
            baseURLString: "https://moark.com/v1",
            apiKeyLabel: "Moark API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "MiniMax-M2.1",
                    displayName: "MiniMax-M2.1",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "GLM-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "modelscope",
            displayName: "ModelScope",
            shortDescription: "OpenAI-compatible \u{B7} 7 text models",
            baseURLString: "https://api-inference.modelscope.cn/v1",
            apiKeyLabel: "ModelScope API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-30B-A3B-Thinking-2507",
                    displayName: "Qwen3 30B A3B Thinking 2507",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Thinking-2507",
                    displayName: "Qwen3-235B-A22B-Thinking-2507",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-30B-A3B-Instruct",
                    displayName: "Qwen3 Coder 30B A3B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-30B-A3B-Instruct-2507",
                    displayName: "Qwen3 30B A3B Instruct 2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Instruct-2507",
                    displayName: "Qwen3 235B A22B Instruct 2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "ZhipuAI/GLM-4.6",
                    displayName: "GLM-4.6",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "ZhipuAI/GLM-4.5",
                    displayName: "GLM-4.5",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "moonshotai",
            displayName: "Moonshot AI",
            shortDescription: "OpenAI-compatible \u{B7} 9 text models",
            baseURLString: "https://api.moonshot.ai/v1",
            apiKeyLabel: "Moonshot AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "kimi-k2-0905-preview",
                    displayName: "Kimi K2 0905",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking-turbo",
                    displayName: "Kimi K2 Thinking Turbo",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.7-code",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-0711-preview",
                    displayName: "Kimi K2 0711",
                    shortDescription: "kimi-k2 \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-turbo-preview",
                    displayName: "Kimi K2 Turbo",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.7-code-highspeed",
                    displayName: "Kimi K2.7 Code HighSpeed",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "moonshotai-cn",
            displayName: "Moonshot AI (China)",
            shortDescription: "OpenAI-compatible \u{B7} 9 text models",
            baseURLString: "https://api.moonshot.cn/v1",
            apiKeyLabel: "Moonshot AI (China) API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "kimi-k2.7-code-highspeed",
                    displayName: "Kimi K2.7 Code HighSpeed",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-turbo-preview",
                    displayName: "Kimi K2 Turbo",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-0711-preview",
                    displayName: "Kimi K2 0711",
                    shortDescription: "kimi-k2 \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.7-code",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking-turbo",
                    displayName: "Kimi K2 Thinking Turbo",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-0905-preview",
                    displayName: "Kimi K2 0905",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "morph",
            displayName: "Morph",
            shortDescription: "OpenAI-compatible \u{B7} 3 text models",
            baseURLString: "https://api.morphllm.com/v1",
            apiKeyLabel: "Morph API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "morph-v3-fast",
                    displayName: "Morph v3 Fast",
                    shortDescription: "morph \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "morph-v3-large",
                    displayName: "Morph v3 Large",
                    shortDescription: "morph \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "auto",
                    displayName: "Auto",
                    shortDescription: "auto \u{B7} 32K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "nano-gpt",
            displayName: "NanoGPT",
            shortDescription: "OpenAI-compatible \u{B7} 615 text models",
            baseURLString: "https://nano-gpt.com/api/v1",
            apiKeyLabel: "NanoGPT API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "step-3",
                    displayName: "Step-3",
                    shortDescription: "65K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-35b-a3b:thinking",
                    displayName: "Qwen3.5 35B A3B Thinking",
                    shortDescription: "260K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4.1v-thinking-flashx",
                    displayName: "GLM 4.1V Thinking FlashX",
                    shortDescription: "64K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "ernie-x1.1-preview",
                    displayName: "ERNIE X1.1",
                    shortDescription: "64K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen25-vl-72b-instruct",
                    displayName: "Qwen25 VL 72b",
                    shortDescription: "32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.0-pro-exp-02-05",
                    displayName: "Gemini 2.0 Pro 0205",
                    shortDescription: "2.09715M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-2-0-lite-260215",
                    displayName: "Doubao Seed 2.0 Lite",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Writer-V2-Derestricted",
                    displayName: "Qwen3.5 27B Writer V2 Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-thinking:8192",
                    displayName: "Claude 4 Opus Thinking (8K)",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-235b-a22b-thinking",
                    displayName: "Qwen3 VL 235B A22B Thinking",
                    shortDescription: "32K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4-air-0111",
                    displayName: "GLM 4 Air 0111",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Queen-Derestricted",
                    displayName: "Qwen3.5 27B Queen Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro-preview-03-25",
                    displayName: "Gemini 2.5 Pro Preview 0325",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "brave-research",
                    displayName: "Brave (Research)",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "qwen-plus",
                    displayName: "Qwen Plus",
                    shortDescription: "995K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-2-0-mini-260215",
                    displayName: "Doubao Seed 2.0 Mini",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-BlueStar-v3-Derestricted-Lite",
                    displayName: "Qwen3.5 27B BlueStar v3 Derestricted Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3-0324",
                    displayName: "DeepSeek Chat 0324",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "Gemma-4-31B-Musica-v1",
                    displayName: "Gemma 4 31B Musica v1",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mirothinker-1-7-deepresearch-mini",
                    displayName: "MiroThinker 1.7 Deep Research Mini",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Baichuan4-Turbo",
                    displayName: "Baichuan 4 Turbo",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-1-6-flash-250615",
                    displayName: "Doubao Seed 1.6 Flash",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-instruct-fast",
                    displayName: "Kimi K2 0711 Fast",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4-plus",
                    displayName: "GLM-4 Plus",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "v0-1.0-md",
                    displayName: "v0 1.0 MD",
                    shortDescription: "200K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-30b-a3b-instruct",
                    displayName: "Qwen3 Coder 30B A3B Instruct",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-preview-09-2025-thinking",
                    displayName: "Gemini 2.5 Flash Preview (09/2025) \u{2013} Thinking",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "v0-1.5-lg",
                    displayName: "v0 1.5 LG",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-flash:thinking",
                    displayName: "Qwen3.5 Flash Thinking",
                    shortDescription: "991K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "jamba-large",
                    displayName: "Jamba Large",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-thinking-preview",
                    displayName: "Kimi Thinking Preview",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.0-flash-thinking-exp-01-21",
                    displayName: "Gemini 2.0 Flash Thinking 0121",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1-thinking:1024",
                    displayName: "Claude 4.1 Opus Thinking (1K)",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-NaNovel-Derestricted-Lite",
                    displayName: "Qwen3.5 27B NaNovel Derestricted Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-1-6-250615",
                    displayName: "Doubao Seed 1.6",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "ernie-5.0-thinking-preview",
                    displayName: "Ernie 5.0 Thinking Preview",
                    shortDescription: "128K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-preview-05-20:thinking",
                    displayName: "Gemini 2.5 Flash 0520 Thinking",
                    shortDescription: "1.048M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Omega-Evolution-v2.2-Derestricted",
                    displayName: "Qwen3.5 27B Omega Evolution v2.2 Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "azure-o1",
                    displayName: "Azure o1",
                    shortDescription: "200K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-plus",
                    displayName: "Qwen3.7 Plus",
                    shortDescription: "991K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4-airx",
                    displayName: "GLM-4 AirX",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "step-r1-v-mini",
                    displayName: "Step R1 V Mini",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4-5-20251001-thinking",
                    displayName: "Claude Haiku 4.5 Thinking",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "jamba-mini-1.6",
                    displayName: "Jamba Mini 1.6",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4-5-20251001",
                    displayName: "Claude Haiku 4.5",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-3-5-haiku-20241022",
                    displayName: "Claude 3.5 Haiku",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-thinking:32768",
                    displayName: "Claude 4 Sonnet Thinking (32K)",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "hermes-low",
                    displayName: "Hermes Low",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-thinking",
                    displayName: "Claude 4 Sonnet Thinking",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-max",
                    displayName: "Qwen3.7 Max",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "yi-medium-200k",
                    displayName: "Yi Medium 200k",
                    shortDescription: "200K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-BlueStar-v2-Derestricted-Lite",
                    displayName: "Qwen3.5 27B BlueStar v2 Derestricted Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Gemma-4-31B-Claude-4.6-Opus-Reasoning-Distilled",
                    displayName: "Gemma 4 31B Claude 4.6 Opus Reasoning Distilled",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-1-5-thinking-vision-pro-250428",
                    displayName: "Doubao 1.5 Thinking Vision Pro",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-BlueStar-Derestricted-Lite",
                    displayName: "Qwen3.5 27B BlueStar Derestricted Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen2.5-32B-EVA-v0.2",
                    displayName: "Qwen 2.5 32b EVA",
                    shortDescription: "24K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen-long",
                    displayName: "Qwen Long 10M",
                    shortDescription: "10M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Gemma-4-31B-DarkIdol",
                    displayName: "Gemma 4 31B DarkIdol",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "step-2-16k-exp",
                    displayName: "Step-2 16k Exp",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Marvin-V2-Derestricted-Lite",
                    displayName: "Qwen3.5 27B Marvin V2 Derestricted Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-NaNovel-Derestricted",
                    displayName: "Qwen3.5 27B NaNovel Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "ernie-4.5-8k-preview",
                    displayName: "Ernie 4.5 8k Preview",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-lite-preview-09-2025",
                    displayName: "Gemini 2.5 Flash Lite Preview (09/2025)",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-reasoner-cheaper",
                    displayName: "Deepseek R1 Cheaper",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "venice-uncensored",
                    displayName: "Venice Uncensored",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.0-flash-001",
                    displayName: "Gemini 2.0 Flash",
                    shortDescription: "1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-31B-Larkspur-v0.5",
                    displayName: "Gemma 4 31B Larkspur v0.5",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1-20250805",
                    displayName: "Claude 4.1 Opus",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "holo3-35b-a3b",
                    displayName: "Holo3-35B-A3B",
                    shortDescription: "65K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-omni-plus",
                    displayName: "Qwen3.5 Omni Plus",
                    shortDescription: "983K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Gemma-4-31B-it",
                    displayName: "Gemma 4 31B IT",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Derestricted",
                    displayName: "Qwen3.5 27B Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "sonar-reasoning-pro",
                    displayName: "Perplexity Reasoning Pro",
                    shortDescription: "127K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "venice-uncensored:web",
                    displayName: "Venice Uncensored Web",
                    shortDescription: "80K context"
                ),
                AIScriptModelPreset(
                    id: "doubao-1.5-pro-32k",
                    displayName: "Doubao 1.5 Pro 32k",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-30b-a3b-instruct-2507",
                    displayName: "Qwen3 30B A3B Instruct 2507",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "ernie-5.1:thinking",
                    displayName: "ERNIE 5.1 Thinking",
                    shortDescription: "119K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mirothinker-1-7-deepresearch",
                    displayName: "MiroThinker 1.7 Deep Research",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hermes-high",
                    displayName: "Hermes High",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "jamba-large-1.6",
                    displayName: "Jamba Large 1.6",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "glm-4-long",
                    displayName: "GLM-4 Long",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-thinking:32768",
                    displayName: "Claude 4 Opus Thinking (32K)",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-thinking:8192",
                    displayName: "Claude 4 Sonnet Thinking (8K)",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "azure-o3-mini",
                    displayName: "Azure o3-mini",
                    shortDescription: "200K context"
                ),
                AIScriptModelPreset(
                    id: "qvq-max",
                    displayName: "Qwen: QvQ Max",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-BlueStar-v2-Derestricted",
                    displayName: "Qwen3.5 27B BlueStar v2 Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Vivid-Durian",
                    displayName: "Qwen3.5 27B Vivid Durian",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "jamba-large-1.7",
                    displayName: "Jamba Large 1.7",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "Baichuan-M2",
                    displayName: "Baichuan M2 32B Medical",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "Magistral-Small-2506",
                    displayName: "Magistral Small 2506",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1",
                    displayName: "DeepSeek R1",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-earica-Derestricted-Lite",
                    displayName: "Qwen3.5 27B earica Derestricted Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-2-0-pro-260215",
                    displayName: "Doubao Seed 2.0 Pro",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "step-2-mini",
                    displayName: "Step-2 Mini",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-exp-1206",
                    displayName: "Gemini 2.0 Pro 1206",
                    shortDescription: "2.09715M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-5-20251101:thinking",
                    displayName: "Claude 4.5 Opus Thinking",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-BlueStar-v3-Derestricted",
                    displayName: "Qwen3.5 27B BlueStar v3 Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-thinking",
                    displayName: "Claude 4 Opus Thinking",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-flash",
                    displayName: "Qwen3.5 Flash",
                    shortDescription: "991K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "exa-research-pro",
                    displayName: "Exa (Research Pro)",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "jamba-mini",
                    displayName: "Jamba Mini",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1-thinking:32000",
                    displayName: "Claude 4.1 Opus Thinking (32K)",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "KAT-Coder-Air-V1",
                    displayName: "KAT Coder Air V1",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "exa-research",
                    displayName: "Exa (Research)",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "deepclaude",
                    displayName: "DeepClaude",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-preview-09-2025",
                    displayName: "Gemini 2.5 Flash Preview (09/2025)",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-5-20251101",
                    displayName: "Claude 4.5 Opus",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "GLM-4.6-Derestricted-v5",
                    displayName: "GLM 4.6 Derestricted v5",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "glm-z1-airx",
                    displayName: "GLM Z1 AirX",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-thinking:1024",
                    displayName: "Claude 4 Sonnet Thinking (1K)",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "holo3-35b-a3b:thinking",
                    displayName: "Holo3-35B-A3B Thinking",
                    shortDescription: "65K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "owl",
                    displayName: "OWL",
                    shortDescription: "1.04876M context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.0-pro-reasoner",
                    displayName: "Gemini 2.0 Pro Reasoner",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "Gemma-4-31B-Cognitive-Unshackled",
                    displayName: "Gemma 4 31B Cognitive Unshackled",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-earica-Derestricted",
                    displayName: "Qwen3.5 27B earica Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "command-a-plus-05-2026",
                    displayName: "Cohere Command A+ (05/2026)",
                    shortDescription: "128K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "auto-model-premium",
                    displayName: "Auto model (Premium)",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "learnlm-1.5-pro-experimental",
                    displayName: "Gemini LearnLM Experimental",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1-sambanova",
                    displayName: "DeepSeek R1 Fast",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "claw-medium",
                    displayName: "Claw Medium",
                    shortDescription: "204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-20250514",
                    displayName: "Claude 4 Opus",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "yi-large",
                    displayName: "Yi Large",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max-2026-01-23",
                    displayName: "Qwen3 Max 2026-01-23",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "phi-4-mini-instruct",
                    displayName: "Phi 4 Mini",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "ernie-x1-turbo-32k",
                    displayName: "Ernie X1 Turbo 32k",
                    shortDescription: "32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claw-low",
                    displayName: "Claw Low",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-31B-Garnet",
                    displayName: "Gemma 4 31B Garnet",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-1.5-vision-pro-32k",
                    displayName: "Doubao 1.5 Vision Pro 32k",
                    shortDescription: "32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "auto-model-standard",
                    displayName: "Auto model (Standard)",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Marvin-DPO-V2-Derestricted-Lite",
                    displayName: "Qwen3.5 27B Marvin DPO V2 Derestricted Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4",
                    displayName: "GLM-4",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Writer-Derestricted-Lite",
                    displayName: "Qwen3.5 27B Writer Derestricted Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen-3.6-plus",
                    displayName: "Qwen 3.6 Plus",
                    shortDescription: "qwen3.6 \u{B7} 991K context"
                ),
                AIScriptModelPreset(
                    id: "brave-pro",
                    displayName: "Brave (Pro)",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-chat-cheaper",
                    displayName: "DeepSeek V3/Chat Cheaper",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Gemma-4-31B-Queen",
                    displayName: "Gemma 4 31B Queen",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Gemma-4-31B-Gemopus",
                    displayName: "Gemma 4 31B Gemopus",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistral-code-latest",
                    displayName: "Mistral Code Latest",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-lite",
                    displayName: "Gemini 2.5 Flash Lite",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "jamba-mini-1.7",
                    displayName: "Jamba Mini 1.7",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "universal-summarizer",
                    displayName: "Universal Summarizer",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Anko",
                    displayName: "Qwen3.5 27B Anko",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-20250514",
                    displayName: "Claude 4 Sonnet",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "ernie-x1-32k-preview",
                    displayName: "Ernie X1 32k",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "azure-gpt-4-turbo",
                    displayName: "Azure gpt-4-turbo",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "Meta-Llama-3-1-8B-Instruct-FP8",
                    displayName: "Llama 3.1 8B (decentralized)",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-5-20250929-thinking",
                    displayName: "Claude Sonnet 4.5 Thinking",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "asi1-mini",
                    displayName: "ASI1 Mini",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-27b",
                    displayName: "Qwen3.5 27B",
                    shortDescription: "260K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Omega-Evolution-v2.2-Derestricted-Lite",
                    displayName: "Qwen3.5 27B Omega Evolution v2.2 Derestricted Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1-thinking:32768",
                    displayName: "Claude 4.1 Opus Thinking (32K)",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-31B-K1-v5",
                    displayName: "Gemma 4 31B K1 v5",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "sonar",
                    displayName: "Perplexity Simple",
                    shortDescription: "127K context"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M2",
                    displayName: "MiniMax M2",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "sarvam-105b",
                    displayName: "Sarvam 105B",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Writer-V2-Derestricted-Lite",
                    displayName: "Qwen3.5 27B Writer V2 Derestricted Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Marvin-V2-Derestricted",
                    displayName: "Qwen3.5 27B Marvin V2 Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claw-high",
                    displayName: "Claw High",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen-max",
                    displayName: "Qwen 2.5 Max",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-31B-Fabled",
                    displayName: "Gemma 4 31B Fabled",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "v0-1.5-md",
                    displayName: "v0 1.5 MD",
                    shortDescription: "200K context"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-thinking:1024",
                    displayName: "Claude 4 Opus Thinking (1K)",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-preview-04-17",
                    displayName: "Gemini 2.5 Flash Preview",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro-exp-03-25",
                    displayName: "Gemini 2.5 Pro Experimental 0325",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "hermes-medium",
                    displayName: "Hermes Medium",
                    shortDescription: "204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "sonar-pro",
                    displayName: "Perplexity Pro",
                    shortDescription: "200K context"
                ),
                AIScriptModelPreset(
                    id: "doubao-1-5-thinking-pro-250415",
                    displayName: "Doubao 1.5 Thinking Pro",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-max:thinking",
                    displayName: "Qwen3.7 Max Thinking",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "ernie-4.5-turbo-vl-32k",
                    displayName: "Ernie 4.5 Turbo VL 32k",
                    shortDescription: "32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro-preview-05-06",
                    displayName: "Gemini 2.5 Pro Preview 0506",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "hunyuan-turbos-20250226",
                    displayName: "Hunyuan Turbo S",
                    shortDescription: "24K context"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-thinking:64000",
                    displayName: "Claude 4 Sonnet Thinking (64K)",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "ernie-x1-32k",
                    displayName: "Ernie X1 32k",
                    shortDescription: "32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "command-a-reasoning-08-2025",
                    displayName: "Cohere Command A (08/2025)",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-2-0-code-preview-260215",
                    displayName: "Doubao Seed 2.0 Code Preview",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "doubao-1.5-pro-256k",
                    displayName: "Doubao 1.5 Pro 256k",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-35b-a3b",
                    displayName: "Qwen3.5 35B A3B",
                    shortDescription: "260K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-122b-a10b:thinking",
                    displayName: "Qwen3.5 122B A10B Thinking",
                    shortDescription: "260K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "yi-lightning",
                    displayName: "Yi Lightning",
                    shortDescription: "12K context"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-5-20250929",
                    displayName: "Claude Sonnet 4.5",
                    shortDescription: "1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-math-v2",
                    displayName: "DeepSeek Math V2",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1-thinking:8192",
                    displayName: "Claude 4.1 Opus Thinking (8K)",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-reasoner",
                    displayName: "DeepSeek Reasoner",
                    shortDescription: "64K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-nothinking",
                    displayName: "Gemini 2.5 Flash (No Thinking)",
                    shortDescription: "1.04876M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Omega-Evolution-v2.0-Derestricted-Lite",
                    displayName: "Qwen3.5 27B Omega Evolution v2.0 Derestricted Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "fastgpt",
                    displayName: "Web Answer",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Infracelestial",
                    displayName: "Qwen3.5 27B Infracelestial",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4-flash",
                    displayName: "GLM-4 Flash",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "azure-gpt-4o-mini",
                    displayName: "Azure gpt-4o-mini",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "sonar-deep-research",
                    displayName: "Perplexity Deep Research",
                    shortDescription: "60K context"
                ),
                AIScriptModelPreset(
                    id: "qwq-32b",
                    displayName: "Qwen: QwQ 32B",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-code-agent-latest",
                    displayName: "Mistral Code Agent Latest",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "glm-4.1v-thinking-flash",
                    displayName: "GLM 4.1V Thinking Flash",
                    shortDescription: "64K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-omni-flash",
                    displayName: "Qwen3.5 Omni Flash",
                    shortDescription: "49K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-31B-MeroMero",
                    displayName: "Gemma 4 31B MeroMero",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-preview-04-17:thinking",
                    displayName: "Gemini 2.5 Flash Preview Thinking",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4-air",
                    displayName: "GLM-4 Air",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-1-6-thinking-250615",
                    displayName: "Doubao Seed 1.6 Thinking",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "auto-model-basic",
                    displayName: "Auto model (Basic)",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-RpRMax-v1",
                    displayName: "Qwen3.5 27B RpRMax v1",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "ernie-5.1",
                    displayName: "ERNIE 5.1",
                    shortDescription: "119K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Marvin-DPO-V2-Derestricted",
                    displayName: "Qwen3.5 27B Marvin DPO V2 Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "azure-gpt-4o",
                    displayName: "Azure gpt-4o",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-chat",
                    displayName: "DeepSeek V3/Deepseek Chat",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-preview-05-20",
                    displayName: "Gemini 2.5 Flash 0520",
                    shortDescription: "1.048M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mercury-2",
                    displayName: "Mercury 2",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-plus:thinking",
                    displayName: "Qwen3.7 Plus Thinking",
                    shortDescription: "983K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.0-flash-thinking-exp-1219",
                    displayName: "Gemini 2.0 Flash Thinking 1219",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "glm-4-plus-0111",
                    displayName: "GLM 4 Plus 0111",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "brave",
                    displayName: "Brave (Answers)",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "glm-zero-preview",
                    displayName: "GLM Zero Preview",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-lite-preview-06-17",
                    displayName: "Gemini 2.5 Flash Lite Preview",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Writer-Derestricted",
                    displayName: "Qwen3.5 27B Writer Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "KAT-Coder-Exp-72B-1010",
                    displayName: "KAT Coder Exp 72B 1010",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro-preview-06-05",
                    displayName: "Gemini 2.5 Pro Preview 0605",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Musica-v1",
                    displayName: "Qwen3.5 27B Musica v1",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M1",
                    displayName: "MiniMax M1",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "doubao-1-5-thinking-pro-vision-250415",
                    displayName: "Doubao 1.5 Thinking Pro Vision",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-27b:thinking",
                    displayName: "Qwen3.5 27B Thinking",
                    shortDescription: "260K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Omega-Evolution-v2.0-Derestricted",
                    displayName: "Qwen3.5 27B Omega Evolution v2.0 Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Gemma-4-31B-GarnetV2",
                    displayName: "Gemma 4 31B Garnet V2",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen-turbo",
                    displayName: "Qwen Turbo",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "phi-4-multimodal-instruct",
                    displayName: "Phi 4 Multimodal",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-small-31-24b-instruct",
                    displayName: "Mistral Small 31 24b Instruct",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "ernie-4.5-turbo-128k",
                    displayName: "Ernie 4.5 Turbo 128k",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-BlueStar-Derestricted",
                    displayName: "Qwen3.5 27B BlueStar Derestricted",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-lite-preview-09-2025-thinking",
                    displayName: "Gemini 2.5 Flash Lite Preview (09/2025) \u{2013} Thinking",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-1-8-251215",
                    displayName: "Doubao Seed 1.8",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-max-preview",
                    displayName: "Qwen3.6 Max Preview",
                    shortDescription: "qwen3.6 \u{B7} 245K context"
                ),
                AIScriptModelPreset(
                    id: "exa-answer",
                    displayName: "Exa (Answer)",
                    shortDescription: "4K context"
                ),
                AIScriptModelPreset(
                    id: "Baichuan4-Air",
                    displayName: "Baichuan 4 Air",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-122b-a10b",
                    displayName: "Qwen3.5 122B A10B",
                    shortDescription: "260K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "sarvam-30b",
                    displayName: "Sarvam 30B",
                    shortDescription: "65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1-thinking",
                    displayName: "Claude 4.1 Opus Thinking",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-thinking:32000",
                    displayName: "Claude 4 Opus Thinking (32K)",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "auto-model",
                    displayName: "Auto model",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-235b-a22b-instruct-original",
                    displayName: "Qwen3 VL 235B A22B Instruct Original",
                    shortDescription: "32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-z1-air",
                    displayName: "GLM Z1 Air",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-27B-Queen-Derestricted-Lite",
                    displayName: "Qwen3.5 27B Queen Derestricted Lite",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "inclusionai/ling-2.6-1t",
                    displayName: "Ling 2.6 1T",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "inclusionai/ring-2.6-1t",
                    displayName: "Ring 2.6 1T",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "inclusionai/ling-2.6-flash",
                    displayName: "Ling 2.6 Flash",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "Alibaba-NLP/Tongyi-DeepResearch-30B-A3B",
                    displayName: "Tongyi DeepResearch 30B A3B",
                    shortDescription: "yi \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "ibm-granite/granite-4.1-8b",
                    displayName: "Granite 4.1 8B",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "Salesforce/Llama-xLAM-2-70b-fc-r",
                    displayName: "Llama-xLAM-2 70B fc-r",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "THUDM/GLM-Z1-32B-0414",
                    displayName: "GLM Z1 32B 0414",
                    shortDescription: "glm-z \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "THUDM/GLM-4-32B-0414",
                    displayName: "GLM 4 32B 0414",
                    shortDescription: "glm \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "THUDM/GLM-4-9B-0414",
                    displayName: "GLM 4 9B 0414",
                    shortDescription: "glm \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "THUDM/GLM-Z1-9B-0414",
                    displayName: "GLM Z1 9B 0414",
                    shortDescription: "glm-z \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.1-8b-instruct",
                    displayName: "Llama 3.1 8b Instruct",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-4-maverick",
                    displayName: "Llama 4 Maverick",
                    shortDescription: "llama \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.3-70b-instruct",
                    displayName: "Llama 3.3 70b Instruct",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-4-scout",
                    displayName: "Llama 4 Scout",
                    shortDescription: "llama \u{B7} 328K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.2-3b-instruct",
                    displayName: "Llama 3.2 3b Instruct",
                    shortDescription: "llama \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "featherless-ai/Qwerky-72B",
                    displayName: "Qwerky 72B",
                    shortDescription: "qwerky \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-instruct-0711",
                    displayName: "Kimi K2 0711",
                    shortDescription: "kimi-k2 \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2-Instruct-0905",
                    displayName: "Kimi K2 0905",
                    shortDescription: "kimi-k2 \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-thinking-original",
                    displayName: "Kimi K2 Thinking Original",
                    shortDescription: "kimi-thinking \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.5:thinking",
                    displayName: "Kimi K2.5 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-instruct",
                    displayName: "Kimi K2 Instruct",
                    shortDescription: "kimi-k2 \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.6:thinking",
                    displayName: "Kimi K2.6 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-latest",
                    displayName: "Kimi Latest",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-thinking-turbo-original",
                    displayName: "Kimi K2 Thinking Turbo Original",
                    shortDescription: "kimi-thinking \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-vl-28b-a3b",
                    displayName: "ERNIE 4.5 VL 28B",
                    shortDescription: "ernie \u{B7} 32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "perceptron/perceptron-mk1",
                    displayName: "Perceptron Mk1",
                    shortDescription: "32K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "failspy/Meta-Llama-3-70B-Instruct-abliterated-v3.5",
                    displayName: "Llama 3 70B abliterated",
                    shortDescription: "llama \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "nanogpt/coding-router:max",
                    displayName: "Coding Router Max",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nanogpt/coding-router:high",
                    displayName: "Coding Router High",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nanogpt/coding-router:low",
                    displayName: "Coding Router Low",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nanogpt/coding-router:medium",
                    displayName: "Coding Router Medium",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nanogpt/coding-router",
                    displayName: "Coding Router",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "GalrionSoftworks/MN-LooseCannon-12B-v1",
                    displayName: "MN-LooseCannon-12B-v1",
                    shortDescription: "mistral-nemo \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "TheDrummer/Cydonia-24B-v4.3",
                    displayName: "The Drummer Cydonia 24B v4.3",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "TheDrummer/Cydonia-24B-v4.1",
                    displayName: "The Drummer Cydonia 24B v4.1",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "TheDrummer/Cydonia-24B-v2",
                    displayName: "The Drummer Cydonia 24B v2",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "TheDrummer/Anubis-70B-v1.1",
                    displayName: "Anubis 70B v1.1",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "TheDrummer/UnslopNemo-12B-v4.1",
                    displayName: "UnslopNemo 12b v4",
                    shortDescription: "32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "TheDrummer/skyfall-36b-v2",
                    displayName: "TheDrummer Skyfall 36B V2",
                    shortDescription: "64K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "TheDrummer/Rocinante-12B-v1.1",
                    displayName: "Rocinante 12b",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "TheDrummer/Magidonia-24B-v4.3",
                    displayName: "The Drummer Magidonia 24B v4.3",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "TheDrummer/Cydonia-24B-v4",
                    displayName: "The Drummer Cydonia 24B v4",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "TheDrummer/Skyfall-31B-v4.2",
                    displayName: "TheDrummer Skyfall 31B v4.2",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "TheDrummer/Anubis-70B-v1",
                    displayName: "Anubis 70B v1",
                    shortDescription: "65K context"
                ),
                AIScriptModelPreset(
                    id: "huihui-ai/Qwen2.5-32B-Instruct-abliterated",
                    displayName: "Qwen 2.5 32B Abliterated",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "huihui-ai/Llama-3.3-70B-Instruct-abliterated",
                    displayName: "Llama 3.3 70B Instruct abliterated",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "huihui-ai/DeepSeek-R1-Distill-Qwen-32B-abliterated",
                    displayName: "DeepSeek R1 Qwen Abliterated",
                    shortDescription: "qwen \u{B7} 16K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "huihui-ai/DeepSeek-R1-Distill-Llama-70B-abliterated",
                    displayName: "DeepSeek R1 Llama 70B Abliterated",
                    shortDescription: "deepseek \u{B7} 16K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Envoid/Llama-3.05-NT-Storybreaker-Ministral-70B",
                    displayName: "Llama 3.05 Storybreaker Ministral 70b",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "Envoid/Llama-3.05-Nemotron-Tenyxchat-Storybreaker-70B",
                    displayName: "Nemotron Tenyxchat Storybreaker 70b",
                    shortDescription: "nemotron \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "stepfun-ai/step-3.5-flash-2603",
                    displayName: "Step 3.5 Flash 2603",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "stepfun-ai/step-3.5-flash",
                    displayName: "Step 3.5 Flash",
                    shortDescription: "step \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral/mistral-medium-3.5",
                    displayName: "Mistral Medium 3.5",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistral/mistral-medium-3.5:thinking",
                    displayName: "Mistral Medium 3.5 Thinking",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Tongyi-Zhiwen/QwenLong-L1-32B",
                    displayName: "QwenLong L1 32B",
                    shortDescription: "qwen \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-flash-1.5",
                    displayName: "Gemini 1.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 2M context"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro-preview-high",
                    displayName: "Gemini 3.1 Pro (Preview High)",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-flash-lite",
                    displayName: "Gemini 3.1 Flash Lite",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-flash-preview-thinking",
                    displayName: "Gemini 3 Flash Thinking",
                    shortDescription: "gemini-flash \u{B7} 1.04876M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.5-flash",
                    displayName: "Gemini 3.5 Flash",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31b-it",
                    displayName: "Gemma 4 31B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-pro-latest",
                    displayName: "Gemini Pro Latest",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro-preview-customtools",
                    displayName: "Gemini 3.1 Pro (Preview Custom Tools)",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-flash-lite-latest",
                    displayName: "Gemini Flash Lite Latest",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-26b-a4b-it:thinking",
                    displayName: "Gemma 4 26B A4B Thinking",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro-preview",
                    displayName: "Gemini 3.1 Pro (Preview)",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-26b-a4b-it",
                    displayName: "Gemma 4 26B A4B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro-preview-low",
                    displayName: "Gemini 3.1 Pro (Preview Low)",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31b-it:thinking",
                    displayName: "Gemma 4 31B Thinking",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.5-flash-thinking",
                    displayName: "Gemini 3.5 Flash Thinking",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-flash-preview",
                    displayName: "Gemini 3 Flash (Preview)",
                    shortDescription: "gemini-flash \u{B7} 1.04876M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-flash-latest",
                    displayName: "Gemini Flash Latest",
                    shortDescription: "1.04876M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "liquid/lfm-2-24b-a2b",
                    displayName: "LFM2 24B A2B",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.20",
                    displayName: "Grok 4.20",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.3",
                    displayName: "Grok 4.3",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.20-multi-agent",
                    displayName: "Grok 4.20 Multi-Agent",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-latest",
                    displayName: "Grok Latest",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-build-0.1",
                    displayName: "Grok Build 0.1",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "EVA-UNIT-01/EVA-LLaMA-3.33-70B-v0.0",
                    displayName: "EVA Llama 3.33 70B",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "EVA-UNIT-01/EVA-Qwen2.5-72B-v0.2",
                    displayName: "EVA-Qwen2.5-72B-v0.2",
                    shortDescription: "qwen \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "EVA-UNIT-01/EVA-LLaMA-3.33-70B-v0.1",
                    displayName: "EVA-LLaMA-3.33-70B-v0.1",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "EVA-UNIT-01/EVA-Qwen2.5-32B-v0.2",
                    displayName: "EVA-Qwen2.5-32B-v0.2",
                    shortDescription: "qwen \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "microsoft/wizardlm-2-8x22b",
                    displayName: "WizardLM-2 8x22B",
                    shortDescription: "gpt \u{B7} 65K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Doctor-Shotgun/MS3.2-24B-Magnum-Diamond",
                    displayName: "MS3.2 24B Magnum Diamond",
                    shortDescription: "mistral \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "poolside/laguna-xs.2",
                    displayName: "Laguna XS.2",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "poolside/laguna-m.1",
                    displayName: "Laguna M.1",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.5v:thinking",
                    displayName: "GLM 4.5V Thinking",
                    shortDescription: "glmv \u{B7} 64K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.6:thinking",
                    displayName: "GLM 4.6 Thinking",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.5v",
                    displayName: "GLM 4.5V",
                    shortDescription: "glmv \u{B7} 64K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.6",
                    displayName: "GLM 4.6",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5v-turbo:thinking",
                    displayName: "GLM 5V Turbo Thinking",
                    shortDescription: "202K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5v-turbo",
                    displayName: "GLM 5V Turbo",
                    shortDescription: "202K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5-turbo",
                    displayName: "GLM 5 Turbo",
                    shortDescription: "202K context"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-mini-low",
                    displayName: "OpenAI o3-mini (Low)",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-safeguard-20b",
                    displayName: "GPT OSS Safeguard 20B",
                    shortDescription: "gpt-oss \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o3",
                    displayName: "OpenAI o3",
                    shortDescription: "o \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini-high",
                    displayName: "OpenAI o4-mini high",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-pro-2025-06-10",
                    displayName: "OpenAI o3-pro (2025-06-10)",
                    shortDescription: "o-pro \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-pro",
                    displayName: "GPT 5.2 Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini-search-preview",
                    displayName: "GPT-4o mini Search Preview",
                    shortDescription: "gpt-mini \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5",
                    displayName: "GPT 5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo",
                    displayName: "GPT-3.5 Turbo",
                    shortDescription: "gpt \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-pro",
                    displayName: "GPT 5 Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o",
                    displayName: "GPT-4o",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini",
                    displayName: "OpenAI o4-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-nano",
                    displayName: "GPT 5.4 Nano",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex",
                    displayName: "GPT 5.1 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-max",
                    displayName: "GPT 5.1 Codex Max",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-2024-08-06",
                    displayName: "GPT-4o (2024-08-06)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o1-preview",
                    displayName: "OpenAI o1-preview",
                    shortDescription: "o \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-mini",
                    displayName: "OpenAI o3-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2",
                    displayName: "GPT 5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-codex",
                    displayName: "GPT 5.3 Codex",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-latest",
                    displayName: "GPT Latest",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-mini",
                    displayName: "GPT 5.1 Codex Mini",
                    shortDescription: "gpt-codex-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini-deep-research",
                    displayName: "OpenAI o4-mini Deep Research",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-nano",
                    displayName: "GPT 4.1 Nano",
                    shortDescription: "gpt-nano \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-2024-11-20",
                    displayName: "GPT-4o (2024-11-20)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o1",
                    displayName: "OpenAI o1",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o1-pro",
                    displayName: "OpenAI o1 Pro",
                    shortDescription: "o-pro \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-chat-latest",
                    displayName: "GPT Chat Latest",
                    shortDescription: "400K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4",
                    displayName: "GPT 5.4",
                    shortDescription: "922K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-mini",
                    displayName: "GPT 5.4 Mini",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1",
                    displayName: "GPT 4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-deep-research",
                    displayName: "OpenAI o3 Deep Research",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4-turbo-preview",
                    displayName: "GPT-4 Turbo Preview",
                    shortDescription: "gpt \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-mini",
                    displayName: "GPT 5 Mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-mini",
                    displayName: "GPT 4.1 Mini",
                    shortDescription: "gpt-mini \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4-turbo",
                    displayName: "GPT-4 Turbo",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-nano",
                    displayName: "GPT 5 Nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-pro",
                    displayName: "GPT 5.4 Pro",
                    shortDescription: "922K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-mini-high",
                    displayName: "OpenAI o3-mini (High)",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-search-preview",
                    displayName: "GPT-4o Search Preview",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-2025-11-13",
                    displayName: "GPT-5.1 (2025-11-13)",
                    shortDescription: "gpt \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini",
                    displayName: "GPT-4o mini",
                    shortDescription: "gpt-mini \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "GPT OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-codex",
                    displayName: "GPT-5 Codex",
                    shortDescription: "gpt-codex \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-codex",
                    displayName: "GPT 5.2 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1",
                    displayName: "GPT 5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5",
                    displayName: "GPT 5.5",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Gryphe/MythoMax-L2-13b",
                    displayName: "MythoMax 13B",
                    shortDescription: "llama \u{B7} 4K context"
                ),
                AIScriptModelPreset(
                    id: "Unbabel/M-Prometheus-14B",
                    displayName: "M-Prometheus 14B",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "LLM360/K2-Think",
                    displayName: "K2-Think",
                    shortDescription: "kimi-thinking \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "NousResearch/hermes-4-405b",
                    displayName: "Hermes 4 Large",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "NousResearch/hermes-3-llama-3.1-70b",
                    displayName: "Hermes 3 70B",
                    shortDescription: "65K context"
                ),
                AIScriptModelPreset(
                    id: "NousResearch/Hermes-4-70B:thinking",
                    displayName: "Hermes 4 (Thinking)",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "NousResearch/hermes-4-70b",
                    displayName: "Hermes 4 Medium",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "NousResearch/DeepHermes-3-Mistral-24B-Preview",
                    displayName: "DeepHermes-3 Mistral 24B (Preview)",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "NousResearch/hermes-4-405b:thinking",
                    displayName: "Hermes 4 Large (Thinking)",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "unsloth/gemma-3-12b-it",
                    displayName: "Gemma 3 12B IT",
                    shortDescription: "unsloth \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "unsloth/gemma-3-4b-it",
                    displayName: "Gemma 3 4B IT",
                    shortDescription: "unsloth \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "unsloth/gemma-3-27b-it",
                    displayName: "Gemma 3 27B IT",
                    shortDescription: "unsloth \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "NeverSleep/Lumimaid-v0.2-70B",
                    displayName: "Lumimaid v0.2",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mixtral-8x7b-instruct-v0.1",
                    displayName: "Mixtral 8x7B",
                    shortDescription: "mixtral \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-small-4-119b-2603:thinking",
                    displayName: "Mistral Small 4 119B Thinking",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mixtral-8x22b-instruct-v0.1",
                    displayName: "Mixtral 8x22B",
                    shortDescription: "mixtral \u{B7} 65K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/Devstral-Small-2505",
                    displayName: "Mistral Devstral Small 2505",
                    shortDescription: "devstral \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/ministral-8b-2512",
                    displayName: "Ministral 8B",
                    shortDescription: "ministral \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-saba",
                    displayName: "Mistral Saba",
                    shortDescription: "mistral \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-large",
                    displayName: "Mistral Large 2411",
                    shortDescription: "mistral-large \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-medium-3.1",
                    displayName: "Mistral Medium 3.1",
                    shortDescription: "mistral-medium \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/ministral-3b-2512",
                    displayName: "Ministral 3B",
                    shortDescription: "ministral \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/ministral-14b-instruct-2512",
                    displayName: "Ministral 3 14B",
                    shortDescription: "ministral \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-small-4-119b-2603",
                    displayName: "Mistral Small 4 119B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/ministral-14b-2512",
                    displayName: "Ministral 14B",
                    shortDescription: "ministral \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-large-3-675b-instruct-2512",
                    displayName: "Mistral Large 3 675B",
                    shortDescription: "mistral-large \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-medium-3",
                    displayName: "Mistral Medium 3",
                    shortDescription: "mistral-medium \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/devstral-2-123b-instruct-2512",
                    displayName: "Devstral 2 123B",
                    shortDescription: "devstral \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/codestral-2508",
                    displayName: "Codestral 2508",
                    shortDescription: "codestral \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/Mistral-Nemo-Instruct-2407",
                    displayName: "Mistral Nemo",
                    shortDescription: "mistral-nemo \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "bytedance-seed/seed-2.0-lite",
                    displayName: "ByteDance Seed 2.0 Lite",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "anthracite-org/magnum-v2-72b",
                    displayName: "Magnum V2 72B",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "anthracite-org/magnum-v4-72b",
                    displayName: "Magnum v4 72B",
                    shortDescription: "llama \u{B7} 16K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "inflatebot/MN-12B-Mag-Mell-R1",
                    displayName: "Mag Mell R1",
                    shortDescription: "mistral-nemo \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-nano-omni-30b-a3b-reasoning",
                    displayName: "Nvidia Nemotron 3 Nano Omni",
                    shortDescription: "nemotron \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/Llama-3.1-Nemotron-70B-Instruct-HF",
                    displayName: "Nvidia Nemotron 70b",
                    shortDescription: "nemotron \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nvidia-nemotron-nano-9b-v2",
                    displayName: "Nvidia Nemotron Nano 9B v2",
                    shortDescription: "nemotron \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/Llama-3_3-Nemotron-Super-49B-v1_5",
                    displayName: "Nvidia Nemotron Super 49B v1.5",
                    shortDescription: "nemotron \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-nano-30b-a3b",
                    displayName: "Nvidia Nemotron 3 Nano 30B",
                    shortDescription: "nemotron \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/Llama-3.3-Nemotron-Super-49B-v1",
                    displayName: "Nvidia Nemotron Super 49B",
                    shortDescription: "nemotron \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-super-120b-a12b:thinking",
                    displayName: "Nvidia Nemotron 3 Super 120B Thinking",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-super-120b-a12b",
                    displayName: "Nvidia Nemotron 3 Super 120B",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "cognitivecomputations/dolphin-2.9.2-qwen2-72b",
                    displayName: "Dolphin 72b",
                    shortDescription: "qwen \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-flash-original",
                    displayName: "MiMo V2 Flash Original",
                    shortDescription: "mimo \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-flash-thinking-original",
                    displayName: "MiMo V2 Flash (Thinking) Original",
                    shortDescription: "mimo \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2.5",
                    displayName: "MiMo V2.5",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-omni",
                    displayName: "MiMo V2 Omni",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-flash",
                    displayName: "MiMo V2 Flash",
                    shortDescription: "mimo \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-pro",
                    displayName: "MiMo V2 Pro",
                    shortDescription: "1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2.5-pro",
                    displayName: "MiMo V2.5 Pro",
                    shortDescription: "1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-flash-thinking",
                    displayName: "MiMo V2 Flash (Thinking)",
                    shortDescription: "mimo \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-haiku-latest",
                    displayName: "Claude Haiku Latest",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.7:thinking",
                    displayName: "Claude 4.7 Opus Thinking",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6:thinking:max",
                    displayName: "Claude 4.6 Opus Thinking Max",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6:thinking:low",
                    displayName: "Claude 4.6 Opus Thinking Low",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.6:thinking",
                    displayName: "Claude Sonnet 4.6 Thinking",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.7",
                    displayName: "Claude 4.7 Opus",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6:thinking:medium",
                    displayName: "Claude 4.6 Opus Thinking Medium",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.8:thinking",
                    displayName: "Claude Opus 4.8 Thinking",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-latest",
                    displayName: "Claude Sonnet Latest",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.8",
                    displayName: "Claude Opus 4.8",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-latest",
                    displayName: "Claude Opus Latest",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6:thinking",
                    displayName: "Claude 4.6 Opus Thinking",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6",
                    displayName: "Claude 4.6 Opus",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "tencent/Hunyuan-MT-7B",
                    displayName: "Hunyuan MT 7B",
                    shortDescription: "hunyuan \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "tencent/hy3-preview",
                    displayName: "Tencent: Hy3 preview",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "chutesai/Mistral-Small-3.2-24B-Instruct-2506",
                    displayName: "Mistral Small 3.2 24b Instruct",
                    shortDescription: "chutesai \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "dmind/dmind-1-mini",
                    displayName: "DMind-1-Mini",
                    shortDescription: "gpt \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "dmind/dmind-1",
                    displayName: "DMind-1",
                    shortDescription: "gpt \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "MarinaraSpaghetti/NemoMix-Unleashed-12B",
                    displayName: "NemoMix 12B Unleashed",
                    shortDescription: "mistral-nemo \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "deepcogito/cogito-v1-preview-qwen-32B",
                    displayName: "Cogito v1 Preview Qwen 32B",
                    shortDescription: "qwen \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "cohere/command-r",
                    displayName: "Cohere: Command R",
                    shortDescription: "command-r \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "cohere/command-r-plus-08-2024",
                    displayName: "Cohere: Command R+",
                    shortDescription: "command-r \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "stepfun/step-3.7-flash:thinking",
                    displayName: "Step 3.7 Flash Thinking",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "nex-agi/deepseek-v3.1-nex-n1",
                    displayName: "DeepSeek V3.1 Nex N1",
                    shortDescription: "deepseek \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "undi95/remm-slerp-l2-13b",
                    displayName: "ReMM SLERP 13B",
                    shortDescription: "llama \u{B7} 6K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "nothingiisreal/L3.1-70B-Celeste-V0.1-BF16",
                    displayName: "Llama 3.1 70B Celeste v0.1",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7-flash-original:thinking",
                    displayName: "GLM 4.7 Flash Original Thinking",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7",
                    displayName: "GLM 4.7",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.5-Air:thinking",
                    displayName: "GLM 4.5 Air (Thinking)",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.5:thinking",
                    displayName: "GLM 4.5 (Thinking)",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.5",
                    displayName: "GLM 4.5",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-5-original",
                    displayName: "GLM 5 Original",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-5.1",
                    displayName: "GLM 5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7-original",
                    displayName: "GLM 4.7 Original",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7-original:thinking",
                    displayName: "GLM 4.7 Original Thinking",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7-flash-original",
                    displayName: "GLM 4.7 Flash Original",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7:thinking",
                    displayName: "GLM 4.7 Thinking",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-5.1:thinking",
                    displayName: "GLM 5.1 Thinking",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-5:thinking",
                    displayName: "GLM 5 Thinking",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.6v",
                    displayName: "GLM 4.6V",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.6-original",
                    displayName: "GLM 4.6 Original",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-5-original:thinking",
                    displayName: "GLM 5 Original Thinking",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7-flash:thinking",
                    displayName: "GLM 4.7 Flash Thinking",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.6v-flash-original",
                    displayName: "GLM 4.6V Flash",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.6v-original",
                    displayName: "GLM 4.6V Original",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-latest",
                    displayName: "GLM Latest",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7-flash",
                    displayName: "GLM 4.7 Flash",
                    shortDescription: "glm-flash \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.6-turbo:thinking",
                    displayName: "GLM 4.6 Turbo (Thinking)",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.5-Air",
                    displayName: "GLM 4.5 Air",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.6-turbo",
                    displayName: "GLM 4.6 Turbo",
                    shortDescription: "200K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-5",
                    displayName: "GLM 5",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Infermatic/MN-12B-Inferor-v0.0",
                    displayName: "Mistral Nemo Inferor 12B",
                    shortDescription: "mistral-nemo \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "shisa-ai/shisa-v2.1-llama3.3-70b",
                    displayName: "Shisa V2.1 Llama 3.3 70B",
                    shortDescription: "llama \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "shisa-ai/shisa-v2-llama3.3-70b",
                    displayName: "Shisa V2 Llama 3.3 70B",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "abacusai/Dracarys-72B-Instruct",
                    displayName: "Llama 3.1 70B Dracarys 2",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1:thinking",
                    displayName: "DeepSeek V3.1 Thinking",
                    shortDescription: "deepseek-thinking \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1-Terminus",
                    displayName: "DeepSeek V3.1 Terminus",
                    shortDescription: "deepseek \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/deepseek-v3.2-exp-thinking",
                    displayName: "DeepSeek V3.2 Exp Thinking",
                    shortDescription: "deepseek-thinking \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1-0528",
                    displayName: "DeepSeek R1 0528",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/deepseek-v3.2-exp",
                    displayName: "DeepSeek V3.2 Exp",
                    shortDescription: "deepseek \u{B7} 163K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1-Terminus:thinking",
                    displayName: "DeepSeek V3.1 Terminus (Thinking)",
                    shortDescription: "deepseek-thinking \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "arcee-ai/trinity-large-thinking",
                    displayName: "Trinity Large Thinking",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "arcee-ai/trinity-mini",
                    displayName: "Trinity Mini",
                    shortDescription: "trinity-mini \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "soob3123/GrayLine-Qwen3-8B",
                    displayName: "Grayline Qwen3 8B",
                    shortDescription: "qwen \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "soob3123/Veiled-Calla-12B",
                    displayName: "Veiled Calla 12B",
                    shortDescription: "llama \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "soob3123/amoral-gemma3-27B-v2",
                    displayName: "Amoral Gemma3 27B v2",
                    shortDescription: "gemma \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "meganova-ai/manta-mini-1.0",
                    displayName: "Manta Mini 1.0",
                    shortDescription: "nova \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "meganova-ai/manta-flash-1.0",
                    displayName: "Manta Flash 1.0",
                    shortDescription: "nova \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "meganova-ai/manta-pro-1.0",
                    displayName: "Manta Pro 1.0",
                    shortDescription: "nova \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/Qwen3.6-35B-A3B:thinking",
                    displayName: "Qwen3.6 35B A3B Thinking",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-plus",
                    displayName: "Qwen3 Coder Plus",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/Qwen3.6-35B-A3B",
                    displayName: "Qwen3.6 35B A3B",
                    shortDescription: "262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-32b",
                    displayName: "Qwen 3 32b",
                    shortDescription: "41K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/Qwen3-VL-235B-A22B-Instruct",
                    displayName: "Qwen3 VL 235B A22B Instruct",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-max",
                    displayName: "Qwen3 Max",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-397b-a17b-thinking",
                    displayName: "Qwen3.5 397B A17B Thinking",
                    shortDescription: "258K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/Qwen3-Next-80B-A3B-Instruct",
                    displayName: "Qwen3 Next 80B A3B (Instruct)",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/Qwen3-235B-A22B-Instruct-2507-TEE",
                    displayName: "Qwen 3 235b A22B 2507 (TEE)",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwq-32b-preview",
                    displayName: "Qwen QwQ 32B Preview",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-next-80b-a3b-thinking",
                    displayName: "Qwen3 Next 80B A3B (Thinking)",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder",
                    displayName: "Qwen 3 Coder 480B",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/Qwen3-235B-A22B-Thinking-2507",
                    displayName: "Qwen 3 235b A22B 2507 Thinking",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-plus",
                    displayName: "Qwen3.5 Plus",
                    shortDescription: "983K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-plus-thinking",
                    displayName: "Qwen3.5 Plus Thinking",
                    shortDescription: "983K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b",
                    displayName: "Qwen 3 235b A22B",
                    shortDescription: "41K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-2.5-72b-instruct",
                    displayName: "Qwen2.5 72B",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-next",
                    displayName: "Qwen3 Coder Next",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-9b",
                    displayName: "Qwen3.5 9B",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-397b-a17b",
                    displayName: "Qwen3.5 397B A17B",
                    shortDescription: "qwen \u{B7} 258K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-flash",
                    displayName: "Qwen3 Coder Flash",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/Qwen2.5-Coder-32B-Instruct",
                    displayName: "Qwen 2.5 Coder 32b",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/Qwen3-8B",
                    displayName: "Qwen 3 8B",
                    shortDescription: "41K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-14b",
                    displayName: "Qwen 3 14b",
                    shortDescription: "41K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/Qwen3-235B-A22B-Instruct-2507",
                    displayName: "Qwen 3 235b A22B 2507",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-30b-a3b",
                    displayName: "Qwen3 30B A3B",
                    shortDescription: "41K context"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-lite-v1",
                    displayName: "Amazon Nova Lite 1.0",
                    shortDescription: "nova-lite \u{B7} 300K context"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-pro-v1",
                    displayName: "Amazon Nova Pro 1.0",
                    shortDescription: "nova-pro \u{B7} 300K context"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-micro-v1",
                    displayName: "Amazon Nova Micro 1.0",
                    shortDescription: "nova-micro \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-2-lite-v1",
                    displayName: "Amazon Nova 2 Lite",
                    shortDescription: "nova \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "alibaba/qwen3.6-flash",
                    displayName: "Qwen3.6 Flash",
                    shortDescription: "qwen3.6 \u{B7} 991K context"
                ),
                AIScriptModelPreset(
                    id: "alibaba/qwen3.6-27b",
                    displayName: "Qwen3.6 27B",
                    shortDescription: "260K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "alibaba/qwen3.6-27b:thinking",
                    displayName: "Qwen3.6 27B Thinking",
                    shortDescription: "260K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-rp-llama-3.1-8b",
                    displayName: "Llama 3.1 8b (uncensored)",
                    shortDescription: "llama \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-2.5",
                    displayName: "AionLabs: Aion-2.5",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-1.0-mini",
                    displayName: "Aion 1.0 mini (DeepSeek)",
                    shortDescription: "deepseek \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-2.0",
                    displayName: "AionLabs: Aion-2.0",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-1.0",
                    displayName: "Aion 1.0",
                    shortDescription: "llama \u{B7} 65K context"
                ),
                AIScriptModelPreset(
                    id: "pamanseau/OpenReasoning-Nemotron-32B",
                    displayName: "OpenReasoning Nemotron 32B",
                    shortDescription: "nemotron \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "LatitudeGames/Wayfarer-Large-70B-Llama-3.3",
                    displayName: "Llama 3.3 70B Wayfarer",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "baseten/Kimi-K2-Instruct-FP4",
                    displayName: "Kimi K2 0711 Instruct FP4",
                    shortDescription: "kimi-k2 \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "inflection/inflection-3-pi",
                    displayName: "Inflection 3 Pi",
                    shortDescription: "gpt \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "inflection/inflection-3-productivity",
                    displayName: "Inflection 3 Productivity",
                    shortDescription: "gpt \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "ReadyArt/MS3.2-The-Omega-Directive-24B-Unslop-v2.0",
                    displayName: "Omega Directive 24B Unslop v2.0",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M1-80k",
                    displayName: "MiniMax M1 80K",
                    shortDescription: "minimax \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "upstage/solar-pro-3",
                    displayName: "Solar Pro 3",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "allenai/olmo-3-32b-think",
                    displayName: "Olmo 3 32B Think",
                    shortDescription: "allenai \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "essentialai/rnj-1-instruct",
                    displayName: "RNJ-1 Instruct 8B",
                    shortDescription: "rnj \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-flash:thinking",
                    displayName: "DeepSeek V4 Flash (Thinking)",
                    shortDescription: "1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-pro-cheaper:thinking",
                    displayName: "DeepSeek V4 Pro Cheaper (Thinking)",
                    shortDescription: "1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-prover-v2-671b",
                    displayName: "DeepSeek Prover v2 671B",
                    shortDescription: "deepseek \u{B7} 160K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-latest",
                    displayName: "DeepSeek Latest",
                    shortDescription: "1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-pro:thinking",
                    displayName: "DeepSeek V4 Pro (Thinking)",
                    shortDescription: "1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2-speciale",
                    displayName: "DeepSeek V3.2 Speciale",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-pro-cheaper",
                    displayName: "DeepSeek V4 Pro Cheaper",
                    shortDescription: "1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2:thinking",
                    displayName: "DeepSeek V3.2 Thinking",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m3:thinking",
                    displayName: "MiniMax M3 Thinking",
                    shortDescription: "512K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.5",
                    displayName: "MiniMax M2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.1",
                    displayName: "MiniMax M2.1",
                    shortDescription: "minimax \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.7-turbo",
                    displayName: "MiniMax M2.7 Turbo",
                    shortDescription: "204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-01",
                    displayName: "MiniMax 01",
                    shortDescription: "minimax \u{B7} 1.00019M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m3",
                    displayName: "MiniMax M3",
                    shortDescription: "512K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2-her",
                    displayName: "MiniMax M2-her",
                    shortDescription: "minimax \u{B7} 65K context"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-latest",
                    displayName: "MiniMax Latest",
                    shortDescription: "512K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.7",
                    displayName: "MiniMax M2.7",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kwaipilot/kat-coder-pro-v2",
                    displayName: "KAT Coder Pro V2",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "mlabonne/NeuralDaredevil-8B-abliterated",
                    displayName: "Neural Daredevil 8B abliterated",
                    shortDescription: "llama \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "VongolaChouko/Starcannon-Unleashed-12B-v1.0",
                    displayName: "Mistral Nemo Starcannon 12b v1",
                    shortDescription: "mistral-nemo \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/minimax-m2.5",
                    displayName: "MiniMax M2.5 TEE",
                    shortDescription: "196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "TEE/glm-4.7",
                    displayName: "GLM 4.7 TEE",
                    shortDescription: "glm \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/llama3-3-70b",
                    displayName: "Llama 3.3 70B",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/gemma-4-31b-it",
                    displayName: "Gemma 4 31B IT TEE",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "TEE/qwen3-30b-a3b-instruct-2507",
                    displayName: "Qwen3 30B A3B Instruct 2507 TEE",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/glm-5.1",
                    displayName: "GLM 5.1 TEE",
                    shortDescription: "202K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro TEE",
                    shortDescription: "800K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "TEE/deepseek-v4-pro:thinking",
                    displayName: "DeepSeek V4 Pro Thinking TEE",
                    shortDescription: "800K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "TEE/gemma4-31b:thinking",
                    displayName: "Gemma 4 31B Thinking TEE",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "TEE/kimi-k2.5",
                    displayName: "Kimi K2.5 TEE",
                    shortDescription: "kimi-k2 \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/qwen2.5-vl-72b-instruct",
                    displayName: "Qwen2.5 VL 72B TEE",
                    shortDescription: "qwen \u{B7} 65K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "TEE/gpt-oss-120b",
                    displayName: "GPT-OSS 120B TEE",
                    shortDescription: "gpt-oss \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/qwen3.5-27b",
                    displayName: "Qwen3.5 27B TEE",
                    shortDescription: "262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "TEE/gemma-4-26b-a4b-uncensored",
                    displayName: "Gemma 4 26B A4B Uncensored TEE",
                    shortDescription: "65K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "TEE/deepseek-v3.1",
                    displayName: "DeepSeek V3.1 TEE",
                    shortDescription: "deepseek \u{B7} 164K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/kimi-k2.6",
                    displayName: "Kimi K2.6 TEE",
                    shortDescription: "262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "TEE/qwen3.5-397b-a17b",
                    displayName: "Qwen3.5 397B A17B TEE",
                    shortDescription: "qwen \u{B7} 258K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/kimi-k2.5-thinking",
                    displayName: "Kimi K2.5 Thinking TEE",
                    shortDescription: "kimi-thinking \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "TEE/qwen3.6-35b-a3b-uncensored",
                    displayName: "Qwen3.6 35B A3B Uncensored TEE",
                    shortDescription: "131K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "TEE/glm-4.7-flash",
                    displayName: "GLM 4.7 Flash TEE",
                    shortDescription: "glm-flash \u{B7} 203K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/gemma4-31b",
                    displayName: "Gemma 4 31B",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/gemma-3-27b-it",
                    displayName: "Gemma 3 27B TEE",
                    shortDescription: "gemma \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/gpt-oss-20b",
                    displayName: "GPT-OSS 20B TEE",
                    shortDescription: "gpt-oss \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/glm-5",
                    displayName: "GLM 5 TEE",
                    shortDescription: "glm \u{B7} 203K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/glm-5.1-thinking",
                    displayName: "GLM 5.1 Thinking TEE",
                    shortDescription: "202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "TEE/deepseek-v3.2",
                    displayName: "DeepSeek V3.2 TEE",
                    shortDescription: "deepseek \u{B7} 164K context"
                ),
                AIScriptModelPreset(
                    id: "TEE/qwen3.5-122b-a10b",
                    displayName: "Qwen3.5 122B A10B TEE",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Sao10K/L3.1-70B-Hanami-x1",
                    displayName: "Llama 3.1 70B Hanami",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "Sao10K/L3-8B-Stheno-v3.2",
                    displayName: "Sao10K Stheno 8b",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "Sao10K/L3.3-70B-Euryale-v2.3",
                    displayName: "Llama 3.3 70B Euryale",
                    shortDescription: "llama \u{B7} 20K context"
                ),
                AIScriptModelPreset(
                    id: "Sao10K/L3.1-70B-Euryale-v2.2",
                    displayName: "Llama 3.1 70B Euryale",
                    shortDescription: "llama \u{B7} 20K context"
                ),
                AIScriptModelPreset(
                    id: "Steelskull/L3.3-MS-Evalebis-70b",
                    displayName: "MS Evalebis 70b",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "Steelskull/L3.3-MS-Nevoria-70b",
                    displayName: "Steelskull Nevoria 70b",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "Steelskull/L3.3-Cu-Mai-R1-70b",
                    displayName: "Llama 3.3 70B Cu Mai",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "Steelskull/L3.3-MS-Evayale-70B",
                    displayName: "Evayale 70b",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "Steelskull/L3.3-Nevoria-R1-70b",
                    displayName: "Steelskull Nevoria R1 70b",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "Steelskull/L3.3-Electra-R1-70b",
                    displayName: "Steelskull Electra R1 70b",
                    shortDescription: "llama \u{B7} 16K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "nearai",
            displayName: "NEAR AI Cloud",
            shortDescription: "OpenAI-compatible \u{B7} 33 text models",
            baseURLString: "https://cloud-api.near.ai/v1",
            apiKeyLabel: "NEAR AI Cloud API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "google/gemini-3.1-flash-lite",
                    displayName: "Gemini 3.1 Flash Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31B-it",
                    displayName: "Gemma 4 31B IT",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.5-flash",
                    displayName: "Gemini 3.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-pro",
                    displayName: "Gemini 3 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash-lite",
                    displayName: "Gemini 2.5 Flash-Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.6-35B-A3B-FP8",
                    displayName: "Qwen 3.6 35B A3B FP8",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-122B-A10B",
                    displayName: "Qwen3.5 122B-A10B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-30B-A3B-Instruct-2507",
                    displayName: "Qwen3 30B-A3B Instruct 2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-30B-A3B-Instruct",
                    displayName: "Qwen3-VL 30B-A3B Instruct",
                    shortDescription: "qwen \u{B7} 256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o3",
                    displayName: "o3",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini",
                    displayName: "o4-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-nano",
                    displayName: "GPT-5.4 nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-mini",
                    displayName: "o3-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-nano",
                    displayName: "GPT-4.1 nano",
                    shortDescription: "gpt-nano \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT-OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-mini",
                    displayName: "GPT-5.4 mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-mini",
                    displayName: "GPT-5 Mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-mini",
                    displayName: "GPT-4.1 mini",
                    shortDescription: "gpt-mini \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-nano",
                    displayName: "GPT-5 Nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1",
                    displayName: "GPT-5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4-5",
                    displayName: "Claude Sonnet 4.5 (latest)",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4-7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-haiku-4-5",
                    displayName: "Claude Haiku 4.5 (latest)",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4-6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4-6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1-FP8",
                    displayName: "GLM-5.1 FP8",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "nebius",
            displayName: "Nebius Token Factory",
            shortDescription: "OpenAI-compatible \u{B7} 28 text models",
            baseURLString: "https://api.tokenfactory.nebius.com/v1",
            apiKeyLabel: "Nebius Token Factory API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.3-70B-Instruct",
                    displayName: "Llama-3.3-70B-Instruct",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.5-fast",
                    displayName: "Kimi-K2.5-fast",
                    shortDescription: "kimi-k2 \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.5",
                    displayName: "Kimi-K2.5",
                    shortDescription: "kimi-k2 \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3-27b-it",
                    displayName: "Gemma-3-27b-it",
                    shortDescription: "110K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Next-80B-A3B-Thinking-fast",
                    displayName: "Qwen3-Next-80B-A3B-Thinking-fast",
                    shortDescription: "8K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-VL-72B-Instruct",
                    displayName: "Qwen2.5-VL-72B-Instruct",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-397B-A17B",
                    displayName: "Qwen3.5-397B-A17B",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-397B-A17B-fast",
                    displayName: "Qwen3.5-397B-A17B-fast",
                    shortDescription: "8K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-30B-A3B-Instruct-2507",
                    displayName: "Qwen3-30B-A3B-Instruct-2507",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Next-80B-A3B-Thinking",
                    displayName: "Qwen3-Next-80B-A3B-Thinking",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Instruct-2507",
                    displayName: "Qwen3 235B A22B Instruct 2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-32B",
                    displayName: "Qwen3-32B",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Thinking-2507-fast",
                    displayName: "Qwen3-235B-A22B-Thinking-2507-fast",
                    shortDescription: "8K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b-fast",
                    displayName: "gpt-oss-120b-fast",
                    shortDescription: "8K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "gpt-oss-120b",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "NousResearch/Hermes-4-405B",
                    displayName: "Hermes-4-405B",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "NousResearch/Hermes-4-70B",
                    displayName: "Hermes-4-70B",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/NVIDIA-Nemotron-3-Nano-30B-A3B",
                    displayName: "Nemotron-3-Nano-30B-A3B",
                    shortDescription: "nemotron \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/Nemotron-3-Nano-Omni",
                    displayName: "Nemotron-3-Nano-Omni",
                    shortDescription: "nemotron \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/Llama-3_1-Nemotron-Ultra-253B-v1",
                    displayName: "Llama-3.1-Nemotron-Ultra-253B-v1",
                    shortDescription: "nemotron \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-super-120b-a12b",
                    displayName: "Nemotron-3-Super-120B-A12B",
                    shortDescription: "nemotron \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5",
                    displayName: "GLM-5",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.2-fast",
                    displayName: "DeepSeek-V3.2-fast",
                    shortDescription: "8K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V4-Pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.2",
                    displayName: "DeepSeek-V3.2",
                    shortDescription: "163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5-fast",
                    displayName: "MiniMax-M2.5-fast",
                    shortDescription: "8K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "PrimeIntellect/INTELLECT-3",
                    displayName: "INTELLECT-3",
                    shortDescription: "128K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "neuralwatt",
            displayName: "Neuralwatt",
            shortDescription: "OpenAI-compatible \u{B7} 13 text models",
            baseURLString: "https://api.neuralwatt.com/v1",
            apiKeyLabel: "Neuralwatt API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "kimi-k2.5-fast",
                    displayName: "Kimi K2.5 Fast",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-5-fast",
                    displayName: "GLM 5 Fast",
                    shortDescription: "glm \u{B7} 202K context"
                ),
                AIScriptModelPreset(
                    id: "glm-5.2",
                    displayName: "GLM 5.2",
                    shortDescription: "glm \u{B7} 1.04856M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-397b-fast",
                    displayName: "Qwen3.5 397B Fast",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1-fast",
                    displayName: "GLM 5.1 Fast",
                    shortDescription: "glm \u{B7} 202K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6-fast",
                    displayName: "Kimi K2.6 Fast",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-35b-fast",
                    displayName: "Qwen3.6 35B Fast",
                    shortDescription: "qwen3.6 \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.7-Code",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.6-35B-A3B",
                    displayName: "Qwen3.6 35B A3B",
                    shortDescription: "qwen3.6 \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-397B-A17B-FP8",
                    displayName: "Qwen3.5 397B A17B FP8",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1-FP8",
                    displayName: "GLM 5.1 FP8",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "nova",
            displayName: "Nova",
            shortDescription: "OpenAI-compatible \u{B7} 2 text models",
            baseURLString: "https://api.nova.amazon.com/v1",
            apiKeyLabel: "Nova API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "nova-2-pro-v1",
                    displayName: "Nova 2 Pro",
                    shortDescription: "nova-pro \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nova-2-lite-v1",
                    displayName: "Nova 2 Lite",
                    shortDescription: "nova-lite \u{B7} 1M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "novita-ai",
            displayName: "NovitaAI",
            shortDescription: "OpenAI-compatible \u{B7} 104 text models",
            baseURLString: "https://api.novita.ai/openai",
            apiKeyLabel: "NovitaAI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "inclusionai/ling-2.6-1t",
                    displayName: "Ling-2.6-1T",
                    shortDescription: "ling \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "inclusionai/ring-2.6-1t",
                    displayName: "Ring-2.6-1T",
                    shortDescription: "ring \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "inclusionai/ling-2.6-flash",
                    displayName: "Ling-2.6-flash",
                    shortDescription: "ling \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.1-8b-instruct",
                    displayName: "Llama 3.1 8B Instruct",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3-70b-instruct",
                    displayName: "Llama3 70B Instruct",
                    shortDescription: "llama \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-4-scout-17b-16e-instruct",
                    displayName: "Llama 4 Scout Instruct",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.3-70b-instruct",
                    displayName: "Llama 3.3 70B Instruct",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3-8b-instruct",
                    displayName: "Llama 3 8B Instruct",
                    shortDescription: "llama \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.2-3b-instruct",
                    displayName: "Llama 3.2 3B Instruct",
                    shortDescription: "llama \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-4-maverick-17b-128e-instruct-fp8",
                    displayName: "Llama 4 Maverick Instruct",
                    shortDescription: "1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-instruct",
                    displayName: "Kimi K2 Instruct",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-0905",
                    displayName: "Kimi K2 0905",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "minimaxai/minimax-m1-80k",
                    displayName: "MiniMax M1",
                    shortDescription: "minimax \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-vl-28b-a3b",
                    displayName: "ERNIE 4.5 VL 28B A3B",
                    shortDescription: "30K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-21B-a3b",
                    displayName: "ERNIE 4.5 21B A3B",
                    shortDescription: "ernie \u{B7} 120K context"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-vl-424b-a47b",
                    displayName: "ERNIE 4.5 VL 424B A47B",
                    shortDescription: "123K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-21B-a3b-thinking",
                    displayName: "ERNIE-4.5-21B-A3B-Thinking",
                    shortDescription: "ernie \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-300b-a47b-paddle",
                    displayName: "ERNIE 4.5 300B A47B",
                    shortDescription: "123K context"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-vl-28b-a3b-thinking",
                    displayName: "ERNIE-4.5-VL-28B-A3B-Thinking",
                    shortDescription: "131K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31b-it",
                    displayName: "Gemma 4 31B",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-26b-a4b-it",
                    displayName: "Gemma 4 26B A4B",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3-12b-it",
                    displayName: "Gemma 3 12B",
                    shortDescription: "gemma \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3-27b-it",
                    displayName: "Gemma 3 27B",
                    shortDescription: "gemma \u{B7} 98K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "microsoft/wizardlm-2-8x22b",
                    displayName: "Wizardlm 2 8x22B",
                    shortDescription: "65K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "OpenAI GPT OSS 120B",
                    shortDescription: "131K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "OpenAI: GPT OSS 20B",
                    shortDescription: "131K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "sao10K/l31-70b-euryale-v2.2",
                    displayName: "L31 70B Euryale V2.2",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "sao10K/L3-8B-stheno-v3.2",
                    displayName: "L3 8B Stheno V3.2",
                    shortDescription: "llama \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "sao10K/l3-8b-lunaris",
                    displayName: "Sao10k L3 8B Lunaris",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "sao10K/l3-70b-euryale-v2.1",
                    displayName: "L3 70B Euryale V2.1",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "baichuan/baichuan-m2-32b",
                    displayName: "baichuan-m2-32b",
                    shortDescription: "baichuan \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-nemo",
                    displayName: "Mistral Nemo",
                    shortDescription: "mistral-nemo \u{B7} 60K context"
                ),
                AIScriptModelPreset(
                    id: "xiaomimimo/mimo-v2-flash",
                    displayName: "XiaomiMiMo/MiMo-V2-Flash",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomimimo/mimo-v2-pro",
                    displayName: "MiMo-V2-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomimimo/mimo-v2.5-pro",
                    displayName: "MiMo-V2.5-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gryphe/mythomax-l2-13b",
                    displayName: "Mythomax L2 13B",
                    shortDescription: "4K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.5v",
                    displayName: "GLM 4.5V",
                    shortDescription: "glmv \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.5",
                    displayName: "GLM-4.5",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/autoglm-phone-9b-multilingual",
                    displayName: "AutoGLM-Phone-9B-Multilingual",
                    shortDescription: "65K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.6",
                    displayName: "GLM 4.6",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.6v",
                    displayName: "GLM 4.6V",
                    shortDescription: "glmv \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.5-air",
                    displayName: "GLM 4.5 Air",
                    shortDescription: "glm-air \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-4.7-flash",
                    displayName: "GLM-4.7-Flash",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "paddlepaddle/paddleocr-vl",
                    displayName: "PaddleOCR-VL",
                    shortDescription: "16K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-235b-a22b-thinking",
                    displayName: "Qwen3 VL 235B A22B Thinking",
                    shortDescription: "131K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-30b-a3b-thinking",
                    displayName: "qwen/qwen3-vl-30b-a3b-thinking",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b-instruct-2507",
                    displayName: "Qwen3 235B A22B Instruct 2507",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-30b-a3b-instruct",
                    displayName: "Qwen3 Coder 30b A3B Instruct",
                    shortDescription: "160K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-8b-fp8",
                    displayName: "Qwen3 8B",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-next-80b-a3b-instruct",
                    displayName: "Qwen3 Next 80B A3B Instruct",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-8b-instruct",
                    displayName: "qwen/qwen3-vl-8b-instruct",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-omni-30b-a3b-thinking",
                    displayName: "Qwen3 Omni 30B A3B Thinking",
                    shortDescription: "65K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.7-max",
                    displayName: "Qwen3.7-Max",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-max",
                    displayName: "Qwen3 Max",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen2.5-7b-instruct",
                    displayName: "Qwen2.5 7B Instruct",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-next-80b-a3b-thinking",
                    displayName: "Qwen3 Next 80B A3B Thinking",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b-thinking-2507",
                    displayName: "Qwen3 235B A22b Thinking 2507",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-mt-plus",
                    displayName: "Qwen MT Plus",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-32b-fp8",
                    displayName: "Qwen3 32B",
                    shortDescription: "40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-4b-fp8",
                    displayName: "Qwen3 4B",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen2.5-vl-72b-instruct",
                    displayName: "Qwen2.5 VL 72B Instruct",
                    shortDescription: "qwen \u{B7} 32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-30b-a3b-fp8",
                    displayName: "Qwen3 30B A3B",
                    shortDescription: "40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-27b",
                    displayName: "Qwen3.5-27B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-2.5-72b-instruct",
                    displayName: "Qwen 2.5 72B Instruct",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-next",
                    displayName: "Qwen3 Coder Next",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-35b-a3b",
                    displayName: "Qwen3.5-35B-A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-480b-a35b-instruct",
                    displayName: "Qwen3 Coder 480B A35B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-397b-a17b",
                    displayName: "Qwen3.5-397B-A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-30b-a3b-instruct",
                    displayName: "qwen/qwen3-vl-30b-a3b-instruct",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-omni-30b-a3b-instruct",
                    displayName: "Qwen3 Omni 30B A3B Instruct",
                    shortDescription: "qwen \u{B7} 65K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-235b-a22b-instruct",
                    displayName: "Qwen3 VL 235B A22B Instruct",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-122b-a10b",
                    displayName: "Qwen3.5-122B-A10B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b-fp8",
                    displayName: "Qwen3 235B A22B",
                    shortDescription: "40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-0528",
                    displayName: "DeepSeek R1 0528",
                    shortDescription: "deepseek-thinking \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.1-terminus",
                    displayName: "Deepseek V3.1 Terminus",
                    shortDescription: "deepseek \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3-0324",
                    displayName: "DeepSeek V3 0324",
                    shortDescription: "deepseek \u{B7} 163K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-ocr",
                    displayName: "DeepSeek-OCR",
                    shortDescription: "8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-distill-llama-70b",
                    displayName: "DeepSeek R1 Distill LLama 70B",
                    shortDescription: "deepseek-thinking \u{B7} 8K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-turbo",
                    displayName: "DeepSeek R1 (Turbo)",
                    shortDescription: "64K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-prover-v2-671b",
                    displayName: "Deepseek Prover V2 671B",
                    shortDescription: "160K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2-exp",
                    displayName: "Deepseek V3.2 Exp",
                    shortDescription: "163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-ocr-2",
                    displayName: "deepseek/deepseek-ocr-2",
                    shortDescription: "8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-distill-qwen-14b",
                    displayName: "DeepSeek R1 Distill Qwen 14B",
                    shortDescription: "deepseek-thinking \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-0528-qwen3-8b",
                    displayName: "DeepSeek R1 0528 Qwen3 8B",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-distill-qwen-32b",
                    displayName: "DeepSeek R1 Distill Qwen 32B",
                    shortDescription: "deepseek-thinking \u{B7} 64K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3-turbo",
                    displayName: "DeepSeek V3 (Turbo)",
                    shortDescription: "64K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2",
                    displayName: "Deepseek V3.2",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.7-highspeed",
                    displayName: "MiniMax-M2.7-highspeed",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.5",
                    displayName: "MiniMax M2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.1",
                    displayName: "Minimax M2.1",
                    shortDescription: "minimax \u{B7} 204K context"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2",
                    displayName: "MiniMax-M2",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.7",
                    displayName: "MiniMax M2.7",
                    shortDescription: "minimax-m2.7 \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.5-highspeed",
                    displayName: "MiniMax M2.5 Highspeed",
                    shortDescription: "minimax-m2.5 \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kwaipilot/kat-coder-pro",
                    displayName: "Kat Coder Pro",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "nousresearch/hermes-2-pro-llama-3-8b",
                    displayName: "Hermes 2 Pro Llama 3 8B",
                    shortDescription: "8K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "nvidia",
            displayName: "Nvidia",
            shortDescription: "OpenAI-compatible \u{B7} 60 text models",
            baseURLString: "https://integrate.api.nvidia.com/v1",
            apiKeyLabel: "Nvidia API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-instruct-0905",
                    displayName: "Kimi K2 0905",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimaxai/minimax-m2.7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "stepfun-ai/step-3.7-flash",
                    displayName: "Step 3.7 Flash",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "stepfun-ai/step-3.5-flash",
                    displayName: "Step 3.5 Flash",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3n-e4b-it",
                    displayName: "Gemma 3n E4b It",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3n-e2b-it",
                    displayName: "Gemma 3n E2b It",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/google-paligemma",
                    displayName: "paligemma",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31b-it",
                    displayName: "Gemma-4-31B-IT",
                    shortDescription: "gemma \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-2-2b-it",
                    displayName: "Gemma 2 2b It",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-4-mini-instruct",
                    displayName: "Phi-4-Mini",
                    shortDescription: "phi \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-4-multimodal-instruct",
                    displayName: "Phi 4 Multimodal",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT-OSS-120B",
                    shortDescription: "gpt-oss \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "GPT OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "bytedance/seed-oss-36b-instruct",
                    displayName: "ByteDance-Seed/Seed-OSS-36B-Instruct",
                    shortDescription: "seed \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-7b-instruct-v03",
                    displayName: "Mistral-7B-Instruct-v0.3",
                    shortDescription: "65K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/magistral-small-2506",
                    displayName: "Magistral Small 2506",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mixtral-8x7b-instruct",
                    displayName: "Mistral: Mixtral 8x7B Instruct",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-medium-3-instruct",
                    displayName: "Mistral Medium 3",
                    shortDescription: "mistral-medium \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-small-4-119b-2603",
                    displayName: "mistral-small-4-119b-2603",
                    shortDescription: "128K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-nemotron",
                    displayName: "mistral-nemotron",
                    shortDescription: "nemotron \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-large-3-675b-instruct-2512",
                    displayName: "Mistral Large 3 675B Instruct 2512",
                    shortDescription: "mistral-large \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mixtral-8x22b-instruct",
                    displayName: "Mistral: Mixtral 8x22B Instruct",
                    shortDescription: "65K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-nano-omni-30b-a3b-reasoning",
                    displayName: "Nemotron 3 Nano Omni",
                    shortDescription: "nemotron \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nvidia-nemotron-nano-9b-v2",
                    displayName: "nvidia-nemotron-nano-9b-v2",
                    shortDescription: "nemotron \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-content-safety-reasoning-4b",
                    displayName: "nemotron-content-safety-reasoning-4b",
                    shortDescription: "nemotron \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/usdcode",
                    displayName: "usdcode",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/riva-translate-4b-instruct-v1_1",
                    displayName: "riva-translate-4b-instruct-v1_1",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/llama-3_1-nemotron-safety-guard-8b-v3",
                    displayName: "llama-3.1-nemotron-safety-guard-8b-v3",
                    shortDescription: "nemotron \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-voicechat",
                    displayName: "nemotron-voicechat",
                    shortDescription: "nemotron \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-ultra-550b-a55b",
                    displayName: "Nemotron 3 Ultra 550B A55B",
                    shortDescription: "nemotron \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-nano-30b-a3b",
                    displayName: "nemotron-3-nano-30b-a3b",
                    shortDescription: "nemotron \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/studiovoice",
                    displayName: "studiovoice",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/gliner-pii",
                    displayName: "gliner-pii",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-mini-4b-instruct",
                    displayName: "nemotron-mini-4b-instruct",
                    shortDescription: "nemotron \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-super-120b-a12b",
                    displayName: "Nemotron 3 Super",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/usdvalidate",
                    displayName: "usdvalidate",
                    shortDescription: "Text model"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-content-safety",
                    displayName: "nemotron-3-content-safety",
                    shortDescription: "nemotron \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "abacusai/dracarys-llama-3_1-70b-instruct",
                    displayName: "dracarys-llama-3.1-70b-instruct",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-next-80b-a3b-instruct",
                    displayName: "Qwen3-Next-80B-A3B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-480b-a35b-instruct",
                    displayName: "Qwen3 Coder 480B A35B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen2.5-coder-32b-instruct",
                    displayName: "Qwen2.5 Coder 32b Instruct",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-397b-a17b",
                    displayName: "Qwen3.5-397B-A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-122b-a10b",
                    displayName: "Qwen3.5 122B-A10B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "sarvamai/sarvam-m",
                    displayName: "sarvam-m",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.1-8b-instruct",
                    displayName: "Llama 3.1 8B Instruct",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.1-70b-instruct",
                    displayName: "Llama 3.1 70b Instruct",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.2-1b-instruct",
                    displayName: "Llama 3.2 1b Instruct",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.2-11b-vision-instruct",
                    displayName: "Llama 3.2 11b Vision Instruct",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.3-70b-instruct",
                    displayName: "Llama 3.3 70b Instruct",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-guard-4-12b",
                    displayName: "Llama Guard 4 12B",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta/esmfold",
                    displayName: "esmfold",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "meta/esm2-650m",
                    displayName: "esm2-650m",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.2-90b-vision-instruct",
                    displayName: "Llama-3.2-90B-Vision-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-4-maverick-17b-128e-instruct",
                    displayName: "Llama 4 Maverick 17b 128e Instruct",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta/llama-3.2-3b-instruct",
                    displayName: "Llama 3.2 3B Instruct",
                    shortDescription: "llama \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "upstage/solar-10_7b-instruct",
                    displayName: "solar-10.7b-instruct",
                    shortDescription: "128K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "ollama-cloud",
            displayName: "Ollama Cloud",
            shortDescription: "OpenAI-compatible \u{B7} 42 text models",
            baseURLString: "https://ollama.com/v1",
            apiKeyLabel: "Ollama Cloud API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "deepseek-v4-flash",
                    shortDescription: "deepseek-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.5",
                    displayName: "minimax-m2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "devstral-small-2:24b",
                    displayName: "devstral-small-2:24b",
                    shortDescription: "devstral \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "glm-4.7",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "cogito-2.1:671b",
                    displayName: "cogito-2.1:671b",
                    shortDescription: "cogito \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.1",
                    displayName: "minimax-m2.1",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss:120b",
                    displayName: "gpt-oss:120b",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nemotron-3-nano:30b",
                    displayName: "nemotron-3-nano:30b",
                    shortDescription: "nemotron \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "ministral-3:8b",
                    displayName: "ministral-3:8b",
                    shortDescription: "ministral \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "rnj-1:8b",
                    displayName: "rnj-1:8b",
                    shortDescription: "rnj \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.7-code",
                    displayName: "kimi-k2.7-code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "glm-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "deepseek-v4-pro",
                    shortDescription: "deepseek-thinking \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6",
                    displayName: "glm-4.6",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking",
                    displayName: "kimi-k2-thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nemotron-3-super",
                    displayName: "nemotron-3-super",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "ministral-3:14b",
                    displayName: "ministral-3:14b",
                    shortDescription: "ministral \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "minimax-m3",
                    displayName: "minimax-m3",
                    shortDescription: "minimax-m3 \u{B7} 512K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2",
                    displayName: "minimax-m2",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-next:80b",
                    displayName: "qwen3-next:80b",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder:480b",
                    displayName: "qwen3-coder:480b",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2:1t",
                    displayName: "kimi-k2:1t",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.7",
                    displayName: "minimax-m2.7",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.1:671b",
                    displayName: "deepseek-v3.1:671b",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "kimi-k2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemma4:31b",
                    displayName: "gemma4:31b",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "ministral-3:3b",
                    displayName: "ministral-3:3b",
                    shortDescription: "ministral \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemma3:12b",
                    displayName: "gemma3:12b",
                    shortDescription: "gemma \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemma3:4b",
                    displayName: "gemma3:4b",
                    shortDescription: "gemma \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5:397b",
                    displayName: "qwen3.5:397b",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "kimi-k2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-next",
                    displayName: "qwen3-coder-next",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl:235b-instruct",
                    displayName: "qwen3-vl:235b-instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistral-large-3:675b",
                    displayName: "mistral-large-3:675b",
                    shortDescription: "mistral-large \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemma3:27b",
                    displayName: "gemma3:27b",
                    shortDescription: "gemma \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl:235b",
                    displayName: "qwen3-vl:235b",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nemotron-3-ultra",
                    displayName: "nemotron-3-ultra",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-flash-preview",
                    displayName: "gemini-3-flash-preview",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss:20b",
                    displayName: "gpt-oss:20b",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "glm-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.2",
                    displayName: "deepseek-v3.2",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "devstral-2:123b",
                    displayName: "devstral-2:123b",
                    shortDescription: "devstral \u{B7} 262K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "openai",
            displayName: "OpenAI",
            shortDescription: "OpenAI-compatible \u{B7} 43 text models",
            baseURLString: "https://api.openai.com/v1",
            apiKeyLabel: "OpenAI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "o3",
                    displayName: "o3",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-pro",
                    displayName: "GPT-5.2 Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-3.5-turbo",
                    displayName: "GPT-3.5-turbo",
                    shortDescription: "gpt \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-pro",
                    displayName: "GPT-5 Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o",
                    displayName: "GPT-4o",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-4",
                    displayName: "GPT-4",
                    shortDescription: "gpt \u{B7} 8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "o4-mini",
                    displayName: "o4-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "o3-pro",
                    displayName: "o3-pro",
                    shortDescription: "o-pro \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o-2024-05-13",
                    displayName: "GPT-4o (2024-05-13)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-nano",
                    displayName: "GPT-5.4 nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-chat-latest",
                    displayName: "GPT-5 Chat (latest)",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex",
                    displayName: "GPT-5.1 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.3-codex-spark",
                    displayName: "GPT-5.3 Codex Spark",
                    shortDescription: "gpt-codex-spark \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex-max",
                    displayName: "GPT-5.1 Codex Max",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.3-chat-latest",
                    displayName: "GPT-5.3 Chat (latest)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o-2024-08-06",
                    displayName: "GPT-4o (2024-08-06)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "o3-mini",
                    displayName: "o3-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.3-codex",
                    displayName: "GPT-5.3 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex-mini",
                    displayName: "GPT-5.1 Codex mini",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-chat-latest",
                    displayName: "GPT-5.1 Chat",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-chat-latest",
                    displayName: "GPT-5.2 Chat",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "o4-mini-deep-research",
                    displayName: "o4-mini-deep-research",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1-nano",
                    displayName: "GPT-4.1 nano",
                    shortDescription: "gpt-nano \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o-2024-11-20",
                    displayName: "GPT-4o (2024-11-20)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "o1",
                    displayName: "o1",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "o1-pro",
                    displayName: "o1-pro",
                    shortDescription: "o-pro \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-mini",
                    displayName: "GPT-5.4 mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "o3-deep-research",
                    displayName: "o3-deep-research",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-mini",
                    displayName: "GPT-5 Mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4.1-mini",
                    displayName: "GPT-4.1 mini",
                    shortDescription: "gpt-mini \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-4-turbo",
                    displayName: "GPT-4 Turbo",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-nano",
                    displayName: "GPT-5 Nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-pro",
                    displayName: "GPT-5.4 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.5-pro",
                    displayName: "GPT-5.5 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-4o-mini",
                    displayName: "GPT-4o mini",
                    shortDescription: "gpt-mini \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-codex",
                    displayName: "GPT-5-Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-codex",
                    displayName: "GPT-5.2 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1",
                    displayName: "GPT-5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "opencode-go",
            displayName: "OpenCode Go",
            shortDescription: "OpenAI-compatible \u{B7} 18 text models",
            baseURLString: "https://opencode.ai/zen/go/v1",
            apiKeyLabel: "OpenCode Go API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.5",
                    displayName: "MiniMax M2.5",
                    shortDescription: "minimax-m2.5 \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-plus",
                    displayName: "Qwen3.7 Plus",
                    shortDescription: "qwen3.7-plus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-max",
                    displayName: "Qwen3.7 Max",
                    shortDescription: "qwen3.7-max \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.7-code",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m3",
                    displayName: "MiniMax M3 (3x usage)",
                    shortDescription: "minimax-m3 \u{B7} 512K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-plus",
                    displayName: "Qwen3.5 Plus",
                    shortDescription: "qwen3.5 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.7",
                    displayName: "MiniMax M2.7",
                    shortDescription: "minimax-m2.7 \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2.5",
                    displayName: "MiMo V2.5",
                    shortDescription: "mimo-v2.5 \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-omni",
                    displayName: "MiMo V2 Omni",
                    shortDescription: "mimo-v2-omni \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-pro",
                    displayName: "MiMo V2 Pro",
                    shortDescription: "mimo-v2-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2.5-pro",
                    displayName: "MiMo V2.5 Pro",
                    shortDescription: "mimo-v2.5-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen3.6 \u{B7} 1M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "opencode",
            displayName: "OpenCode Zen",
            shortDescription: "OpenAI-compatible \u{B7} 70 text models",
            baseURLString: "https://opencode.ai/zen/v1",
            apiKeyLabel: "OpenCode Zen API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "ring-2.6-1t-free",
                    displayName: "Ring 2.6 1T Free",
                    shortDescription: "ring-1t-free \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-pro-free",
                    displayName: "MiMo V2 Pro Free",
                    shortDescription: "mimo-pro-free \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.5",
                    displayName: "MiniMax M2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2.5-free",
                    displayName: "MiMo V2.5 Free",
                    shortDescription: "mimo-v2.5-free \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2",
                    displayName: "Kimi K2",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.1",
                    displayName: "MiniMax M2.1",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nemotron-3-ultra-free",
                    displayName: "Nemotron 3 Ultra Free",
                    shortDescription: "nemotron-free \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7-free",
                    displayName: "GLM-4.7 Free",
                    shortDescription: "glm-free \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-flash",
                    displayName: "Gemini 3 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-flash-free",
                    displayName: "DeepSeek V4 Flash Free",
                    shortDescription: "deepseek-flash-free \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4",
                    displayName: "Claude Sonnet 4",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-5",
                    displayName: "Claude Opus 4.5",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.5-flash",
                    displayName: "Gemini 3.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m3-free",
                    displayName: "MiniMax M3 Free",
                    shortDescription: "minimax-m3-free \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-pro",
                    displayName: "Gemini 3 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5-free",
                    displayName: "Kimi K2.5 Free",
                    shortDescription: "kimi-free \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6",
                    displayName: "GLM-4.6",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2-thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-5",
                    displayName: "Claude Sonnet 4.5",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-nano",
                    displayName: "GPT-5.4 Nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder",
                    displayName: "Qwen3 Coder",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "hy3-preview-free",
                    displayName: "Hy3 preview Free",
                    shortDescription: "hy3-free \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex",
                    displayName: "GPT-5.1 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.3-codex-spark",
                    displayName: "GPT-5.3 Codex Spark",
                    shortDescription: "gpt-codex-spark \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex-max",
                    displayName: "GPT-5.1 Codex Max",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-8",
                    displayName: "Claude Opus 4.8",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "ling-2.6-flash-free",
                    displayName: "Ling 2.6 Flash Free",
                    shortDescription: "ling-flash-free \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-plus",
                    displayName: "Qwen3.5 Plus",
                    shortDescription: "qwen3.5 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-3-5-haiku",
                    displayName: "Claude Haiku 3.5",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.3-codex",
                    displayName: "GPT-5.3 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.7",
                    displayName: "MiniMax M2.7",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "north-mini-code-free",
                    displayName: "North Mini Code Free",
                    shortDescription: "north-free \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-code",
                    displayName: "Grok Code Fast 1",
                    shortDescription: "grok \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-1",
                    displayName: "Claude Opus 4.1",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1-codex-mini",
                    displayName: "GPT-5.1 Codex Mini",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-fable-5",
                    displayName: "Claude Fable 5",
                    shortDescription: "claude-fable \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-haiku-4-5",
                    displayName: "Claude Haiku 4.5",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-mini",
                    displayName: "GPT-5.4 Mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.5-free",
                    displayName: "MiniMax M2.5 Free",
                    shortDescription: "minimax-free \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.1-free",
                    displayName: "MiniMax M2.1 Free",
                    shortDescription: "minimax-free \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-nano",
                    displayName: "GPT-5 Nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.4-pro",
                    displayName: "GPT-5.4 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-flash-free",
                    displayName: "MiMo V2 Flash Free",
                    shortDescription: "mimo-flash-free \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.1-pro",
                    displayName: "Gemini 3.1 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "trinity-large-preview-free",
                    displayName: "Trinity Large Preview",
                    shortDescription: "trinity \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "big-pickle",
                    displayName: "Big Pickle",
                    shortDescription: "big-pickle \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.5-pro",
                    displayName: "GPT-5.5 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-plus-free",
                    displayName: "Qwen3.6 Plus Free",
                    shortDescription: "qwen-free \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-omni-free",
                    displayName: "MiMo V2 Omni Free",
                    shortDescription: "mimo-omni-free \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-codex",
                    displayName: "GPT-5 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-codex",
                    displayName: "GPT-5.2 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5-free",
                    displayName: "GLM-5 Free",
                    shortDescription: "glm-free \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen3.6 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nemotron-3-super-free",
                    displayName: "Nemotron 3 Super Free",
                    shortDescription: "nemotron-free \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-build-0.1",
                    displayName: "Grok Build 0.1",
                    shortDescription: "grok-build \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.1",
                    displayName: "GPT-5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "openrouter",
            displayName: "OpenRouter",
            shortDescription: "OpenAI-compatible \u{B7} 330 text models",
            baseURLString: "https://openrouter.ai/api/v1",
            apiKeyLabel: "OpenRouter API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "inclusionai/ling-2.6-1t",
                    displayName: "Ling-2.6-1T",
                    shortDescription: "ling \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "inclusionai/ring-2.6-1t",
                    displayName: "Ring-2.6-1T",
                    shortDescription: "ring \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "inclusionai/ling-2.6-flash",
                    displayName: "Ling-2.6-flash",
                    shortDescription: "ling \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "ibm-granite/granite-4.0-h-micro",
                    displayName: "Granite 4.0 Micro",
                    shortDescription: "granite \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "ibm-granite/granite-4.1-8b",
                    displayName: "Granite 4.1 8B",
                    shortDescription: "granite \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.1-8b-instruct",
                    displayName: "Llama 3.1 8B Instruct",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3-70b-instruct",
                    displayName: "Llama 3 70B Instruct",
                    shortDescription: "llama \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.1-70b-instruct",
                    displayName: "Llama 3.1 70B Instruct",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.2-1b-instruct",
                    displayName: "Llama 3.2 1B Instruct",
                    shortDescription: "llama \u{B7} 60K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-4-maverick",
                    displayName: "Llama 4 Maverick",
                    shortDescription: "llama \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.2-11b-vision-instruct",
                    displayName: "Llama 3.2 11B Vision Instruct",
                    shortDescription: "llama \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.3-70b-instruct:free",
                    displayName: "Llama 3.3 70B Instruct (free)",
                    shortDescription: "llama \u{B7} 65K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.3-70b-instruct",
                    displayName: "Llama-3.3-70B-Instruct",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.2-3b-instruct:free",
                    displayName: "Llama 3.2 3B Instruct (free)",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-guard-4-12b",
                    displayName: "Llama Guard 4 12B",
                    shortDescription: "llama \u{B7} 163K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3-8b-instruct",
                    displayName: "Llama 3 8B Instruct",
                    shortDescription: "llama \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-4-scout",
                    displayName: "Llama 4 Scout",
                    shortDescription: "llama \u{B7} 327K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/llama-3.2-3b-instruct",
                    displayName: "Llama 3.2 3B Instruct",
                    shortDescription: "llama \u{B7} 80K context"
                ),
                AIScriptModelPreset(
                    id: "~anthropic/claude-haiku-latest",
                    displayName: "Anthropic Claude Haiku Latest",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "~anthropic/claude-fable-latest",
                    displayName: "Claude Fable Latest",
                    shortDescription: "claude-fable \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "~anthropic/claude-sonnet-latest",
                    displayName: "Anthropic Claude Sonnet Latest",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "~anthropic/claude-opus-latest",
                    displayName: "Claude Opus Latest",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2",
                    displayName: "Kimi K2 0711",
                    shortDescription: "kimi-k2 \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.7-code",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-0905",
                    displayName: "Kimi K2 0905",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-4.5-vl-424b-a47b",
                    displayName: "ERNIE 4.5 VL 424B A47B",
                    shortDescription: "ernie \u{B7} 123K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "perceptron/perceptron-mk1",
                    displayName: "Perceptron Mk1",
                    shortDescription: "32K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-flash-lite",
                    displayName: "Gemini 3.1 Flash Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3n-e4b-it",
                    displayName: "Gemma 3n 4B",
                    shortDescription: "gemma \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-26b-a4b-it:free",
                    displayName: "Gemma 4 26B A4B (free)",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.5-flash",
                    displayName: "Gemini 3.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash-lite-preview-09-2025",
                    displayName: "Gemini 2.5 Flash Lite Preview 09-2025",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31b-it",
                    displayName: "Gemma 4 31B IT",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/lyria-3-clip-preview",
                    displayName: "Lyria 3 Clip Preview",
                    shortDescription: "lyria \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro-preview-customtools",
                    displayName: "Gemini 3.1 Pro Preview Custom Tools",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash-lite",
                    displayName: "Gemini 2.5 Flash-Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro-preview-05-06",
                    displayName: "Gemini 2.5 Pro Preview 05-06",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro-preview",
                    displayName: "Gemini 3.1 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-26b-a4b-it",
                    displayName: "Gemma 4 26B A4B IT",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro-preview",
                    displayName: "Gemini 2.5 Pro Preview 06-05",
                    shortDescription: "gemini \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-flash-preview",
                    displayName: "Gemini 3 Flash Preview",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3-12b-it",
                    displayName: "Gemma 3 12B",
                    shortDescription: "gemma \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3-4b-it",
                    displayName: "Gemma 3 4B",
                    shortDescription: "gemma \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3-27b-it",
                    displayName: "Gemma 3 27B",
                    shortDescription: "gemma \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/lyria-3-pro-preview",
                    displayName: "Lyria 3 Pro Preview",
                    shortDescription: "lyria \u{B7} 1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31b-it:free",
                    displayName: "Gemma 4 31B (free)",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-2-27b-it",
                    displayName: "Gemma 2 27B",
                    shortDescription: "gemma \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-flash-lite-preview",
                    displayName: "Gemini 3.1 Flash Lite Preview",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "liquid/lfm-2.5-1.2b-thinking:free",
                    displayName: "LFM2.5-1.2B-Thinking (free)",
                    shortDescription: "liquid \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "liquid/lfm-2-24b-a2b",
                    displayName: "LFM2-24B-A2B",
                    shortDescription: "liquid \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "liquid/lfm-2.5-1.2b-instruct:free",
                    displayName: "LFM2.5-1.2B-Instruct (free)",
                    shortDescription: "liquid \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.20",
                    displayName: "Grok 4.20",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.3",
                    displayName: "Grok 4.3",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.20-multi-agent",
                    displayName: "Grok 4.20 Multi-Agent",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-build-0.1",
                    displayName: "Grok Build 0.1",
                    shortDescription: "grok-build \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "~google/gemini-pro-latest",
                    displayName: "Google Gemini Pro Latest",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "~google/gemini-flash-latest",
                    displayName: "Google Gemini Flash Latest",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-4-mini-instruct",
                    displayName: "Phi 4 Mini Instruct",
                    shortDescription: "phi \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "microsoft/phi-4",
                    displayName: "Phi 4",
                    shortDescription: "phi \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "microsoft/wizardlm-2-8x22b",
                    displayName: "WizardLM-2 8x22B",
                    shortDescription: "65K context"
                ),
                AIScriptModelPreset(
                    id: "poolside/laguna-xs.2:free",
                    displayName: "Laguna XS.2 (free)",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "poolside/laguna-m.1:free",
                    displayName: "Laguna M.1 (free)",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "writer/palmyra-x5",
                    displayName: "Palmyra X5",
                    shortDescription: "palmyra \u{B7} 1.04M context"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.5v",
                    displayName: "GLM-4.5V",
                    shortDescription: "glm \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.5",
                    displayName: "GLM-4.5",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.6",
                    displayName: "GLM-4.6",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5.2",
                    displayName: "GLM-5.2",
                    shortDescription: "glm \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.6v",
                    displayName: "GLM-4.6V",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.5-air",
                    displayName: "GLM-4.5-Air",
                    shortDescription: "glm-air \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.7-flash",
                    displayName: "GLM-4.7-Flash",
                    shortDescription: "glm-flash \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5-turbo",
                    displayName: "GLM-5-Turbo",
                    shortDescription: "glm \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini-2024-07-18",
                    displayName: "GPT-4o-mini (2024-07-18)",
                    shortDescription: "o-mini \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-safeguard-20b",
                    displayName: "gpt-oss-safeguard-20b",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo-instruct",
                    displayName: "GPT-3.5 Turbo Instruct",
                    shortDescription: "gpt \u{B7} 4K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-chat",
                    displayName: "GPT-5.2 Chat",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o3",
                    displayName: "o3",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini-high",
                    displayName: "o4 Mini High",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-audio",
                    displayName: "GPT Audio",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-pro",
                    displayName: "GPT-5.2 Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini-search-preview",
                    displayName: "GPT-4o-mini Search Preview",
                    shortDescription: "o-mini \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-chat",
                    displayName: "GPT-5 Chat",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo",
                    displayName: "GPT-3.5-turbo",
                    shortDescription: "gpt \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-pro",
                    displayName: "GPT-5 Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o",
                    displayName: "GPT-4o",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4",
                    displayName: "GPT-4",
                    shortDescription: "gpt \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini",
                    displayName: "o4-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo-16k",
                    displayName: "GPT-3.5 Turbo 16k",
                    shortDescription: "gpt \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-pro",
                    displayName: "o3-pro",
                    shortDescription: "o-pro \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-chat",
                    displayName: "GPT-5.1 Chat",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-2024-05-13",
                    displayName: "GPT-4o (2024-05-13)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-nano",
                    displayName: "GPT-5.4 nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-chat",
                    displayName: "GPT-5.3 Chat",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo-0613",
                    displayName: "GPT-3.5 Turbo (older v0613)",
                    shortDescription: "gpt \u{B7} 4K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex",
                    displayName: "GPT-5.1 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-max",
                    displayName: "GPT-5.1 Codex Max",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b:free",
                    displayName: "gpt-oss-120b (free)",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-2024-08-06",
                    displayName: "GPT-4o (2024-08-06)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-mini",
                    displayName: "o3-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-codex",
                    displayName: "GPT-5.3 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-audio-mini",
                    displayName: "GPT Audio Mini",
                    shortDescription: "o-mini \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-mini",
                    displayName: "GPT-5.1 Codex mini",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini-deep-research",
                    displayName: "o4-mini-deep-research",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-nano",
                    displayName: "GPT-4.1 nano",
                    shortDescription: "gpt-nano \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "gpt-oss-120b",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-2024-11-20",
                    displayName: "GPT-4o (2024-11-20)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o1",
                    displayName: "o1",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o1-pro",
                    displayName: "o1-pro",
                    shortDescription: "o-pro \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-chat-latest",
                    displayName: "GPT Chat Latest",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-mini",
                    displayName: "GPT-5.4 mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-deep-research",
                    displayName: "o3-deep-research",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4-turbo-preview",
                    displayName: "GPT-4 Turbo Preview",
                    shortDescription: "gpt \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-mini",
                    displayName: "GPT-5 Mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-mini",
                    displayName: "GPT-4.1 mini",
                    shortDescription: "gpt-mini \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4-turbo",
                    displayName: "GPT-4 Turbo",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-nano",
                    displayName: "GPT-5 Nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-pro",
                    displayName: "GPT-5.4 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-mini-high",
                    displayName: "o3 Mini High",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-search-preview",
                    displayName: "GPT-4o Search Preview",
                    shortDescription: "gpt \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5-pro",
                    displayName: "GPT-5.5 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini",
                    displayName: "GPT-4o mini",
                    shortDescription: "gpt-mini \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "gpt-oss-20b",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-codex",
                    displayName: "GPT-5-Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-codex",
                    displayName: "GPT-5.2 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b:free",
                    displayName: "gpt-oss-20b (free)",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1",
                    displayName: "GPT-5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "thedrummer/cydonia-24b-v4.1",
                    displayName: "Cydonia 24B V4.1",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "thedrummer/skyfall-36b-v2",
                    displayName: "Skyfall 36B V2",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "thedrummer/unslopnemo-12b",
                    displayName: "UnslopNemo 12B",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "thedrummer/rocinante-12b",
                    displayName: "Rocinante 12B",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "bytedance/ui-tars-1.5-7b",
                    displayName: "UI-TARS 7B",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "rekaai/reka-flash-3",
                    displayName: "Reka Flash 3",
                    shortDescription: "reka \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "rekaai/reka-edge",
                    displayName: "Reka Edge",
                    shortDescription: "reka \u{B7} 16K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-large-2407",
                    displayName: "Mistral Large 2407",
                    shortDescription: "mistral-large \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-small-3.2-24b-instruct",
                    displayName: "Mistral Small 3.2 24B",
                    shortDescription: "mistral-small \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-nemo",
                    displayName: "Mistral Nemo",
                    shortDescription: "mistral-nemo \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-medium-3-5",
                    displayName: "Mistral Medium 3.5",
                    shortDescription: "mistral-medium \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistralai/ministral-8b-2512",
                    displayName: "Ministral 3 8B 2512",
                    shortDescription: "ministral \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-small-3.1-24b-instruct",
                    displayName: "Mistral Small 3.1 24B",
                    shortDescription: "mistral-small \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-saba",
                    displayName: "Saba",
                    shortDescription: "mistral \u{B7} 32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-large",
                    displayName: "Mistral Large",
                    shortDescription: "mistral-large \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-medium-3.1",
                    displayName: "Mistral Medium 3.1",
                    shortDescription: "mistral-medium \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-small-24b-instruct-2501",
                    displayName: "Mistral Small 3",
                    shortDescription: "mistral-small \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "mistralai/ministral-3b-2512",
                    displayName: "Ministral 3 3B 2512",
                    shortDescription: "ministral \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-small-2603",
                    displayName: "Mistral Small 4",
                    shortDescription: "mistral-small \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistralai/ministral-14b-2512",
                    displayName: "Ministral 3 14B 2512",
                    shortDescription: "ministral \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/devstral-2512",
                    displayName: "Devstral 2",
                    shortDescription: "devstral \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mixtral-8x22b-instruct",
                    displayName: "Mixtral 8x22B Instruct",
                    shortDescription: "mistral \u{B7} 65K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-medium-3",
                    displayName: "Mistral Medium 3",
                    shortDescription: "mistral-medium \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/voxtral-small-24b-2507",
                    displayName: "Voxtral Small 24B 2507",
                    shortDescription: "mistral \u{B7} 32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/mistral-large-2512",
                    displayName: "Mistral Large 3",
                    shortDescription: "mistral-large \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistralai/codestral-2508",
                    displayName: "Codestral 2508",
                    shortDescription: "codestral \u{B7} 256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "morph/morph-v3-fast",
                    displayName: "Morph V3 Fast",
                    shortDescription: "morph \u{B7} 81K context"
                ),
                AIScriptModelPreset(
                    id: "morph/morph-v3-large",
                    displayName: "Morph V3 Large",
                    shortDescription: "morph \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "bytedance-seed/seed-1.6-flash",
                    displayName: "Seed 1.6 Flash",
                    shortDescription: "seed \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "bytedance-seed/seed-1.6",
                    displayName: "Seed 1.6",
                    shortDescription: "seed \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "bytedance-seed/seed-2.0-mini",
                    displayName: "Seed-2.0-Mini",
                    shortDescription: "seed \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "bytedance-seed/seed-2.0-lite",
                    displayName: "Seed-2.0-Lite",
                    shortDescription: "seed \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthracite-org/magnum-v4-72b",
                    displayName: "Magnum v4 72B",
                    shortDescription: "16K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-nano-30b-a3b:free",
                    displayName: "Nemotron 3 Nano 30B A3B (free)",
                    shortDescription: "nemotron \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-nano-9b-v2:free",
                    displayName: "Nemotron Nano 9B V2 (free)",
                    shortDescription: "nemotron \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-nano-12b-v2-vl:free",
                    displayName: "Nemotron Nano 12B 2 VL (free)",
                    shortDescription: "nemotron \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free",
                    displayName: "Nemotron 3 Nano Omni (free)",
                    shortDescription: "nemotron \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-ultra-550b-a55b:free",
                    displayName: "Nemotron 3 Ultra (free)",
                    shortDescription: "nemotron \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-ultra-550b-a55b",
                    displayName: "Nemotron 3 Ultra 550B A55B",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3.5-content-safety:free",
                    displayName: "Nemotron 3.5 Content Safety (free)",
                    shortDescription: "nemotron \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-nano-30b-a3b",
                    displayName: "Nemotron 3 Nano 30B A3B",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/llama-3.3-nemotron-super-49b-v1.5",
                    displayName: "Llama 3.3 Nemotron Super 49B v1.5",
                    shortDescription: "nemotron \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-super-120b-a12b:free",
                    displayName: "Nemotron 3 Super (free)",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-super-120b-a12b",
                    displayName: "Nemotron 3 Super 120B A12B",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "cognitivecomputations/dolphin-mistral-24b-venice-edition:free",
                    displayName: "Uncensored (free)",
                    shortDescription: "mistral \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2.5",
                    displayName: "MiMo-V2.5",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-flash",
                    displayName: "MiMo-V2-Flash",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2.5-pro",
                    displayName: "MiMo-V2.5-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "inception/mercury-2",
                    displayName: "Mercury 2",
                    shortDescription: "mercury \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-3.5-haiku",
                    displayName: "Claude 3.5 Haiku",
                    shortDescription: "claude \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.5",
                    displayName: "Claude Sonnet 4.5 (latest)",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4",
                    displayName: "Claude Sonnet 4",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6-fast",
                    displayName: "Claude Opus 4.6 (Fast)",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-haiku-4.5",
                    displayName: "Claude Haiku 4.5 (latest)",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.7-fast",
                    displayName: "Claude Opus 4.7 (Fast)",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.8",
                    displayName: "Claude Opus 4.8",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.1",
                    displayName: "Claude Opus 4.1 (latest)",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.5",
                    displayName: "Claude Opus 4.5 (latest)",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-3-haiku",
                    displayName: "Claude 3 Haiku",
                    shortDescription: "claude \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4",
                    displayName: "Claude Opus 4",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.8-fast",
                    displayName: "Claude Opus 4.8 (Fast)",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "tencent/hunyuan-a13b-instruct",
                    displayName: "Hunyuan A13B Instruct",
                    shortDescription: "hunyuan \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "tencent/hy3-preview",
                    displayName: "Hy3 preview",
                    shortDescription: "Hy \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepcogito/cogito-v2.1-671b",
                    displayName: "Cogito v2.1 671B",
                    shortDescription: "cogito \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "cohere/command-a",
                    displayName: "Command A",
                    shortDescription: "command-a \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "cohere/command-r-08-2024",
                    displayName: "Command R",
                    shortDescription: "command-r \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "cohere/command-r7b-12-2024",
                    displayName: "Command R7B",
                    shortDescription: "command-r \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "cohere/command-r-plus-08-2024",
                    displayName: "Command R+",
                    shortDescription: "command-r \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gryphe/mythomax-l2-13b",
                    displayName: "MythoMax 13B",
                    shortDescription: "4K context"
                ),
                AIScriptModelPreset(
                    id: "stepfun/step-3.7-flash",
                    displayName: "Step 3.7 Flash",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "stepfun/step-3.5-flash",
                    displayName: "Step 3.5 Flash",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "prime-intellect/intellect-3",
                    displayName: "INTELLECT-3",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nex-agi/nex-n2-pro:free",
                    displayName: "Nex-N2-Pro (free)",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "undi95/remm-slerp-l2-13b",
                    displayName: "ReMM SLERP 13B",
                    shortDescription: "6K context"
                ),
                AIScriptModelPreset(
                    id: "~openai/gpt-mini-latest",
                    displayName: "OpenAI GPT Mini Latest",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "~openai/gpt-latest",
                    displayName: "OpenAI GPT Latest",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "~moonshotai/kimi-latest",
                    displayName: "MoonshotAI Kimi Latest",
                    shortDescription: "kimi \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "relace/relace-search",
                    displayName: "Relace Search",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "relace/relace-apply-3",
                    displayName: "Relace Apply 3",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "ai21/jamba-large-1.7",
                    displayName: "Jamba Large 1.7",
                    shortDescription: "jamba \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "arcee-ai/coder-large",
                    displayName: "Coder Large",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "arcee-ai/virtuoso-large",
                    displayName: "Virtuoso Large",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "arcee-ai/trinity-large-thinking",
                    displayName: "Trinity Large Thinking",
                    shortDescription: "trinity \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "arcee-ai/trinity-mini",
                    displayName: "Trinity Mini",
                    shortDescription: "trinity-mini \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mancer/weaver",
                    displayName: "Weaver (alpha)",
                    shortDescription: "alpha \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "perplexity/sonar-reasoning-pro",
                    displayName: "Sonar Reasoning Pro",
                    shortDescription: "sonar-reasoning \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "perplexity/sonar",
                    displayName: "Sonar",
                    shortDescription: "sonar \u{B7} 127K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "perplexity/sonar-pro",
                    displayName: "Sonar Pro",
                    shortDescription: "sonar-pro \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "perplexity/sonar-pro-search",
                    displayName: "Sonar Pro Search",
                    shortDescription: "sonar-pro \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "perplexity/sonar-deep-research",
                    displayName: "Sonar Deep Research",
                    shortDescription: "sonar-deep-research \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "switchpoint/router",
                    displayName: "Switchpoint Router",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openrouter/bodybuilder",
                    displayName: "Body Builder (beta)",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "openrouter/free",
                    displayName: "Free Models Router",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openrouter/fusion",
                    displayName: "Fusion",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "openrouter/owl-alpha",
                    displayName: "Owl Alpha",
                    shortDescription: "alpha \u{B7} 1.04876M context"
                ),
                AIScriptModelPreset(
                    id: "openrouter/pareto-code",
                    displayName: "Pareto Code Router",
                    shortDescription: "2M context"
                ),
                AIScriptModelPreset(
                    id: "openrouter/auto",
                    displayName: "Auto Router",
                    shortDescription: "auto \u{B7} 2M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-plus-20260420",
                    displayName: "Qwen3.5 Plus 2026-04-20",
                    shortDescription: "qwen3.5 \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-next-80b-a3b-instruct:free",
                    displayName: "Qwen3 Next 80B A3B Instruct (free)",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-235b-a22b-thinking",
                    displayName: "Qwen3 VL 235B A22B Thinking",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-30b-a3b-thinking",
                    displayName: "Qwen3 VL 30B A3B Thinking",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-plus",
                    displayName: "Qwen3 Coder Plus",
                    shortDescription: "qwen \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-plus",
                    displayName: "Qwen Plus",
                    shortDescription: "qwen \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-30b-a3b-instruct",
                    displayName: "Qwen3-Coder 30B-A3B Instruct",
                    shortDescription: "qwen \u{B7} 160K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-32b",
                    displayName: "Qwen3 32B",
                    shortDescription: "qwen \u{B7} 40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-next-80b-a3b-instruct",
                    displayName: "Qwen3-Next 80B-A3B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-8b-instruct",
                    displayName: "Qwen3 VL 8B Instruct",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.7-plus",
                    displayName: "Qwen3.7 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-35b-a3b",
                    displayName: "Qwen3.6 35B-A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.7-max",
                    displayName: "Qwen3.7 Max",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-max",
                    displayName: "Qwen3 Max",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-8b",
                    displayName: "Qwen3 8B",
                    shortDescription: "qwen \u{B7} 40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-plus-2025-07-28",
                    displayName: "Qwen Plus 0728",
                    shortDescription: "qwen \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-flash-02-23",
                    displayName: "Qwen3.5-Flash",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder:free",
                    displayName: "Qwen3 Coder 480B A35B (free)",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-30b-a3b-instruct-2507",
                    displayName: "Qwen3 30B A3B Instruct 2507",
                    shortDescription: "qwen \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-2.5-coder-32b-instruct",
                    displayName: "Qwen2.5 Coder 32B Instruct",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-next-80b-a3b-thinking",
                    displayName: "Qwen3-Next 80B-A3B (Thinking)",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b-thinking-2507",
                    displayName: "Qwen3 235B A22B Thinking 2507",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-32b-instruct",
                    displayName: "Qwen3 VL 32B Instruct",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder",
                    displayName: "Qwen3 Coder 480B A35B",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-flash",
                    displayName: "Qwen3.6 Flash",
                    shortDescription: "qwen3.6 \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-plus-02-15",
                    displayName: "Qwen3.5 Plus 2026-02-15",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-2.5-7b-instruct",
                    displayName: "Qwen2.5 7B Instruct",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-8b-thinking",
                    displayName: "Qwen3 VL 8B Thinking",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-max-thinking",
                    displayName: "Qwen3 Max Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-30b-a3b-thinking-2507",
                    displayName: "Qwen3 30B A3B Thinking 2507",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen2.5-vl-72b-instruct",
                    displayName: "Qwen2.5 VL 72B Instruct",
                    shortDescription: "qwen \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-27b",
                    displayName: "Qwen3.5 27B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b",
                    displayName: "Qwen3 235B-A22B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-2.5-72b-instruct",
                    displayName: "Qwen2.5 72B Instruct",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen-plus-2025-07-28:thinking",
                    displayName: "Qwen Plus 0728 (thinking)",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-next",
                    displayName: "Qwen3 Coder Next",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-27b",
                    displayName: "Qwen3.6 27B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-35b-a3b",
                    displayName: "Qwen3.5 35B-A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-9b",
                    displayName: "Qwen3.5-9B",
                    shortDescription: "qwen3.5 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-397b-a17b",
                    displayName: "Qwen3.5 397B-A17B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-30b-a3b-instruct",
                    displayName: "Qwen3 VL 30B A3B Instruct",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-235b-a22b-2507",
                    displayName: "Qwen3 235B A22B Instruct 2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-flash",
                    displayName: "Qwen3 Coder Flash",
                    shortDescription: "qwen \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-14b",
                    displayName: "Qwen3 14B",
                    shortDescription: "qwen \u{B7} 40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-vl-235b-a22b-instruct",
                    displayName: "Qwen3 VL 235B A22B Instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-30b-a3b",
                    displayName: "Qwen3 30B A3B",
                    shortDescription: "qwen \u{B7} 40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-max-preview",
                    displayName: "Qwen3.6 Max Preview",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-122b-a10b",
                    displayName: "Qwen3.5 122B-A10B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-lite-v1",
                    displayName: "Nova Lite 1.0",
                    shortDescription: "nova-lite \u{B7} 300K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-premier-v1",
                    displayName: "Nova Premier 1.0",
                    shortDescription: "nova \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-pro-v1",
                    displayName: "Nova Pro 1.0",
                    shortDescription: "nova-pro \u{B7} 300K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-micro-v1",
                    displayName: "Nova Micro 1.0",
                    shortDescription: "nova-micro \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "amazon/nova-2-lite-v1",
                    displayName: "Nova 2 Lite",
                    shortDescription: "nova \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-rp-llama-3.1-8b",
                    displayName: "Aion-RP 1.0 (8B)",
                    shortDescription: "llama \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-1.0-mini",
                    displayName: "Aion-1.0-Mini",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-2.0",
                    displayName: "Aion-2.0",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "aion-labs/aion-1.0",
                    displayName: "Aion-1.0",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "inflection/inflection-3-pi",
                    displayName: "Inflection 3 Pi",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "inflection/inflection-3-productivity",
                    displayName: "Inflection 3 Productivity",
                    shortDescription: "8K context"
                ),
                AIScriptModelPreset(
                    id: "sao10k/l3.1-euryale-70b",
                    displayName: "Llama 3.1 Euryale 70B v2.2",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "sao10k/l3.3-euryale-70b",
                    displayName: "Llama 3.3 Euryale 70B",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "sao10k/l3-lunaris-8b",
                    displayName: "Llama 3 8B Lunaris",
                    shortDescription: "llama \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "sao10k/l3.1-70b-hanami-x1",
                    displayName: "Llama 3.1 70B Hanami x1",
                    shortDescription: "llama \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "upstage/solar-pro-3",
                    displayName: "Solar Pro 3",
                    shortDescription: "solar-pro \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "allenai/olmo-3-32b-think",
                    displayName: "Olmo 3 32B Think",
                    shortDescription: "allenai \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "essentialai/rnj-1-instruct",
                    displayName: "Rnj 1 Instruct",
                    shortDescription: "rnj \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-0528",
                    displayName: "R1 0528",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.1-terminus",
                    displayName: "DeepSeek V3.1 Terminus",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1-distill-llama-70b",
                    displayName: "R1 Distill Llama 70B",
                    shortDescription: "deepseek-thinking \u{B7} 8K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-r1",
                    displayName: "DeepSeek-R1",
                    shortDescription: "deepseek-thinking \u{B7} 64K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2-exp",
                    displayName: "DeepSeek V3.2 Exp",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-chat-v3-0324",
                    displayName: "DeepSeek V3 0324",
                    shortDescription: "deepseek \u{B7} 163K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-chat",
                    displayName: "DeepSeek Chat",
                    shortDescription: "deepseek \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-chat-v3.1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.1",
                    displayName: "MiniMax-M2.1",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-01",
                    displayName: "MiniMax-01",
                    shortDescription: "minimax \u{B7} 1.00019M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m3",
                    displayName: "MiniMax-M3",
                    shortDescription: "minimax \u{B7} 524K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2",
                    displayName: "MiniMax-M2",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2-her",
                    displayName: "MiniMax M2-her",
                    shortDescription: "minimax \u{B7} 65K context"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m1",
                    displayName: "MiniMax M1",
                    shortDescription: "minimax \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kwaipilot/kat-coder-pro-v2",
                    displayName: "KAT-Coder-Pro V2",
                    shortDescription: "kat-coder \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "nousresearch/hermes-3-llama-3.1-405b:free",
                    displayName: "Hermes 3 405B Instruct (free)",
                    shortDescription: "hermes \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "nousresearch/hermes-4-405b",
                    displayName: "Hermes 4 405B",
                    shortDescription: "hermes \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nousresearch/hermes-3-llama-3.1-70b",
                    displayName: "Hermes 3 70B Instruct",
                    shortDescription: "nousresearch \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "nousresearch/hermes-3-llama-3.1-405b",
                    displayName: "Hermes 3 405B Instruct",
                    shortDescription: "nousresearch \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "nousresearch/hermes-4-70b",
                    displayName: "Hermes 4 70B",
                    shortDescription: "hermes \u{B7} 131K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "orcarouter",
            displayName: "OrcaRouter",
            shortDescription: "OpenAI-compatible \u{B7} 81 text models",
            baseURLString: "https://api.orcarouter.ai/v1",
            apiKeyLabel: "OrcaRouter API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31b-it",
                    displayName: "Gemma 4 31B IT",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro-preview-customtools",
                    displayName: "Gemini 3.1 Pro Preview Custom Tools",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-flash-lite-latest",
                    displayName: "Gemini Flash-Lite Latest",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash-lite",
                    displayName: "Gemini 2.5 Flash-Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro-preview",
                    displayName: "Gemini 3.1 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-26b-a4b-it",
                    displayName: "Gemma 4 26B A4B IT",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-pro-preview",
                    displayName: "Gemini 3 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-flash-preview",
                    displayName: "Gemini 3 Flash Preview",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-flash-latest",
                    displayName: "Gemini Flash Latest",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-flash-lite-preview",
                    displayName: "Gemini 3.1 Flash Lite Preview",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.5",
                    displayName: "GLM-4.5",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.6",
                    displayName: "GLM-4.6",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.5-air",
                    displayName: "GLM-4.5-Air",
                    shortDescription: "glm-air \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-pro",
                    displayName: "GPT-5.2 Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo",
                    displayName: "GPT-3.5-turbo",
                    shortDescription: "gpt \u{B7} 16K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-pro",
                    displayName: "GPT-5 Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o",
                    displayName: "GPT-4o",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4",
                    displayName: "GPT-4",
                    shortDescription: "gpt \u{B7} 8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-2024-05-13",
                    displayName: "GPT-4o (2024-05-13)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-nano",
                    displayName: "GPT-5.4 nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-chat-latest",
                    displayName: "GPT-5 Chat (latest)",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex",
                    displayName: "GPT-5.1 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-max",
                    displayName: "GPT-5.1 Codex Max",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-chat-latest",
                    displayName: "GPT-5.3 Chat (latest)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-2024-08-06",
                    displayName: "GPT-4o (2024-08-06)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-codex",
                    displayName: "GPT-5.3 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-mini",
                    displayName: "GPT-5.1 Codex mini",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-chat-latest",
                    displayName: "GPT-5.1 Chat",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-chat-latest",
                    displayName: "GPT-5.2 Chat",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-nano",
                    displayName: "GPT-4.1 nano",
                    shortDescription: "gpt-nano \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-2024-11-20",
                    displayName: "GPT-4o (2024-11-20)",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-mini",
                    displayName: "GPT-5.4 mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-mini",
                    displayName: "GPT-5 Mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-mini",
                    displayName: "GPT-4.1 mini",
                    shortDescription: "gpt-mini \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4-turbo",
                    displayName: "GPT-4 Turbo",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-nano",
                    displayName: "GPT-5 Nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-pro",
                    displayName: "GPT-5.4 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5-pro",
                    displayName: "GPT-5.5 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini",
                    displayName: "GPT-4o mini",
                    shortDescription: "gpt-mini \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-codex",
                    displayName: "GPT-5-Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-codex",
                    displayName: "GPT-5.2 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1",
                    displayName: "GPT-5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi/kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi/kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "orcarouter/auto",
                    displayName: "OrcaRouter Auto",
                    shortDescription: "auto \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.5",
                    displayName: "Claude Sonnet 4.5 (latest)",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4",
                    displayName: "Claude Sonnet 4 (latest)",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-haiku-4.5",
                    displayName: "Claude Haiku 4.5 (latest)",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.1",
                    displayName: "Claude Opus 4.1 (latest)",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.5",
                    displayName: "Claude Opus 4.5 (latest)",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4",
                    displayName: "Claude Opus 4 (latest)",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok/grok-4.3",
                    displayName: "Grok 4.3",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-35b-a3b",
                    displayName: "Qwen3.6 35B-A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-max",
                    displayName: "Qwen3 Max",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-plus",
                    displayName: "Qwen3.5 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-27b",
                    displayName: "Qwen3.5 27B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-35b-a3b",
                    displayName: "Qwen3.5 35B-A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-397b-a17b",
                    displayName: "Qwen3.5 397B-A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-122b-a10b",
                    displayName: "Qwen3.5 122B-A10B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-reasoner",
                    displayName: "DeepSeek Reasoner",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-chat",
                    displayName: "DeepSeek Chat",
                    shortDescription: "deepseek \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.7-highspeed",
                    displayName: "MiniMax-M2.7-highspeed",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.5-highspeed",
                    displayName: "MiniMax-M2.5-highspeed",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "ovhcloud",
            displayName: "OVHcloud AI Endpoints",
            shortDescription: "OpenAI-compatible \u{B7} 15 text models",
            baseURLString: "https://oai.endpoints.kepler.ai.cloud.ovh.net/v1",
            apiKeyLabel: "OVHcloud AI Endpoints API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "llama-3.1-8b-instruct",
                    displayName: "Llama-3.1-8B-Instruct",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-30b-a3b-instruct",
                    displayName: "Qwen3-Coder-30B-A3B-Instruct",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-32b",
                    displayName: "Qwen3-32B",
                    shortDescription: "32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3guard-gen-8b",
                    displayName: "Qwen3Guard-Gen-8B",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3guard-gen-0.6b",
                    displayName: "Qwen3Guard-Gen-0.6B",
                    shortDescription: "32K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama-3_3-70b-instruct",
                    displayName: "Meta-Llama-3_3-70B-Instruct",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-small-3.2-24b-instruct-2506",
                    displayName: "Mistral-Small-3.2-24B-Instruct-2506",
                    shortDescription: "131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen2.5-vl-72b-instruct",
                    displayName: "Qwen2.5-VL-72B-Instruct",
                    shortDescription: "32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-120b",
                    displayName: "gpt-oss-120b",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-7b-instruct-v0.3",
                    displayName: "Mistral-7B-Instruct-v0.3",
                    shortDescription: "65K context"
                ),
                AIScriptModelPreset(
                    id: "mistral-nemo-instruct-2407",
                    displayName: "Mistral-Nemo-Instruct-2407",
                    shortDescription: "65K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-27b",
                    displayName: "Qwen3.6-27B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-9b",
                    displayName: "Qwen3.5-9B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-397b-a17b",
                    displayName: "Qwen3.5-397B-A17B",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-20b",
                    displayName: "gpt-oss-20b",
                    shortDescription: "131K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "perplexity",
            displayName: "Perplexity",
            shortDescription: "OpenAI-compatible \u{B7} 4 text models",
            baseURLString: "https://api.perplexity.ai",
            apiKeyLabel: "Perplexity API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "sonar-reasoning-pro",
                    displayName: "Sonar Reasoning Pro",
                    shortDescription: "sonar-reasoning \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "sonar",
                    displayName: "Sonar",
                    shortDescription: "sonar \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "sonar-pro",
                    displayName: "Sonar Pro",
                    shortDescription: "sonar-pro \u{B7} 200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "sonar-deep-research",
                    displayName: "Perplexity Sonar Deep Research",
                    shortDescription: "128K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "poe",
            displayName: "Poe",
            shortDescription: "OpenAI-compatible \u{B7} 104 text models",
            baseURLString: "https://api.poe.com/v1",
            apiKeyLabel: "Poe API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "trytako/tako",
                    displayName: "Tako",
                    shortDescription: "tako \u{B7} 2K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "xai/grok-code-fast-1",
                    displayName: "Grok Code Fast 1",
                    shortDescription: "grok \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xai/grok-4.1-fast-reasoning",
                    displayName: "Grok-4.1-Fast-Reasoning",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xai/grok-3-mini",
                    displayName: "Grok 3 Mini",
                    shortDescription: "grok \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xai/grok-4.1-fast-non-reasoning",
                    displayName: "Grok-4.1-Fast-Non-Reasoning",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "xai/grok-3",
                    displayName: "Grok 3",
                    shortDescription: "grok \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "xai/grok-4-fast-reasoning",
                    displayName: "Grok-4-Fast-Reasoning",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xai/grok-4",
                    displayName: "Grok-4",
                    shortDescription: "grok \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xai/grok-4-fast-non-reasoning",
                    displayName: "Grok-4-Fast-Non-Reasoning",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "xai/grok-4.20-multi-agent",
                    displayName: "Grok-4.20-Multi-Agent",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "fireworks-ai/kimi-k2.5-fw",
                    displayName: "Kimi-K2.5-FW",
                    shortDescription: "262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-flash-lite",
                    displayName: "Gemini-3.1-Flash-Lite",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/nano-banana",
                    displayName: "Nano-Banana",
                    shortDescription: "nano-banana \u{B7} 65K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-deep-research",
                    displayName: "gemini-deep-research",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-flash",
                    displayName: "Gemini-3-Flash",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro",
                    displayName: "Gemini-2.5-Pro",
                    shortDescription: "gemini-pro \u{B7} 1.06553M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash",
                    displayName: "Gemini-2.5-Flash",
                    shortDescription: "gemini-flash \u{B7} 1.06553M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.5-flash",
                    displayName: "Gemini-3.5-Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31b",
                    displayName: "Gemma-4-31B",
                    shortDescription: "262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-pro",
                    displayName: "Gemini-3-Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.0-flash",
                    displayName: "Gemini-2.0-Flash",
                    shortDescription: "gemini-flash \u{B7} 990K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash-lite",
                    displayName: "Gemini-2.5-Flash-Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.024M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro",
                    displayName: "Gemini-3.1-Pro",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.0-flash-lite",
                    displayName: "Gemini-2.0-Flash-Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 990K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/chatgpt-4o-latest",
                    displayName: "ChatGPT-4o-Latest",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo-instruct",
                    displayName: "GPT-3.5-Turbo-Instruct",
                    shortDescription: "gpt \u{B7} 3K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o3",
                    displayName: "o3",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-instant",
                    displayName: "GPT-5.2-Instant",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-search",
                    displayName: "GPT-4o-Search",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-pro",
                    displayName: "GPT-5.2-Pro",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4-classic-0314",
                    displayName: "GPT-4-Classic-0314",
                    shortDescription: "gpt \u{B7} 8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-chat",
                    displayName: "GPT-5-Chat",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo",
                    displayName: "GPT-3.5-Turbo",
                    shortDescription: "gpt \u{B7} 16K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-pro",
                    displayName: "GPT-5-Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o",
                    displayName: "GPT-4o",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini",
                    displayName: "o4-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-pro",
                    displayName: "o3-pro",
                    shortDescription: "o-pro \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4-classic",
                    displayName: "GPT-4-Classic",
                    shortDescription: "gpt \u{B7} 8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-aug",
                    displayName: "GPT-4o-Aug",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-nano",
                    displayName: "GPT-5.4-Nano",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex",
                    displayName: "GPT-5.1-Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-instant",
                    displayName: "GPT-5.3-Instant",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-codex-spark",
                    displayName: "GPT-5.3-Codex-Spark",
                    shortDescription: "128K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-max",
                    displayName: "GPT-5.1-Codex-Max",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-mini",
                    displayName: "o3-mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-codex",
                    displayName: "GPT-5.3-Codex",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-mini",
                    displayName: "GPT-5.1-Codex-Mini",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini-deep-research",
                    displayName: "o4-mini-deep-research",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-nano",
                    displayName: "GPT-4.1-nano",
                    shortDescription: "gpt-nano \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-3.5-turbo-raw",
                    displayName: "GPT-3.5-Turbo-Raw",
                    shortDescription: "gpt \u{B7} 4K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o1",
                    displayName: "o1",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o1-pro",
                    displayName: "o1-pro",
                    shortDescription: "o-pro \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-mini",
                    displayName: "GPT-5.4-Mini",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-deep-research",
                    displayName: "o3-deep-research",
                    shortDescription: "o \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-mini",
                    displayName: "GPT-5-mini",
                    shortDescription: "gpt-mini \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-mini",
                    displayName: "GPT-4.1-mini",
                    shortDescription: "gpt-mini \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4-turbo",
                    displayName: "GPT-4-Turbo",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-nano",
                    displayName: "GPT-5-nano",
                    shortDescription: "gpt-nano \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o3-mini-high",
                    displayName: "o3-mini-high",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5-pro",
                    displayName: "GPT-5.5-Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini",
                    displayName: "GPT-4o-mini",
                    shortDescription: "gpt-mini \u{B7} 124K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini-search",
                    displayName: "GPT-4o-mini-Search",
                    shortDescription: "gpt-mini \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-codex",
                    displayName: "GPT-5-Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-codex",
                    displayName: "GPT-5.2-Codex",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-instant",
                    displayName: "GPT-5.1-Instant",
                    shortDescription: "gpt \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1",
                    displayName: "GPT-5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "cerebras/llama-3.1-8b-cs",
                    displayName: "Llama-3.1-8B-CS",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "cerebras/qwen3-235b-2507-cs",
                    displayName: "qwen3-235b-2507-cs",
                    shortDescription: "Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "cerebras/gpt-oss-120b-cs",
                    displayName: "GPT-OSS-120B-CS",
                    shortDescription: "128K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "cerebras/llama-3.3-70b-cs",
                    displayName: "llama-3.3-70b-cs",
                    shortDescription: "Attachments"
                ),
                AIScriptModelPreset(
                    id: "cerebras/qwen3-32b-cs",
                    displayName: "qwen3-32b-cs",
                    shortDescription: "Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-3.5",
                    displayName: "Claude-Sonnet-3.5",
                    shortDescription: "claude-sonnet \u{B7} 189K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-3.7",
                    displayName: "Claude-Sonnet-3.7",
                    shortDescription: "claude-sonnet \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-3.5-june",
                    displayName: "Claude-Sonnet-3.5-June",
                    shortDescription: "claude-sonnet \u{B7} 189K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.5",
                    displayName: "Claude-Sonnet-4.5",
                    shortDescription: "claude-sonnet \u{B7} 983K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4",
                    displayName: "Claude-Sonnet-4",
                    shortDescription: "claude-sonnet \u{B7} 983K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-haiku-4.5",
                    displayName: "Claude-Haiku-4.5",
                    shortDescription: "claude-haiku \u{B7} 192K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-haiku-3",
                    displayName: "Claude-Haiku-3",
                    shortDescription: "claude-haiku \u{B7} 189K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.7",
                    displayName: "Claude-Opus-4.7",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-haiku-3.5",
                    displayName: "Claude-Haiku-3.5",
                    shortDescription: "claude-haiku \u{B7} 189K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.8",
                    displayName: "Claude-Opus-4.8",
                    shortDescription: "claude-opus \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.1",
                    displayName: "Claude-Opus-4.1",
                    shortDescription: "claude-opus \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.5",
                    displayName: "Claude-Opus-4.5",
                    shortDescription: "claude-opus \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.6",
                    displayName: "Claude-Sonnet-4.6",
                    shortDescription: "983K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4",
                    displayName: "Claude-Opus-4",
                    shortDescription: "claude-opus \u{B7} 192K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6",
                    displayName: "Claude-Opus-4.6",
                    shortDescription: "983K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "poetools/claude-code",
                    displayName: "claude-code",
                    shortDescription: "Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "empiriolabs/deepseek-v4-pro-el",
                    displayName: "DeepSeek-V4-Pro-EL",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "empiriolabs/deepseek-v4-flash-el",
                    displayName: "DeepSeek-V4-Flash-EL",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "novita/glm-4.7",
                    displayName: "glm-4.7",
                    shortDescription: "205K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "novita/minimax-m2.1",
                    displayName: "minimax-m2.1",
                    shortDescription: "205K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "novita/glm-4.6",
                    displayName: "GLM-4.6",
                    shortDescription: "glm \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "novita/kimi-k2-thinking",
                    displayName: "kimi-k2-thinking",
                    shortDescription: "kimi-thinking \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "novita/kimi-k2.5",
                    displayName: "Kimi-K2.5",
                    shortDescription: "128K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "novita/glm-4.6v",
                    displayName: "glm-4.6v",
                    shortDescription: "131K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "novita/kimi-k2.6",
                    displayName: "Kimi-K2.6",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "novita/glm-4.7-flash",
                    displayName: "glm-4.7-flash",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "novita/glm-4.7-n",
                    displayName: "glm-4.7-n",
                    shortDescription: "205K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "novita/glm-5",
                    displayName: "GLM-5",
                    shortDescription: "205K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "novita/deepseek-v3.2",
                    displayName: "DeepSeek-V3.2",
                    shortDescription: "128K context \u{B7} Reasoning \u{B7} Attachments"
                )
            ]
        ),
        AIScriptProvider(
            id: "poolside",
            displayName: "Poolside",
            shortDescription: "OpenAI-compatible \u{B7} 2 text models",
            baseURLString: "https://inference.poolside.ai/v1",
            apiKeyLabel: "Poolside API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "poolside/laguna-xs.2",
                    displayName: "Laguna XS.2",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "poolside/laguna-m.1",
                    displayName: "Laguna M.1",
                    shortDescription: "262K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "privatemode-ai",
            displayName: "Privatemode AI",
            shortDescription: "OpenAI-compatible \u{B7} 3 text models",
            baseURLString: "http://localhost:8080/v1",
            apiKeyLabel: "Privatemode AI API Key",
            requiresAPIKey: false,
            modelPresets: [
                AIScriptModelPreset(
                    id: "gemma-3-27b",
                    displayName: "Gemma 3 27B",
                    shortDescription: "gemma \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-120b",
                    displayName: "gpt-oss-120b",
                    shortDescription: "gpt-oss \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-30b-a3b",
                    displayName: "Qwen3-Coder 30B-A3B",
                    shortDescription: "qwen \u{B7} 128K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "qihang-ai",
            displayName: "QiHang",
            shortDescription: "OpenAI-compatible \u{B7} 9 text models",
            baseURLString: "https://api.qhaigc.net/v1",
            apiKeyLabel: "QiHang API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "claude-haiku-4-5-20251001",
                    displayName: "Claude Haiku 4.5",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-opus-4-5-20251101",
                    displayName: "Claude Opus 4.5",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-sonnet-4-5-20250929",
                    displayName: "Claude Sonnet 4.5",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-pro-preview",
                    displayName: "Gemini 3 Pro Preview",
                    shortDescription: "gemini-pro \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5-mini",
                    displayName: "GPT-5-Mini",
                    shortDescription: "gpt-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3-flash-preview",
                    displayName: "Gemini 3 Flash Preview",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-5.2-codex",
                    displayName: "GPT-5.2 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "qiniu-ai",
            displayName: "Qiniu",
            shortDescription: "OpenAI-compatible \u{B7} 88 text models",
            baseURLString: "https://api.qnaigc.com/v1",
            apiKeyLabel: "Qiniu API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "deepseek-r1-0528",
                    displayName: "DeepSeek-R1-0528",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "doubao-1.5-thinking-pro",
                    displayName: "Doubao 1.5 Thinking Pro",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-vl-30b-a3b-thinking",
                    displayName: "Qwen3-Vl 30b A3b Thinking",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-3.5-haiku",
                    displayName: "Claude 3.5 Haiku",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3-0324",
                    displayName: "DeepSeek-V3-0324",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b-instruct-2507",
                    displayName: "Qwen3 235b A22B Instruct 2507",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3",
                    displayName: "DeepSeek-V3",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2",
                    displayName: "Kimi K2",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-32b",
                    displayName: "Qwen3 32B",
                    shortDescription: "40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max-preview",
                    displayName: "Qwen3 Max Preview",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "claude-3.5-sonnet",
                    displayName: "Claude 3.5 Sonnet",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3-next-80b-a3b-instruct",
                    displayName: "Qwen3 Next 80B A3B Instruct",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-4.5-haiku",
                    displayName: "Claude 4.5 Haiku",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5",
                    displayName: "GLM 4.5",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-4.1-opus",
                    displayName: "Claude 4.1 Opus",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3-max",
                    displayName: "Qwen3 Max",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-2.0-pro",
                    displayName: "Doubao Seed 2.0 Pro",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-1.6",
                    displayName: "Doubao-Seed 1.6",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-1.6-thinking",
                    displayName: "Doubao-Seed 1.6 Thinking",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.0-flash",
                    displayName: "Gemini 2.0 Flash",
                    shortDescription: "1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen-max-2025-01-25",
                    displayName: "Qwen2.5-Max-2025-01-25",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "claude-4.0-sonnet",
                    displayName: "Claude 4.0 Sonnet",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-1.5-pro-32k",
                    displayName: "Doubao 1.5 Pro 32k",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-30b-a3b-instruct-2507",
                    displayName: "Qwen3 30b A3b Instruct 2507",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-next-80b-a3b-thinking",
                    displayName: "Qwen3 Next 80B A3B Thinking",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b-thinking-2507",
                    displayName: "Qwen3 235B A22B Thinking 2507",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-r1",
                    displayName: "DeepSeek-R1",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "doubao-1.5-vision-pro",
                    displayName: "Doubao 1.5 Vision Pro",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.5-flash-lite",
                    displayName: "Gemini 2.5 Flash Lite",
                    shortDescription: "1.04858M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-3.7-sonnet",
                    displayName: "Claude 3.7 Sonnet",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen3-30b-a3b-thinking-2507",
                    displayName: "Qwen3 30b A3b Thinking 2507",
                    shortDescription: "126K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen2.5-vl-72b-instruct",
                    displayName: "Qwen 2.5 VL 72B Instruct",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-120b",
                    displayName: "gpt-oss-120b",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-1.6-flash",
                    displayName: "Doubao-Seed 1.6 Flash",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v3.1",
                    displayName: "DeepSeek-V3.1",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b",
                    displayName: "Qwen 3 235B A22B",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-480b-a35b-instruct",
                    displayName: "Qwen3 Coder 480B A35B Instruct",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-397b-a17b",
                    displayName: "Qwen3.5 397B A17B",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-flash",
                    displayName: "Mimo-V2-Flash",
                    shortDescription: "mimo \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-vl-max-2025-01-25",
                    displayName: "Qwen VL-MAX-2025-01-25",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen2.5-vl-7b-instruct",
                    displayName: "Qwen 2.5 VL 7B Instruct",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-air",
                    displayName: "GLM 4.5 Air",
                    shortDescription: "131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-4.5-opus",
                    displayName: "Claude 4.5 Opus",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.0-pro-preview",
                    displayName: "Gemini 3.0 Pro Preview",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-2.0-mini",
                    displayName: "Doubao Seed 2.0 Mini",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "claude-4.0-opus",
                    displayName: "Claude 4.0 Opus",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-20b",
                    displayName: "gpt-oss-20b",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemini-3.0-flash-preview",
                    displayName: "Gemini 3.0 Flash Preview",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "MiniMax-M1",
                    displayName: "MiniMax M1",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen-turbo",
                    displayName: "Qwen-Turbo",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-30b-a3b",
                    displayName: "Qwen3 30B A3B",
                    shortDescription: "40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "claude-4.5-sonnet",
                    displayName: "Claude 4.5 Sonnet",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-2.0-lite",
                    displayName: "Doubao Seed 2.0 Lite",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemini-2.0-flash-lite",
                    displayName: "Gemini 2.0 Flash Lite",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "doubao-seed-2.0-code",
                    displayName: "Doubao Seed 2.0 Code",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.5",
                    displayName: "Moonshotai/Kimi-K2.5",
                    shortDescription: "256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-0905",
                    displayName: "Kimi K2 0905",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "stepfun-ai/gelab-zero-4b-preview",
                    displayName: "Stepfun-Ai/Gelab Zero 4b Preview",
                    shortDescription: "8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-code-fast-1",
                    displayName: "x-AI/Grok-Code-Fast 1",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.1-fast-reasoning",
                    displayName: "X-Ai/Grok 4.1 Fast Reasoning",
                    shortDescription: "20M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.1-fast-non-reasoning",
                    displayName: "X-Ai/Grok 4.1 Fast Non Reasoning",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4-fast-reasoning",
                    displayName: "X-Ai/Grok-4-Fast-Reasoning",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4-fast",
                    displayName: "x-AI/Grok-4-Fast",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4-fast-non-reasoning",
                    displayName: "X-Ai/Grok-4-Fast-Non-Reasoning",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.1-fast",
                    displayName: "x-AI/Grok-4.1-Fast",
                    shortDescription: "2M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/autoglm-phone-9b",
                    displayName: "Z-Ai/Autoglm Phone 9b",
                    shortDescription: "12K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.7",
                    displayName: "Z-Ai/GLM 4.7",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.6",
                    displayName: "Z-AI/GLM 4.6",
                    shortDescription: "200K context"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5",
                    displayName: "Z-Ai/GLM 5",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5",
                    displayName: "OpenAI/GPT-5",
                    shortDescription: "400K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2",
                    displayName: "OpenAI/GPT-5.2",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-flash",
                    displayName: "Xiaomi/Mimo-V2-Flash",
                    shortDescription: "mimo \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "stepfun/step-3.5-flash",
                    displayName: "Stepfun/Step-3.5 Flash",
                    shortDescription: "64K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "meituan/longcat-flash-lite",
                    displayName: "Meituan/Longcat-Flash-Lite",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "meituan/longcat-flash-chat",
                    displayName: "Meituan/Longcat-Flash-Chat",
                    shortDescription: "131K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.1-terminus",
                    displayName: "DeepSeek/DeepSeek-V3.1-Terminus",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.1-terminus-thinking",
                    displayName: "DeepSeek/DeepSeek-V3.1-Terminus-Thinking",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2-exp-thinking",
                    displayName: "DeepSeek/DeepSeek-V3.2-Exp-Thinking",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2-exp",
                    displayName: "DeepSeek/DeepSeek-V3.2-Exp",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2-251201",
                    displayName: "Deepseek/DeepSeek-V3.2",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-math-v2",
                    displayName: "Deepseek/Deepseek-Math-V2",
                    shortDescription: "160K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.5",
                    displayName: "Minimax/Minimax-M2.5",
                    shortDescription: "204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.1",
                    displayName: "Minimax/Minimax-M2.1",
                    shortDescription: "204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2",
                    displayName: "Minimax/Minimax-M2",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.5-highspeed",
                    displayName: "Minimax/Minimax-M2.5 Highspeed",
                    shortDescription: "204K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "regolo-ai",
            displayName: "Regolo AI",
            shortDescription: "OpenAI-compatible \u{B7} 10 text models",
            baseURLString: "https://api.regolo.ai/v1",
            apiKeyLabel: "Regolo AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "llama-3.1-8b-instruct",
                    displayName: "Llama 3.1 8B Instruct",
                    shortDescription: "llama \u{B7} 120K context"
                ),
                AIScriptModelPreset(
                    id: "minimax-m2.5",
                    displayName: "MiniMax 2.5",
                    shortDescription: "minimax \u{B7} 190K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-small3.2",
                    displayName: "Mistral Small 3.2",
                    shortDescription: "mistral-small \u{B7} 120K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "llama-3.3-70b-instruct",
                    displayName: "Llama 3.3 70B Instruct",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-122b",
                    displayName: "Qwen3.5-122B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-120b",
                    displayName: "GPT-OSS-120B",
                    shortDescription: "gpt-oss \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-next",
                    displayName: "Qwen3-Coder-Next",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-9b",
                    displayName: "Qwen3.5-9B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-small-4-119b",
                    displayName: "Mistral Small 4 119B",
                    shortDescription: "mistral-small \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-20b",
                    displayName: "GPT-OSS-20B",
                    shortDescription: "gpt-oss \u{B7} 128K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "requesty",
            displayName: "Requesty",
            shortDescription: "OpenAI-compatible \u{B7} 37 text models",
            baseURLString: "https://router.requesty.ai/v1",
            apiKeyLabel: "Requesty API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "xai/grok-4",
                    displayName: "Grok 4",
                    shortDescription: "grok \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xai/grok-4-fast",
                    displayName: "Grok 4 Fast",
                    shortDescription: "grok \u{B7} 2M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-pro-preview",
                    displayName: "Gemini 3 Pro",
                    shortDescription: "gemini-pro \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-flash-preview",
                    displayName: "Gemini 3 Flash",
                    shortDescription: "1.04858M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-chat",
                    displayName: "GPT-5.2 Chat",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-pro",
                    displayName: "GPT-5.2 Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-chat",
                    displayName: "GPT-5 Chat (latest)",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-pro",
                    displayName: "GPT-5 Pro",
                    shortDescription: "gpt-pro \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/o4-mini",
                    displayName: "o4 Mini",
                    shortDescription: "o-mini \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-chat",
                    displayName: "GPT-5.1 Chat",
                    shortDescription: "gpt-codex \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex",
                    displayName: "GPT-5.1-Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-max",
                    displayName: "GPT-5.1-Codex-Max",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-codex",
                    displayName: "GPT-5.3-Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-mini",
                    displayName: "GPT-5.1-Codex-Mini",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1",
                    displayName: "GPT-4.1",
                    shortDescription: "gpt \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-mini",
                    displayName: "GPT-5 Mini",
                    shortDescription: "gpt-mini \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4.1-mini",
                    displayName: "GPT-4.1 Mini",
                    shortDescription: "gpt-mini \u{B7} 1.04758M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-nano",
                    displayName: "GPT-5 Nano",
                    shortDescription: "gpt-nano \u{B7} 16K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-pro",
                    displayName: "GPT-5.4 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-4o-mini",
                    displayName: "GPT-4o Mini",
                    shortDescription: "gpt-mini \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-codex",
                    displayName: "GPT-5 Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-codex",
                    displayName: "GPT-5.2-Codex",
                    shortDescription: "gpt-codex \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1",
                    displayName: "GPT-5.1",
                    shortDescription: "gpt \u{B7} 400K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-3-7-sonnet",
                    displayName: "Claude Sonnet 3.7",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4",
                    displayName: "Claude Sonnet 4",
                    shortDescription: "claude-sonnet \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4-5",
                    displayName: "Claude Opus 4.5",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4-5",
                    displayName: "Claude Sonnet 4.5",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4-1",
                    displayName: "Claude Opus 4.1",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-haiku-4-5",
                    displayName: "Claude Haiku 4.5",
                    shortDescription: "claude-haiku \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4-6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4-6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "claude-sonnet \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4",
                    displayName: "Claude Opus 4",
                    shortDescription: "claude-opus \u{B7} 200K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "routing-run",
            displayName: "routing.run",
            shortDescription: "OpenAI-compatible \u{B7} 26 text models",
            baseURLString: "https://ai.routing.sh/v1",
            apiKeyLabel: "routing.run API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "route/deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/deepseek-v4-flash-6bit",
                    displayName: "DeepSeek V4 Flash 6bit",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/minimax-m2.7-highspeed",
                    displayName: "MiniMax M2.7 Highspeed",
                    shortDescription: "minimax \u{B7} 100K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/glm-5.1-6bit",
                    displayName: "GLM 5.1 6bit",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/minimax-m2.5",
                    displayName: "MiniMax M2.5",
                    shortDescription: "minimax \u{B7} 100K context"
                ),
                AIScriptModelPreset(
                    id: "route/mistral-small-2503",
                    displayName: "Mistral Small 2503",
                    shortDescription: "mistral-small \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "route/gemma-4-31b-it",
                    displayName: "Gemma 4 31B IT",
                    shortDescription: "gemma \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "route/step-3.5-flash-2603",
                    displayName: "Step 3.5 Flash 2603",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/glm-5.1",
                    displayName: "GLM 5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/mistral-large-3",
                    displayName: "Mistral Large 3",
                    shortDescription: "mistral-large \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "route/deepseek-v4-pro-6bit",
                    displayName: "DeepSeek V4 Pro 6bit",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/mistral-medium-2505",
                    displayName: "Mistral Medium 2505",
                    shortDescription: "mistral-medium \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "route/minimax-m2.7",
                    displayName: "MiniMax M2.7",
                    shortDescription: "minimax \u{B7} 100K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/qwen3.6-27b-202k",
                    displayName: "Qwen3.6 27B 202K",
                    shortDescription: "qwen \u{B7} 202K context"
                ),
                AIScriptModelPreset(
                    id: "route/kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "route/minimax-m2.5-highspeed",
                    displayName: "MiniMax M2.5 Highspeed",
                    shortDescription: "minimax \u{B7} 100K context"
                ),
                AIScriptModelPreset(
                    id: "route/kimi-k2.6-6bit",
                    displayName: "Kimi K2.6 6bit",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/mimo-v2.5",
                    displayName: "MiMo V2.5",
                    shortDescription: "mimo \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/qwen3.6-27b",
                    displayName: "Qwen3.6 27B",
                    shortDescription: "qwen \u{B7} 202K context"
                ),
                AIScriptModelPreset(
                    id: "route/mimo-v2.5-pro-6bit",
                    displayName: "MiMo V2.5 Pro 6bit",
                    shortDescription: "mimo \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/stepfun-3.5-flash",
                    displayName: "StepFun 3.5 Flash",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/mimo-v2.5-pro",
                    displayName: "MiMo V2.5 Pro",
                    shortDescription: "mimo \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/step-3.5-flash",
                    displayName: "Step 3.5 Flash",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "route/deepseek-v3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 163K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "sarvam",
            displayName: "Sarvam AI",
            shortDescription: "OpenAI-compatible \u{B7} 2 text models",
            baseURLString: "https://api.sarvam.ai/v1",
            apiKeyLabel: "Sarvam AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "sarvam-105b",
                    displayName: "Sarvam-105B",
                    shortDescription: "sarvam \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "sarvam-30b",
                    displayName: "Sarvam-30B",
                    shortDescription: "sarvam \u{B7} 65K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "scaleway",
            displayName: "Scaleway",
            shortDescription: "OpenAI-compatible \u{B7} 13 text models",
            baseURLString: "https://api.scaleway.ai/v1",
            apiKeyLabel: "Scaleway API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "qwen3-235b-a22b-instruct-2507",
                    displayName: "Qwen3 235B A22B Instruct 2507",
                    shortDescription: "qwen \u{B7} 260K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3-coder-30b-a3b-instruct",
                    displayName: "Qwen3-Coder 30B-A3B Instruct",
                    shortDescription: "qwen \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "qwen3.6-35b-a3b",
                    displayName: "Qwen3.6 35B A3B",
                    shortDescription: "qwen \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "llama-3.3-70b-instruct",
                    displayName: "Llama-3.3-70B-Instruct",
                    shortDescription: "llama \u{B7} 100K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "pixtral-12b-2409",
                    displayName: "Pixtral 12B 2409",
                    shortDescription: "pixtral \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "mistral-small-3.2-24b-instruct-2506",
                    displayName: "Mistral Small 3.2 24B Instruct (2506)",
                    shortDescription: "mistral-small \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "gpt-oss-120b",
                    displayName: "GPT-OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "gemma-4-26b-a4b-it",
                    displayName: "Gemma 4 26B A4B IT",
                    shortDescription: "gemma \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mistral-medium-3.5-128b",
                    displayName: "Mistral Medium 3.5 128B",
                    shortDescription: "mistral-medium \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.5-397b-a17b",
                    displayName: "Qwen3.5 397B A17B",
                    shortDescription: "qwen \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "gemma-3-27b-it",
                    displayName: "Gemma-3-27B-IT",
                    shortDescription: "gemma \u{B7} 40K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "voxtral-small-24b-2507",
                    displayName: "Voxtral Small 24B 2507",
                    shortDescription: "voxtral \u{B7} 32K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "devstral-2-123b-instruct-2512",
                    displayName: "Devstral 2 123B Instruct (2512)",
                    shortDescription: "devstral \u{B7} 256K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "siliconflow",
            displayName: "SiliconFlow",
            shortDescription: "OpenAI-compatible \u{B7} 72 text models",
            baseURLString: "https://api.siliconflow.com/v1",
            apiKeyLabel: "SiliconFlow API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "THUDM/GLM-Z1-32B-0414",
                    displayName: "THUDM/GLM-Z1-32B-0414",
                    shortDescription: "glm-z \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "THUDM/GLM-4-32B-0414",
                    displayName: "THUDM/GLM-4-32B-0414",
                    shortDescription: "glm \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "THUDM/GLM-4-9B-0414",
                    displayName: "THUDM/GLM-4-9B-0414",
                    shortDescription: "glm \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "THUDM/GLM-Z1-9B-0414",
                    displayName: "THUDM/GLM-Z1-9B-0414",
                    shortDescription: "glm-z \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2-Thinking",
                    displayName: "moonshotai/Kimi-K2-Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2-Instruct-0905",
                    displayName: "moonshotai/Kimi-K2-Instruct-0905",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2-Instruct",
                    displayName: "moonshotai/Kimi-K2-Instruct",
                    shortDescription: "kimi-k2 \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.6",
                    displayName: "moonshotai/Kimi-K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.5",
                    displayName: "moonshotai/Kimi-K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "baidu/ERNIE-4.5-300B-A47B",
                    displayName: "baidu/ERNIE-4.5-300B-A47B",
                    shortDescription: "ernie \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "ByteDance-Seed/Seed-OSS-36B-Instruct",
                    displayName: "ByteDance-Seed/Seed-OSS-36B-Instruct",
                    shortDescription: "seed \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "stepfun-ai/Step-3.5-Flash",
                    displayName: "stepfun-ai/Step-3.5-Flash",
                    shortDescription: "step \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31B-it",
                    displayName: "Gemma 4 31B IT",
                    shortDescription: "gemma \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-26B-A4B-it",
                    displayName: "Gemma 4 26B A4B IT",
                    shortDescription: "gemma \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "inclusionAI/Ling-flash-2.0",
                    displayName: "inclusionAI/Ling-flash-2.0",
                    shortDescription: "ling \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Omni-30B-A3B-Thinking",
                    displayName: "Qwen/Qwen3-Omni-30B-A3B-Thinking",
                    shortDescription: "qwen \u{B7} 66K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-VL-72B-Instruct",
                    displayName: "Qwen/Qwen2.5-VL-72B-Instruct",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-VL-32B-Instruct",
                    displayName: "Qwen/Qwen2.5-VL-32B-Instruct",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-30B-A3B-Thinking-2507",
                    displayName: "Qwen/Qwen3-30B-A3B-Thinking-2507",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-7B-Instruct",
                    displayName: "Qwen/Qwen2.5-7B-Instruct",
                    shortDescription: "qwen \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-235B-A22B-Instruct",
                    displayName: "Qwen/Qwen3-VL-235B-A22B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-32B-Instruct",
                    displayName: "Qwen/Qwen2.5-32B-Instruct",
                    shortDescription: "qwen \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Next-80B-A3B-Instruct",
                    displayName: "Qwen/Qwen3-Next-80B-A3B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Thinking-2507",
                    displayName: "Qwen/Qwen3-235B-A22B-Thinking-2507",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-72B-Instruct-128K",
                    displayName: "Qwen/Qwen2.5-72B-Instruct-128K",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-480B-A35B-Instruct",
                    displayName: "Qwen/Qwen3-Coder-480B-A35B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-30B-A3B-Instruct",
                    displayName: "Qwen/Qwen3-Coder-30B-A3B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-30B-A3B-Instruct-2507",
                    displayName: "Qwen/Qwen3-30B-A3B-Instruct-2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-30B-A3B-Thinking",
                    displayName: "Qwen/Qwen3-VL-30B-A3B-Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-8B-Thinking",
                    displayName: "Qwen/Qwen3-VL-8B-Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-8B-Instruct",
                    displayName: "Qwen/Qwen3-VL-8B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/QwQ-32B",
                    displayName: "Qwen/QwQ-32B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-235B-A22B-Thinking",
                    displayName: "Qwen/Qwen3-VL-235B-A22B-Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Next-80B-A3B-Thinking",
                    displayName: "Qwen/Qwen3-Next-80B-A3B-Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-Coder-32B-Instruct",
                    displayName: "Qwen/Qwen2.5-Coder-32B-Instruct",
                    shortDescription: "qwen \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-VL-7B-Instruct",
                    displayName: "Qwen/Qwen2.5-VL-7B-Instruct",
                    shortDescription: "qwen \u{B7} 33K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-8B",
                    displayName: "Qwen/Qwen3-8B",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Instruct-2507",
                    displayName: "Qwen/Qwen3-235B-A22B-Instruct-2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-32B",
                    displayName: "Qwen/Qwen3-32B",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-32B-Instruct",
                    displayName: "Qwen/Qwen3-VL-32B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-14B-Instruct",
                    displayName: "Qwen/Qwen2.5-14B-Instruct",
                    shortDescription: "qwen \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-14B",
                    displayName: "Qwen/Qwen3-14B",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B",
                    displayName: "Qwen/Qwen3-235B-A22B",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-72B-Instruct",
                    displayName: "Qwen/Qwen2.5-72B-Instruct",
                    shortDescription: "qwen \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Omni-30B-A3B-Instruct",
                    displayName: "Qwen/Qwen3-Omni-30B-A3B-Instruct",
                    shortDescription: "qwen \u{B7} 66K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-30B-A3B-Instruct",
                    displayName: "Qwen/Qwen3-VL-30B-A3B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-32B-Thinking",
                    displayName: "Qwen/Qwen3-VL-32B-Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "openai/gpt-oss-120b",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "openai/gpt-oss-20b",
                    shortDescription: "gpt-oss \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "tencent/Hunyuan-MT-7B",
                    displayName: "tencent/Hunyuan-MT-7B",
                    shortDescription: "hunyuan \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "tencent/Hunyuan-A13B-Instruct",
                    displayName: "tencent/Hunyuan-A13B-Instruct",
                    shortDescription: "hunyuan \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5V-Turbo",
                    displayName: "zai-org/GLM-5V-Turbo",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.6",
                    displayName: "zai-org/GLM-4.6",
                    shortDescription: "glm \u{B7} 205K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.6V",
                    displayName: "zai-org/GLM-4.6V",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5",
                    displayName: "zai-org/GLM-5",
                    shortDescription: "glm \u{B7} 205K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.7",
                    displayName: "zai-org/GLM-4.7",
                    shortDescription: "glm \u{B7} 205K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.5V",
                    displayName: "zai-org/GLM-4.5V",
                    shortDescription: "glm \u{B7} 66K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.5-Air",
                    displayName: "zai-org/GLM-4.5-Air",
                    shortDescription: "glm-air \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1",
                    displayName: "zai-org/GLM-5.1",
                    shortDescription: "glm \u{B7} 205K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.5",
                    displayName: "zai-org/GLM-4.5",
                    shortDescription: "glm \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1",
                    displayName: "deepseek-ai/DeepSeek-R1",
                    shortDescription: "deepseek-thinking \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1-Distill-Qwen-32B",
                    displayName: "deepseek-ai/DeepSeek-R1-Distill-Qwen-32B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1-Terminus",
                    displayName: "deepseek-ai/DeepSeek-V3.1-Terminus",
                    shortDescription: "deepseek \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1",
                    displayName: "deepseek-ai/DeepSeek-V3.1",
                    shortDescription: "deepseek \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.2-Exp",
                    displayName: "deepseek-ai/DeepSeek-V3.2-Exp",
                    shortDescription: "deepseek \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/deepseek-vl2",
                    displayName: "deepseek-ai/deepseek-vl2",
                    shortDescription: "deepseek \u{B7} 4K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.2",
                    displayName: "deepseek-ai/DeepSeek-V3.2",
                    shortDescription: "deepseek \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3",
                    displayName: "deepseek-ai/DeepSeek-V3",
                    shortDescription: "deepseek \u{B7} 164K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1-Distill-Qwen-14B",
                    displayName: "deepseek-ai/DeepSeek-R1-Distill-Qwen-14B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5",
                    displayName: "MiniMaxAI/MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 197K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "siliconflow-cn",
            displayName: "SiliconFlow (China)",
            shortDescription: "OpenAI-compatible \u{B7} 77 text models",
            baseURLString: "https://api.siliconflow.cn/v1",
            apiKeyLabel: "SiliconFlow (China) API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "THUDM/GLM-Z1-9B-0414",
                    displayName: "THUDM/GLM-Z1-9B-0414",
                    shortDescription: "glm-z \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "THUDM/GLM-4-9B-0414",
                    displayName: "THUDM/GLM-4-9B-0414",
                    shortDescription: "glm \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "THUDM/GLM-4-32B-0414",
                    displayName: "THUDM/GLM-4-32B-0414",
                    shortDescription: "glm \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "THUDM/GLM-Z1-32B-0414",
                    displayName: "THUDM/GLM-Z1-32B-0414",
                    shortDescription: "glm-z \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2-Instruct-0905",
                    displayName: "moonshotai/Kimi-K2-Instruct-0905",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2-Thinking",
                    displayName: "moonshotai/Kimi-K2-Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "baidu/ERNIE-4.5-300B-A47B",
                    displayName: "baidu/ERNIE-4.5-300B-A47B",
                    shortDescription: "ernie \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "ByteDance-Seed/Seed-OSS-36B-Instruct",
                    displayName: "ByteDance-Seed/Seed-OSS-36B-Instruct",
                    shortDescription: "seed \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "stepfun-ai/Step-3.5-Flash",
                    displayName: "stepfun-ai/Step-3.5-Flash",
                    shortDescription: "step \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "inclusionAI/Ling-flash-2.0",
                    displayName: "inclusionAI/Ling-flash-2.0",
                    shortDescription: "ling \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Pro/moonshotai/Kimi-K2-Thinking",
                    displayName: "Pro/moonshotai/Kimi-K2-Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Pro/moonshotai/Kimi-K2-Instruct-0905",
                    displayName: "Pro/moonshotai/Kimi-K2-Instruct-0905",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Pro/moonshotai/Kimi-K2.6",
                    displayName: "Pro/moonshotai/Kimi-K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Pro/moonshotai/Kimi-K2.5",
                    displayName: "Pro/moonshotai/Kimi-K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Pro/zai-org/GLM-5",
                    displayName: "Pro/zai-org/GLM-5",
                    shortDescription: "glm \u{B7} 205K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Pro/zai-org/GLM-4.7",
                    displayName: "Pro/zai-org/GLM-4.7",
                    shortDescription: "glm \u{B7} 205K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Pro/zai-org/GLM-5.1",
                    displayName: "Pro/zai-org/GLM-5.1",
                    shortDescription: "glm \u{B7} 205K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Pro/deepseek-ai/DeepSeek-R1",
                    displayName: "Pro/deepseek-ai/DeepSeek-R1",
                    shortDescription: "deepseek-thinking \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Pro/deepseek-ai/DeepSeek-V3.1-Terminus",
                    displayName: "Pro/deepseek-ai/DeepSeek-V3.1-Terminus",
                    shortDescription: "deepseek \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Pro/deepseek-ai/DeepSeek-V3.2",
                    displayName: "Pro/deepseek-ai/DeepSeek-V3.2",
                    shortDescription: "deepseek \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Pro/deepseek-ai/DeepSeek-V3",
                    displayName: "Pro/deepseek-ai/DeepSeek-V3",
                    shortDescription: "deepseek \u{B7} 164K context"
                ),
                AIScriptModelPreset(
                    id: "Pro/MiniMaxAI/MiniMax-M2.1",
                    displayName: "Pro/MiniMaxAI/MiniMax-M2.1",
                    shortDescription: "minimax \u{B7} 197K context"
                ),
                AIScriptModelPreset(
                    id: "Pro/MiniMaxAI/MiniMax-M2.5",
                    displayName: "Pro/MiniMaxAI/MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 192K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.6-35B-A3B",
                    displayName: "Qwen/Qwen3.6-35B-A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-397B-A17B",
                    displayName: "Qwen/Qwen3.5-397B-A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-122B-A10B",
                    displayName: "Qwen/Qwen3.5-122B-A10B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-27B",
                    displayName: "Qwen/Qwen3.5-27B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-4B",
                    displayName: "Qwen/Qwen3.5-4B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-9B",
                    displayName: "Qwen/Qwen3.5-9B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-35B-A3B",
                    displayName: "Qwen/Qwen3.5-35B-A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-32B-Thinking",
                    displayName: "Qwen/Qwen3-VL-32B-Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-30B-A3B-Instruct",
                    displayName: "Qwen/Qwen3-VL-30B-A3B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Omni-30B-A3B-Instruct",
                    displayName: "Qwen/Qwen3-Omni-30B-A3B-Instruct",
                    shortDescription: "qwen \u{B7} 66K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-72B-Instruct",
                    displayName: "Qwen/Qwen2.5-72B-Instruct",
                    shortDescription: "qwen \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-14B",
                    displayName: "Qwen/Qwen3-14B",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-14B-Instruct",
                    displayName: "Qwen/Qwen2.5-14B-Instruct",
                    shortDescription: "qwen \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-32B-Instruct",
                    displayName: "Qwen/Qwen3-VL-32B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-32B",
                    displayName: "Qwen/Qwen3-32B",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Instruct-2507",
                    displayName: "Qwen/Qwen3-235B-A22B-Instruct-2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-8B",
                    displayName: "Qwen/Qwen3-8B",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-Coder-32B-Instruct",
                    displayName: "Qwen/Qwen2.5-Coder-32B-Instruct",
                    shortDescription: "qwen \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Next-80B-A3B-Thinking",
                    displayName: "Qwen/Qwen3-Next-80B-A3B-Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-235B-A22B-Thinking",
                    displayName: "Qwen/Qwen3-VL-235B-A22B-Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/QwQ-32B",
                    displayName: "Qwen/QwQ-32B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-8B-Instruct",
                    displayName: "Qwen/Qwen3-VL-8B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-8B-Thinking",
                    displayName: "Qwen/Qwen3-VL-8B-Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-30B-A3B-Thinking",
                    displayName: "Qwen/Qwen3-VL-30B-A3B-Thinking",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-30B-A3B-Instruct-2507",
                    displayName: "Qwen/Qwen3-30B-A3B-Instruct-2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-30B-A3B-Instruct",
                    displayName: "Qwen/Qwen3-Coder-30B-A3B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-480B-A35B-Instruct",
                    displayName: "Qwen/Qwen3-Coder-480B-A35B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-72B-Instruct-128K",
                    displayName: "Qwen/Qwen2.5-72B-Instruct-128K",
                    shortDescription: "qwen \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Thinking-2507",
                    displayName: "Qwen/Qwen3-235B-A22B-Thinking-2507",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Next-80B-A3B-Instruct",
                    displayName: "Qwen/Qwen3-Next-80B-A3B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-32B-Instruct",
                    displayName: "Qwen/Qwen2.5-32B-Instruct",
                    shortDescription: "qwen \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-235B-A22B-Instruct",
                    displayName: "Qwen/Qwen3-VL-235B-A22B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-7B-Instruct",
                    displayName: "Qwen/Qwen2.5-7B-Instruct",
                    shortDescription: "qwen \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-30B-A3B-Thinking-2507",
                    displayName: "Qwen/Qwen3-30B-A3B-Thinking-2507",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-VL-32B-Instruct",
                    displayName: "Qwen/Qwen2.5-VL-32B-Instruct",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-VL-72B-Instruct",
                    displayName: "Qwen/Qwen2.5-VL-72B-Instruct",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Omni-30B-A3B-Thinking",
                    displayName: "Qwen/Qwen3-Omni-30B-A3B-Thinking",
                    shortDescription: "qwen \u{B7} 66K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "PaddlePaddle/PaddleOCR-VL-1.5",
                    displayName: "PaddlePaddle/PaddleOCR-VL-1.5",
                    shortDescription: "16K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "tencent/Hunyuan-A13B-Instruct",
                    displayName: "tencent/Hunyuan-A13B-Instruct",
                    shortDescription: "hunyuan \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "tencent/Hunyuan-MT-7B",
                    displayName: "tencent/Hunyuan-MT-7B",
                    shortDescription: "hunyuan \u{B7} 33K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.5-Air",
                    displayName: "zai-org/GLM-4.5-Air",
                    shortDescription: "glm-air \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.5V",
                    displayName: "zai-org/GLM-4.5V",
                    shortDescription: "glm \u{B7} 66K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.6V",
                    displayName: "zai-org/GLM-4.6V",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.6",
                    displayName: "zai-org/GLM-4.6",
                    shortDescription: "glm \u{B7} 205K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V4-Pro",
                    displayName: "deepseek-ai/DeepSeek-V4-Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1.049M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-OCR",
                    displayName: "deepseek-ai/DeepSeek-OCR",
                    shortDescription: "8K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1-Distill-Qwen-14B",
                    displayName: "deepseek-ai/DeepSeek-R1-Distill-Qwen-14B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3",
                    displayName: "deepseek-ai/DeepSeek-V3",
                    shortDescription: "deepseek \u{B7} 164K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.2",
                    displayName: "deepseek-ai/DeepSeek-V3.2",
                    shortDescription: "deepseek \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/deepseek-vl2",
                    displayName: "deepseek-ai/deepseek-vl2",
                    shortDescription: "deepseek \u{B7} 4K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1-Terminus",
                    displayName: "deepseek-ai/DeepSeek-V3.1-Terminus",
                    shortDescription: "deepseek \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1-Distill-Qwen-32B",
                    displayName: "deepseek-ai/DeepSeek-R1-Distill-Qwen-32B",
                    shortDescription: "qwen \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1",
                    displayName: "deepseek-ai/DeepSeek-R1",
                    shortDescription: "deepseek-thinking \u{B7} 164K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Kwaipilot/KAT-Dev",
                    displayName: "Kwaipilot/KAT-Dev",
                    shortDescription: "kat-coder \u{B7} 128K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "stackit",
            displayName: "STACKIT",
            shortDescription: "OpenAI-compatible \u{B7} 6 text models",
            baseURLString: "https://api.openai-compat.model-serving.eu01.onstackit.cloud/v1",
            apiKeyLabel: "STACKIT API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "neuralmagic/Meta-Llama-3.1-8B-Instruct-FP8",
                    displayName: "Llama 3.1 8B",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "neuralmagic/Mistral-Nemo-Instruct-2407-FP8",
                    displayName: "Mistral Nemo",
                    shortDescription: "mistral \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "cortecs/Llama-3.3-70B-Instruct-FP8-Dynamic",
                    displayName: "Llama 3.3 70B",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3-27b-it",
                    displayName: "Gemma 3 27B",
                    shortDescription: "gemma \u{B7} 37K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-VL-235B-A22B-Instruct-FP8",
                    displayName: "Qwen3-VL 235B",
                    shortDescription: "qwen \u{B7} 218K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT-OSS 120B",
                    shortDescription: "gpt \u{B7} 131K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "stepfun",
            displayName: "StepFun",
            shortDescription: "OpenAI-compatible \u{B7} 4 text models",
            baseURLString: "https://api.stepfun.com/v1",
            apiKeyLabel: "StepFun API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "step-1-32k",
                    displayName: "Step 1 (32K)",
                    shortDescription: "32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "step-3.5-flash-2603",
                    displayName: "Step 3.5 Flash 2603",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "step-3.5-flash",
                    displayName: "Step 3.5 Flash",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "step-2-16k",
                    displayName: "Step 2 (16K)",
                    shortDescription: "16K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "stepfun-ai",
            displayName: "StepFun AI",
            shortDescription: "OpenAI-compatible \u{B7} 2 text models",
            baseURLString: "https://api.stepfun.ai/step_plan/v1",
            apiKeyLabel: "StepFun AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "step-3.5-flash",
                    displayName: "Step 3.5 Flash",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "step-3.5-flash-2603",
                    displayName: "Step 3.5 Flash 2603",
                    shortDescription: "256K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "submodel",
            displayName: "submodel",
            shortDescription: "OpenAI-compatible \u{B7} 9 text models",
            baseURLString: "https://llm.submodel.ai/v1",
            apiKeyLabel: "submodel API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Thinking-2507",
                    displayName: "Qwen3 235B A22B Thinking 2507",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-480B-A35B-Instruct-FP8",
                    displayName: "Qwen3 Coder 480B A35B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Instruct-2507",
                    displayName: "Qwen3 235B A22B Instruct 2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.5-FP8",
                    displayName: "GLM 4.5 FP8",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-4.5-Air",
                    displayName: "GLM 4.5 Air",
                    shortDescription: "glm-air \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3-0324",
                    displayName: "DeepSeek V3 0324",
                    shortDescription: "deepseek \u{B7} 75K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1-0528",
                    displayName: "DeepSeek R1 0528",
                    shortDescription: "deepseek-thinking \u{B7} 75K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 75K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "synthetic",
            displayName: "Synthetic",
            shortDescription: "OpenAI-compatible \u{B7} 34 text models",
            baseURLString: "https://api.synthetic.new/openai/v1",
            apiKeyLabel: "Synthetic API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "hf:meta-llama/Llama-4-Maverick-17B-128E-Instruct-FP8",
                    displayName: "Llama-4-Maverick-17B-128E-Instruct-FP8",
                    shortDescription: "llama \u{B7} 524K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "hf:meta-llama/Llama-4-Scout-17B-16E-Instruct",
                    displayName: "Llama-4-Scout-17B-16E-Instruct",
                    shortDescription: "llama \u{B7} 328K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "hf:meta-llama/Llama-3.3-70B-Instruct",
                    displayName: "Llama-3.3-70B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:meta-llama/Llama-3.1-70B-Instruct",
                    displayName: "Llama-3.1-70B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:meta-llama/Llama-3.1-405B-Instruct",
                    displayName: "Llama-3.1-405B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:meta-llama/Llama-3.1-8B-Instruct",
                    displayName: "Llama-3.1-8B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:deepseek-ai/DeepSeek-R1",
                    displayName: "DeepSeek R1",
                    shortDescription: "deepseek-thinking \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:deepseek-ai/DeepSeek-V3-0324",
                    displayName: "DeepSeek V3 (0324)",
                    shortDescription: "deepseek \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "hf:deepseek-ai/DeepSeek-V3.1-Terminus",
                    displayName: "DeepSeek V3.1 Terminus",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:deepseek-ai/DeepSeek-R1-0528",
                    displayName: "DeepSeek R1 (0528)",
                    shortDescription: "deepseek-thinking \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:deepseek-ai/DeepSeek-V3.1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:deepseek-ai/DeepSeek-V3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 162K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:deepseek-ai/DeepSeek-V3",
                    displayName: "DeepSeek V3",
                    shortDescription: "deepseek \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:moonshotai/Kimi-K2-Thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "kimi-thinking \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:moonshotai/Kimi-K2-Instruct-0905",
                    displayName: "Kimi K2 0905",
                    shortDescription: "kimi-k2 \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "hf:moonshotai/Kimi-K2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:moonshotai/Kimi-K2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:zai-org/GLM-4.7-Flash",
                    displayName: "GLM-4.7-Flash",
                    shortDescription: "glm \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:zai-org/GLM-4.6",
                    displayName: "GLM 4.6",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:zai-org/GLM-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:zai-org/GLM-4.7",
                    displayName: "GLM 4.7",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:zai-org/GLM-5.1",
                    displayName: "GLM 5.1",
                    shortDescription: "glm \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:MiniMaxAI/MiniMax-M2.1",
                    displayName: "MiniMax-M2.1",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:MiniMaxAI/MiniMax-M2",
                    displayName: "MiniMax-M2",
                    shortDescription: "minimax \u{B7} 196K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:MiniMaxAI/MiniMax-M2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 191K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:MiniMaxAI/MiniMax-M3",
                    displayName: "MiniMax-M3",
                    shortDescription: "minimax \u{B7} 524K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:openai/gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:Qwen/Qwen3.5-397B-A17B",
                    displayName: "Qwen3.5-97B-A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:Qwen/Qwen3-235B-A22B-Thinking-2507",
                    displayName: "Qwen3 235B A22B Thinking 2507",
                    shortDescription: "qwen \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:Qwen/Qwen3-Coder-480B-A35B-Instruct",
                    displayName: "Qwen 3 Coder 480B",
                    shortDescription: "qwen \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "hf:Qwen/Qwen2.5-Coder-32B-Instruct",
                    displayName: "Qwen2.5-Coder-32B-Instruct",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "hf:Qwen/Qwen3-235B-A22B-Instruct-2507",
                    displayName: "Qwen 3 235B Instruct",
                    shortDescription: "qwen \u{B7} 256K context"
                ),
                AIScriptModelPreset(
                    id: "hf:nvidia/Kimi-K2.5-NVFP4",
                    displayName: "Kimi K2.5 (NVFP4)",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hf:nvidia/NVIDIA-Nemotron-3-Super-120B-A12B-NVFP4",
                    displayName: "Nemotron 3 Super 120B",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "tencent-coding-plan",
            displayName: "Tencent Coding Plan (China)",
            shortDescription: "OpenAI-compatible \u{B7} 8 text models",
            baseURLString: "https://api.lkeap.cloud.tencent.com/coding/v3",
            apiKeyLabel: "Tencent Coding Plan (China) API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "minimax-m2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "kimi-k2.5",
                    displayName: "Kimi-K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hunyuan-turbos",
                    displayName: "Hunyuan-TurboS",
                    shortDescription: "hunyuan \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "hunyuan-t1",
                    displayName: "Hunyuan-T1",
                    shortDescription: "hunyuan \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "tc-code-latest",
                    displayName: "Auto",
                    shortDescription: "auto \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "hunyuan-2.0-instruct",
                    displayName: "Tencent HY 2.0 Instruct",
                    shortDescription: "hunyuan \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "hunyuan-2.0-thinking",
                    displayName: "Tencent HY 2.0 Think",
                    shortDescription: "hunyuan \u{B7} 131K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "tencent-tokenhub",
            displayName: "Tencent TokenHub",
            shortDescription: "OpenAI-compatible \u{B7} 1 text models",
            baseURLString: "https://tokenhub.tencentmaas.com/v1",
            apiKeyLabel: "Tencent TokenHub API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "hy3-preview",
                    displayName: "Hy3 preview",
                    shortDescription: "Hy \u{B7} 256K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "the-grid-ai",
            displayName: "The Grid AI",
            shortDescription: "OpenAI-compatible \u{B7} 9 text models",
            baseURLString: "https://api.thegrid.ai/v1",
            apiKeyLabel: "The Grid AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "agent-prime",
                    displayName: "Agent Prime",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "agent-max",
                    displayName: "Agent Max",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "text-standard",
                    displayName: "Text Standard",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "code-prime",
                    displayName: "Code Prime",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "text-prime",
                    displayName: "Text Prime",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "code-max",
                    displayName: "Code Max",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "agent-standard",
                    displayName: "Agent Standard",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "text-max",
                    displayName: "Text Max",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "code-standard",
                    displayName: "Code Standard",
                    shortDescription: "128K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "togetherai",
            displayName: "Together AI",
            shortDescription: "OpenAI-compatible \u{B7} 31 text models",
            baseURLString: "https://api.together.xyz/v1",
            apiKeyLabel: "Together AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "LiquidAI/LFM2-24B-A2B",
                    displayName: "LFM2-24B-A2B",
                    shortDescription: "liquid \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Meta-Llama-3-8B-Instruct-Lite",
                    displayName: "Meta Llama 3 8B Instruct Lite",
                    shortDescription: "llama \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.3-70B-Instruct-Turbo",
                    displayName: "Llama 3.3 70B",
                    shortDescription: "llama \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.7-Code",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-4-31B-it",
                    displayName: "Gemma 4 31B Instruct",
                    shortDescription: "gemma \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemma-3n-E4B-it",
                    displayName: "Gemma 3N E4B Instruct",
                    shortDescription: "gemma \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.7-Max",
                    displayName: "Qwen3.7 Max",
                    shortDescription: "qwen \u{B7} 1M context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.6-Plus",
                    displayName: "Qwen3.6 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-397B-A17B",
                    displayName: "Qwen3.5 397B A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-Next-FP8",
                    displayName: "Qwen3 Coder Next FP8",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-480B-A35B-Instruct-FP8",
                    displayName: "Qwen3 Coder 480B A35B Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Instruct-2507-tput",
                    displayName: "Qwen3 235B A22B Instruct 2507 FP8",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen2.5-7B-Instruct-Turbo",
                    displayName: "Qwen 2.5 7B Instruct Turbo",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3.5-9B",
                    displayName: "Qwen3.5 9B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "GPT OSS 120B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "GPT OSS 20B",
                    shortDescription: "gpt-oss \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "pearl-ai/gemma-4-31b-it",
                    displayName: "Pearl AI Gemma 4 31B Instruct",
                    shortDescription: "gemma \u{B7} 32K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/nemotron-3-ultra-550b-a55b",
                    displayName: "Nemotron 3 Ultra 550B A55B",
                    shortDescription: "nemotron \u{B7} 512K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepcogito/cogito-v2-1-671b",
                    displayName: "Cogito v2.1 671B",
                    shortDescription: "cogito \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-R1",
                    displayName: "DeepSeek-R1",
                    shortDescription: "deepseek-thinking \u{B7} 163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3-1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V4-Pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek \u{B7} 512K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3",
                    displayName: "DeepSeek-V3",
                    shortDescription: "deepseek \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5",
                    displayName: "MiniMax-M2.5",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M3",
                    displayName: "MiniMax-M3",
                    shortDescription: "minimax \u{B7} 524K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "minimax \u{B7} 202K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "essentialai/Rnj-1-Instruct",
                    displayName: "Rnj-1 Instruct",
                    shortDescription: "rnj \u{B7} 32K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "umans-ai",
            displayName: "Umans AI",
            shortDescription: "OpenAI-compatible \u{B7} 5 text models",
            baseURLString: "https://api.code.umans.ai/v1",
            apiKeyLabel: "Umans AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "umans-kimi-k2.7",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "umans-kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "umans-glm-5.1",
                    displayName: "GLM 5.1",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "umans-coder",
                    displayName: "Umans Coder",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "umans-flash",
                    displayName: "Umans Flash",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "umans-ai-coding-plan",
            displayName: "Umans AI Coding Plan",
            shortDescription: "OpenAI-compatible \u{B7} 6 text models",
            baseURLString: "https://api.code.umans.ai/v1",
            apiKeyLabel: "Umans AI Coding Plan API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "umans-kimi-k2.7",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "umans-kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "umans-glm-5.1",
                    displayName: "GLM 5.1",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "umans-coder",
                    displayName: "Umans Coder",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "umans-flash",
                    displayName: "Umans Flash",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "umans-qwen3.6-35b-a3b",
                    displayName: "Qwen3.6 35B A3B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "upstage",
            displayName: "Upstage",
            shortDescription: "OpenAI-compatible \u{B7} 3 text models",
            baseURLString: "https://api.upstage.ai/v1/solar",
            apiKeyLabel: "Upstage API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "solar-pro2",
                    displayName: "solar-pro2",
                    shortDescription: "solar-pro \u{B7} 65K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "solar-pro3",
                    displayName: "solar-pro3",
                    shortDescription: "solar-pro \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "solar-mini",
                    displayName: "solar-mini",
                    shortDescription: "solar-mini \u{B7} 32K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "vultr",
            displayName: "Vultr",
            shortDescription: "OpenAI-compatible \u{B7} 7 text models",
            baseURLString: "https://api.vultrinference.com/v1",
            apiKeyLabel: "Vultr API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/Llama-3.1-Nemotron-Safety-Guard-8B-v3",
                    displayName: "Llama 3.1 Nemotron Safety Guard",
                    shortDescription: "llama \u{B7} 8K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/Nemotron-3-Nano-Omni-30B-A3B-Reasoning-BF16",
                    displayName: "NVIDIA Nemotron 3 Nano Omni",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/DeepSeek-V3.2-NVFP4",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "deepseek \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "nvidia/Nemotron-Cascade-2-30B-A3B",
                    displayName: "NVIDIA Nemotron Cascade 2",
                    shortDescription: "nemotron \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1-FP8",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.7",
                    displayName: "MiniMax-M2.7",
                    shortDescription: "minimax \u{B7} 204K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "wafer.ai",
            displayName: "Wafer",
            shortDescription: "OpenAI-compatible \u{B7} 7 text models",
            baseURLString: "https://pass.wafer.ai/v1",
            apiKeyLabel: "Wafer API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.6-35B-A3B",
                    displayName: "Qwen3.6-35B-A3B",
                    shortDescription: "qwen \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen3.7-max",
                    displayName: "Qwen3.7-Max",
                    shortDescription: "qwen3.7-max \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen3.5-397B-A17B",
                    displayName: "Qwen3.5-397B-A17B",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Kimi-K2.6",
                    displayName: "Kimi-K2.6",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "GLM-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 202K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "wandb",
            displayName: "Weights & Biases",
            shortDescription: "OpenAI-compatible \u{B7} 18 text models",
            baseURLString: "https://api.inference.wandb.ai/v1",
            apiKeyLabel: "Weights & Biases API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "meta-llama/Llama-4-Scout-17B-16E-Instruct",
                    displayName: "Llama 4 Scout 17B 16E Instruct",
                    shortDescription: "llama \u{B7} 64K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.3-70B-Instruct",
                    displayName: "Llama-3.3-70B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.1-70B-Instruct",
                    displayName: "Llama 3.1 70B",
                    shortDescription: "llama \u{B7} 128K context"
                ),
                AIScriptModelPreset(
                    id: "meta-llama/Llama-3.1-8B-Instruct",
                    displayName: "Meta-Llama-3.1-8B-Instruct",
                    shortDescription: "llama \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/Kimi-K2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "microsoft/Phi-4-mini-instruct",
                    displayName: "Phi-4-mini-instruct",
                    shortDescription: "phi \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Thinking-2507",
                    displayName: "Qwen3-235B-A22B-Thinking-2507",
                    shortDescription: "qwen \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-Coder-480B-A35B-Instruct",
                    displayName: "Qwen3-Coder-480B-A35B-Instruct",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-30B-A3B-Instruct-2507",
                    displayName: "Qwen3 30B A3B Instruct 2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "Qwen/Qwen3-235B-A22B-Instruct-2507",
                    displayName: "Qwen3 235B A22B Instruct 2507",
                    shortDescription: "qwen \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-120b",
                    displayName: "gpt-oss-120b",
                    shortDescription: "gpt-oss \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-oss-20b",
                    displayName: "gpt-oss-20b",
                    shortDescription: "gpt-oss \u{B7} 131K context"
                ),
                AIScriptModelPreset(
                    id: "nvidia/NVIDIA-Nemotron-3-Super-120B-A12B-FP8",
                    displayName: "NVIDIA Nemotron 3 Super 120B",
                    shortDescription: "nemotron \u{B7} 262K context"
                ),
                AIScriptModelPreset(
                    id: "OpenPipe/Qwen3-14B-Instruct",
                    displayName: "OpenPipe Qwen3 14B Instruct",
                    shortDescription: "qwen \u{B7} 32K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5-FP8",
                    displayName: "GLM 5",
                    shortDescription: "glm \u{B7} 200K context"
                ),
                AIScriptModelPreset(
                    id: "zai-org/GLM-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek-ai/DeepSeek-V3.1",
                    displayName: "DeepSeek V3.1",
                    shortDescription: "deepseek \u{B7} 161K context"
                ),
                AIScriptModelPreset(
                    id: "MiniMaxAI/MiniMax-M2.5",
                    displayName: "MiniMax M2.5",
                    shortDescription: "minimax \u{B7} 196K context"
                )
            ]
        ),
        AIScriptProvider(
            id: "xai",
            displayName: "xAI",
            shortDescription: "OpenAI-compatible \u{B7} 5 text models",
            baseURLString: "https://api.x.ai/v1",
            apiKeyLabel: "xAI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "grok-4.20-multi-agent-0309",
                    displayName: "Grok 4.20 Multi-Agent",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4.20-0309-non-reasoning",
                    displayName: "Grok 4.20 (Non-Reasoning)",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "grok-4.3",
                    displayName: "Grok 4.3",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-4.20-0309-reasoning",
                    displayName: "Grok 4.20 (Reasoning)",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "grok-build-0.1",
                    displayName: "Grok Build 0.1",
                    shortDescription: "grok-build \u{B7} 256K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "xiaomi",
            displayName: "Xiaomi",
            shortDescription: "OpenAI-compatible \u{B7} 6 text models",
            baseURLString: "https://api.xiaomimimo.com/v1",
            apiKeyLabel: "Xiaomi API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "mimo-v2.5-pro-ultraspeed",
                    displayName: "MiMo-V2.5-Pro-UltraSpeed",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2.5",
                    displayName: "MiMo-V2.5",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-omni",
                    displayName: "MiMo-V2-Omni",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-flash",
                    displayName: "MiMo-V2-Flash",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-pro",
                    displayName: "MiMo-V2-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2.5-pro",
                    displayName: "MiMo-V2.5-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "xiaomi-token-plan-cn",
            displayName: "Xiaomi Token Plan (China)",
            shortDescription: "OpenAI-compatible \u{B7} 4 text models",
            baseURLString: "https://token-plan-cn.xiaomimimo.com/v1",
            apiKeyLabel: "Xiaomi Token Plan (China) API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "mimo-v2.5",
                    displayName: "MiMo-V2.5",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-omni",
                    displayName: "MiMo-V2-Omni",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-pro",
                    displayName: "MiMo-V2-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2.5-pro",
                    displayName: "MiMo-V2.5-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "xiaomi-token-plan-ams",
            displayName: "Xiaomi Token Plan (Europe)",
            shortDescription: "OpenAI-compatible \u{B7} 4 text models",
            baseURLString: "https://token-plan-ams.xiaomimimo.com/v1",
            apiKeyLabel: "Xiaomi Token Plan (Europe) API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "mimo-v2.5-pro",
                    displayName: "MiMo-V2.5-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-pro",
                    displayName: "MiMo-V2-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-omni",
                    displayName: "MiMo-V2-Omni",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2.5",
                    displayName: "MiMo-V2.5",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "xiaomi-token-plan-sgp",
            displayName: "Xiaomi Token Plan (Singapore)",
            shortDescription: "OpenAI-compatible \u{B7} 4 text models",
            baseURLString: "https://token-plan-sgp.xiaomimimo.com/v1",
            apiKeyLabel: "Xiaomi Token Plan (Singapore) API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "mimo-v2.5-pro",
                    displayName: "MiMo-V2.5-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-pro",
                    displayName: "MiMo-V2-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2-omni",
                    displayName: "MiMo-V2-Omni",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "mimo-v2.5",
                    displayName: "MiMo-V2.5",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "xpersona",
            displayName: "Xpersona",
            shortDescription: "OpenAI-compatible \u{B7} 2 text models",
            baseURLString: "https://www.xpersona.co/v1",
            apiKeyLabel: "Xpersona API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "xpersona-gpt-5.5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xpersona-frieren-coder",
                    displayName: "Xpersona Frieren 1",
                    shortDescription: "1M context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "zai",
            displayName: "Z.AI",
            shortDescription: "OpenAI-compatible \u{B7} 13 text models",
            baseURLString: "https://api.z.ai/api/paas/v4",
            apiKeyLabel: "Z.AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5v",
                    displayName: "GLM-4.5V",
                    shortDescription: "glm \u{B7} 64K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5",
                    displayName: "GLM-4.5",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7-flashx",
                    displayName: "GLM-4.7-FlashX",
                    shortDescription: "glm-flash \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6",
                    displayName: "GLM-4.6",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6v",
                    displayName: "GLM-4.6V",
                    shortDescription: "glm \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5v-turbo",
                    displayName: "GLM-5V-Turbo",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-air",
                    displayName: "GLM-4.5-Air",
                    shortDescription: "glm-air \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7-flash",
                    displayName: "GLM-4.7-Flash",
                    shortDescription: "glm-flash \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-flash",
                    displayName: "GLM-4.5-Flash",
                    shortDescription: "glm-flash \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5-turbo",
                    displayName: "GLM-5-Turbo",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "zai-coding-plan",
            displayName: "Z.AI Coding Plan",
            shortDescription: "OpenAI-compatible \u{B7} 6 text models",
            baseURLString: "https://api.z.ai/api/coding/paas/v4",
            apiKeyLabel: "Z.AI Coding Plan API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.2",
                    displayName: "GLM-5.2",
                    shortDescription: "glm \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5v-turbo",
                    displayName: "GLM-5V-Turbo",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-air",
                    displayName: "GLM-4.5-Air",
                    shortDescription: "glm-air \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5-turbo",
                    displayName: "GLM-5-Turbo",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "zeldoc",
            displayName: "Zeldoc",
            shortDescription: "OpenAI-compatible \u{B7} 1 text models",
            baseURLString: "https://api.zeldoc.ai/v1",
            apiKeyLabel: "Zeldoc API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "z-code",
                    displayName: "Z-Code",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                )
            ]
        ),
        AIScriptProvider(
            id: "zenmux",
            displayName: "ZenMux",
            shortDescription: "OpenAI-compatible \u{B7} 110 text models",
            baseURLString: "https://zenmux.ai/api/v1",
            apiKeyLabel: "ZenMux API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "inclusionai/ling-1t",
                    displayName: "Ling-1T",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "inclusionai/ring-2.6-1t",
                    displayName: "inclusionAI: Ring-2.6-1T",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "inclusionai/ring-1t",
                    displayName: "Ring-1T",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.7-code-free",
                    displayName: "Kimi K2.7 Code (Free)",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-thinking-turbo",
                    displayName: "Kimi K2 Thinking Turbo",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.7-code",
                    displayName: "Kimi K2.7 Code",
                    shortDescription: "kimi-k2 \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-thinking",
                    displayName: "Kimi K2 Thinking",
                    shortDescription: "262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.5",
                    displayName: "Kimi K2.5",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2.6",
                    displayName: "Kimi K2.6",
                    shortDescription: "262K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "moonshotai/kimi-k2-0905",
                    displayName: "Kimi K2 0905",
                    shortDescription: "262K context"
                ),
                AIScriptModelPreset(
                    id: "baidu/ernie-5.0-thinking-preview",
                    displayName: "ERNIE 5.0",
                    shortDescription: "128K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-flash-lite",
                    displayName: "Gemini 3.1 Flash Lite",
                    shortDescription: "gemini-flash-lite \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-pro",
                    displayName: "Gemini 2.5 Pro",
                    shortDescription: "1.048M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash",
                    displayName: "Gemini 2.5 Flash",
                    shortDescription: "1.048M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.5-flash",
                    displayName: "Gemini 3.5 Flash",
                    shortDescription: "gemini-flash \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-2.5-flash-lite",
                    displayName: "Gemini 2.5 Flash Lite",
                    shortDescription: "1.048M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-pro-preview",
                    displayName: "Gemini 3.1 Pro Preview",
                    shortDescription: "1.048M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3-flash-preview",
                    displayName: "Gemini 3 Flash Preview",
                    shortDescription: "1.048M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "google/gemini-3.1-flash-lite-preview",
                    displayName: "Gemini 3.1 Flash Lite Preview",
                    shortDescription: "1.05M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-code-fast-1",
                    displayName: "Grok Code Fast 1",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.3",
                    displayName: "Grok 4.3",
                    shortDescription: "grok \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.1-fast-non-reasoning",
                    displayName: "Grok 4.1 Fast Non Reasoning",
                    shortDescription: "2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4",
                    displayName: "Grok 4",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4-fast",
                    displayName: "Grok 4 Fast",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.2-fast-non-reasoning",
                    displayName: "Grok 4.2 Fast Non Reasoning",
                    shortDescription: "2M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.2-fast",
                    displayName: "Grok 4.2 Fast",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-4.1-fast",
                    displayName: "Grok 4.1 Fast",
                    shortDescription: "2M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "x-ai/grok-build-0.1",
                    displayName: "Grok Build 0.1",
                    shortDescription: "grok-build \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.7",
                    displayName: "GLM 4.7",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.5",
                    displayName: "GLM 4.5",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.7-flashx",
                    displayName: "GLM 4.7 FlashX",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.6",
                    displayName: "GLM 4.6",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.6v-flash-free",
                    displayName: "GLM 4.6V Flash (Free)",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.7-flash-free",
                    displayName: "GLM 4.7 Flash (Free)",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.6v",
                    displayName: "GLM 4.6V",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5v-turbo",
                    displayName: "GLM 5V Turbo",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.6v-flash",
                    displayName: "GLM 4.6V FlashX",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-4.5-air",
                    displayName: "GLM 4.5 Air",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5",
                    displayName: "GLM 5",
                    shortDescription: "200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "z-ai/glm-5-turbo",
                    displayName: "GLM 5 Turbo",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5-instant",
                    displayName: "GPT-5.5 Instant",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-pro",
                    displayName: "GPT-5.2-Pro",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5",
                    displayName: "GPT-5",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-chat",
                    displayName: "GPT-5.1 Chat",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-nano",
                    displayName: "GPT-5.4 Nano",
                    shortDescription: "400K context"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-chat",
                    displayName: "GPT-5.3 Chat",
                    shortDescription: "128K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex",
                    displayName: "GPT-5.1-Codex",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2",
                    displayName: "GPT-5.2",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.3-codex",
                    displayName: "GPT-5.3 Codex",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1-codex-mini",
                    displayName: "GPT-5.1-Codex-Mini",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4",
                    displayName: "GPT-5.4",
                    shortDescription: "1.05M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-mini",
                    displayName: "GPT-5.4 Mini",
                    shortDescription: "400K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.4-pro",
                    displayName: "GPT-5.4 Pro",
                    shortDescription: "1.05M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5-pro",
                    displayName: "GPT-5.5 Pro",
                    shortDescription: "gpt-pro \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5-codex",
                    displayName: "GPT-5 Codex",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.2-codex",
                    displayName: "GPT-5.2-Codex",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.1",
                    displayName: "GPT-5.1",
                    shortDescription: "400K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "openai/gpt-5.5",
                    displayName: "GPT-5.5",
                    shortDescription: "gpt \u{B7} 1.05M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2.5",
                    displayName: "MiMo-V2.5",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-omni",
                    displayName: "MiMo V2 Omni",
                    shortDescription: "mimo \u{B7} 265K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-flash",
                    displayName: "MiMo-V2-Flash",
                    shortDescription: "mimo \u{B7} 262K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2-pro",
                    displayName: "MiMo V2 Pro",
                    shortDescription: "mimo \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "xiaomi/mimo-v2.5-pro",
                    displayName: "MiMo-V2.5-Pro",
                    shortDescription: "mimo \u{B7} 1.04858M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "sapiens-ai/agnes-1.5-pro",
                    displayName: "Agnes 1.5 Pro",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "sapiens-ai/agnes-1.5-lite",
                    displayName: "Agnes 1.5 Lite",
                    shortDescription: "256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "volcengine/doubao-seed-2.0-pro",
                    displayName: "Doubao-Seed-2.0-pro",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "volcengine/doubao-seed-code",
                    displayName: "Doubao-Seed-Code",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "volcengine/doubao-seed-1.8",
                    displayName: "Doubao-Seed-1.8",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "volcengine/doubao-seed-2.0-mini",
                    displayName: "Doubao-Seed-2.0-mini",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "volcengine/doubao-seed-2.0-lite",
                    displayName: "Doubao-Seed-2.0-lite",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "volcengine/doubao-seed-2.0-code",
                    displayName: "Doubao Seed 2.0 Code",
                    shortDescription: "256K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-3.5-haiku",
                    displayName: "Claude 3.5 Haiku",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.5",
                    displayName: "Claude Sonnet 4.5",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4",
                    displayName: "Claude Sonnet 4",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-haiku-4.5",
                    displayName: "Claude Haiku 4.5",
                    shortDescription: "200K context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.7",
                    displayName: "Claude Opus 4.7",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-3.7-sonnet",
                    displayName: "Claude 3.7 Sonnet",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.8",
                    displayName: "Claude Opus 4.8",
                    shortDescription: "claude-opus \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-fable-5",
                    displayName: "Claude Fable 5",
                    shortDescription: "claude-fable \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.1",
                    displayName: "Claude Opus 4.1",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.5",
                    displayName: "Claude Opus 4.5",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-sonnet-4.6",
                    displayName: "Claude Sonnet 4.6",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4",
                    displayName: "Claude Opus 4",
                    shortDescription: "200K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "anthropic/claude-opus-4.6",
                    displayName: "Claude Opus 4.6",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "tencent/hy3-preview",
                    displayName: "Hy3 preview",
                    shortDescription: "Hy \u{B7} 256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "stepfun/step-3",
                    displayName: "Step-3",
                    shortDescription: "65K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "stepfun/step-3.7-flash",
                    displayName: "Step 3.7 Flash",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "stepfun/step-3.7-flash-free",
                    displayName: "Step 3.7 Flash (Free)",
                    shortDescription: "256K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "stepfun/step-3.5-flash",
                    displayName: "Step 3.5 Flash",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "kuaishou/kat-coder-pro-v2",
                    displayName: "KAT-Coder-Pro-V2",
                    shortDescription: "256K context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-coder-plus",
                    displayName: "Qwen3-Coder-Plus",
                    shortDescription: "1M context"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.7-plus",
                    displayName: "Qwen3.7 Plus",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.7-max",
                    displayName: "Qwen3.7 Max",
                    shortDescription: "qwen \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3-max",
                    displayName: "Qwen3-Max-Thinking",
                    shortDescription: "256K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-flash",
                    displayName: "Qwen3.5 Flash",
                    shortDescription: "1.02M context \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.5-plus",
                    displayName: "Qwen3.5 Plus",
                    shortDescription: "1M context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "qwen/qwen3.6-plus",
                    displayName: "Qwen3.6-Plus",
                    shortDescription: "1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-flash",
                    displayName: "DeepSeek V4 Flash",
                    shortDescription: "deepseek-flash \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v4-pro",
                    displayName: "DeepSeek V4 Pro",
                    shortDescription: "deepseek-thinking \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2-exp",
                    displayName: "DeepSeek-V3.2-Exp",
                    shortDescription: "163K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-chat",
                    displayName: "DeepSeek-V3.2 (Non-thinking Mode)",
                    shortDescription: "128K context"
                ),
                AIScriptModelPreset(
                    id: "deepseek/deepseek-v3.2",
                    displayName: "DeepSeek V3.2",
                    shortDescription: "128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.7-highspeed",
                    displayName: "MiniMax M2.7 highspeed",
                    shortDescription: "204K context \u{B7} Reasoning \u{B7} Attachments"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.5",
                    displayName: "MiniMax M2.5",
                    shortDescription: "204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.5-lightning",
                    displayName: "MiniMax M2.5 highspeed",
                    shortDescription: "204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.1",
                    displayName: "MiniMax M2.1",
                    shortDescription: "204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m3",
                    displayName: "MiniMax-M3",
                    shortDescription: "minimax \u{B7} 512K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2",
                    displayName: "MiniMax M2",
                    shortDescription: "204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "minimax/minimax-m2.7",
                    displayName: "MiniMax M2.7",
                    shortDescription: "204K context \u{B7} Reasoning \u{B7} Attachments"
                )
            ]
        ),
        AIScriptProvider(
            id: "zhipuai",
            displayName: "Zhipu AI",
            shortDescription: "OpenAI-compatible \u{B7} 12 text models",
            baseURLString: "https://open.bigmodel.cn/api/paas/v4",
            apiKeyLabel: "Zhipu AI API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5v-turbo",
                    displayName: "GLM-5V-Turbo",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5",
                    displayName: "GLM-5",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-flash",
                    displayName: "GLM-4.5-Flash",
                    shortDescription: "glm-flash \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7-flash",
                    displayName: "GLM-4.7-Flash",
                    shortDescription: "glm-flash \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-air",
                    displayName: "GLM-4.5-Air",
                    shortDescription: "glm-air \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6v",
                    displayName: "GLM-4.6V",
                    shortDescription: "glm \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6",
                    displayName: "GLM-4.6",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7-flashx",
                    displayName: "GLM-4.7-FlashX",
                    shortDescription: "glm-flash \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5",
                    displayName: "GLM-4.5",
                    shortDescription: "glm \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5v",
                    displayName: "GLM-4.5V",
                    shortDescription: "glm \u{B7} 64K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                )
            ]
        ),
        AIScriptProvider(
            id: "zhipuai-coding-plan",
            displayName: "Zhipu AI Coding Plan",
            shortDescription: "OpenAI-compatible \u{B7} 7 text models",
            baseURLString: "https://open.bigmodel.cn/api/coding/paas/v4",
            apiKeyLabel: "Zhipu AI Coding Plan API Key",
            requiresAPIKey: true,
            modelPresets: [
                AIScriptModelPreset(
                    id: "glm-5.1",
                    displayName: "GLM-5.1",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5v-turbo",
                    displayName: "GLM-5V-Turbo",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5-turbo",
                    displayName: "GLM-5-Turbo",
                    shortDescription: "glm \u{B7} 200K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.5-air",
                    displayName: "GLM-4.5-Air",
                    shortDescription: "glm-air \u{B7} 131K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.6v",
                    displayName: "GLM-4.6V",
                    shortDescription: "glm \u{B7} 128K context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-5.2",
                    displayName: "GLM-5.2",
                    shortDescription: "glm \u{B7} 1M context \u{B7} Reasoning"
                ),
                AIScriptModelPreset(
                    id: "glm-4.7",
                    displayName: "GLM-4.7",
                    shortDescription: "glm \u{B7} 204K context \u{B7} Reasoning"
                )
            ]
        )
    ]
}
