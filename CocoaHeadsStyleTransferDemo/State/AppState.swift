//
//  AppState.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import Foundation

class AppState: ObservableObject {

    @Published private(set) var styles: [Style] = [Style.defaultStyle]

    @Published private(set) var selectedStyle = Style.defaultStyle

    func dispatch(action: AppAction) {
        switch action {
        case .selectStyle(let style):
            selectedStyle = style
        case .addStyle(let style):
            styles.append(style)
            selectedStyle = style
            break
        }
    }
}
