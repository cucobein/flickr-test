//
//  ImageDetailView.swift
//  flickr-test
//
//  Created by Hugo Ramirez on 18/02/24.
//

import WebKit
import SwiftUI

struct HTMLView: UIViewRepresentable {
    
    let htmlString: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let htmlStyling = """
                <html>
                    <head>
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <style>
                            body {
                                font-size: 18px; /* Adjust the font size as needed */
                            }
                        </style>
                    </head>
                    <body>
                        \(htmlString)
                    </body>
                </html>
                """
        uiView.loadHTMLString(htmlStyling, baseURL: nil)
    }
}

struct ImageDetailView: View {

    let title: String
    let imageURL: String
    let description: String
    let author: String

    var body: some View {
        ScrollView(.vertical) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16) {
                    Label("Title:", systemImage: "photo")
                        .fontWeight(.bold)
                    Text(title)
                }

                HStack(spacing: 16) {
                    Label("Description:", systemImage: "book")
                        .fontWeight(.bold)
                    HTMLView(htmlString: description)
                        .frame(minWidth: 80, maxWidth: .infinity, minHeight: 160, maxHeight: .infinity)
                }

                HStack(spacing: 16) {
                    Label("Author:", systemImage: "person")
                        .fontWeight(.bold)
                    Text(author)
                }
            }
            .padding(24)
        }
    }
}

#Preview {
    ImageDetailView(title: "Title",
                    imageURL: "https://live.staticflickr.com/65535/53529914873_f11e77c6a7_m.jpg",
                    description: "Description",
                    author: "Author")
}
