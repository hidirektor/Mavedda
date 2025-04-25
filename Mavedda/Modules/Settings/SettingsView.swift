//
//  SettingsView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var isDarkMode = false // Örnek ayar

    var body: some View {
        NavigationView{ // iç içe navigationView
            VStack {
                Text("Ayarlar")
                    .padding()
                    .font(.title)

                // Örnek ayar: Karanlık Mod
                Toggle("Karanlık Mod", isOn: $isDarkMode)
                    .padding()
                
                Button("Çıkış Yap") {
                    // Uygulamadan çıkış yapma işlemini simüle et
                    // Genellikle burada kullanıcı oturumunu sonlandırma işlemleri yapılır
                    appCoordinator.isLoggedIn = false // Örnek: isLoggedIn durumunu güncelle
                    appCoordinator.show(.authSelection) // Giriş ekranına geri dön
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)

                Spacer()
            }
            .padding()
            .navigationTitle("Ayarlar")
        }
    }
}
