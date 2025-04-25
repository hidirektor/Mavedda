//
//  ResetPasswordEnterNewPasswordView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct ResetPasswordEnterNewPasswordView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var newPassword = ""
    @State private var newPasswordAgain = ""
    let token: String // Önceki ekrandan gelen token
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isUpdating = false
    
    var body: some View {
        VStack {
            SecureField("Yeni Şifre", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Yeni Şifre Tekrar", text: $newPasswordAgain)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Şifreyi Değiştir") {
                isUpdating = true
                Task {
                    do {
                        if newPassword != newPasswordAgain{
                            alertMessage = "Şifreler eşleşmiyor"
                            showAlert = true
                            isUpdating = false
                            return
                        }
                        // Şifre değiştirme işlemini simüle et
                        try await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 saniye
                        
                        // Başarılı olursa şifre değiştirildi ekranına git
                        appCoordinator.show(.resetPasswordChanged)
                        isUpdating = false
                        
                    } catch {
                        alertMessage = "Şifre değiştirme başarısız: \(error.localizedDescription)"
                        showAlert = true
                        isUpdating = false
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(isUpdating)
            
            if isUpdating{
                ProgressView()
                    .padding()
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Yeni Şifre")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Hata"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
    }
}
