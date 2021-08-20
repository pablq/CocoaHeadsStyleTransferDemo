//
//  VideoFeedMiddleware.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/19/21.
//

import Combine

typealias Middleware = (State, Action) -> AnyPublisher<Action, Never>

func globalVideoFeedMiddleware(with videoCaptureService: VideoCaptureService) -> Middleware {
    { state, action in
        switch action {
        case .startVideo where !videoCaptureService.isSessionConfigured:
            let videoFeedPublisher = PassthroughSubject<Action, Never>()
            videoCaptureService.configureSession(with: state.styleTransferService)
            state.styleTransferService.outputHandler = { newFrame in
                videoFeedPublisher.send(.updateVideoFrame(newFrame))
            }
            videoCaptureService.startRunning()
            return videoFeedPublisher
                .eraseToAnyPublisher()
        case .startVideo:
            videoCaptureService.startRunning()
        case .stopVideo:
            videoCaptureService.stopRunning()
        default:
            break
        }
        return Empty()
            .eraseToAnyPublisher()
    }
}
