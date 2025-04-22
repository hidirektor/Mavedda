//
//  AppCoordinator.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 22.04.2025.
//
import SwiftUI
import Combine

enum AppState {
    case splash
    case onboarding
    case login
    case dashboard
}

class AppCoordinator: ObservableObject {
    @Published var appState: AppState = .splash
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    @StateObject var networkMonitor = NetworkManager()
    private var cancellables = Set<AnyCancellable>()

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // 1.5 saniye sonra ilk durumu belirle
            self.determineInitialState()
        }

        networkMonitor.$isConnected
            .dropFirst()
            .sink { [weak self] isConnected in
                guard let self = self else { return }
                if !isConnected && self.appState != .splash {
                    self.appState = .login
                } else if isConnected && self.appState == .login {
                    self.determineInitialState()
                }
            }
            .store(in: &cancellables)
    }

    private func determineInitialState() {
        if !hasCompletedOnboarding {
            appState = .onboarding
        } else {
            appState = .dashboard
        }
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
        appState = .dashboard
    }

    func login() {
        appState = .dashboard
    }
}

struct AppCoordinatorView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject var dataManager = DataManager()
    @StateObject var authService = AuthService()

    @State private var showingAddSheet = false
    @State private var navigateToHome = false

    var body: some View {
        Group {
            switch appCoordinator.appState {
            case .splash:
                SplashView()
            case .onboarding:
                SplashView()
                //OnboardingView(onComplete: appCoordinator.completeOnboarding)
            case .login:
                LoginView()
                    .environmentObject(authService)
            case .dashboard:
                SplashView()
                //DashboardView(showingAddSheet: $showingAddSheet,
                              //navigateToHome: $navigateToHome)
                    //.environmentObject(dataManager)
            }
        }
        .applyLanguageChange()
    }
}
