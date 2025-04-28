//
//  DashboardView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var showingProfile = false
    @State private var verticalSwitchIsOn = false

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(spacing: 15) {
                        TopBarView()
                        RemainingTimeView(endTime: Date().addingTimeInterval(4 * 24 * 60 * 60))
                        ButtonRowView()
                        SummaryView()
                        RecentTransactionsView()
                    }
                    .padding()
                }
                .navigationBarHidden(true)
                .safeAreaInset(edge: .bottom) {
                    BottomNavigationView()
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        OperationTypeSwitch()
                    }
                    .padding(.bottom, 72)
                    .padding(.trailing, 12)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background_main"))
        .ignoresSafeArea()
        .navigationViewStyle(.stack)
    }
}
