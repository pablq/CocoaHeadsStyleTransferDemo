//
//  State.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import Foundation
import SwiftUI

struct State {
    var styles: [Style] = Style.allCases
    var videoFrame: UIImage?
    var style: Style {
        styleTransferService.style
    }
    var styleTransferService: StyleTransferService
}
