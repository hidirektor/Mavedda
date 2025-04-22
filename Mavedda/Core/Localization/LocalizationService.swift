//
//  LocalizationService.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import Foundation
import SwiftUI
import Combine

class LocalizationService: ObservableObject {
    static let shared = LocalizationService()
    @Published var currentLocale: Locale = .current

    private let userDefaults = UserDefaults.standard
    private let appleLanguagesKey = "AppleLanguages"
    private let languageChangedNotification = Notification.Name("AppLanguageChanged")

    init() {
        if let preferredLanguage = userDefaults.array(forKey: appleLanguagesKey)?.first as? String {
            setLocale(preferredLanguage)
        }
    }

    func setLocale(_ localeIdentifier: String) {
        let newLocale = Locale(identifier: localeIdentifier)
        currentLocale = newLocale
        userDefaults.set([localeIdentifier], forKey: appleLanguagesKey)
        userDefaults.synchronize()

        NotificationCenter.default.post(name: languageChangedNotification, object: nil)
    }

    var currentLanguageCode: String {
        return currentLocale.languageCode ?? Locale.current.languageCode ?? "en"
    }
}

struct LanguageChangeViewModifier: ViewModifier {
    @ObservedObject var localizationService = LocalizationService.shared
    @State private var dummy = false

    func body(content: Content) -> some View {
        content
            .environment(\.locale, localizationService.currentLocale)
            .id(dummy)
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("AppLanguageChanged"))) { _ in
                dummy.toggle() // State'i değiştirerek görünümü yeniden tetikler
            }
    }
}

extension View {
    func applyLanguageChange() -> some View {
        self.modifier(LanguageChangeViewModifier())
    }
}
