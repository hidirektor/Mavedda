//
//  ErrorView.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import SwiftUI

// Basit bir hata gösterme view'ı
struct ErrorView: View {
    let title: String
    let message: String
    var retryAction: (() -> Void)? = nil // Opsiyonel yeniden deneme aksiyonu

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.orange)

            Text(title)
                .font(.title2)
                .fontWeight(.bold)

            Text(message)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            if let retryAction = retryAction {
                Button("Tekrar Dene") {
                    retryAction()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
        }
        .padding()
    }
}

#Preview {
    ErrorView(
        title: Constants.localizedString("error.noInternet.title"),
        message: Constants.localizedString("error.noInternet.message"),
        retryAction: { print("Retry tapped") }
    )
}

#Preview("No Retry Button") {
     ErrorView(
        title: Constants.localizedString("error.dataLoad.title"),
        message: Constants.localizedString("error.dataLoad.message")
    )
}
