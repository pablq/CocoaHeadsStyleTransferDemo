//
//  StyleThumbnailView.swift
//  CocoaHeadsStyleTransferDemo
//
//  Created by Pablo Philipps on 8/19/21.
//

import SwiftUI

struct StyleThumbnailView: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 75, height: 75, alignment: .center)
            .aspectRatio(contentMode: .fit)
    }
}

struct StyleThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        StyleThumbnailView(imageName: "Etching")
    }
}
