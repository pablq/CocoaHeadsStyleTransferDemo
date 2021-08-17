//
//  CMSampleBuffer+CGImage.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import CoreMedia
import CoreImage

extension CMSampleBuffer {
    var cgImage: CGImage? {
        guard let pixelBuffer: CVImageBuffer = CMSampleBufferGetImageBuffer(self) else {
            return nil
        }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext()
        return context.createCGImage(ciImage, from: ciImage.extent)
    }
}
