//
//  MaveddaApp.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

@main
struct MaveddaApp: App {
    @StateObject var appCoordinator = AppCoordinator()

    // Lazy initialization of authRepository with APIClient
    @StateObject private var authRepository: AuthRepository

    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore = false

    init() {
        // Initialize authRepository after the app starts
        let apiBaseURL = URL(string: "https://your-api-base-url.com")!
        _authRepository = StateObject(wrappedValue: AuthRepository(apiClient: APIClient(baseURL: apiBaseURL)))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appCoordinator)
                .environmentObject(authRepository)
                .onAppear {
                    appCoordinator.show(hasLaunchedBefore ? .authSelection : .onboarding)
                    hasLaunchedBefore = true
                }
        }
    }
}
