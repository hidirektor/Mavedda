//
//  FirstSetupView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct FirstSetupView: View {
    @ObservedObject var viewModel: FirstSetupViewModel
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        VStack {
            Text("İlk Kurulum")
                .padding()
                .font(.title)
            
            // Bildirim izni
            Button(action: {
                viewModel.requestNotificationPermission()
            }) {
                Text(viewModel.notificationPermissionGranted ? "Bildirim İzni Verildi" : "Bildirim İzni Ver")
                    .padding()
                    .background(viewModel.notificationPermissionGranted ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .disabled(viewModel.notificationPermissionRequested) // İzin istendikten sonra butonu devre dışı bırak
            
            // Kamera izni
            Button(action: {
                viewModel.requestCameraPermission()
            }) {
                Text(viewModel.cameraPermissionGranted ? "Kamera İzni Verildi" : "Kamera İzni Ver")
                    .padding()
                    .background(viewModel.cameraPermissionGranted ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .disabled(viewModel.cameraPermissionRequested)
            
            // İnternet bağlantı kontrolü
            Text(viewModel.isConnected ? "İnternet Bağlantısı Var" : "İnternet Bağlantısı Yok")
                .padding()
                .foregroundColor(viewModel.isConnected ? .green : .red)
            
            Button("Devam Et") {
                appCoordinator.show(.authSelection)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
            .disabled(!viewModel.allPermissionsGranted)
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.checkInitialPermissions() // Uygulama ilk açıldığında izinleri kontrol et
            viewModel.startMonitoringNetwork()
        }
        .onDisappear {
            viewModel.stopMonitoringNetwork()
        }
    }
}
