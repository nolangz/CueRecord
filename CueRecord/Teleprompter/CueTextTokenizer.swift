//
//  CueTextTokenizer.swift
//  CueRecord
//

import Foundation

enum TeleprompterLineBreak {
    static let markerToken = "\u{2028}"
    static let newlineToken = "\u{2029}"
    static let token = markerToken
    static let markers: Set<Character> = ["|", "｜"]

    static func isBreakToken(_ word: String) -> Bool {
        word == markerToken || word == newlineToken
    }

    static func isMarkerBreakToken(_ word: String) -> Bool {
        word == markerToken
    }
}

extension Unicode.Scalar {
    var isCJK: Bool {
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
func splitTextIntoWords(_ text: String) -> [String] {
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

    for char in text {
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
    }

    flushBuffer()

    if let last = result.last, TeleprompterLineBreak.isBreakToken(last) {
        result.removeLast()
    }

    return result
}
