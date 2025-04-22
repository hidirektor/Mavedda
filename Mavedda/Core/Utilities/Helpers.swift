//
//  Helpers.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import Foundation

func formatDate(_ date: Date, format: String = "dd.MM.yyyy") -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}

func formatTime(_ date: Date, format: String = "HH:mm") -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}

func toggleTheme() {
    let current = UserDefaults.standard.string(forKey: "AppTheme") ?? "light"
    let newTheme = current == "dark" ? "light" : "dark"
    UserDefaults.standard.set(newTheme, forKey: "AppTheme")
    print("Theme changed to: \(newTheme)")
}
