//
//  MainApp.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/15/21.
//

import SwiftUI

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(
                    Store(
                        initial: State(styleTransferService: StyleTransferService()),
                        reducer: globalReducer,
                        middleware: globalVideoFeedMiddleware(with: VideoCaptureService())
                    )
                )
        }
    }
}
