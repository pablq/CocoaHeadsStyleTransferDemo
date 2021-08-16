//
//  Style.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import Foundation

struct Style: Identifiable {

    var id: String { name }

    let name: String

    static let defaultStyle = Style(name: "At The Gallery")
}
