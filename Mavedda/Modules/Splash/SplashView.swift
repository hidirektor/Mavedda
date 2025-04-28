//
//  SplashView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject var viewModel: SplashViewModel
    @State private var isActive = false
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore = false

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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background_main"))
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isActive = true
                viewModel.navigateToNextScreen()
            }
        }
    }
}
