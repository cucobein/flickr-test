//
//  Image.swift
//  flickr-test
//
//  Created by Hugo Ramirez on 18/02/24.
//

import Foundation

struct ImageGrid: Identifiable {
    
    let id = UUID()
    let title: String
    let imageURL: String
    let description: String
    let author: String
}
