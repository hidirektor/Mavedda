//
//  ProfileView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var showingSettings = false

    var body: some View {
        VStack {
            Text("Profil")
                .padding()
                .font(.title)

            // Profil bilgileri burada gösterilir
            Text("Kullanıcı Adı: John Doe")
                .padding()
            Text("E-posta: john.doe@example.com")
                .padding()
            
            Button(action: {
                showingSettings = true
            }){
                Text("Ayarlara Git")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Profil")
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }
}
