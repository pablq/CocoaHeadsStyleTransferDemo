//
//  VideoControlsView.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/19/21.
//

import SwiftUI

struct VideoControlsView<Destination: View>: View {
    let toggleStyleAction: () -> Void
    let toggleEnabled: Bool
    let buildSelectStyleDestination: () -> Destination

    var body: some View {
        HStack {
            Button("Toggle Style", action: toggleStyleAction)
                .disabled(!toggleEnabled)
            Spacer()
            NavigationLink(destination: buildSelectStyleDestination()) {
                Text("Select Style")
            }
        }
        .padding()
    }
}

struct VideoFeedControlsView_Previews: PreviewProvider {
    static var previews: some View {
        VideoControlsView<SelectStyleView>(
            toggleStyleAction: {},
            toggleEnabled: true,
            buildSelectStyleDestination: { SelectStyleView() }
        )
    }
}
