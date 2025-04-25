//
//  AuthSelectionView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct AuthSelectionView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator

    var body: some View {
        VStack {
            Text("Giriş yapın veya kayıt olun")
                .padding()
                .font(.title2)

            Button(action: {
                appCoordinator.show(.login)
            }) {
                Text("Giriş Yap")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            Button(action: {
                appCoordinator.show(.register)
            }) {
                Text("Kayıt Ol")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .navigationTitle("Yetkilendirme")
    }
}
