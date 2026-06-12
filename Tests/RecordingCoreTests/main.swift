import CoreGraphics
import CoreMedia
import Foundation

enum TestFailure: Error, CustomStringConvertible {
    case failed(String)

    var description: String {
        switch self {
        case .failed(let message):
            return message
        }
    }
}

func expect(_ condition: @autoclosure () -> Bool, _ message: String) throws {
    if !condition() {
        throw TestFailure.failed(message)
    }
}

func seconds(_ value: Double) -> CMTime {
    CMTime(seconds: value, preferredTimescale: 600)
}

func testAudioStartGate() throws {
    let gate = AudioStartGate(holdLimit: seconds(0.5))
    let firstVideo = seconds(1.0)

    try expect(
        gate.decision(audioStart: seconds(0.9), audioDuration: seconds(0.05), firstVideoStart: nil) == .waitForVideo,
        "Audio should wait while video start is unknown"
    )

    switch gate.decision(audioStart: seconds(0.2), audioDuration: seconds(0.2), firstVideoStart: firstVideo) {
    case .dropBeforeVideo:
        break
    default:
        throw TestFailure.failed("Audio that ends before first video should be dropped")
    }

    switch gate.decision(audioStart: seconds(0.95), audioDuration: seconds(0.1), firstVideoStart: firstVideo) {
    case .append(let relativeTo, let partialOverlap):
        try expect(relativeTo == firstVideo, "Overlapping audio should stay on the video time base")
        try expect(partialOverlap == seconds(0.05), "Overlap duration should be measured")
    default:
        throw TestFailure.failed("Overlapping audio should be appended")
    }

    switch gate.decision(audioStart: seconds(1.2), audioDuration: seconds(0.1), firstVideoStart: firstVideo) {
    case .append(let relativeTo, let partialOverlap):
        try expect(relativeTo == firstVideo, "Post-video audio should use first video as offset")
        try expect(partialOverlap == .zero, "Post-video audio should have no partial overlap")
    default:
        throw TestFailure.failed("Post-video audio should be appended")
    }

    try expect(
        gate.shouldKeepPendingAudio(newestAudioStart: seconds(1.0), oldestAudioStart: seconds(0.55)),
        "Pending audio within hold limit should be kept"
    )
    try expect(
        !gate.shouldKeepPendingAudio(newestAudioStart: seconds(1.0), oldestAudioStart: seconds(0.4)),
        "Pending audio beyond hold limit should be trimmed"
    )
}

func testBoundedDropOldestBuffer() throws {
    var buffer = BoundedDropOldestBuffer<Int>(capacity: 2)
    buffer.append(1)
    buffer.append(2)
    buffer.append(3)

    try expect(buffer.droppedCount == 1, "Buffer should count dropped oldest entries")
    try expect(buffer.removeAll() == [2, 3], "Buffer should keep newest entries")
    try expect(buffer.isEmpty, "removeAll should empty the buffer")
}

func testResolvedRecordingTarget() throws {
    let displayOne = RecordingDisplayGeometry(
        id: 1,
        frame: CGRect(x: 0, y: 0, width: 100, height: 100),
        name: "Internal",
        index: 0
    )
    let displayTwo = RecordingDisplayGeometry(
        id: 2,
        frame: CGRect(x: 100, y: 0, width: 200, height: 100),
        name: "External",
        index: 1
    )
    let displays = [displayOne, displayTwo]

    let fullScreen = ResolvedRecordingTarget.resolve(
        mode: .fullScreen,
        selectedDisplayID: 2,
        displays: displays
    )
    try expect(fullScreen?.displayID == 2, "Full-screen target should honor selected display")
    try expect(fullScreen?.interfaceFrame == displayTwo.frame, "Full-screen interface frame should be selected display")

    let area = ResolvedRecordingTarget.resolve(
        mode: .selectedArea(CGRect(x: 140, y: 20, width: 60, height: 60)),
        selectedDisplayID: 1,
        displays: displays
    )
    try expect(area?.displayID == 2, "Area target should use the display with the largest intersection")
    try expect(area?.overlayFrame == CGRect(x: 140, y: 20, width: 60, height: 60), "Area overlay should be the capture rect")

    let windowTarget = WindowRecordingTarget(
        windowID: 42,
        frame: CGRect(x: 20, y: 10, width: 50, height: 50),
        title: "Doc",
        ownerName: "App"
    )
    let window = ResolvedRecordingTarget.resolve(
        mode: .selectedWindow(windowTarget),
        selectedDisplayID: 2,
        displays: displays
    )
    try expect(window?.displayID == 1, "Window target should follow the window display")
    try expect(window?.modeName == "selectedWindow", "Window target should expose mode name")
}

func testMetricsURLAndMissingOutputValidation() throws {
    let outputURL = URL(fileURLWithPath: "/tmp/CueRecord Sample.mov")
    let metricsURL = RecordingMetricsRecorder.metricsURL(for: outputURL)
    try expect(metricsURL.lastPathComponent == "CueRecord Sample_metrics.json", "Metrics URL should use output base name")

    let missingURL = URL(fileURLWithPath: "/tmp/cuerecord-missing-\(UUID().uuidString).mov")
    let validation = RecordingOutputValidator.validate(outputURL: missingURL)
    try expect(validation.health == .damaged, "Missing output should be damaged")
    try expect(validation.issues.contains("Output file does not exist"), "Missing output should report a clear issue")
}

func testRecordingPixelFormatPolicy() throws {
    try expect(
        RecordingPixelFormatPolicy.format(from: "bgra") == .bgra,
        "BGRA alias should resolve"
    )
    try expect(
        RecordingPixelFormatPolicy.format(from: "420v") == .yuv420VideoRange,
        "420v alias should resolve"
    )
    try expect(
        RecordingPixelFormatPolicy.format(from: "NV12") == .yuv420VideoRange,
        "NV12 alias should map to video-range 420"
    )
    try expect(
        RecordingPixelFormatPolicy.format(from: "420f") == .yuv420FullRange,
        "420f alias should resolve"
    )

    let suiteName = "CueRecordRecordingPixelFormatPolicyTests-\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suiteName)!
    defer { defaults.removePersistentDomain(forName: suiteName) }

    try expect(
        RecordingPixelFormatPolicy.selectedFormat(defaults: defaults, environment: [:]) == .bgra,
        "Default capture pixel format should stay BGRA until a quality path is explicitly enabled"
    )

    defaults.set("420v", forKey: RecordingPixelFormatPolicy.userDefaultsKey)
    try expect(
        RecordingPixelFormatPolicy.selectedFormat(defaults: defaults, environment: [:]) == .yuv420VideoRange,
        "Stored 420v preference should select video-range 420"
    )

    try expect(
        RecordingPixelFormatPolicy.selectedFormat(
            defaults: defaults,
            environment: [RecordingPixelFormatPolicy.environmentKey: "420f"]
        ) == .yuv420FullRange,
        "Environment override should take precedence over stored preference"
    )
}

func testRecordingArtifactOrganizer() throws {
    let fileManager = FileManager.default
    let root = fileManager.temporaryDirectory
        .appendingPathComponent("CueRecordArtifactOrganizer-\(UUID().uuidString)", isDirectory: true)
    defer { try? fileManager.removeItem(at: root) }

    try fileManager.createDirectory(at: root, withIntermediateDirectories: true)

    let finalURL = root.appendingPathComponent("ScreenRecord_2026-06-10_17-33-36_composited.mov")
    let rawScreenURL = root.appendingPathComponent("ScreenRecord_2026-06-10_17-33-36.mov")
    let cameraURL = root.appendingPathComponent("ScreenRecord_2026-06-10_17-33-36_camera.mov")
    let overlayURL = root.appendingPathComponent("ScreenRecord_2026-06-10_17-33-36_overlay.json")
    let metricsURL = root.appendingPathComponent("ScreenRecord_2026-06-10_17-33-36_metrics.json")

    for url in [finalURL, rawScreenURL, cameraURL, overlayURL, metricsURL] {
        try Data(url.lastPathComponent.utf8).write(to: url)
    }

    let movedURLs = try RecordingArtifactOrganizer.moveRawArtifacts(in: root, keeping: finalURL)
    let rawDataURL = root.appendingPathComponent(RecordingArtifactOrganizer.rawDataDirectoryName, isDirectory: true)

    try expect(fileManager.fileExists(atPath: finalURL.path), "Final composited export should stay in the session folder")
    try expect(!fileManager.fileExists(atPath: rawScreenURL.path), "Raw screen recording should leave the session folder")
    try expect(fileManager.fileExists(atPath: rawDataURL.appendingPathComponent(rawScreenURL.lastPathComponent).path), "Raw screen recording should move into raw_data")
    try expect(fileManager.fileExists(atPath: rawDataURL.appendingPathComponent(cameraURL.lastPathComponent).path), "Camera recording should move into raw_data")
    try expect(fileManager.fileExists(atPath: rawDataURL.appendingPathComponent(overlayURL.lastPathComponent).path), "Overlay metadata should move into raw_data")
    try expect(fileManager.fileExists(atPath: rawDataURL.appendingPathComponent(metricsURL.lastPathComponent).path), "Metrics should move into raw_data")
    try expect(movedURLs.count == 4, "Only non-final root artifacts should move into raw_data")
}

func testRecordingArtifactDeletion() throws {
    let fileManager = FileManager.default
    let root = fileManager.temporaryDirectory
        .appendingPathComponent("CueRecordArtifactDeletion-\(UUID().uuidString)", isDirectory: true)
    defer { try? fileManager.removeItem(at: root) }

    try fileManager.createDirectory(at: root, withIntermediateDirectories: true)

    let screenURL = root.appendingPathComponent("ScreenRecord_2026-06-10_17-33-36.mov")
    let cameraURL = root.appendingPathComponent("ScreenRecord_2026-06-10_17-33-36_camera.mov")
    let overlayURL = root.appendingPathComponent("ScreenRecord_2026-06-10_17-33-36_overlay.json")
    let unrelatedURL = root.appendingPathComponent("notes.md")

    for url in [screenURL, cameraURL, overlayURL, unrelatedURL] {
        try Data(url.lastPathComponent.utf8).write(to: url)
    }

    let capturedOutput = CapturedRecordingOutput(
        outputURL: screenURL,
        cameraURL: cameraURL,
        overlayMetadataURL: overlayURL
    )
    let deletedURLs = try RecordingArtifactOrganizer.deleteArtifacts(for: capturedOutput)

    try expect(!fileManager.fileExists(atPath: screenURL.path), "Delete should remove the raw screen recording")
    try expect(!fileManager.fileExists(atPath: cameraURL.path), "Delete should remove the camera recording")
    try expect(!fileManager.fileExists(atPath: overlayURL.path), "Delete should remove overlay metadata")
    try expect(fileManager.fileExists(atPath: unrelatedURL.path), "Delete should keep unrelated project files")
    try expect(deletedURLs.count == 3, "Delete should report only the removed recording files")
}

let tests: [(String, () throws -> Void)] = [
    ("AudioStartGate", testAudioStartGate),
    ("BoundedDropOldestBuffer", testBoundedDropOldestBuffer),
    ("ResolvedRecordingTarget", testResolvedRecordingTarget),
    ("MetricsAndValidator", testMetricsURLAndMissingOutputValidation),
    ("RecordingPixelFormatPolicy", testRecordingPixelFormatPolicy),
    ("RecordingArtifactOrganizer", testRecordingArtifactOrganizer),
    ("RecordingArtifactDeletion", testRecordingArtifactDeletion)
]

do {
    for (name, test) in tests {
        try test()
        print("PASS \(name)")
    }
    print("PASS recording core tests")
} catch {
    fputs("FAIL \(error)\n", stderr)
    exit(1)
}
