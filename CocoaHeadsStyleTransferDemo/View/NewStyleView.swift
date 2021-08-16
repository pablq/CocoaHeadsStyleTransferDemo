//
//  NewStyleView.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import SwiftUI

struct NewStyleView: View {

    @EnvironmentObject var appState: AppState

    @Environment(\.presentationMode) var presentation

    var body: some View {
        NavigationView {
            Text("New Style View")
                .toolbar {
                    ToolbarItem(placement: .destructiveAction) {
                        Button("Dismiss") {
                            presentation.wrappedValue.dismiss()
                        }
                    }
                }
        }
    }
}

struct NewStyleView_Previews: PreviewProvider {
    static var previews: some View {
        NewStyleView()
    }
}
