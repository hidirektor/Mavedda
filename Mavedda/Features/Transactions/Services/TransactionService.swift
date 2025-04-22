//
//  TransactionService.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import Foundation
import Combine

class TransactionService {
    private let apiClient: APIClient

    init(apiClient: APIClient = DefaultAPIClient()) {
        self.apiClient = apiClient
    }

    func fetchTransactions() -> AnyPublisher<[Transaction], NetworkError> {
        return apiClient.fetchTransactions()
    }

    func createTransaction(transaction: Transaction) -> AnyPublisher<Transaction, NetworkError> {
        return apiClient.createTransaction(transaction: transaction)
    }

    // Diğer işlem yönetimi API çağrıları
}
