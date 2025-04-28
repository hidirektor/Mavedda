//
//  SummaryView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 27.04.2025.
//

import SwiftUI

struct SummaryView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            LazyVGrid(columns: columns, spacing: 16) {
                ExpenseCard()
                IncomeCard()
                BalanceCard()
                AssetCard()
            }
            CreditCardDebtCard()
        }
        .background(Color.white.opacity(0.5))
        //.padding()
    }
}

struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .shadow(radius: 5)
            .frame(height: 150) // <-- Burayı ekledim
            .overlay(
                content
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            )
    }
}

struct ExpenseCard: View {
    // Örnek veriler
    var expenseRate: String = "%19,75"
    var expenseAmount: String = "₺7.898,99"
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.red)
                    
                    Text("Giden")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                }
                
                Text(expenseAmount)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                HStack {
                    Text("Geçen haftaya göre")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text(expenseRate)
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct IncomeCard: View {
    // Örnek veriler
    var incomeRate: String = "%100,00"
    var incomeAmount: String = "₺40.000,00"
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.down.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.green)
                    
                    Text("Gelen")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                }
                
                Text(incomeAmount)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                HStack {
                    Text("Geçen haftaya göre")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text(incomeRate)
                        .font(.system(size: 14))
                        .foregroundColor(.green)
                }
            }
        }
    }
}

struct BalanceCard: View {
    // Örnek veriler
    var balance: String = "₺32.101,01"
    var dailyLimit: String = "1.106,93₺"
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "creditcard")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray)
                    
                    Text("Bakiyem")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                }
                
                Text(balance)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                HStack(spacing: 4) {
                    Text("Günlük Harcama Limiti")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Text(dailyLimit)
                        .font(.system(size: 12))
                        .foregroundColor(.green)
                }
            }
        }
    }
}

struct AssetCard: View {
    // Örnek veriler
    var assetValue: String = "₺1.200.000,00"
    var weeklyChange: Double = 8.60 // Pozitif veya negatif olabilir
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "banknote") // İstediğin başka ikon varsa değiştiririz
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray)
                    
                    Text("Mal Varlığım")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                }
                
                Text(assetValue)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                HStack(spacing: 4) {
                    Text("Haftalık değer")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Text(String(format: "%@%.2f", weeklyChange > 0 ? "+" : "", weeklyChange) + "%")
                        .font(.system(size: 12))
                        .foregroundColor(weeklyChange >= 0 ? .green : .red)
                }
            }
        }
    }
}

struct CreditCardDebtCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .shadow(radius: 5)
            .frame(height: 75)
            .overlay(
                HStack() {
                    Text("K.Kart Borçlarım")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                    Spacer()
                    Text("₺-10.000,00")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.red)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            )
    }
}
