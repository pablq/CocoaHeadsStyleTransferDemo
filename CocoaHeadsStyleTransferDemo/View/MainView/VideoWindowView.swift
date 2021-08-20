//
//  VideoWindowView.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/16/21.
//

import SwiftUI

struct VideoWindowView: View {
    let image: UIImage?

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        } else {
            ProgressView()
        }
    }
}

struct VideoWindowView_Previews: PreviewProvider {
    static var previews: some View {
        VideoWindowView(image: UIImage(systemName: "paintpalette"))
    }
}
