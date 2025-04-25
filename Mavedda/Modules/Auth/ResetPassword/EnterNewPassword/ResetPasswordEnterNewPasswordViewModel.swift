//
//  ResetPasswordEnterNewPasswordViewModel.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import Foundation//
class ResetPasswordEnterNewPasswordViewModel: BaseViewModel {
    @Published var newPassword = ""
    @Published var newPasswordAgain = ""
    @Published var showPasswordChangedScreen = false
    var token: String // Önceki ekrandan gelen token

    init(token: String) {
        self.token = token
    }

    func changePassword() {
        // Şifre değiştirme işlemleri
        // Başarılı ise showPasswordChangedScreen = true
       showPasswordChangedScreen = true // Örnek olarak doğrudan şifre değiştirildi ekranına geçiş
    }
}
