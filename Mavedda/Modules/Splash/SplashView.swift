//
//  SplashView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var isActive = false

    var body: some View {
        VStack {
            // Splash ekranı içeriği (örneğin, logo)
            Text("Splash Ekranı")
                .font(.largeTitle)
                .padding()
            
            if isActive{
                ProgressView()
            }
        }
        .onAppear {
            // Splash ekranında bir süre bekledikten sonra diğer ekrana geçiş yap
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2 saniye sonra
                isActive = true
                appCoordinator.show(.onboarding) // Onboarding'e geçiş
                
            }
        }
    }
}
