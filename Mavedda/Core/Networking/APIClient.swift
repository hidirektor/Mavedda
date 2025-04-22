//
//  APIClient.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import Foundation
import Combine

protocol APIClient {
    func fetchTransactions() -> AnyPublisher<[Transaction], NetworkError>
    func createTransaction(transaction: Transaction) -> AnyPublisher<Transaction, NetworkError>
    // Diğer API endpoint'leri
}

class DefaultAPIClient: APIClient {
    private let networkService: NetworkService
    private let baseURL = URL(string: "https://your-api-base-url.com")! // Kendi API URL'niz

    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }

    func fetchTransactions() -> AnyPublisher<[Transaction], NetworkError> {
        let url = baseURL.appendingPathComponent("/transactions")
        return networkService.fetch(url: url)
    }

    func createTransaction(transaction: Transaction) -> AnyPublisher<Transaction, NetworkError> {
        let url = baseURL.appendingPathComponent("/transactions")
        return networkService.post(url: url, body: transaction)
    }
    // Diğer API endpoint'leri
}
