//
//  CGImage+CenterCrop.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/17/21.
//

import CoreGraphics

extension CGImage {
    func centerCrop(to size: CGSize) -> CGImage? {
        let newOriginX = CGFloat(width) - size.width / 2.0
        let newOriginY = CGFloat(height) - size.height / 2.0
        return cropping(
            to: CGRect(
                x: newOriginX,
                y: newOriginY,
                width: size.width,
                height: size.height
            )
        )
    }
}
