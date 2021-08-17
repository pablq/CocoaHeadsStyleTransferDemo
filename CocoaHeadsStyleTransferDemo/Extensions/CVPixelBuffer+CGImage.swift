//
//  CVPixelBuffer+CGImage.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/17/21.
//

import CoreVideo
import VideoToolbox

extension CVPixelBuffer {
    var cgImage: CGImage? {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(self, options: nil, imageOut: &cgImage)
        return cgImage
    }
}
