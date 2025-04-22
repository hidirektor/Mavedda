//
//  HamburgerMenuView.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 4.04.2025.
//

import SwiftUI

struct HamburgerMenuView: View {
    @Binding var isPresented: Bool
    @State private var showingWebView = false
    private let termsURL = Constants.URLs.termsOfServiceURL
    @ObservedObject var localizationService = LocalizationService.shared

    var body: some View {
        ZStack(alignment: .leading) {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }

            VStack(alignment: .leading, spacing: 20) {
                if #available(iOS 16.0, *) {
                    Spacer().frame(height: 50)
                } else {
                    Spacer().frame(height: 0)
                }

                Image("logo_mavedda")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 150)
                    .foregroundColor(Color("bodyPrimary"))
                    .padding(.bottom, 30)

                menuItem(iconName: "paintpalette", text: "menu.theme") {
                    withAnimation {
                        isPresented = false
                    }
                    toggleTheme()
                }

                menuItem(iconName: "globe", text: "menu.language") {
                    withAnimation {
                        isPresented = false
                    }
                    if localizationService.currentLanguageCode == "tr" {
                        localizationService.setLocale("en")
                    } else {
                        localizationService.setLocale("tr")
                    }
                }

                menuItem(iconName: "doc.text.magnifyingglass", text: "menu.legal") {
                    showingWebView = true
                }

                Spacer()
            }
            .padding()
            .frame(width: 250, alignment: .leading)
            .background(Color("background"))
            .offset(x: isPresented ? 0 : -250)
            .transition(.move(edge: .leading))
            .sheet(isPresented: $showingWebView) {
                WebView(url: termsURL)
            }
        }
    }

    private func menuItem(iconName: String, text: LocalizedStringKey, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color("bodyPrimary"))
                Text(text)
                    .foregroundColor(Color("bodyPrimary"))
            }
        }
    }
}
