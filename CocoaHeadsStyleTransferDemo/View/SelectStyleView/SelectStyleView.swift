//
//  SelectStyleView.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import SwiftUI

struct SelectStyleView: View {
    @EnvironmentObject var store: Store
    @Environment(\.presentationMode) var presentation

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(store.state.styles) { style in
                    SelectStyleViewCell(
                        name: style.name,
                        isSelected: store.state.currentStyle == style,
                        isEnabled: true
                    ) {
                        presentation.wrappedValue.dismiss()
                        store.dispatch(.selectStyle(style))
                    }
                }
                SelectStyleViewCell(
                    name: "Add Style",
                    isSelected: false,
                    isEnabled: false,
                    action: { /* TODO */ }
                )
                Spacer()
            }
        }
    }
}

struct SelectStyleView_Previews: PreviewProvider {
    static var previews: some View {
        SelectStyleView()
            .environmentObject(Store.preview)
    }
}
