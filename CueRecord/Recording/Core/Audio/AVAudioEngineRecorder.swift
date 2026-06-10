import Foundation
import AVFoundation

// MARK: - AVAudioEngine 麦克风录制器
@MainActor
class AVAudioEngineRecorder: NSObject {
    private var audioEngine: AVAudioEngine?
    private var inputNode: AVAudioInputNode?
    private var audioFile: AVAudioFile?
    private var audioWriterInput: AVAssetWriterInput?
    private var isRecording = false

    // 音频缓冲区管理
    private let audioQueue = DispatchQueue(label: "com.screenrecorder.audioengine", qos: .userInteractive)
    private var startTime: CMTime?
    private var audioFormat: AVAudioFormat?
    private var sampleCount: Int64 = 0  // 音频样本计数器
    private var firstSampleTime: AVAudioTime?  // 记录第一个样本的时间
    private var sessionStartTime: CMTime = .zero  // 录制会话开始时间
    
    // MARK: - 初始化
    override init() {
        super.init()
        setupAudioEngine()
    }
    
    deinit {
        // 清理将在stopRecording方法中处理
    }
    
    // MARK: - 音频引擎设置
    private func setupAudioEngine() {
        audioEngine = AVAudioEngine()
        inputNode = audioEngine?.inputNode
        
        guard let inputNode = inputNode else {
            print("❌ 无法获取音频输入节点")
            return
        }
        
        // 获取输入格式
        audioFormat = inputNode.outputFormat(forBus: 0)
        print("🎤 AVAudioEngine 初始化完成")
        print("   格式: \(audioFormat?.description ?? "未知")")
    }
    
    // MARK: - 设置音频设备
    func setInputDevice(deviceID: AudioDeviceID?) {
        guard let engine = audioEngine else { return }
        
        do {
            // 如果没有指定设备ID，使用默认设备
            guard let deviceID = deviceID else {
                print("🎤 使用默认麦克风设备")
                return
            }
            
            // 设置指定的音频输入设备
            let audioUnit = engine.inputNode.audioUnit
            var deviceIDVar = deviceID
            let propertySize = UInt32(MemoryLayout<AudioDeviceID>.size)
            
            let status = AudioUnitSetProperty(
                audioUnit!,
                kAudioOutputUnitProperty_CurrentDevice,
                kAudioUnitScope_Global,
                0,
                &deviceIDVar,
                propertySize
            )
            
            if status == noErr {
                print("✅ 已设置音频输入设备: \(deviceID)")
            } else {
                print("❌ 设置音频输入设备失败: \(status)")
            }
        } catch {
            print("❌ 设置音频设备失败: \(error)")
        }
    }
    
    // MARK: - 开始录制
    func startRecording(writerInput: AVAssetWriterInput) throws {
        guard let engine = audioEngine,
              let inputNode = inputNode else {
            throw RecordingError.audioSetupFailed
        }

        self.audioWriterInput = writerInput
        self.isRecording = true
        self.startTime = nil
        self.sampleCount = 0  // 重置样本计数器
        self.firstSampleTime = nil  // 重置第一个样本时间
        self.sessionStartTime = .zero  // 重置会话开始时间
        
        // 安装音频tap来捕获音频数据
        let format = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, time in
            guard let self = self, self.isRecording else { return }
            
            // 处理音频缓冲区
            self.processAudioBuffer(buffer, time: time)
        }
        
        // 启动音频引擎
        try engine.start()
        print("✅ AVAudioEngine 开始录制")
    }
    
    // MARK: - 停止录制
    func stopRecording() {
        guard let engine = audioEngine else { return }

        isRecording = false
        sampleCount = 0  // 重置样本计数器
        firstSampleTime = nil  // 重置第一个样本时间
        
        // 移除音频tap
        inputNode?.removeTap(onBus: 0)
        
        // 停止音频引擎
        engine.stop()
        
        print("⏹ AVAudioEngine 停止录制")
    }
    
    // MARK: - 处理音频缓冲区
    private func processAudioBuffer(_ buffer: AVAudioPCMBuffer, time: AVAudioTime) {
        guard let writerInput = audioWriterInput,
              writerInput.isReadyForMoreMediaData else {
            return
        }
        
        // 转换为CMSampleBuffer
        guard let sampleBuffer = createSampleBuffer(from: buffer, time: time) else {
            print("⚠️ 无法创建音频样本缓冲区")
            return
        }
        
        // 写入音频数据
        audioQueue.async { [weak self] in
            guard let self = self, self.isRecording else { return }
            
            if writerInput.append(sampleBuffer) {
                // 成功写入
            } else {
                print("⚠️ 音频数据写入失败")
            }
        }
    }
    
    // MARK: - 创建CMSampleBuffer
    private func createSampleBuffer(from audioBuffer: AVAudioPCMBuffer, time: AVAudioTime) -> CMSampleBuffer? {
        let audioFormat = audioBuffer.format
        let frameLength = Int64(audioBuffer.frameLength)
        let sampleRate = audioFormat.sampleRate

        // 记录第一个样本的时间，用于后续计算相对时间
        if firstSampleTime == nil {
            firstSampleTime = time
            print("🎤 音频录制开始，首个样本时间: \(time.hostTime)")
        }

        // 计算相对于第一个样本的时间偏移（使用主机时间）
        guard let firstTime = firstSampleTime else { return nil }

        // 使用AVAudioTime的hostTime计算精确的时间差
        let hostTimeDiff = time.hostTime - firstTime.hostTime
        let hostTimeFrequency = CVGetHostClockFrequency()
        let seconds = Double(hostTimeDiff) / hostTimeFrequency

        // 创建基于实际时间差的时间戳，确保与视频同步
        let presentationTime = CMTime(seconds: seconds, preferredTimescale: CMTimeScale(sampleRate))

        // 更新样本计数器（用于调试）
        sampleCount += frameLength

        // 每秒打印一次调试信息
        if sampleCount % Int64(sampleRate) < frameLength {
            print("🎵 音频时间戳: \(String(format: "%.3f", seconds))秒, 样本数: \(sampleCount)")
        }
        
        // 创建音频格式描述
        var formatDescription: CMAudioFormatDescription?
        var asbd = audioFormat.streamDescription.pointee
        let status = CMAudioFormatDescriptionCreate(
            allocator: kCFAllocatorDefault,
            asbd: &asbd,
            layoutSize: 0,
            layout: nil,
            magicCookieSize: 0,
            magicCookie: nil,
            extensions: nil,
            formatDescriptionOut: &formatDescription
        )
        
        guard status == noErr, let formatDesc = formatDescription else {
            print("❌ 无法创建音频格式描述: \(status)")
            return nil
        }
        
        // 使用Data来管理内存，避免手动内存管理
        let frameCount = audioBuffer.frameLength
        let channelCount = Int(audioFormat.channelCount)
        
        // 创建Data对象来存储音频数据
        var audioData = Data()
        
        if let channelData = audioBuffer.floatChannelData {
            // 交错音频数据到Data
            audioData.reserveCapacity(Int(frameCount) * channelCount * MemoryLayout<Float>.size)
            
            for frame in 0..<Int(frameCount) {
                for channel in 0..<channelCount {
                    var sample = channelData[channel][frame]
                    audioData.append(Data(bytes: &sample, count: MemoryLayout<Float>.size))
                }
            }
        }
        
        // 创建CMBlockBuffer
        var blockBuffer: CMBlockBuffer?
        let blockStatus = audioData.withUnsafeBytes { dataPointer in
            CMBlockBufferCreateWithMemoryBlock(
                allocator: kCFAllocatorDefault,
                memoryBlock: UnsafeMutableRawPointer(mutating: dataPointer.baseAddress),
                blockLength: audioData.count,
                blockAllocator: kCFAllocatorNull,  // 不需要释放，因为Data会管理
                customBlockSource: nil,
                offsetToData: 0,
                dataLength: audioData.count,
                flags: kCMBlockBufferAssureMemoryNowFlag,
                blockBufferOut: &blockBuffer
            )
        }
        
        guard blockStatus == noErr, let block = blockBuffer else {
            print("❌ 创建CMBlockBuffer失败: \(blockStatus)")
            return nil
        }
        
        // 创建CMSampleBuffer
        var sampleBuffer: CMSampleBuffer?
        let duration = CMTime(
            value: frameLength,
            timescale: CMTimeScale(sampleRate)
        )
        
        let sampleStatus = CMAudioSampleBufferCreateReadyWithPacketDescriptions(
            allocator: kCFAllocatorDefault,
            dataBuffer: block,
            formatDescription: formatDesc,
            sampleCount: CMItemCount(frameCount),
            presentationTimeStamp: presentationTime,
            packetDescriptions: nil,
            sampleBufferOut: &sampleBuffer
        )
        
        if sampleStatus != noErr {
            print("❌ 创建CMSampleBuffer失败: \(sampleStatus)")
            return nil
        }
        
        return sampleBuffer
    }
}

// MARK: - 录制错误扩展
// RecordingError.audioSetupFailed 已在其他地方定义