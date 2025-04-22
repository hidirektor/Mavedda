//
//  NetworkError.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
    case custom(String) // Genel hata durumu

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL"
        case .requestFailed(let error):
            return "İstek başarısız: \(error.localizedDescription)"
        case .invalidResponse:
            return "Geçersiz sunucu yanıtı"
        case .invalidData:
            return "Geçersiz veri"
        case .custom(let message):
            return message
        }
    }
}
