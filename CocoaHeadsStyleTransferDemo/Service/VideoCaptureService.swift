//
//  CameraService.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import AVFoundation

protocol VideoCaptureServiceOutputHandling: AVCaptureVideoDataOutputSampleBufferDelegate {
    var queue: DispatchQueue { get }
}

class VideoCaptureService {
    private(set) var isSessionConfigured: Bool = false

    private var captureSession: AVCaptureSession?

    func configureSession(with outputHandler: VideoCaptureServiceOutputHandling) {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.medium
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: backCamera) else {
            return
        }
        captureSession?.addInput(input)
        captureSession?.sessionPreset = AVCaptureSession.Preset.medium

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(outputHandler, queue: outputHandler.queue)

        if captureSession?.canAddOutput(videoOutput) == true {
            captureSession?.addOutput(videoOutput)
        }

        if let connection = videoOutput.connection(with: .video),
           connection.isVideoOrientationSupported {
            connection.videoOrientation = .portrait
        }

        isSessionConfigured = true
    }

    func startRunning() {
        captureSession?.startRunning()
    }

    func stopRunning() {
        captureSession?.stopRunning()
    }
}
