//
//  Style.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

enum Style: String, CaseIterable, Identifiable {
    case none = "No Style"
    case etching = "Etching"
    case painting = "Painting"
    case max = "Max"
    case mandy = "Mandy"
    case sean = "Sean"
    case seth = "Seth"

    var mlModelFilename: String {
        rawValue
    }

    var imageName: String {
        rawValue
    }

    var name: String {
        rawValue
    }

    // swiftlint:disable:next identifier_name
    var id: String {
        rawValue
    }
}
