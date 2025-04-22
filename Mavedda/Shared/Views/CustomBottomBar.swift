//
//  CustomBottomBar.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import SwiftUI

struct CustomBottomBar: View {
    let addTransaction: () -> Void
    @Binding var selectedTab: Tab
    @Binding var navigateToCO2: Bool
    @Binding var navigateToAssets: Bool
    @Binding var showScanner: Bool

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(alignment: .center) {
                BottomBarItem(
                    tab: .home,
                    selectedTab: $selectedTab,
                    imageName: "icon_home",
                    text: LocalizedStringKey("tab.home")
                ) {
                    // Home action
                }
                Spacer()
                BottomBarItem(
                    tab: .card,
                    selectedTab: $selectedTab,
                    imageName: "icon_scan",
                    text: LocalizedStringKey("tab.scan")
                ) {
                    showScanner = true
                }
                Spacer()

                Button(action: {
                    addTransaction()
                }) {
                    Image("icon_plus")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(Color("background"))
                        .background(Circle().fill(Color("bodyPrimary")).frame(width: 48, height: 48))
                }
                Spacer()
                BottomBarItem(
                    tab: .report,
                    selectedTab: $selectedTab,
                    imageName: "icon_leaf",
                    text: LocalizedStringKey("tab.ecology"),
                    successBase: true
                ) {
                    navigateToCO2 = true
                }
                Spacer()
                BottomBarItem(
                    tab: .settings,
                    selectedTab: $selectedTab,
                    imageName: "icon_assets",
                    text: LocalizedStringKey("tab.assets")
                ) {
                    navigateToAssets = true
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 66)
            .background(Color("background"))
            .cornerRadius(28)
            .padding(.horizontal)
            .shadow(radius: 5)
        }
    }
}

struct BottomBarItem: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    let imageName: String
    let text: LocalizedStringKey
    let action: () -> Void
    let successBase: Bool

    init(tab: Tab, selectedTab: Binding<Tab>, imageName: String, text: LocalizedStringKey, successBase: Bool = false, action: @escaping () -> Void) {
        self.tab = tab
        self._selectedTab = selectedTab
        self.imageName = imageName
        self.text = text
        self.action = action
        self.successBase = successBase
    }

    var body: some View {
        Button(action: {
            selectedTab = tab
            action()
        }) {
            VStack {
                Image(imageName)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(selectedTab == tab ? (successBase ? Color("successBase") : Color("primary")) : Color("bodyPrimary"))
                Text(text)
                    .font(.caption)
                    .foregroundColor(selectedTab == tab ? (successBase ? Color("successBase") : Color("primary")) : Color("bodyPrimary"))
            }
        }
    }
}
