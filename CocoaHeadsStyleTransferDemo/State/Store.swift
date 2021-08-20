//
//  Store.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/19/21.
//

import Foundation
import Combine

class Store: ObservableObject {
    @Published private(set) var state: State

    private let reducer: Reducer
    private let middleware: Middleware
    private let queue = DispatchQueue(label: "com.pablo.CocoaHeadsStyleTransferDemo.StoreQueue", qos: .userInitiated)
    private var subscriptions: Set<AnyCancellable> = []

    init(
        initial: State,
        reducer: @escaping Reducer,
        middleware: @escaping Middleware
    ) {
        self.state = initial
        self.reducer = reducer
        self.middleware = middleware
    }

    func dispatch(_ action: Action) {
        queue.sync {
            self.dispatch(self.state, action)
        }
    }

    private func dispatch(_ currentState: State, _ action: Action) {
        let newState = reducer(currentState, action)
        middleware(newState, action)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: dispatch)
            .store(in: &subscriptions)
        state = newState
    }

    static var preview: Store {
        let fakeMiddleware: Middleware = { _, _ in Empty().eraseToAnyPublisher() }
        let fakeState = State(styleTransferService: StyleTransferService())
        fakeState.styleTransferService.style = .etching
        return Store(
            initial: fakeState,
            reducer: globalReducer,
            middleware: fakeMiddleware
        )
    }
}
