//
//  RegisterView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
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
            SecureField("Şifre Tekrar", text: $viewModel.passwordAgain)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                Task {
                    await viewModel.register()
                }
            }) {
                Text("Kayıt Ol")
                    .padding()
                    .background(Color.green)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background_main"))
        .ignoresSafeArea()
        .padding()
        .navigationTitle("Kayıt Ol")
        .onDisappear {
            viewModel.errorMessage = nil
            viewModel.email = ""
            viewModel.password = ""
            viewModel.passwordAgain = ""
        }
    }
}
