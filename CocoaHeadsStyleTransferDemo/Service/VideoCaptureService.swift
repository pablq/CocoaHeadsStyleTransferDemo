//
//  CameraService.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import AVFoundation

class VideoCaptureService {
    private var captureSession: AVCaptureSession?
    private(set) var isSessionConfigured: Bool = false

    func configureSession(videoDataHandler: AVCaptureVideoDataOutputSampleBufferDelegate) {
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

        let queue = DispatchQueue(label: "VideoQueue", qos: .userInitiated)
        videoOutput.setSampleBufferDelegate(videoDataHandler, queue: queue)
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
