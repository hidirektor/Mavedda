//
//  DashboardView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var showingProfile = false  // Profil sayfasını göstermek için

    var body: some View {
        VStack {
            Text("Dashboard")
                .padding()
                .font(.title)

            Button(action: {
                showingProfile = true
            }) {
                Text("Profili Görüntüle")
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .sheet(isPresented: $showingProfile) {
                ProfileView() // Profil sayfasını sun
            }
            
            Button(action: {
                appCoordinator.show(.settings)
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
        .navigationTitle("Anasayfa")
        .onAppear{
            print("Dashboard göründü")
        }
    }
}
