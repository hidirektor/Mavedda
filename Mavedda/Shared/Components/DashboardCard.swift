//
//  DashboardCard.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import SwiftUI

struct DashboardCard: View {
    let imageName: String
    let title: LocalizedStringKey
    let value: String
    let percentageChange: Double?

    var body: some View {
        boxContent
    }

    private var boxContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Color("bodyPrimary"))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(value)
                .font(.headline)
                .foregroundColor(.black.opacity(1.0))
                .frame(maxWidth: .infinity, alignment: .leading)
            if let percentageChange = percentageChange {
                HStack(spacing: 4) {
                    Image(systemName: percentageChange >= 0 ? "arrow.up" : "arrow.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                        .foregroundColor(percentageChange >= 0 ? Color("successBase") : .red)
                    Text(String(format: "%@%.2f%%", percentageChange >= 0 ? "+" : "", percentageChange))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(percentageChange >= 0 ? Color("successBase") : .red)
                    Text(LocalizedStringKey("dashboardcard.previous_month"))
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .padding(.top, 2)
                .transition(.opacity)
            } else {
                Text(LocalizedStringKey("dashboardcard.no_data_or_calculation"))
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .italic()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color("borderAndDivider"))
        .cornerRadius(10)
        .animation(.easeInOut(duration: 0.3), value: percentageChange)
    }
}
