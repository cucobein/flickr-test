//
//  FlickrViewModel.swift
//  flickr-test
//
//  Created by Hugo Ramirez on 18/02/24.
//

import Foundation

final class FlickerImagesViewModel: ImagesViewModel {

    @Published var images: [ImageGrid] = []
    @Published var searchText = ""
    @Published var isLoading: Bool = false

    let networkingService: NetworkingService
    private var searchTimer: Timer?

    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }

    func getImages() {
        guard !searchText.isEmpty else {
            searchTimer?.invalidate()

            DispatchQueue.main.async {
                self.images = []
                self.isLoading = false
            }

            return
        }

        DispatchQueue.main.async {
            self.isLoading = true
        }

        searchTimer?.invalidate()

        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0/3.0, repeats: false) { _ in
            let endpoint = Endpoint()
            let fetchURL = endpoint.makeImageFetchRequest(searchTag: self.searchText)

            self.networkingService.fetchData(url: fetchURL, model: FlickrResponse.self) { result in
                
                DispatchQueue.main.async {
                    self.isLoading = false
                }

                var resultImages = [ImageGrid]()

                switch result {
                case .success(let flickrResponse):
                    resultImages = flickrResponse.items.compactMap {
                        ImageGrid(title: $0.title, imageURL: $0.media.m, description: $0.description, author: $0.author)
                    }
                case .failure:
                    resultImages = []
                }

                DispatchQueue.main.async {
                    self.images = resultImages
                }
            }
        }
    }
}
