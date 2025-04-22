//
//  HTTPClient.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import Foundation
import Combine

protocol HTTPClient {
    func performRequest<T: Decodable>(request: URLRequest) -> AnyPublisher<T, NetworkError>
}

class DefaultHTTPClient: HTTPClient {
    func performRequest<T: Decodable>(request: URLRequest) -> AnyPublisher<T, NetworkError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { NetworkError.requestFailed($0) }
            .flatMap { data, response -> AnyPublisher<T, NetworkError> in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
                }

                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { _ in NetworkError.invalidData }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
