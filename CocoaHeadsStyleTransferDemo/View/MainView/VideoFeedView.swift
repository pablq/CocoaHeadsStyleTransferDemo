//
//  VideoFeedView.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/19/21.
//

import SwiftUI

struct VideoFeedView: View {
    @EnvironmentObject var store: Store

    let currentFrame: UIImage

    var body: some View {
        VStack {
            if store.state.style != .none {
                StyleThumbnailView(imageName: store.state.style.imageName)
            } else {
                NoStyleThumbnailView()
            }
            VideoWindowView(image: currentFrame)
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
        VideoFeedView(currentFrame: UIImage())
    }
}
