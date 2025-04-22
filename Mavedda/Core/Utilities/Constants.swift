//
//  Constants.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import Foundation

struct Constants {
    struct UserDefaultsKeys {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
        static let transactions = "transactionsData"
        static let cumulativeIncome = "cumulativeIncome"
        static let cumulativeExpense = "cumulativeExpense"
        static let enduranceDays = "enduranceDays"
        static let askedForNotificationPermission = "askedForNotificationPermission"
        static let monthlySpendingLimit = "monthlySpendingLimit"
    }

    struct AppInfo {
        static let appName = localizedString("app.name")
    }
    
    struct URLs {
        static let termsOfServiceURL = URL(string: "https://mavedda.com/policy")!
        static let privacyPolicyURL = URL(string: "https://mavedda.com/policy")!
    }

    // Helper for localization
    static func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
