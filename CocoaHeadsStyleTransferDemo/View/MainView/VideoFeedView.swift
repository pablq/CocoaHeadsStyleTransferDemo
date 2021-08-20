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
            if store.state.currentStyle != .none {
                StyleThumbnailView(imageName: store.state.currentStyle.imageName)
            } else {
                NoStyleThumbnailView()
            }
            VideoWindowView(image: currentFrame)
            VideoControlsView(
                toggleStyleAction: {
                    store.dispatch(.toggleStyle)
                },
                toggleEnabled: store.state.currentStyle != .none,
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
