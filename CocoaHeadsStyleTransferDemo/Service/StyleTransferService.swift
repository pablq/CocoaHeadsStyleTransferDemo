//
//  StyleTransferService.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import AVFoundation
import Vision

class StyleTransferService: NSObject, VideoCaptureServiceOutputHandling {
    var style: Style = .none {
        didSet {
            if style == .none {
                currModel = nil
                return
            }
            let config = MLModelConfiguration()
            config.computeUnits = .all
            guard let modelUrl = Bundle.main.url(forResource: style.mlModelFilename, withExtension: "mlmodelc"),
                  let mlModel = try? MLModel(contentsOf: modelUrl, configuration: config) else { return }
            currModel = try? VNCoreMLModel(for: mlModel)
        }
    }
    var shouldApplyStyle: Bool = true
    var outputHandler: ((CGImage) -> Void)?
    let queue = DispatchQueue(label: "com.pablo.CocoaHeadsStyleTransferDemo.StyleTransferingQueue", qos: .userInitiated)

    private var currModel: VNCoreMLModel?

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard let videoFrame = sampleBuffer.cgImage,
              let croppedVideoFrame = videoFrame.centerCrop(to: CGSize(width: 512, height: 512)) else { return }
        if let model = currModel, shouldApplyStyle {
            applyStyle(with: model, to: croppedVideoFrame)
        } else {
            notify(result: croppedVideoFrame)
        }
    }

    private func applyStyle(with model: VNCoreMLModel, to videoFrame: CGImage) {
        let request = VNCoreMLRequest(model: model) { [weak self] request, _ in
            guard let observation = request.results?.first as? VNPixelBufferObservation,
                  let cgImage = observation.pixelBuffer.cgImage else {
                return
            }
            self?.notify(result: cgImage)
        }

        try? VNImageRequestHandler(
            cgImage: videoFrame,
            options: [:]
        )
        .perform([request])
    }

    private func notify(result: CGImage) {
        guard let outputHandler = outputHandler else { return }
        DispatchQueue.main.async {
            outputHandler(result)
        }
    }
}
