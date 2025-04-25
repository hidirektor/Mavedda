//
//  LoginViewModel.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let authRepository: AuthRepositoring
    private let appCoordinator: AppCoordinator

    init(authRepository: AuthRepositoring, appCoordinator: AppCoordinator) {
        self.authRepository = authRepository
        self.appCoordinator = appCoordinator
    }

    @MainActor
    func login() async {
        isLoading = true
        errorMessage = nil
        do {
            //let user = try await authRepository.login(email: email, password: password)
            let defaultUser = User(id: UUID().uuidString, email: "default@example.com", name: "Varsayılan Kullanıcı")
            isLoading = false
            // Başarılı giriş, 2FA kontrolü gerekebilir.
            // Bu örnekte, 2FA kontrolü yapmadan direkt dashboard'a yönlendiriyoruz.
            // Eğer backend 2FA gerektiriyorsa, burası değişmeli.
            appCoordinator.completeLogin(user: defaultUser)

        } catch let error as HTTPError {
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
            isLoading = false
            errorMessage = "Bilinmeyen bir hata oluştu: \(error.localizedDescription)"
        }
    }
}
