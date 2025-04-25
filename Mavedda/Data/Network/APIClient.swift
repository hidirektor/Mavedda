//
//  APIClient.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case serverError(statusCode: Int)
    case noData
}

struct RequestParameters {
    var body: [String: Any]?
    var queryItems: [URLQueryItem]?
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParameters? { get }
}

class APIClient {
    private let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = URL(string: baseURL.appendingPathComponent(endpoint.path).absoluteString) else {
            throw HTTPError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body = endpoint.parameters?.body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }

        if let queryItems = endpoint.parameters?.queryItems {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            if let urlWithQuery = components?.url {
                request.url = urlWithQuery
            }
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw HTTPError.serverError(statusCode: httpResponse.statusCode)
        }
        
        guard !data.isEmpty else{
            throw HTTPError.noData
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw HTTPError.decodingFailed(error)
        }
    }
}
