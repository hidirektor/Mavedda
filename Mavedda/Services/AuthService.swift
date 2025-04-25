//
//  AuthService.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import Foundation

class AuthService {
    // Kullanıcı kimlik doğrulama işlemleri (örneğin, giriş, çıkış)
    // Bu sınıf, AuthRepository'i kullanarak APIClient ile iletişim kurar.
    private let authRepository: AuthRepositoring

    init(authRepository: AuthRepositoring) {
        self.authRepository = authRepository
    }

    func login(email: String, password: String) async throws -> User {
        return try await authRepository.login(email: email, password: password)
    }
    
    func register(email: String, password: String) async throws -> User{
        return try await authRepository.register(email: email, password: password)
    }
    
    func verifyTwoFactorAuth(email: String, code: String) async throws -> User {
        return try await authRepository.verifyTwoFactorAuth(email: email, code: code)
    }
    // Diğer auth ile ilgili fonksiyonlar
}
