//
//  ViewModel.swift
//  flickr-test
//
//  Created by Hugo Ramirez on 18/02/24.
//

import Foundation

protocol NetworkingService {

    func fetchData<T: Decodable>(url: String,
                                 model: T.Type,
                                 completion: @escaping (Result<T, Error>) -> ())
}
