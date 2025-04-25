//
//  RegisterViewModel.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let authRepository: AuthRepositoring
    private let appCoordinator: AppCoordinator

    // Dependency injection via initializer
    init(authRepository: AuthRepositoring, appCoordinator: AppCoordinator) {
        self.authRepository = authRepository
        self.appCoordinator = appCoordinator
    }

    // The method to register the user
    @MainActor
    func register() async {
        isLoading = true
        errorMessage = nil

        // Check if the passwords match
        if password != passwordAgain {
            errorMessage = "Şifreler eşleşmiyor."
            isLoading = false
            return
        }

        // Perform the registration asynchronously
        do {
            // Call the register function on the repository
            let _ = try await authRepository.register(email: email, password: password)
            isLoading = false
            
            // After successful registration, navigate to the login screen
            appCoordinator.show(.login)
        } catch let error as HTTPError {
            // Handle specific HTTP errors
            isLoading = false
            switch error {
            case .serverError(let statusCode):
                errorMessage = "Sunucu hatası: \(statusCode)"
            case .invalidResponse:
                errorMessage = "Geçersiz yanıt"
            case .decodingFailed:
                errorMessage = "Veri çözümlenemedi"
            case .requestFailed(let error):
                errorMessage = "İstek başarısız: \(error.localizedDescription)"
            case .invalidURL:
                errorMessage = "Geçersiz URL"
            case .noData:
                errorMessage = "Sunucu veri dönmedi"
            }
        } catch {
            // Handle unknown errors
            isLoading = false
            errorMessage = "Bilinmeyen bir hata oluştu: \(error.localizedDescription)"
        }
    }
}
