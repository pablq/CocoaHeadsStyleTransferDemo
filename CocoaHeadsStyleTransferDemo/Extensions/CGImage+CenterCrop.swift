//
//  CGImage+CenterCrop.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/17/21.
//

import CoreGraphics

extension CGImage {
    func centerCrop(to newSize: CGSize) -> CGImage? {
        let newOriginX = CGFloat(width) - newSize.width / 2.0
        let newOriginY = CGFloat(height) - newSize.height / 2.0
        return cropping(
            to: CGRect(
                x: newOriginX,
                y: newOriginY,
                width: newSize.width,
                height: newSize.height
            )
        )
    }
}
