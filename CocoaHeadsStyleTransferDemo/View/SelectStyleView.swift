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
                .padding()
            }
            Button("Train New Style") {
                // TODO: Update to Xcode Beta and implement me!
            }
            .disabled(true)
            .padding()
            Spacer()
        }
    }
}

struct SelectStyleView_Previews: PreviewProvider {
    static var previews: some View {
        SelectStyleView()
    }
}
