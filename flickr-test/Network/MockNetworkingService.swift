//
//  MockNetworkingService.swift
//  flickr-testTests
//
//  Created by Hugo Ramirez on 18/02/24.
//

import Foundation

class MockNetworkingService: NetworkingService {

    func fetchData<T>(url: String, model: T.Type, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable {

        guard let url = Bundle.main.url(forResource: url, withExtension: nil) else {
            completion(.failure(NSError(domain: "MockNetworkingService", code: 0, userInfo: nil)))
            return
        }

        guard let data = try? Data(contentsOf: url) else {
            completion(.failure(NSError(domain: "MockNetworkingService", code: 0, userInfo: nil)))
            return
        }

        let decoder = JSONDecoder()

        do {
            let loadedData = try decoder.decode(T.self, from: data)
            return completion(.success(loadedData))
        } catch {
            completion(.failure(error))
        }
    }
}
