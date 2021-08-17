//
//  AppState.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {

    @Published private(set) var styles: [Style] = [
        Style(name: "Etching"),
        Style(name: "Painting"),
        Style(name: "Max"),
        Style(name: "Mandy"),
        Style(name: "Sean")
    ]

    @Published private(set) var currImage: UIImage?

    var selectedStyle: Style? {
        videoProcessingService.style
    }

    private let videoCaptureService = VideoCaptureService()
    private let videoProcessingService = VideoProcessingService()

    func dispatch(action: AppAction) {
        switch action {
        case .selectStyle(let style):
            videoProcessingService.style = style
            videoProcessingService.shouldApplyStyle = true
        case .addStyle(let style):
            styles.append(style)
            videoProcessingService.style = style
            videoProcessingService.shouldApplyStyle = true
        case .startVideo:
            if !videoCaptureService.isSessionConfigured {
                videoProcessingService.outputHandler = { [unowned self] cgImage in
                    currImage = UIImage(cgImage: cgImage)
                }
                videoProcessingService.style = styles.first
                videoProcessingService.shouldApplyStyle = true
                videoCaptureService.configureSession(videoDataHandler: videoProcessingService)
            }
            videoCaptureService.startRunning()
        case .stopVideo:
            videoCaptureService.stopRunning()
            currImage = nil
        case .toggleStyle:
            videoProcessingService.shouldApplyStyle = !videoProcessingService.shouldApplyStyle
        }
    }
}
