//
//  NetworkingServiceTests.swift
//  flickr-testTests
//
//  Created by Hugo Ramirez on 18/02/24.
//

import XCTest

class EndpointTests: XCTestCase {

    func testBasicRequestGeneration() {

        let endpoint = Endpoint()

        XCTAssertEqual(endpoint.path, "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=")
    }

    func testRequestGenerationWithTag() {

        let endpoint = Endpoint()

        XCTAssertEqual(endpoint.makeImageFetchRequest(searchTag: "porcupine"), "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=porcupine")
    }

    func testLoadAndParseDataFromService() {

        let networkingService = MockNetworkingService()

        networkingService.fetchData(url: "porcupine.json", model: FlickrResponse.self) { (result) in
            switch result {
            case .success(let imageFeed):
                XCTAssertEqual(imageFeed.items.count, 20)
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        }
    }

    // MARK: Integration Test

    func testHitEndpointAndParseDataFromService() throws {

        let endpoint = Endpoint()
        let networkingService = FlickrService()
        let requestUrl = endpoint.makeImageFetchRequest(searchTag: "porcupine")

        let expectation = self.expectation(description: "Awaiting completion")
        var result: Result<FlickrResponse, Error>? = nil

        networkingService.fetchData(url: requestUrl, model: FlickrResponse.self) {
            result = $0
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(result)
        XCTAssertGreaterThan(try! result!.get().items.count, 0)
    }
}
