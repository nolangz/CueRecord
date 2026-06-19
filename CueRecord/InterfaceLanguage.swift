import Combine
import Foundation

enum InterfaceLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case simplifiedChinese = "zh-Hans"

    var id: String { rawValue }

    var toggleTitle: String {
        switch self {
        case .english:
            return "中"
        case .simplifiedChinese:
            return "EN"
        }
    }
}

final class InterfaceLanguageSettings: ObservableObject {
    static let shared = InterfaceLanguageSettings()

    private let storageKey = "cueRecord.interfaceLanguage"

    @Published var language: InterfaceLanguage {
        didSet {
            UserDefaults.standard.set(language.rawValue, forKey: storageKey)
        }
    }

    private init() {
        let savedLanguage = UserDefaults.standard.string(forKey: storageKey)
        language = InterfaceLanguage(rawValue: savedLanguage ?? "") ?? .english
    }

    func toggle() {
        language = language == .english ? .simplifiedChinese : .english
    }

    func text(_ english: String) -> String {
        guard language == .simplifiedChinese else { return english }
        return Self.zhHans[english] ?? english
    }

    func format(_ english: String, _ arguments: CVarArg...) -> String {
        String(format: text(english), arguments: arguments)
    }

    private static let zhHans: [String: String] = [
        "AI Breath Cuts": "AI 断句",
        "Processing": "处理中",
        "Completed": "已完成",
        "AI Breath Cuts Failed": "AI 断句失败",
        "AI Breath Cuts is processing": "AI 断句处理中",
        "Add natural teleprompter line breaks": "添加自然的提词器断句",
        "Drop PowerPoint (.pptx) file": "拖入 PowerPoint (.pptx) 文件",
        "For Keynote or Google Slides,\nexport as PPTX first.": "Keynote 或 Google Slides\n请先导出为 PPTX。",
        "Choose a CueRecord Workspace": "选择 CueRecord 工作区",
        "Projects, scripts, and recordings are saved here.": "项目、脚本和录制文件会保存在这里。",
        "Choose Folder": "选择文件夹",
        "Director Mode": "导演模式",
        "Reading from director…": "导演端正在朗读…",
        "Waiting for director to send script…": "等待导演端发送脚本…",
        "Open Settings": "打开设置",
        "OK": "好",
        "Conversion Required": "需要转换",
        "Keynote files can't be imported directly. Please export your Keynote presentation as PowerPoint (.pptx) first, then drop the exported file here.": "不能直接导入 Keynote 文件。请先将 Keynote 演示文稿导出为 PowerPoint (.pptx)，再拖入这里。",
        "Import Error": "导入错误",
        "Unsupported file. Drop a PowerPoint (.pptx) file.": "不支持的文件。请拖入 PowerPoint (.pptx) 文件。",
        "Finishing recording": "正在完成录制",
        "Empty": "空",
        "New Project": "新项目",
        "Settings": "设置",
        "Switch Language": "切换语言",
        "Switch interface language": "切换界面语言",
        "Select Folder as Vault": "选择文件夹作为库",
        "Show Vault in Finder": "在 Finder 中显示库",
        "Open Vault in Finder": "在 Finder 中打开库",
        "New Markdown": "新建 Markdown",
        "Show in Finder": "在 Finder 中显示",
        "Rename Project": "重命名项目",
        "Delete Project": "删除项目",
        "Rename File": "重命名文件",
        "Delete File": "删除文件",
        "Choose Take": "选择 Take",
        "Edit Recorded Take": "剪辑已录制 Take",
        "Take": "Take",
        "Untitled": "未命名",
        "Version": "版本",
        "A recording workspace for scripted screen videos.": "面向脚本化屏幕视频的录制工作区。",
        "Made by Nolan Lai": "Nolan Lai 制作",

        "Set Up CueRecord": "设置 CueRecord",
        "Permissions": "权限",
        "Workspace": "工作区",
        "Microphone": "麦克风",
        "Camera": "摄像头",
        "Screen": "屏幕",
        "Checking": "检查中",
        "Recheck": "重新检查",
        "Back": "返回",
        "Choose Workspace": "选择工作区",
        "Next": "下一步",
        "Finish Setup": "完成设置",
        "Choose CueRecord Workspace": "选择 CueRecord 工作区",
        "Choose": "选择",
        "Screen and System Audio Recording": "屏幕和系统音频录制",
        "Granted": "已授权",
        "Not Granted": "未授权",
        "Working": "处理中",
        "Authorize": "授权",
        "Test Microphone": "测试麦克风",
        "Testing": "测试中",
        "Input OK": "输入正常",
        "Test Camera": "测试摄像头",
        "Video OK": "视频正常",
        "Microphone input level": "麦克风输入音量",
        "Microphone permission not granted": "未授予麦克风权限",
        "No input device": "没有输入设备",
        "Microphone failed to start": "麦克风启动失败",
        "No audio input": "没有音频输入",

        "Appearance": "外观",
        "Guidance": "跟读",
        "Teleprompter": "提词器",
        "External": "外接",
        "Remote": "遥控",
        "Director": "导演",
        "Reset All": "全部重置",
        "Done": "完成",
        "Reset All Settings?": "重置所有设置？",
        "Cancel": "取消",
        "Reset": "重置",
        "This will restore all settings to their defaults.": "这会将所有设置恢复为默认值。",
        "Font": "字体",
        "Sans": "无衬线",
        "Serif": "衬线",
        "Mono": "等宽",
        "Dyslexia": "易读",
        "Size": "大小",
        "Highlight Color": "高亮颜色",
        "Cue Color": "提示颜色",
        "White": "白色",
        "Yellow": "黄色",
        "Green": "绿色",
        "Blue": "蓝色",
        "Pink": "粉色",
        "Orange": "橙色",
        "Cue Brightness": "提示亮度",
        "Dim": "暗",
        "Low": "低",
        "Medium": "中",
        "Bright": "亮",
        "Dimensions": "尺寸",
        "Width": "宽度",
        "Height": "高度",
        "Classic": "经典",
        "Voice-Activated": "语音触发",
        "Word Tracking": "逐词跟读",
        "Auto-scrolls at a constant speed. No microphone needed.": "以恒定速度自动滚动，不需要麦克风。",
        "Scrolls while you speak, pauses when you're silent.": "说话时滚动，安静时暂停。",
        "Tracks each word you say and highlights it in real time.": "实时跟踪并高亮你说到的词。",
        "ASR Model": "ASR 模型",
        "System Default": "系统默认",
        "Scroll Speed": "滚动速度",
        "Slower": "更慢",
        "Faster": "更快",
        "words/s": "词/秒",
        "Pinned to Notch": "固定到刘海",
        "Floating Window": "浮动窗口",
        "Fullscreen": "全屏",
        "Anchored below the notch at the top of your screen.": "固定在屏幕顶部刘海下方。",
        "A draggable window you can place anywhere. Always on top.": "可拖拽到任意位置，并始终置顶。",
        "Fullscreen teleprompter on the selected display. Press Esc to stop.": "在所选显示器上全屏显示提词器，按 Esc 停止。",
        "Display": "显示器",
        "Follow Mouse": "跟随鼠标",
        "Fixed Display": "固定显示器",
        "The notch moves to whichever display your mouse is on.": "刘海会移动到鼠标所在的显示器。",
        "The notch stays on the selected display.": "刘海固定在所选显示器。",
        "Transparency": "透明度",
        "Makes the overlay see-through so desktop content shows through.": "让浮层变透明，以便看到桌面内容。",
        "Amount": "程度",
        "More transparent": "更透明",
        "Less transparent": "更不透明",
        "Background": "背景",
        "No background is shown behind the teleprompter text.": "提词器文字后方不显示背景。",
        "Use your own image behind the teleprompter text.": "在提词器文字后方使用你自己的图片。",
        "Custom Image": "自定义图片",
        "Choose Image": "选择图片",
        "Change Image": "更换图片",
        "Remove Image": "移除图片",
        "No image selected.": "未选择图片。",
        "Background Image Opacity": "背景图片不透明度",
        "Image Scale": "图片缩放",
        "Horizontal Position": "水平位置",
        "Vertical Position": "垂直位置",
        "Reset Image Framing": "重置图片构图",
        "The image stays behind the words.": "图片会留在文字下方。",
        "Choose Background Image": "选择背景图片",
        "Audience Face": "观众脸",
        "Male": "男生",
        "Female": "女生",
        "Shows a semi-transparent curious cartoon face behind the teleprompter text.": "在提词器文字下方显示一个半透明、求知若渴的卡通脸。",
        "Stay curious. Keep reading.": "保持好奇，继续读。",
        "The face stays below the words.": "头像会留在文字下方。",
        "Follow Cursor": "跟随光标",
        "The window follows your cursor and sticks to its bottom-right.": "窗口会跟随光标，并贴在光标右下方。",
        "Glass Effect": "玻璃效果",
        "Opacity": "不透明度",
        "Press Esc to stop the teleprompter.": "按 Esc 停止提词器。",
        "Elapsed Time": "经过时间",
        "Display a running timer while the teleprompter is active.": "提词器运行时显示计时器。",
        "Hide from Screen Sharing": "从屏幕共享中隐藏",
        "Hide the overlay from screen recordings and video calls.": "在屏幕录制和视频通话中隐藏浮层。",
        "Pagination": "翻页",
        "Auto Next Page": "自动下一页",
        "Automatically advance to the next page after a countdown.": "倒计时后自动进入下一页。",
        "Countdown": "倒计时",
        "3 seconds": "3 秒",
        "5 seconds": "5 秒",
        "Show the teleprompter on an external display or Sidecar iPad.": "在外接显示器或 Sidecar iPad 上显示提词器。",
        "Off": "关闭",
        "Mirror": "镜像",
        "No external display output.": "不输出到外接显示器。",
        "Fullscreen teleprompter on the selected display.": "在所选显示器上全屏显示提词器。",
        "Horizontally flipped for use with a prompter mirror rig.": "水平翻转，用于提词器反射镜设备。",
        "Mirror Axis": "镜像轴",
        "Horizontal": "水平",
        "Vertical": "垂直",
        "Both": "双轴",
        "Flipped left-to-right. Standard for prompter mirror rigs.": "左右翻转，适合标准提词器反射镜设备。",
        "Flipped top-to-bottom.": "上下翻转。",
        "Flipped on both axes (rotated 180°).": "双轴翻转（旋转 180°）。",
        "Target Display": "目标显示器",
        "No external displays detected. Connect a display or enable Sidecar.": "未检测到外接显示器。请连接显示器或启用 Sidecar。",
        "Scan the QR code or open the URL with your iPhone, Android or TV browser on the same Wi-Fi network.": "在同一 Wi-Fi 下，用 iPhone、Android 或电视浏览器扫描二维码或打开链接。",
        "Enable Remote Connection": "启用遥控连接",
        "Advanced": "高级",
        "Port": "端口",
        "Restart required after change": "修改后需要重启",
        "Restart": "重启",
        "Uses ports %@ (HTTP) and %@ (WebSocket).": "使用端口 %@ (HTTP) 和 %@ (WebSocket)。",
        "Director Mode lets a remote person control your teleprompter script in real-time via a web browser. The editor will be disabled while active.": "导演模式允许远程人员通过浏览器实时控制你的提词器脚本。启用时编辑器会被禁用。",
        "Enable Director Mode": "启用导演模式",
        "Word tracking is forced when the director starts reading.": "导演端开始朗读时会强制启用逐词跟读。",
        "Refresh": "刷新",

        "Fast breath cutting": "快速断句",
        "More careful pacing": "更细致的节奏",
        "General chat model": "通用聊天模型",
        "Slower reasoning model": "较慢的推理模型",
        "OpenAI Chat Completions endpoint": "OpenAI Chat Completions 端点",
        "Fast OpenAI preset": "快速 OpenAI 预设",
        "Balanced OpenAI preset": "均衡 OpenAI 预设",
        "Stronger OpenAI preset": "更强的 OpenAI 预设",
        "Use many hosted models through one OpenAI-compatible API": "通过一个 OpenAI-compatible API 使用多个托管模型",
        "Fast hosted model": "快速托管模型",
        "Careful hosted model": "更细致的托管模型",
        "Fast Gemini preset": "快速 Gemini 预设",
        "DeepSeek through OpenRouter": "通过 OpenRouter 使用 DeepSeek",
        "Gemini OpenAI-compatible endpoint": "Gemini OpenAI-compatible 端点",
        "Fast Gemini model": "快速 Gemini 模型",
        "Stronger Gemini model": "更强的 Gemini 模型",
        "Low-latency OpenAI-compatible endpoint": "低延迟 OpenAI-compatible 端点",
        "Fast open-weight preset": "快速开放权重预设",
        "Reasoning-oriented preset": "偏推理预设",
        "xAI OpenAI-compatible endpoint": "xAI OpenAI-compatible 端点",
        "Fast xAI preset": "快速 xAI 预设",
        "Stronger xAI preset": "更强的 xAI 预设",
        "Local OpenAI-compatible server": "本地 OpenAI-compatible 服务",
        "Local Ollama preset": "本地 Ollama 预设",
        "Local Qwen preset": "本地 Qwen 预设",
        "Local LM Studio OpenAI-compatible server": "本地 LM Studio OpenAI-compatible 服务",
        "Use any OpenAI-compatible endpoint": "使用任意 OpenAI-compatible 端点",
        "Fast OpenAI-compatible Chinese and English editing": "快速处理中英文断句的 OpenAI-compatible 服务",
        "Use any OpenAI-compatible model ID": "使用任意 OpenAI-compatible 模型 ID",
        "Marked": "带标记",
        "Clean": "干净",
        "Add natural teleprompter line breaks to \"%@\"": "为“%@”添加自然的提词器断句",
        "Breath Marks": "呼吸标记",
        "Provider": "服务商",
        "Search providers": "搜索服务商",
        "Model": "模型",
        "Search models": "搜索模型",
        "Showing first %@ models. Type to narrow.": "正在显示前 %@ 个模型。输入关键词缩小范围。",
        "Custom OpenAI-Compatible": "自定义 OpenAI-Compatible",
        "Custom model ID": "自定义模型 ID",
        "Model ID": "模型 ID",
        "Provider Name": "服务商名称",
        "Base URL": "Base URL",
        "API key required": "需要 API Key",
        "Output": "输出",
        "Create new markdown": "创建新的 Markdown",
        "Notes": "备注",
        "Optional instructions, e.g. shorter lines, preserve paragraph shape, or cut more aggressively.": "可选要求，例如更短的行、保留段落形状，或更积极地断句。",
        "DeepSeek API Key": "DeepSeek API Key",
        "OpenAI API Key": "OpenAI API Key",
        "OpenRouter API Key": "OpenRouter API Key",
        "Gemini API Key": "Gemini API Key",
        "Groq API Key": "Groq API Key",
        "xAI API Key": "xAI API Key",
        "Ollama API Key": "Ollama API Key",
        "LM Studio API Key": "LM Studio API Key",
        "API Key": "API Key",
        "optional": "可选",
        "Optional": "可选",
        "Use Saved Key": "使用已保存密钥",
        "Replace Key": "替换密钥",
        "Save key in Keychain": "将密钥保存到钥匙串",
        "Saved key in Keychain": "密钥已保存到钥匙串",
        "Create Draft": "创建草稿",

        "Each recording is saved in the current project folder.": "每次录制都会保存到当前项目文件夹。",
        "Grant": "授权",
        "Mic": "麦克风",
        "Ready": "就绪",
        "Mode": "模式",
        "Full": "全屏",
        "Area": "区域",
        "Window": "窗口",
        "Audio": "音频",
        "Input": "输入",
        "System Audio": "系统音频",
        "Area Ratio": "区域比例",
        "Custom": "自定义",
        "Square": "方形",
        "Free": "自由",
        "Camera Overlay": "摄像头浮层",
        "No Camera": "没有摄像头",
        "Shape": "形状",
        "Position": "位置",
        "Small": "小",
        "Large": "大",
        "Circle": "圆形",
        "Rounded Rectangle": "圆角矩形",
        "Rounded Square": "圆角方形",
        "Top Left": "左上",
        "Top Right": "右上",
        "Bottom Left": "左下",
        "Bottom Right": "右下",
        "Cancel preview": "取消预览",
        "Start": "开始",
        "Area aspect ratio": "区域宽高比",
        "No camera available": "没有可用摄像头",
        "No devices enabled": "未启用设备",
        "Devices": "设备",
        "Stop recording": "停止录制",
        "Choose Output": "选择输出",
        "Delete": "删除",
        "Delete this recording": "删除这段录制",
        "Delete recording": "删除录制",
        "Camera Only": "仅摄像头",
        "Transparent": "透明",
        "Transparent Camera": "透明摄像头",
        "Render camera only with transparent background": "渲染透明背景的仅摄像头视频",
        "Render All": "全部渲染",
        "Render full recording": "渲染完整录制",
        "Edit Recording": "编辑录制",
        "Timeline": "时间线",
        "Main Timeline": "主时间线",
        "Cut Track": "剪辑轨",
        "Resize Timeline": "调整时间线高度",
        "Cuts": "剪辑段",
        "Cut": "剪辑段",
        "Add Cut": "添加剪辑段",
        "Add Cut at Playhead": "在播放头位置切段",
        "Merge Cut": "合并剪辑段",
        "Clip": "片段",
        "Playhead": "播放头",
        "Drag Playhead": "拖动播放头",
        "Zoom In": "放大",
        "Zoom Out": "缩小",
        "Zoom to Fit": "适合窗口",
        "Zoom": "缩放",
        "Trim Start": "修剪开头",
        "Trim End": "修剪结尾",
        "Preview": "预览",
        "Restart Playback": "重新播放",
        "Play": "播放",
        "Pause": "暂停",
        "Current Cut": "当前剪辑段",
        "Display Mode": "显示模式",
        "Person": "人物",
        "Combo": "组合",
        "Screen + Camera": "屏幕 + 摄像头",
        "Timing": "时间",
        "End": "结束",
        "Camera Frame": "摄像头框",
        "Camera Shape": "摄像头形状",
        "Resize Camera Frame": "调整摄像头框大小",
        "No camera track was recorded.": "这段录制没有摄像头轨道。",
        "Delete Recording": "删除录制",
        "Export": "导出",
        "Rendering edit": "正在渲染剪辑",
        "Drag": "拖拽",
        "Drag to select recording area · %@ · Release to use · Press ESC to cancel": "拖拽选择录制区域 · %@ · 松开确认 · 按 ESC 取消",
        "Click a window to record. Press ESC or right-click to cancel.": "点击要录制的窗口。按 ESC 或右键取消。",

        "About CueRecord": "关于 CueRecord",
        "Check for Updates…": "检查更新…",
        "Settings…": "设置…",
        "Open Folder…": "打开文件夹…",
        "CueRecord Help": "CueRecord 帮助",
        "Update Available": "有可用更新",
        "CueRecord %@ is available. You are currently running %@.": "CueRecord %@ 已可用。当前版本为 %@。",
        "You're Up to Date": "已是最新版本",
        "CueRecord %@ is the latest version.": "CueRecord %@ 已是最新版本。",
        "Update Check Failed": "检查更新失败",
        "Download": "下载",
        "Later": "稍后",
        "Failed to open CueRecord workspace": "无法打开 CueRecord 工作区",
        "Failed to save file": "保存文件失败",
        "Failed to open file": "打开文件失败",
        "File changed on disk": "文件已在磁盘上更改",
        "Jump to page": "跳转页面",
        "Tap a page to jump": "轻点页面跳转",
        "Next Page": "下一页",
        "Done!": "完成！"
    ]
}

func uiText(_ english: String) -> String {
    InterfaceLanguageSettings.shared.text(english)
}

extension SettingsTab {
    var localizedLabel: String { uiText(label) }
}

extension AIScriptModelPreset {
    var localizedShortDescription: String { uiText(shortDescription) }
}

extension AIBreathMarkerMode {
    var localizedLabel: String { uiText(label) }
}

extension FontFamilyPreset {
    var localizedLabel: String { uiText(label) }
}

extension FontColorPreset {
    var localizedLabel: String { uiText(label) }
}

extension CueBrightness {
    var localizedLabel: String { uiText(label) }
}

extension AudienceFace {
    var localizedLabel: String { uiText(label) }
}

extension OverlayMode {
    var localizedLabel: String { uiText(label) }
    var localizedDescription: String { uiText(description) }
}

extension NotchDisplayMode {
    var localizedLabel: String { uiText(label) }
    var localizedDescription: String { uiText(description) }
}

extension ExternalDisplayMode {
    var localizedLabel: String { uiText(label) }
    var localizedDescription: String { uiText(description) }
}

extension MirrorAxis {
    var localizedLabel: String { uiText(label) }
    var localizedDescription: String { uiText(description) }
}

extension ListeningMode {
    var localizedLabel: String { uiText(label) }
    var localizedDescription: String { uiText(description) }
}

extension RecordingCaptureMode {
    var localizedDisplayName: String { uiText(displayName) }
}

extension CameraOverlayPosition {
    var localizedDisplayName: String { uiText(displayName) }
}

extension CameraOverlaySize {
    var localizedDisplayName: String { uiText(displayName) }
}

extension CameraOverlayShape {
    var localizedDisplayName: String { uiText(displayName) }
}

extension AreaAspectRatioPreset {
    var localizedTitle: String { uiText(title) }
    var localizedSubtitle: String { uiText(subtitle) }
}
