//
//  NetworkService.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import Foundation
import Combine

protocol NetworkService {
    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, NetworkError>
    func post<T: Decodable, U: Encodable>(url: URL, body: U) -> AnyPublisher<T, NetworkError>
}

class DefaultNetworkService: NetworkService {
    private let jsonDecoder = JSONDecoder()
    
    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, NetworkError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .mapError { NetworkError.requestFailed($0) }
            .flatMap(handleResponse)
            .eraseToAnyPublisher()
    }
    
    func post<T: Decodable, U: Encodable>(url: URL, body: U) -> AnyPublisher<T, NetworkError> {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            return Fail(error: NetworkError.requestFailed(error)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { NetworkError.requestFailed($0) }
            .flatMap(handleResponse)
            .eraseToAnyPublisher()
    }

    /// Genel HTTP yanıtlarını işleyen yardımcı fonksiyon
    private func handleResponse<T: Decodable>(_ output: URLSession.DataTaskPublisher.Output) -> AnyPublisher<T, NetworkError> {
        let (data, response) = output
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            return Fail(error: NetworkError.custom("HTTP Hatası: \(httpResponse.statusCode)")).eraseToAnyPublisher()
        }
        
        return Just(data)
            .decode(type: T.self, decoder: jsonDecoder)
            .mapError { _ in NetworkError.invalidData }
            .eraseToAnyPublisher()
    }
}
