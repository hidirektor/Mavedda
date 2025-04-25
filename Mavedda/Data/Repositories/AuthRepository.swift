//
//  AuthRepository.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import Foundation

// MARK: - AuthRepositoring Protocol

protocol AuthRepositoring {
    func login(email: String, password: String) async throws -> User
    func register(email: String, password: String) async throws -> User
    func resetPassword(email: String) async throws
    func sendOTP(email: String) async throws
    func verifyOTP(token: String, otp: String) async throws -> String
    func updatePassword(token: String, newPassword: String) async throws
    func verifyTwoFactorAuth(email: String, code: String) async throws -> User
}

// MARK: - AuthRepository Implementation

final class AuthRepository: AuthRepositoring, ObservableObject {
    
    // MARK: - Properties
    
    private let apiClient: APIClient
    
    // Observable properties
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?

    // MARK: - Initialization
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    // MARK: - AuthRepositoring Methods

    func login(email: String, password: String) async throws -> User {
        // Explicitly specify the type here
        let user: User = try await apiClient.request(endpoint: AuthEndpoint.login(email: email, password: password))
        self.isLoggedIn = true
        self.currentUser = user
        return user
    }

    func register(email: String, password: String) async throws -> User {
        let user: User = try await apiClient.request(endpoint: AuthEndpoint.register(email: email, password: password))
        self.isLoggedIn = true
        self.currentUser = user
        return user
    }

    func verifyOTP(token: String, otp: String) async throws -> String {
        // Explicitly specify the type here
        let response: OTPResponse = try await apiClient.request(endpoint: AuthEndpoint.verifyOTP(token: token, otp: otp))
        return response.token
    }

    func verifyTwoFactorAuth(email: String, code: String) async throws -> User {
        let user: User = try await apiClient.request(endpoint: AuthEndpoint.twoFactorAuth(email: email, code: code))
        self.currentUser = user
        return user
    }

    func resetPassword(email: String) async throws {
        let _: EmptyResponse = try await apiClient.request(endpoint: AuthEndpoint.resetPassword(email: email))
    }

    func sendOTP(email: String) async throws {
        let _: EmptyResponse = try await apiClient.request(endpoint: AuthEndpoint.sendOTP(email: email))
    }

    func updatePassword(token: String, newPassword: String) async throws {
        let _: EmptyResponse = try await apiClient.request(endpoint: AuthEndpoint.updatePassword(token: token, newPassword: newPassword))
    }

    // MARK: - Internal Models

    private struct OTPResponse: Decodable {
        let token: String
    }

    private struct EmptyResponse: Decodable {}
}
