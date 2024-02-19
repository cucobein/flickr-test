//
//  ImageGridView.swift
//  flickr-test
//
//  Created by Hugo Ramirez on 18/02/24.
//

import SwiftUI

struct ImageGridView: View {

    private let dimensions: Double = 140
    private let corner: Double = 5
    let imageURL: String

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: dimensions, height: dimensions)
            } placeholder: {
                ProgressView()
                    .frame(width: dimensions, height: dimensions)
            }
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: corner, height: corner)))
        }
    }
}

#Preview {
    ImageGridView(imageURL: "https://live.staticflickr.com/65535/53529914873_f11e77c6a7_m.jpg")
}
