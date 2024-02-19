//
//  ImagesViewModel.swift
//  flickr-test
//
//  Created by Hugo Ramirez on 18/02/24.
//

import Foundation

protocol ImagesViewModel: ObservableObject {

    var images: [ImageGrid] { get set }
    var searchText: String { get set }
    var networkingService: NetworkingService { get }
    var isLoading: Bool { get }

    func getImages()
}
