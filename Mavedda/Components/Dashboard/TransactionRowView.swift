//
//  TransactionRowView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 27.04.2025.
//

import SwiftUI

struct TransactionRowView: View {
    let iconName: String
    let title: String
    let description: String
    let amount: String
    let date: String
    let percentageChange: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .frame(width: 30, height: 30)
                .background(Color(.systemGray5))
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(amount)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(percentageChange)
                    .font(.caption)
                    .foregroundColor(percentageChange.contains("-") ? .red : .green)
            }
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(8)
    }
}
