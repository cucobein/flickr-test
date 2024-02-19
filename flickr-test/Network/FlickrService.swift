//
//  FlickrService.swift
//  flickr-test
//
//  Created by Hugo Ramirez on 18/02/24.
//

import Foundation

final class FlickrService: NetworkingService {

    func fetchData<T: Decodable>(url: String,
                                 model: T.Type,
                                 completion: @escaping (Result<T, Error>) -> ()) {

        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }

            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(serverData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
