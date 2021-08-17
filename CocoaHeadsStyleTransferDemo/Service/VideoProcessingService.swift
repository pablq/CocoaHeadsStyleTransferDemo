//
//  VideoProcessingService.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import AVFoundation
import Vision

class VideoProcessingService: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    typealias OutputHandler = (CGImage) -> Void

    var style: Style?
    var shouldApplyStyle: Bool = true
    var outputHandler: OutputHandler?

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard let cgImage = sampleBuffer.cgImage,
              let cropped = cgImage.centerCrop(to: CGSize(width: 512, height: 512)) else { return }
        if let mlModelFilename = style?.mlModelFilename, shouldApplyStyle {
            applyStyle(withModel: mlModelFilename, to: cropped)
        } else {
            notify(result: cropped)
        }
    }

    private func applyStyle(withModel mlModelFilename: String, to image: CGImage) {
        let config = MLModelConfiguration()
        config.computeUnits = .all
        guard let modelUrl = Bundle.main.url(forResource: mlModelFilename, withExtension: "mlmodelc"),
              let mlModel = try? MLModel(contentsOf: modelUrl, configuration: config),
              let vnModel = try? VNCoreMLModel(for: mlModel) else { return }

        let request = VNCoreMLRequest(model: vnModel) { [weak self] request, _ in
            guard let observation = request.results?.first as? VNPixelBufferObservation,
                  let cgImage = observation.pixelBuffer.cgImage else {
                return
            }
            self?.notify(result: cgImage)
        }

        try? VNImageRequestHandler(
            cgImage: image,
            options: [:]
        )
        .perform([request])
    }

    private func notify(result: CGImage) {
        DispatchQueue.main.async { [weak self] in
            self?.outputHandler?(result)
        }
    }
}
