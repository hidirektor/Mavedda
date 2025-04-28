//
//  RecentTransactionsView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 27.04.2025.
//

import SwiftUI

struct RecentTransactionsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Son hesap hareketleri")
                    .font(.headline)
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 8)

            TransactionRowView(
                iconName: "building.columns.fill",
                title: "Mavedda Inc.",
                description: "\"Keyifli harcama başarılarınız devamını bekliyoruz!\" X Bankkart ile ödendi.",
                amount: "40.00,00 ₺",
                date: "09:41 - 19.04.2024",
                percentageChange: "+%100,0"
            )

            TransactionRowView(
                iconName: "applelogo",
                title: "Paypal",
                description: "\"VirtualPOS Ödemesi\" X Bank K Kartı ile ödendi.",
                amount: "199,99 ₺",
                date: "09:50 - 19.04.2024",
                percentageChange: "-%0,5"
            )

            TransactionRowView(
                iconName: "applelogo",
                title: "Apple Store",
                description: "\"AppStore 4 ödemesi\" X Bank K Kartı ile ödendi.",
                amount: "7.699,00 ₺",
                date: "09:51 - 19.04.2024",
                percentageChange: "-%18,25"
            )
        }
        .padding()
    }
}
