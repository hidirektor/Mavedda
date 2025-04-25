//
//  AppCoordinator.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var currentScreen: Screen = .splash // Initial screen (not optional)
    @Published var isLoggedIn = false

    // Enum should conform to Equatable
    enum Screen: Equatable {
        case splash
        case onboarding
        case firstSetup
        case authSelection
        case login
        case register
        case resetPasswordSelectMethod
        case resetPasswordEnterOTP(email: String)
        case resetPasswordEnterNewPassword(token: String)
        case resetPasswordChanged
        case twoFactorAuth(user: User)
        case dashboard
        case profile
        case settings
        
        // Manually implement Equatable conformance
        static func == (lhs: Screen, rhs: Screen) -> Bool {
            switch (lhs, rhs) {
            case (.splash, .splash),
                 (.onboarding, .onboarding),
                 (.firstSetup, .firstSetup),
                 (.authSelection, .authSelection),
                 (.login, .login),
                 (.register, .register),
                 (.resetPasswordSelectMethod, .resetPasswordSelectMethod),
                 (.resetPasswordChanged, .resetPasswordChanged),
                 (.dashboard, .dashboard),
                 (.profile, .profile),
                 (.settings, .settings):
                return true
                
            case (.resetPasswordEnterOTP(let email1), .resetPasswordEnterOTP(let email2)):
                return email1 == email2
                
            case (.resetPasswordEnterNewPassword(let token1), .resetPasswordEnterNewPassword(let token2)):
                return token1 == token2
                
            case (.twoFactorAuth(let user1), .twoFactorAuth(let user2)):
                return user1 == user2 // Assumes User conforms to Equatable
                
            default:
                return false
            }
        }
    }

    // Show a specific screen
    func show(_ screen: Screen) {
        currentScreen = screen
    }

    // Start the app and decide which screen to show initially
    func start() {
        // For now, we show the splash screen first.
        // You can modify this logic if you need a different starting screen.
        if !isLoggedIn {
            show(.splash) // Show the splash screen initially
        } else {
            show(.dashboard) // If logged in, show dashboard
        }
    }

    // Complete login and navigate to the appropriate screen
    func completeLogin(user: User) {
        // After login, mark the user as logged in
        isLoggedIn = true
        // Optionally, save user info (e.g., UserDefaults or similar)
        show(.dashboard) // Navigate to the dashboard after login
    }

    // Optionally, handle logout or user session clearing
    func logout() {
        isLoggedIn = false
        show(.login) // Navigate back to login screen after logout
    }
}
