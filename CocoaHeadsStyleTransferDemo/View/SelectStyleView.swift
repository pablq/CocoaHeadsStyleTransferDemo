//
//  SelectStyleView.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import SwiftUI

struct SelectStyleView: View {

    @EnvironmentObject var appState: AppState

    @Environment(\.presentationMode) var presentation

    @State private var presentNewStyleView = false

    var body: some View {
        VStack {
            ForEach(appState.styles) { style in
                Button(style.name) {
                    appState.dispatch(action: .selectStyle(style))
                    presentation.wrappedValue.dismiss()
                }
            }
        }.toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("New Style") {
                    presentNewStyleView.toggle()
                }
                .fullScreenCover(
                    isPresented: $presentNewStyleView,
                    content: NewStyleView.init
                )
            }
        }
    }
}

struct SelectStyleView_Previews: PreviewProvider {
    static var previews: some View {
        SelectStyleView()
    }
}
