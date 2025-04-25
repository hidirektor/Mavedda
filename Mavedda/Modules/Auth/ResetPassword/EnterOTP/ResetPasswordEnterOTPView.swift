//
//  ResetPasswordEnterOTPView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct ResetPasswordEnterOTPView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var otp: String = ""
    let email: String
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isVerifying = false
    
    var body: some View {
        VStack {
            Text("Lütfen \(email) adresine gönderilen OTP'yi girin.")
                .padding()
            TextField("OTP", text: $otp)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Doğrula") {
                isVerifying = true
                Task {
                    do {
                        // OTP doğrulama işlemini simüle et
                        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 saniye
                        
                        if otp == "123456" { // Örnek OTP kontrolü
                            let token = "dummy_token" // Backend'den gelen token
                            appCoordinator.show(.resetPasswordEnterNewPassword(token: token))
                            isVerifying = false
                        } else {
                            alertMessage = "Geçersiz OTP"
                            showAlert = true
                            isVerifying = false
                        }
                        
                    } catch {
                        alertMessage = "OTP doğrulama başarısız: \(error.localizedDescription)"
                        showAlert = true
                        isVerifying = false
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(isVerifying)
            
            if isVerifying{
                ProgressView()
                    .padding()
            }

            Spacer()
        }
        .padding()
        .navigationTitle("OTP Doğrulama")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Hata"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
    }
}
