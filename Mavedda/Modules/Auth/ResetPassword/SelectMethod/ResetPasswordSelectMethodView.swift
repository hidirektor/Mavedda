//
//  ResetPasswordSelectMethodView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct ResetPasswordSelectMethodView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSending = false
    
    var body: some View{
        VStack{
            TextField("E-posta adresinizi girin", text: $email)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Sıfırlama Linki Gönder"){
                isSending = true
                Task{
                    do{
                        // Email gönderme işlemini simüle et
                        try await Task.sleep(nanoseconds: 2_000_000_000) // 2 saniye
                        
                        // Başarılı olursa OTP ekranına git
                        appCoordinator.show(.resetPasswordEnterOTP(email: email))
                        isSending = false
                        
                    } catch{
                        alertMessage = "Email gönderme başarısız: \(error.localizedDescription)"
                        showAlert = true
                        isSending = false
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(isSending)
            
            if isSending{
                ProgressView()
                    .padding()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Şifre Sıfırlama")
        .alert(isPresented: $showAlert){
            Alert(title: Text("Hata"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
    }
}
