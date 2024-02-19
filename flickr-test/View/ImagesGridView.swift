//
//  ContentView.swift
//  flickr-test
//
//  Created by Hugo Ramirez on 18/02/24.
//

import SwiftUI

struct ImagesGridView<ViewModel>: View where ViewModel: ImagesViewModel {

    @StateObject var viewModel: ViewModel

    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]

    private var loadingStateView: some View {
        VStack {
            Spacer()

            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                Text("Loading images...")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Spacer()
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 24) {
            Image(systemName: "photo")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            Text("No images found")
                .font(.title)
                .foregroundColor(.gray)
            Text("Please type another search term.")
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding([.top, .bottom], 80)
    }

    var body: some View {
        NavigationView {
            ScrollView([.vertical]) {
                if viewModel.isLoading {
                    loadingStateView
                }
                else if viewModel.images.isEmpty {
                    emptyStateView
                } else {
                    LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                        ForEach(viewModel.images) { image in
                            NavigationLink {
                                ImageDetailView(title: image.title,
                                                imageURL: image.imageURL,
                                                description: image.description,
                                                author: image.author)
                            } label: {
                                ImageGridView(imageURL: image.imageURL)
                            }
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
            .onChange(of: viewModel.searchText) {
                viewModel.getImages()
            }
        }
        .navigationTitle("Flickr Images")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut(duration: 1.0/3.0), value: viewModel.images.count)
    }
}

#Preview {
    ImagesGridView(viewModel: MockImagesViewModel(networkingService: MockNetworkingService()))
}
