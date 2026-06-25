//
//  SherpaOnnxStreamingASR.swift
//  CueRecord
//

import AVFoundation
import Foundation

enum SherpaOnnxModelLocator {
    static let modelName = "sherpa-onnx-streaming-paraformer-bilingual-zh-en"
    static let modelDisplayName = "Paraformer zh-en int8"

    static func modelDirectory() throws -> URL {
        if let resourceURL = Bundle.main.resourceURL {
            let bundled = resourceURL
                .appendingPathComponent("SherpaOnnxModels", isDirectory: true)
                .appendingPathComponent(modelName, isDirectory: true)
            if hasRequiredFiles(in: bundled) {
                return bundled
            }
        }

        var sourceFile = URL(fileURLWithPath: #filePath)
        sourceFile.deleteLastPathComponent()
        sourceFile.deleteLastPathComponent()
        let projectVendor = sourceFile
            .appendingPathComponent("Vendor", isDirectory: true)
            .appendingPathComponent("Models", isDirectory: true)
            .appendingPathComponent(modelName, isDirectory: true)
        if hasRequiredFiles(in: projectVendor) {
            return projectVendor
        }

        throw ASRError.modelMissing(projectVendor.path)
    }

    static func hasRequiredFiles(in directory: URL) -> Bool {
        // The .onnx weights are stored via Git LFS. When a checkout is made
        // without `git lfs pull`, the files exist as ~130-byte text pointers.
        // ONNX Runtime then throws an uncaught C++ exception while building the
        // session, which aborts the whole app. Require a realistic minimum size
        // so a missing/pointer model surfaces as a recoverable ASRError instead.
        let requirements: [(name: String, minSize: Int)] = [
            ("tokens.txt", 1_024),
            ("encoder.int8.onnx", 1_048_576),
            ("decoder.int8.onnx", 1_048_576)
        ]
        let fileManager = FileManager.default
        return requirements.allSatisfy { requirement in
            let path = directory.appendingPathComponent(requirement.name).path
            guard let attributes = try? fileManager.attributesOfItem(atPath: path),
                  let size = attributes[.size] as? Int else {
                return false
            }
            return size >= requirement.minSize
        }
    }
}

enum ASRError: LocalizedError {
    case modelMissing(String)
    case invalidAudioInput
    case recognizerInitFailed

    var errorDescription: String? {
        switch self {
        case .modelMissing(let expectedPath):
            return "Sherpa-onnx model missing. Run scripts/setup_sherpa_onnx.sh, expected at \(expectedPath)."
        case .invalidAudioInput:
            return "Audio input unavailable"
        case .recognizerInitFailed:
            return "Sherpa-onnx recognizer failed to initialize"
        }
    }
}

final class SherpaOnnxStreamingASR {
    var onTextUpdate: ((String) -> Void)?
    var onNewSegment: (() -> Void)?
    var onLevelUpdate: ((CGFloat) -> Void)?
    var onError: ((String) -> Void)?

    private let decodeQueue = DispatchQueue(label: "com.nolanlai.cuerecord.sherpa-onnx.decode")
    private let targetSampleRate = 16_000.0
    private let decodeChunkSize = 1_600

    private var audioEngine = AVAudioEngine()
    private var recognizer: SherpaOnnxRecognizer?
    private var converter: AVAudioConverter?
    private var targetFormat: AVAudioFormat?
    private var pendingSamples: [Float] = []
    private var lastText = ""
    private var isRunning = false
    private var configurationChangeObserver: Any?
    private var suppressConfigChange = false

    func start(selectedMicUID: String) {
        stop()
        isRunning = true

        do {
            try createRecognizer()
            try startAudio(selectedMicUID: selectedMicUID)
            DispatchQueue.main.async { [weak self] in
                self?.onNewSegment?()
            }
        } catch {
            isRunning = false
            cleanupAudio()
            decodeQueue.sync {
                recognizer = nil
                pendingSamples.removeAll()
                lastText = ""
            }
            DispatchQueue.main.async { [weak self] in
                self?.onError?(error.localizedDescription)
            }
        }
    }

    func stop() {
        isRunning = false
        cleanupAudio()
        decodeQueue.sync {
            recognizer?.inputFinished()
            recognizer = nil
            pendingSamples.removeAll()
            lastText = ""
        }
    }

    private func createRecognizer() throws {
        let modelDirectory = try SherpaOnnxModelLocator.modelDirectory()
        let tokens = modelDirectory.appendingPathComponent("tokens.txt").path
        let encoder = modelDirectory.appendingPathComponent("encoder.int8.onnx").path
        let decoder = modelDirectory.appendingPathComponent("decoder.int8.onnx").path

        var config = sherpaOnnxOnlineRecognizerConfig(
            featConfig: sherpaOnnxFeatureConfig(sampleRate: Int(targetSampleRate), featureDim: 80),
            modelConfig: sherpaOnnxOnlineModelConfig(
                tokens: tokens,
                paraformer: sherpaOnnxOnlineParaformerModelConfig(
                    encoder: encoder,
                    decoder: decoder
                ),
                numThreads: 2,
                provider: "cpu",
                debug: 0,
                modelType: "paraformer"
            ),
            enableEndpoint: true,
            rule1MinTrailingSilence: 2.4,
            rule2MinTrailingSilence: 1.2,
            rule3MinUtteranceLength: 20,
            decodingMethod: "greedy_search"
        )

        decodeQueue.sync {
            recognizer = withUnsafePointer(to: &config) {
                SherpaOnnxRecognizer(config: $0)
            }
        }

        if recognizer == nil {
            throw ASRError.recognizerInitFailed
        }
    }

    private func startAudio(selectedMicUID: String) throws {
        audioEngine = AVAudioEngine()

        if !selectedMicUID.isEmpty, let deviceID = AudioInputDevice.deviceID(forUID: selectedMicUID) {
            suppressConfigChange = true
            if let audioUnit = audioEngine.inputNode.audioUnit {
                var devID = deviceID
                AudioUnitSetProperty(
                    audioUnit,
                    kAudioOutputUnitProperty_CurrentDevice,
                    kAudioUnitScope_Global,
                    0,
                    &devID,
                    UInt32(MemoryLayout<AudioDeviceID>.size)
                )
                AudioUnitUninitialize(audioUnit)
                AudioUnitInitialize(audioUnit)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.suppressConfigChange = false
            }
        }

        let inputNode = audioEngine.inputNode
        let inputFormat = inputNode.outputFormat(forBus: 0)
        guard inputFormat.sampleRate > 0, inputFormat.channelCount > 0 else {
            throw ASRError.invalidAudioInput
        }

        guard let targetFormat = AVAudioFormat(
            commonFormat: .pcmFormatFloat32,
            sampleRate: targetSampleRate,
            channels: 1,
            interleaved: false
        ) else {
            throw ASRError.invalidAudioInput
        }
        self.targetFormat = targetFormat
        converter = AVAudioConverter(from: inputFormat, to: targetFormat)

        configurationChangeObserver = NotificationCenter.default.addObserver(
            forName: .AVAudioEngineConfigurationChange,
            object: audioEngine,
            queue: .main
        ) { [weak self] _ in
            guard let self, self.isRunning, !self.suppressConfigChange else { return }
            self.restartAudioAfterConfigurationChange()
        }

        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: inputFormat) { [weak self] buffer, _ in
            self?.process(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()
    }

    private func cleanupAudio() {
        if let observer = configurationChangeObserver {
            NotificationCenter.default.removeObserver(observer)
            configurationChangeObserver = nil
        }

        if audioEngine.isRunning {
            audioEngine.stop()
        }
        audioEngine.inputNode.removeTap(onBus: 0)
        converter = nil
        targetFormat = nil
    }

    private func restartAudioAfterConfigurationChange() {
        guard isRunning else { return }
        cleanupAudio()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self, self.isRunning else { return }
            do {
                try self.startAudio(selectedMicUID: NotchSettings.shared.selectedMicUID)
            } catch {
                self.isRunning = false
                self.onError?(error.localizedDescription)
            }
        }
    }

    private func process(_ buffer: AVAudioPCMBuffer) {
        guard isRunning else { return }
        updateAudioLevel(buffer)

        guard let samples = convertToModelSamples(buffer), !samples.isEmpty else { return }
        decodeQueue.async { [weak self] in
            guard let self, self.isRunning, let recognizer = self.recognizer else { return }
            self.pendingSamples.append(contentsOf: samples)

            while self.pendingSamples.count >= self.decodeChunkSize {
                let chunk = Array(self.pendingSamples.prefix(self.decodeChunkSize))
                self.pendingSamples.removeFirst(self.decodeChunkSize)
                recognizer.acceptWaveform(samples: chunk, sampleRate: Int(self.targetSampleRate))
                while recognizer.isReady() {
                    recognizer.decode()
                }
            }

            let text = recognizer.getResult().text.trimmingCharacters(in: .whitespacesAndNewlines)
            if !text.isEmpty, text != self.lastText {
                self.lastText = text
                DispatchQueue.main.async { [weak self] in
                    self?.onTextUpdate?(text)
                }
            }

            if recognizer.isEndpoint() {
                recognizer.reset()
                self.pendingSamples.removeAll(keepingCapacity: true)
                self.lastText = ""
                DispatchQueue.main.async { [weak self] in
                    self?.onNewSegment?()
                }
            }
        }
    }

    private func convertToModelSamples(_ buffer: AVAudioPCMBuffer) -> [Float]? {
        guard let converter, let targetFormat else { return nil }

        let ratio = targetFormat.sampleRate / buffer.format.sampleRate
        let frameCapacity = AVAudioFrameCount(max(1, ceil(Double(buffer.frameLength) * ratio) + 32))
        guard let convertedBuffer = AVAudioPCMBuffer(pcmFormat: targetFormat, frameCapacity: frameCapacity) else {
            return nil
        }

        var didProvideInput = false
        var conversionError: NSError?
        converter.convert(to: convertedBuffer, error: &conversionError) { _, status in
            if didProvideInput {
                status.pointee = .noDataNow
                return nil
            }
            didProvideInput = true
            status.pointee = .haveData
            return buffer
        }

        guard conversionError == nil,
              let channelData = convertedBuffer.floatChannelData?[0],
              convertedBuffer.frameLength > 0 else {
            return nil
        }

        return Array(UnsafeBufferPointer(start: channelData, count: Int(convertedBuffer.frameLength)))
    }

    private func updateAudioLevel(_ buffer: AVAudioPCMBuffer) {
        guard let channelData = buffer.floatChannelData?[0] else { return }
        let frameLength = Int(buffer.frameLength)
        var sum: Float = 0
        for index in 0..<frameLength {
            sum += channelData[index] * channelData[index]
        }
        let rms = sqrt(sum / Float(max(frameLength, 1)))
        let level = CGFloat(min(rms * 5, 1.0))
        DispatchQueue.main.async { [weak self] in
            self?.onLevelUpdate?(level)
        }
    }
}
