//
//  ResetPasswordSelectMethodViewModel.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import Foundation

class ResetPasswordSelectMethodViewModel: BaseViewModel {
    @Published var email: String = ""
    @Published var showOTPScreen = false

    func sendResetLink() {
        // Şifre sıfırlama linki gönderme işlemleri
        // Başarılı ise showOTPScreen = true
        showOTPScreen = true // Örnek olarak doğrudan OTP ekranına geçiş
    }
}
