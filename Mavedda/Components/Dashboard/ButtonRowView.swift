//
//  ButtonRowView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 27.04.2025.
//

import SwiftUI

struct ButtonRowView: View {
    @State private var selectedButton: String = "Durum"
    
    var body: some View {
        HStack {
            CustomButton(title: "Durum", selectedButton: $selectedButton)
            CustomButton(title: "Gelen", selectedButton: $selectedButton)
            CustomButton(title: "Giden", selectedButton: $selectedButton)
            CustomButton(title: "ddAI", selectedButton: $selectedButton)
        }
    }
}

struct CustomButton: View {
    let title: String
    @Binding var selectedButton: String

    var body: some View {
        Button(action: {
            selectedButton = title
            print("\(title) butonuna tıklandı")
        }) {
            Text(title)
                .font(.system(size: 15))
                .foregroundColor(selectedButton == title ? Color("button_active_text") : Color("button_inactive_text"))
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(selectedButton == title ? Color("button_active") : Color("button_inactive"))
                .cornerRadius(17)
        }
        .frame(maxWidth: .infinity)
    }
}
