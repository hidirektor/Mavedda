//
//  CustomPieChart.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import SwiftUI

struct CustomPieChartView: View {
    let income: Double
    let expense: Double

    var body: some View {
        GeometryReader { geometry in
            let total = income + expense
            let incomeAngle = total > 0 ? (income / total) * 360 : 0
            let radius = min(geometry.size.width, geometry.size.height) / 2
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)

            ZStack {
                // Income Segment
                Path { path in
                    path.move(to: center)
                    path.addArc(
                        center: center,
                        radius: radius,
                        startAngle: .degrees(0),
                        endAngle: .degrees(incomeAngle),
                        clockwise: true
                    )
                }
                .fill(.green)

                // Expense Segment
                Path { path in
                    path.move(to: center)
                    path.addArc(
                        center: center,
                        radius: radius,
                        startAngle: .degrees(incomeAngle),
                        endAngle: .degrees(360),
                        clockwise: true
                    )
                }
                .fill(.red)

                // Inner Circle (for donut effect)
                Circle()
                    .frame(width: radius, height: radius)
                    .foregroundColor(Color("background"))
            }
            .overlay(
                // Legend
                HStack {
                    Circle().frame(width: 10, height: 10).foregroundColor(.green)
                    Text(LocalizedStringKey("piechart.income")) + Text(": \(income.formattedCurrency())").font(.caption)
                        .font(.caption)
                    Spacer()
                    Circle().frame(width: 10, height: 10).foregroundColor(.red)
                    Text(LocalizedStringKey("piechart.expense")) + Text(": \(expense.formattedCurrency())").font(.caption)
                        .font(.caption)
                }
                .padding(8)
                .cornerRadius(8)
                .offset(y: radius/2),
                alignment: .bottom
            )
        }
    }
}
