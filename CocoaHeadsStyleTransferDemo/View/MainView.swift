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
                if let frame = appState.currImage,
                   let styleThumbnail = appState.selectedStyle?.image {
                    VStack {
                        Image(uiImage: styleThumbnail)
                            .resizable()
                            .frame(width: 75, height: 75, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                        VideoFeedView(image: frame)
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
            .navigationTitle(appState.selectedStyle?.name ?? "No Style")
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
