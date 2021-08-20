//
//  View+IsHidden.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/19/21.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
}
