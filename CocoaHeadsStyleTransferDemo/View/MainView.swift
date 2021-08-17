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
            Group {
                if let image = appState.currImage {
                    Image(uiImage: image)
                } else {
                    ProgressView()
                }
            }
            .navigationTitle(appState.selectedStyle.name)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: SelectStyleView()) {
                        Text("Select Style")
                    }
                    .disabled(true)
                }
            }
        }
        .onAppear { appState.dispatch(action: .startCamera) }
        .onDisappear { appState.dispatch(action: .stopCamera) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
