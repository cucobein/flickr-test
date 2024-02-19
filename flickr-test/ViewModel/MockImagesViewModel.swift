//
//  MockImagesViewModel.swift
//  flickr-test
//
//  Created by Hugo Ramirez on 18/02/24.
//

import Foundation

final class MockImagesViewModel: ImagesViewModel {
    
    var isLoading: Bool = false
    var images: [ImageGrid] = []
    var searchText = ""
    let networkingService: NetworkingService

    init(networkingService: NetworkingService) {
        self.networkingService = networkingService

        getImages()
    }

    func getImages() {
        isLoading = true

        networkingService.fetchData(url: "porcupine.json", model: FlickrResponse.self) {
            self.isLoading = false

            switch $0 {
            case .success(let imageFeed):
                self.images = imageFeed.items.map {
                    ImageGrid(title: $0.title, imageURL: $0.media.m, description: $0.description, author: $0.author)
                }
            case .failure:
                self.images = []
            }
        }
    }
}
