//
//  ContentView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

//
//  ContentView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var authRepository: AuthRepository

    @ViewBuilder
    var currentView: some View {
        switch appCoordinator.currentScreen {
        case .splash:
            SplashView()
        case .onboarding:
            OnboardingView(viewModel: OnboardingViewModel())
        case .firstSetup:
            FirstSetupView(viewModel: FirstSetupViewModel())
        case .authSelection:
            AuthSelectionView()
        case .login:
            LoginView(viewModel: LoginViewModel(authRepository: authRepository, appCoordinator: appCoordinator))
        case .register:
            RegisterView(viewModel: RegisterViewModel(authRepository: authRepository, appCoordinator: appCoordinator))
        case .resetPasswordSelectMethod:
            ResetPasswordSelectMethodView()
        case .resetPasswordEnterOTP(let email):
            ResetPasswordEnterOTPView(email: email)
        case .resetPasswordEnterNewPassword(let token):
            ResetPasswordEnterNewPasswordView(token: token)
        case .resetPasswordChanged:
            ResetPasswordChangedView()
        case .twoFactorAuth(let user):
            TwoFactorAuthView(viewModel: TwoFactorAuthViewModel(authRepository: authRepository, appCoordinator: appCoordinator, user: user), user: user)
        case .dashboard:
            DashboardView()
        case .profile:
            ProfileView()
        case .settings:
            SettingsView()
        }
    }

    var body: some View {
        Group {
            currentView
                .transition(.opacity)
                .animation(.easeInOut, value: appCoordinator.currentScreen)
        }
    }
}
