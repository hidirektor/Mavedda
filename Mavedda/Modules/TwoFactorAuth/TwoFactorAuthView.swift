//
//  TwoFactorAuthView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct TwoFactorAuthView: View {
    @ObservedObject var viewModel: TwoFactorAuthViewModel
    @EnvironmentObject var appCoordinator: AppCoordinator
    let user: User // Önceki ekrandan gelen kullanıcı bilgisi

    var body: some View {
        VStack {
            Text("Lütfen e-posta adresinize gönderilen 2FA kodunu girin.")
                .padding()
            TextField("2FA Kodu", text: $viewModel.code)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                Task {
                    await viewModel.verifyCode()
                }
            }) {
                Text("Doğrula")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(viewModel.isLoading)
            .padding()

            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }

            Spacer()
        }
        .padding()
        .navigationTitle("2FA Doğrulama")
        .onDisappear {
            viewModel.errorMessage = nil
            viewModel.code = ""
        }
    }
}
