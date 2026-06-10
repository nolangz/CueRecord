//
//  DictationManager.swift
//  CueRecord
//
//

import Foundation
import AVFoundation
import AppKit

@Observable
class DictationManager {
    var isRecording: Bool = false
    var audioLevels: [CGFloat] = Array(repeating: 0, count: 40)
    var error: String?

    /// Called on main thread with the latest recognized text for the current segment
    var onTextUpdate: ((String) -> Void)?
    /// Called on main thread when a new recognition segment begins (after silence/restart)
    var onNewSegment: (() -> Void)?

    private let asr = SherpaOnnxStreamingASR()

    // Tracks the committed text from previous recognition segments
    private var committedText: String = ""
    private var sessionGeneration: Int = 0

    func start() {
        guard !isRecording else { return }
        cleanup()
        committedText = ""
        sessionGeneration += 1
        error = nil

        // Check microphone permission
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .denied, .restricted:
            error = "Microphone access denied. Open System Settings → Privacy & Security → Microphone."
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.beginRecognition()
                    } else {
                        self?.error = "Microphone access denied."
                    }
                }
            }
            return
        case .authorized:
            break
        @unknown default:
            break
        }

        beginRecognition()
    }

    func stop() {
        isRecording = false
        cleanup()
    }

    private func cleanup() {
        asr.stop()
    }

    private func beginRecognition() {
        cleanup()

        let currentGeneration = sessionGeneration
        asr.onTextUpdate = { [weak self] spoken in
            guard let self, self.sessionGeneration == currentGeneration else { return }
            self.onTextUpdate?(spoken)
        }
        asr.onNewSegment = { [weak self] in
            guard let self, self.sessionGeneration == currentGeneration else { return }
            self.onNewSegment?()
        }
        asr.onLevelUpdate = { [weak self] level in
            self?.audioLevels.append(level)
            if (self?.audioLevels.count ?? 0) > 40 {
                self?.audioLevels.removeFirst()
            }
        }
        asr.onError = { [weak self] message in
            guard let self, self.sessionGeneration == currentGeneration else { return }
            self.error = message
            isRecording = false
        }

        isRecording = true
        asr.start(selectedMicUID: NotchSettings.shared.selectedMicUID)
    }
}
