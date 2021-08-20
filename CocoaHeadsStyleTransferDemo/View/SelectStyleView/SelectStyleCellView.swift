//
//  SelectStyleCellView.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/19/21.
//

import SwiftUI

struct SelectStyleViewCell: View {
    let name: String
    let isSelected: Bool
    let isEnabled: Bool
    let action: () -> Void

    private let checkmarkSize: CGFloat = 15

    var body: some View {
        HStack {
            Image(systemName: "checkmark.square")
                .resizable()
                .frame(
                    width: checkmarkSize,
                    height: checkmarkSize,
                    alignment: .leading
                )
                .isHidden(!isSelected)
            Button(name, action: action)
                .padding()
                .disabled(!isEnabled)
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, -checkmarkSize)
    }
}

struct SelectStyleViewCell_Previews: PreviewProvider {
    static var previews: some View {
        SelectStyleViewCell(
            name: "The Style Name",
            isSelected: true,
            isEnabled: true,
            action: {}
        )
    }
}
