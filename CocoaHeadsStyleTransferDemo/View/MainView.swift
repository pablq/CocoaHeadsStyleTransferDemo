//
//  ContentView.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/15/21.
//

import SwiftUI

struct MainView: View {

    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            Text("Main View")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        NavigationLink(destination: SelectStyleView()) {
                            Text("Select Style")
                        }
                        .disabled(true)
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
