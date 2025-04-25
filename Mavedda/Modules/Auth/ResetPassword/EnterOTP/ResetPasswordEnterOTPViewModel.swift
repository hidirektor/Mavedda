//
//  ResetPasswordEnterOTPViewModel.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import Foundation

class ResetPasswordEnterOTPViewModel: BaseViewModel {
    @Published var otp: String = ""
    @Published var showNewPasswordScreen = false
    var email: String // Önceki ekrandan gelen email

    init(email: String) {
        self.email = email
    }

    func verifyOTP() {
        // OTP doğrulama işlemleri
        // Başarılı ise showNewPasswordScreen = true
        showNewPasswordScreen = true // Örnek olarak doğrudan yeni şifre ekranına geçiş
    }
}
