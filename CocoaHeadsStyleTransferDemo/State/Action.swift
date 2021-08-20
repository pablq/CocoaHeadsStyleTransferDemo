//
//  Action.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import CoreGraphics

enum Action {
    case selectStyle(Style)
    case toggleStyle
    case startVideo
    case stopVideo
    case updateVideoFrame(CGImage)
}
