//
//  Reducer.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/19/21.
//

import UIKit

typealias Reducer = (State, Action) -> State

let globalReducer: Reducer = { state, action in
    var mutableState = state
    switch action {
    case .selectStyle(let style):
        mutableState.styleTransferService.style = style
        mutableState.styleTransferService.shouldApplyStyle = style != .none
    case .toggleStyle:
        mutableState.styleTransferService.shouldApplyStyle.toggle()
    case .startVideo:
        break
    case .stopVideo:
        mutableState.currentVideoFrame = nil
    case .updateVideoFrame(let newFrameImage):
        mutableState.currentVideoFrame = UIImage(cgImage: newFrameImage)
    }
    return mutableState
}
