//
//  TwoFactorAuthViewModel.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

class TwoFactorAuthViewModel: ObservableObject {
    @Published var code = ""
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let authRepository: AuthRepositoring
    private let appCoordinator: AppCoordinator
    let user: User

    init(authRepository: AuthRepositoring, appCoordinator: AppCoordinator, user: User) {
        self.authRepository = authRepository
        self.appCoordinator = appCoordinator
        self.user = user
    }

    @MainActor
    func verifyCode() async {
        isLoading = true
        errorMessage = nil
        do {
            //FIXME: Bu satırdaki kodu açın ve dummyUser satırını silin.
            //let verifiedUser = try await authRepository.verifyTwoFactorAuth(email: user.email ?? "", code: code)
            // Başarılı doğrulama, kullanıcı bilgilerini al ve dashboard'a yönlendir
            // appCoordinator.show(.dashboard) //  2FA sonrası dashboard'a yönlendir.

            // Dummy user ile devam et
            let dummyUser = User(id: "1", email: "test@example.com", name: "halil")
            appCoordinator.completeLogin(user: dummyUser)
            isLoading = false


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
