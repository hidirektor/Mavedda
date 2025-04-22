//
//  ExpenseCard.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 7.04.2025.
//

import SwiftUI

struct ExpenseIncomeCard: View {
    let title: String
    let amount: Double
    let changePercentage: Double
    let isPositiveChange: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(.secondarySystemBackground))
            .frame(width: 160, height: 120) // İhtiyacınıza göre boyutları ayarlayın
            .overlay(
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: title == "Gider" ? "person" : "envelope") // İkonları ihtiyaca göre ayarlayın
                            .font(.headline)
                        Text(title)
                            .font(.headline)
                    }
                    .foregroundColor(.gray)

                    Text("\(amount, specifier: "%.0f")")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    HStack {
                        Image(systemName: isPositiveChange ? "arrow.up" : "arrow.down")
                            .foregroundColor(isPositiveChange ? .green : .red)
                        Text("\(changePercentage, specifier: "%.1f")%")
                            .foregroundColor(isPositiveChange ? .green : .red)
                    }
                    Text("geçen aya göre")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                , alignment: .leading
            )
    }
}
