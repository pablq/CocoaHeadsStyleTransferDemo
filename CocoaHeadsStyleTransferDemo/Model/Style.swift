//
//  Style.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import UIKit

struct Style: Identifiable {
    // swiftlint:disable:next identifier_name
    var id: String { name }

    let name: String

    var mlModelFilename: String {
        name
    }

    var image: UIImage? {
        UIImage(named: name)
    }
}
