//
//  CueTextTokenizer.swift
//  CueRecord
//

import Foundation

enum TeleprompterLineBreak {
    nonisolated static let markerToken = "\u{2028}"
    nonisolated static let newlineToken = "\u{2029}"
    nonisolated static let token = markerToken
    nonisolated static let markers: Set<Character> = ["|", "｜"]

    nonisolated static func isBreakToken(_ word: String) -> Bool {
        word == markerToken || word == newlineToken
    }

    nonisolated static func isMarkerBreakToken(_ word: String) -> Bool {
        word == markerToken
    }
}

enum TeleprompterPaceCue {
    nonisolated static let fastToken = "\u{E000}"
    nonisolated static let slowToken = "\u{E001}"

    private nonisolated static let fastMarkers = ["››"]
    private nonisolated static let slowMarkers = ["--(慢)", "--（慢）", "--"]

    nonisolated static func isCueToken(_ word: String) -> Bool {
        word == fastToken || word == slowToken
    }

    nonisolated static func isFastToken(_ word: String) -> Bool {
        word == fastToken
    }

    nonisolated static func isSlowToken(_ word: String) -> Bool {
        word == slowToken
    }

    nonisolated static func matchedCueToken(in text: String, at index: String.Index) -> (token: String, length: Int)? {
        let suffix = text[index...]

        if let marker = fastMarkers.first(where: { suffix.hasPrefix($0) }) {
            return (fastToken, marker.count)
        }

        if let marker = slowMarkers.first(where: { suffix.hasPrefix($0) }) {
            return (slowToken, marker.count)
        }

        return nil
    }
}

extension Unicode.Scalar {
    nonisolated var isCJK: Bool {
        let value = value
        return (value >= 0x4E00 && value <= 0x9FFF)
            || (value >= 0x3400 && value <= 0x4DBF)
            || (value >= 0x20000 && value <= 0x2A6DF)
            || (value >= 0xF900 && value <= 0xFAFF)
            || (value >= 0x3040 && value <= 0x309F)
            || (value >= 0x30A0 && value <= 0x30FF)
            || (value >= 0xAC00 && value <= 0xD7AF)
    }
}

/// Splits text into display-ready words. CJK characters are split individually
/// and explicit cue breaks become internal line-break tokens.
nonisolated func splitTextIntoWords(_ text: String) -> [String] {
    var result: [String] = []
    var buffer = ""

    func appendToken(_ token: String) {
        guard !token.isEmpty else { return }

        guard token.unicodeScalars.contains(where: { $0.isCJK }) else {
            result.append(token)
            return
        }

        var latinBuffer = ""
        for char in token {
            if char.unicodeScalars.first.map({ $0.isCJK }) == true {
                if !latinBuffer.isEmpty {
                    result.append(latinBuffer)
                    latinBuffer = ""
                }
                result.append(String(char))
            } else {
                latinBuffer.append(char)
            }
        }

        if !latinBuffer.isEmpty {
            result.append(latinBuffer)
        }
    }

    func flushBuffer() {
        appendToken(buffer)
        buffer = ""
    }

    func appendBreak(_ breakToken: String) {
        if let last = result.last, TeleprompterLineBreak.isBreakToken(last) {
            if TeleprompterLineBreak.isMarkerBreakToken(breakToken),
               !TeleprompterLineBreak.isMarkerBreakToken(last) {
                result[result.count - 1] = breakToken
            }
            return
        }
        result.append(breakToken)
    }

    var index = text.startIndex
    while index < text.endIndex {
        if let cue = TeleprompterPaceCue.matchedCueToken(in: text, at: index) {
            flushBuffer()
            result.append(cue.token)
            index = text.index(index, offsetBy: cue.length)
            continue
        }

        let char = text[index]
        if TeleprompterLineBreak.markers.contains(char) {
            flushBuffer()
            appendBreak(TeleprompterLineBreak.markerToken)
        } else if char == "\n" || char == "\r" {
            flushBuffer()
            appendBreak(TeleprompterLineBreak.newlineToken)
        } else if char.isWhitespace {
            flushBuffer()
        } else {
            buffer.append(char)
        }
        index = text.index(after: index)
    }

    flushBuffer()

    if let last = result.last, TeleprompterLineBreak.isBreakToken(last) {
        result.removeLast()
    }

    return result
}
