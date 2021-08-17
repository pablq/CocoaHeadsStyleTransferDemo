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
                    VStack {
                        VideoFeedView(image: image)
                        HStack {
                            Button("Toggle Styling") {
                                appState.dispatch(action: .toggleStyle)
                            }
                            Spacer()
                            NavigationLink(destination: SelectStyleView()) {
                                Text("Select Style")
                            }
                        }.padding()
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle(appState.styleName ?? "No Style")
        }
        .onAppear { appState.dispatch(action: .startVideo) }
        .onDisappear { appState.dispatch(action: .stopVideo) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let envObject = AppState()

    static var previews: some View {
        MainView()
            .environmentObject(envObject)
    }
}
