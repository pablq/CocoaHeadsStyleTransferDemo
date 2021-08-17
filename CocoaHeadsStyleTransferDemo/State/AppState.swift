//
//  AppState.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {

    @Published private(set) var styles: [Style] = [Style.defaultStyle]

    @Published private(set) var selectedStyle = Style.defaultStyle

    @Published private(set) var currImage: UIImage? = nil

    private let cameraService = CameraService()

    func dispatch(action: AppAction) {
        switch action {
        case .selectStyle(let style):
            selectedStyle = style
        case .addStyle(let style):
            styles.append(style)
            selectedStyle = style
        case .startCamera:
            if !cameraService.isSessionConfigured {
                cameraService.configureSession(with: handleCameraServiceUpdate)
            }
            cameraService.startRunning()
        case .stopCamera:
            cameraService.stopRunning()
            currImage = nil
            break
        }
    }

    private func handleCameraServiceUpdate(_ newImage: CGImage) {
        currImage = UIImage(cgImage: newImage)
    }
}
