//
//  flickr_testApp.swift
//  flickr-test
//
//  Created by Hugo Ramirez on 18/02/24.
//

import SwiftUI

@main
struct flickr_testApp: App {
    var body: some Scene {
        WindowGroup {
            ImagesGridView(viewModel: FlickerImagesViewModel(networkingService: FlickrService()))
        }
    }
}
