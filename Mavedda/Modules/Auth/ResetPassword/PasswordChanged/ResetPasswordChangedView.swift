//
//  ResetPasswordChangedView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct ResetPasswordChangedView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator

    var body: some View {
        VStack {
            Text("Şifreniz başarıyla değiştirildi!")
                .padding()
                .font(.title2)
            
            Button("Giriş Yap"){
                appCoordinator.show(.login)
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Şifre Değiştirildi")
    }
}
