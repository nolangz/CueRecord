import CoreGraphics
import CoreImage
import CoreVideo
import Foundation

enum CameraFrameProcessor {
    static func mirroredVisibleImage(from pixelBuffer: CVPixelBuffer) -> (image: CIImage, extent: CGRect) {
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let cropRect = visibleContentRect(in: pixelBuffer, imageExtent: ciImage.extent)
        let sourceImage = ciImage.cropped(to: cropRect)
        let normalizedImage = sourceImage.transformed(
            by: CGAffineTransform(translationX: -cropRect.minX, y: -cropRect.minY)
        )
        let normalizedExtent = CGRect(origin: .zero, size: cropRect.size)

        let flippedImage = normalizedImage.transformed(by: CGAffineTransform(scaleX: -1, y: 1))
        let mirroredImage = flippedImage.transformed(
            by: CGAffineTransform(translationX: normalizedExtent.width, y: 0)
        )

        return (mirroredImage, normalizedExtent)
    }

    static func evenDimensions(for size: CGSize) -> (width: Int, height: Int) {
        let width = max(2, Int(size.width.rounded(.down)) / 2 * 2)
        let height = max(2, Int(size.height.rounded(.down)) / 2 * 2)
        return (width, height)
    }

    private static func visibleContentRect(in pixelBuffer: CVPixelBuffer, imageExtent: CGRect) -> CGRect {
        guard let detectedRect = detectNonBlackContentRect(in: pixelBuffer) else {
            return imageExtent
        }

        let horizontalTrim = detectedRect.minX + imageExtent.width - detectedRect.maxX
        let verticalTrim = detectedRect.minY + imageExtent.height - detectedRect.maxY
        let horizontalTrimThreshold = max(2, imageExtent.width * 0.005)
        let verticalTrimThreshold = max(2, imageExtent.height * 0.005)
        let hasMeaningfulTrim = horizontalTrim > horizontalTrimThreshold || verticalTrim > verticalTrimThreshold

        guard hasMeaningfulTrim else {
            return imageExtent
        }

        return detectedRect.intersection(imageExtent)
    }

    private static func detectNonBlackContentRect(in pixelBuffer: CVPixelBuffer) -> CGRect? {
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)

        guard width > 0, height > 0 else { return nil }
        guard CVPixelBufferGetPixelFormatType(pixelBuffer) == kCVPixelFormatType_32BGRA else {
            return CGRect(x: 0, y: 0, width: width, height: height)
        }

        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        defer { CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly) }

        guard let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer) else { return nil }

        let bytes = baseAddress.assumingMemoryBound(to: UInt8.self)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let sampleStep = max(1, min(width, height) / 120)
        let brightnessThreshold = 18
        let minimumBrightSampleRatio = 0.02

        func isBrightPixel(x: Int, y: Int) -> Bool {
            let offset = y * bytesPerRow + x * 4
            let blue = Int(bytes[offset])
            let green = Int(bytes[offset + 1])
            let red = Int(bytes[offset + 2])
            return max(red, green, blue) > brightnessThreshold
        }

        func rowHasContent(_ y: Int) -> Bool {
            var brightSamples = 0
            var totalSamples = 0

            for x in stride(from: 0, to: width, by: sampleStep) {
                totalSamples += 1
                if isBrightPixel(x: x, y: y) {
                    brightSamples += 1
                }
            }

            guard totalSamples > 0 else { return false }
            return Double(brightSamples) / Double(totalSamples) > minimumBrightSampleRatio
        }

        func columnHasContent(_ x: Int, top: Int, bottom: Int) -> Bool {
            var brightSamples = 0
            var totalSamples = 0

            for y in stride(from: top, through: bottom, by: sampleStep) {
                totalSamples += 1
                if isBrightPixel(x: x, y: y) {
                    brightSamples += 1
                }
            }

            guard totalSamples > 0 else { return false }
            return Double(brightSamples) / Double(totalSamples) > minimumBrightSampleRatio
        }

        var top = 0
        while top < height && !rowHasContent(top) {
            top += sampleStep
        }

        var bottom = height - 1
        while bottom > top && !rowHasContent(bottom) {
            bottom -= sampleStep
        }

        guard top < bottom else {
            return CGRect(x: 0, y: 0, width: width, height: height)
        }

        var left = 0
        while left < width && !columnHasContent(left, top: top, bottom: bottom) {
            left += sampleStep
        }

        var right = width - 1
        while right > left && !columnHasContent(right, top: top, bottom: bottom) {
            right -= sampleStep
        }

        guard left < right else {
            return CGRect(x: 0, y: 0, width: width, height: height)
        }

        let minX = max(0, left)
        let minY = max(0, top)
        let maxX = min(width, right + 1)
        let maxY = min(height, bottom + 1)

        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
}
