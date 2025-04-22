//
//  FilterButton.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import SwiftUI

struct FilterButton: View {
    let text: LocalizedStringKey
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isSelected ? Color("borderAndDivider") : Color("bodyPrimary"))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color("bodyPrimary") : Color("borderAndDivider"))
                .cornerRadius(14)
        }
    }
}
