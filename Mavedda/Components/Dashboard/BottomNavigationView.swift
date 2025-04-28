//
//  BottomNavigationView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 27.04.2025.
//

import SwiftUI

struct BottomNavigationView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button(action: {
                    selectedTab = tab
                }) {
                    VStack(spacing: 4) {
                        Image(tab.iconName)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(selectedTab == tab ? Color("bottom_bar_indicator") : Color.black)

                        Text(tab.title)
                            .font(.caption)
                            .foregroundColor(selectedTab == tab ? Color("bottom_bar_indicator") : Color.black)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 12)
        .background(Color("background_main"))
    }
}

enum Tab: CaseIterable {
    case home
    case camera
    case exchange
    case assets
    case map

    var iconName: String {
        switch self {
        case .home: return "icon_home"
        case .camera: return "icon_camera"
        case .exchange: return "icon_exchange"
        case .assets: return "icon_assets"
        case .map: return "icon_map"
        }
    }

    var title: String {
        switch self {
        case .home: return "Home"
        case .camera: return "Camera"
        case .exchange: return "Exchange"
        case .assets: return "Assets"
        case .map: return "Map"
        }
    }
}
