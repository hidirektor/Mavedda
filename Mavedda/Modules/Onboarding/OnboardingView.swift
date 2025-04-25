//
//  OnboardingView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @EnvironmentObject var appCoordinator: AppCoordinator

    var body: some View {
        TabView(selection: $viewModel.currentPage) {
            OnboardingPageView(
                title: "Hoş Geldiniz",
                description: "Uygulamamıza hoş geldiniz! Başlamak için kaydırın.",
                imageName: "pencil.circle.fill"
            )
            .tag(0)

            OnboardingPageView(
                title: "Özellik 1",
                description: "Bu uygulama harika özelliklere sahip. Örneğin, bu ekran size ilk özellik hakkında bilgi veriyor.",
                imageName: "pencil.circle.fill"
            )
            .tag(1)

            OnboardingPageView(
                title: "Hazır Olun",
                description: "Artık uygulamayı kullanmaya başlayabilirsiniz. Birkaç ayar kaldı!",
                imageName: "pencil.circle.fill"
            )
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .overlay(alignment: .bottom) {
            Button(action: {
                if viewModel.currentPage < 2 {
                    viewModel.currentPage += 1
                } else {
                    appCoordinator.show(.firstSetup) // Onboarding tamamlandı, FirstSetup'a geç
                }
            }) {
                Text(viewModel.currentPage < 2 ? "İleri" : "Başla")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.bottom)
        }
    }
}

//  OnboardingPageView.swift
//  Created by AI

import SwiftUI

struct OnboardingPageView: View {
    let title: String
    let description: String
    let imageName: String

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .padding()
            Text(title)
                .font(.title)
                .padding()
            Text(description)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .padding()
    }
}
