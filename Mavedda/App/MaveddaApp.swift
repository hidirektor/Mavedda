//
//  MaveddaApp.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 22.04.2025.
//

import SwiftUI

@main
struct FinanceApp: App {
    @StateObject private var appCoordinator = AppCoordinator()
    @StateObject var localizationService = LocalizationService.shared
    @AppStorage("AppTheme") var appTheme: String = "light"

    init() {
        if let preferredLanguage = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as? String {
            LocalizationService.shared.setLocale(preferredLanguage)
        }
    }

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView()
                .environmentObject(appCoordinator)
                .applyLanguageChange()
                .preferredColorScheme(appTheme == "dark" ? .dark : .light)
        }
    }
}
