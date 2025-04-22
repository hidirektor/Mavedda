//
//  WelcomeView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 22.04.2025.
//

import SwiftUI

struct WelcomeView: View {
    @State private var isActive = false
    @State private var blink = false

    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()

            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Image("logo_mavedda_light")
                        .resizable()
                        .frame(width: 280, height: 280)
                }

                VStack(spacing: 20) {
                    Button(action: {
                        isActive = true
                    }) {
                        Text("Kabul Et ve Devam Et")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 32)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(16)
                    }

                    Text("**Gizlilik Politikamızı** okuyun. **Hizmet Şartlarını** kabul etmek için ‘Kabul Et ve Devam Et’e dokunun.")
                        .font(.subheadline)
                        .foregroundColor(Color("descriptionTextColor"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
                .padding(.top, 50)

                Text("from")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text("Mavedda")
                    .font(.title2.bold())
                    .foregroundStyle(LinearGradient(
                        colors: [Color("maveddaDegradeStart"), Color("maveddaDegradeEnd")],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) { // Alt güvenli alan boşluğu
                EmptyView()
                    .frame(height: 20) // İsteğe bağlı alt boşluk
            }
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $isActive) {
            LoginView()
        }
    }
}

#Preview {
    WelcomeView()
}
