//
//  VideoFeedView.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/19/21.
//

import SwiftUI

struct VideoFeedView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        VStack {
            if store.state.style != .none {
                StyleThumbnailView(imageName: store.state.style.imageName)
            } else {
                NoStyleThumbnailView()
            }
            VideoWindowView(image: store.state.videoFrame)
            VideoControlsView(
                toggleStyleAction: {
                    store.dispatch(.toggleStyle)
                },
                toggleEnabled: store.state.style != .none,
                buildSelectStyleDestination: {
                    SelectStyleView()
                }
            )
        }
    }
}

struct VideoFeedView_Previews: PreviewProvider {
    static var previews: some View {
        VideoFeedView()
            .environmentObject(Store.preview)
    }
}
