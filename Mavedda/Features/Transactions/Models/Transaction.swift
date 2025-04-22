//
//  Transaction.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import Foundation

enum TransactionType: String, Codable, CaseIterable, Identifiable {
    case income = "Gelir"
    case expense = "Gider"

    var id: String { self.rawValue }
}

struct Transaction: Identifiable, Codable, Hashable {
    let id: UUID = UUID()
    var type: TransactionType
    var amount: Double
    var description: String? // Açıklama isteğe bağlı
    var date: Date
    var category: String? // Kategori isteğe bağlı
    var company: String? // Firma adı (isteğe bağlı)
    var companyLogo: String? // Firma logosu (isteğe bağlı)

    // Hashable conformance için
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // Equatable conformance için (Hashable bunu gerektirir)
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id
    }
}
