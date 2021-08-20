//
//  Store+Preview.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/19/21.
//

import UIKit
import Combine

extension Store {
    static var preview: Store {
        let fakeMiddleware: Middleware = { _, _ in Empty().eraseToAnyPublisher() }
        var fakeState = State(styleTransferService: StyleTransferService())
        fakeState.styleTransferService.style = .etching
        fakeState.videoFrame = UIImage(systemName: "paintpalette")
        let fakeReducer: Reducer = { _, _ in fakeState }
        return Store(
            initial: fakeState,
            reducer: fakeReducer,
            middleware: fakeMiddleware
        )
    }
}
