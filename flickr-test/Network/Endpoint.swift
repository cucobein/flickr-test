//
//  Endpoint.swift
//  flickr-test
//
//  Created by Hugo Ramirez on 18/02/24.
//

struct Endpoint {

    var path: String = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="
}

extension Endpoint {
    
    func makeImageFetchRequest(searchTag: String) -> String {
        return path.appending(searchTag)
    }
}
