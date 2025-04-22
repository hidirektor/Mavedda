//
//  NetworkManager.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import Foundation
import Network
import Combine

@MainActor
class NetworkManager: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    @Published var isConnected: Bool = true
    @Published var networkError: NetworkError?

    init() {
        startMonitoring()
    }

    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                guard let self = self else { return } // self'in hala var olduğundan emin ol

                self.isConnected = path.status == .satisfied
                if !self.isConnected {
                    self.networkError = .custom("İnternet bağlantısı yok")
                } else {
                    self.networkError = nil // Bağlantı geldiğinde hatayı temizle
                }

                print("Network Status: \(path.status)")
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }

    func clearError() {
        networkError = nil
    }
}
