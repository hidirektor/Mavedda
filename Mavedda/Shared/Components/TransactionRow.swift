//
//  TransactionRow.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 16) {
            transactionIcon.frame(width: 40, height: 40)
            transactionDescription
            Spacer()
            transactionAmount
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }

    private var transactionIcon: some View {
        Image(systemName: "creditcard.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
            .background(Color.gray.opacity(0.2))
            .clipShape(Circle())
    }

    private var transactionDescription: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(transaction.description ?? NSLocalizedString("transactionrow.no_description", comment: "No description for transaction"))
                .font(.headline)
                .foregroundColor(Color("bodyPrimary"))
            HStack(spacing: 4) {
                Text(LocalizedStringKey("transactionrow.today"))
                    .font(.caption)
                    .foregroundColor(.secondary)
                Circle()
                    .fill(Color.secondary)
                    .frame(width: 2, height: 2)
                Text(transaction.date, style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }

    private var transactionAmount: some View {
        Text((transaction.type == .income ? "+" : "-") + transaction.amount.formattedCurrency())
            .foregroundColor(transaction.type == .income ? Color("bodyPrimary") : Color("bodyPrimary"))
            .font(.headline)
    }
}
