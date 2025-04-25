//
//  AuthEndpoint.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import Foundation

enum AuthEndpoint: Endpoint {
    case login(email: String, password: String)
    case register(email: String, password: String)
    case resetPassword(email: String)
    case sendOTP(email: String)
    case verifyOTP(token: String, otp: String)
    case updatePassword(token: String, newPassword: String)
    case twoFactorAuth(email: String, code: String)

    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .register:
            return "/auth/register"
        case .resetPassword:
            return "/auth/password/reset"
        case .sendOTP(let email):
            return "/auth/password/reset/otp/\(email)"
        case .verifyOTP:
            return "/auth/password/reset/verify"
        case .updatePassword:
            return "/auth/password/reset/update"
        case .twoFactorAuth:
            return "/auth/two-factor-auth/verify" // 2FA endpoint'i
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login, .register, .resetPassword, .sendOTP, .verifyOTP, .updatePassword, .twoFactorAuth:
            return .post
        }
    }

    var parameters: RequestParameters? {
        switch self {
        case .login(let email, let password):
            return RequestParameters(body: ["email": email, "password": password])
        case .register(let email, let password):
            return RequestParameters(body: ["email": email, "password": password])
        case .resetPassword(let email):
            return RequestParameters(body: ["email": email])
        case .sendOTP:
            return nil
        case .verifyOTP(let token, let otp):
            return RequestParameters(body: ["token": token, "otp": otp])
        case .updatePassword(let token, let newPassword):
            return RequestParameters(body: ["token": token, "newPassword": newPassword])
        case .twoFactorAuth(let email, let code):
             return RequestParameters(body: ["email": email, "code": code])
        }
    }
}
