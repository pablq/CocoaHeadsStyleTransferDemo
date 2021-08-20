//
//  ContentView.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/15/21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        NavigationView {
            VideoFeedView()
                .navigationTitle(store.state.style.name)
        }
        .onAppear { store.dispatch(.startVideo) }
        .onDisappear { store.dispatch(.stopVideo) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Store.preview)
    }
}
