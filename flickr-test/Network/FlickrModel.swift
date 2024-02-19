//
//  FlickrModel.swift
//  flickr-test
//
//  Created by Hugo Ramirez on 18/02/24.
//

import Foundation

struct FlickrResponse: Codable {

    let items: [FlickrItem]
}

struct FlickrItem: Codable {

    let media: FlickrMedia
    let title: String
    let description: String
    let author: String
}

struct FlickrMedia: Codable {
    
    let m: String
}
