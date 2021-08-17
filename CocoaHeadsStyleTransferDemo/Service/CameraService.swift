//
//  CameraService.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import Foundation
import AVFoundation
import UIKit

class CameraService: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {

    typealias UpdateHandler = (CGImage) -> Void

    private var updateHandler: UpdateHandler? = nil
    private var captureSession: AVCaptureSession? = nil

    var isSessionConfigured: Bool = false

    func configureSession(with updateHandler: @escaping UpdateHandler) {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.medium

        let availableDevices = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: AVMediaType.video,
            position: .back
        ).devices

        do {
            if let captureDevice = availableDevices.first {
                captureSession?.addInput(try AVCaptureDeviceInput(device: captureDevice))
            }
        } catch {
            assertionFailure("Crashing because app is useless without a capture session.\n\nSee: \(error.localizedDescription)")
        }

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        if captureSession?.canAddOutput(videoOutput) == true {
            captureSession?.addOutput(videoOutput)
        }

        guard let connection = videoOutput.connection(with: .video) else { return }
        guard connection.isVideoOrientationSupported else { return }

        connection.videoOrientation = .portrait

        /*
         TODO: WHAT TO DO WITH THIS?

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
         */

        self.updateHandler = updateHandler
        isSessionConfigured = true

    }

    func startRunning() {
        captureSession?.startRunning()
    }

    func stopRunning() {
        captureSession?.stopRunning()
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

//        if currentModelConfig == 0{
            DispatchQueue.main.async { [weak self] in
                self?.updateHandler?(CameraUtil.imageFromSampleBuffer(buffer: sampleBuffer))
            }
//        }
//        else{
//
//            let config = MLModelConfiguration()
//            config.computeUnits = .all
//
//            var s : MLModel?
//            s = try? StyleBlue.init(configuration: config).model
//
//
//            guard let styleModel = s else{return}
//
//            guard let model = try? VNCoreMLModel(for: styleModel) else { return }
//            let request = VNCoreMLRequest(model: model) { (finishedRequest, error) in
//                guard let results = finishedRequest.results as? [VNPixelBufferObservation] else { return }
//
//                guard let observation = results.first else { return }
//
//                DispatchQueue.main.async(execute: {
//                    self.imageView.image = UIImage(pixelBuffer: observation.pixelBuffer)
//                })
//            }
//
//            guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
//            try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
//        }
    }
}

fileprivate class CameraUtil {
    class func imageFromSampleBuffer(buffer: CMSampleBuffer) -> CGImage {
        let pixelBuffer: CVImageBuffer = CMSampleBufferGetImageBuffer(buffer)!

        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)

        let pixelBufferWidth = CGFloat(CVPixelBufferGetWidth(pixelBuffer))
        let pixelBufferHeight = CGFloat(CVPixelBufferGetHeight(pixelBuffer))
        let imageRect: CGRect = CGRect(x: 0, y: 0, width: pixelBufferWidth, height: pixelBufferHeight)
        let ciContext = CIContext.init()
        return ciContext.createCGImage(ciImage, from: imageRect)!
    }
}
