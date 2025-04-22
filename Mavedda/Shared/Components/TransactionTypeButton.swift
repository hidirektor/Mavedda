//
//  TransactionTypeButton.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import SwiftUI

struct TransactionTypeButton: View {
    let imageName: String
    let type: TransactionType
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .font(.title)
                .foregroundColor(isSelected ? .white : .gray)
                .padding()
                .background(isSelected ? Color("successTheme").opacity(0.7) : Color.white.opacity(0.1))
                .cornerRadius(10)
        }
    }
}
