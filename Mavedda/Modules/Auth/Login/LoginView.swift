//
//  LoginView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @EnvironmentObject var appCoordinator: AppCoordinator

    var body: some View {
        VStack {
            TextField("E-posta", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Şifre", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                Task {
                    await viewModel.login()
                }
            }) {
                Text("Giriş Yap")
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
            
            Button("Şifremi Unuttum") {
                appCoordinator.show(.resetPasswordSelectMethod)
            }
            .padding()
            
            Button("2FA kodunu gir") {
                // Bu örnekte, kullanıcıyı direkt 2FA ekranına yönlendiriyoruz.
                // Gerçek senaryoda, giriş yapmaya çalışan ve 2FA'ya yönlendirilen
                // kullanıcının bilgilerini (örneğin e-posta) taşımak gerekebilir.
                // Şimdilik statik bir kullanıcı ile devam ediyoruz.
                let dummyUser = User(id: "1", email: "test@example.com", name: "halil") // Örnek kullanıcı
                appCoordinator.show(.twoFactorAuth(user: dummyUser))
            }
            .padding()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background_main"))
        .ignoresSafeArea()
        .padding()
        .navigationTitle("Giriş Yap")
        .onDisappear { // Ekran kaybolduğunda state'i temizle
            viewModel.errorMessage = nil
            viewModel.email = ""
            viewModel.password = ""
        }
    }
}
