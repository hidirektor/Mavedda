//
//  FirstSetupViewModel.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI
import AVFoundation
import Network

class FirstSetupViewModel: NSObject, ObservableObject { // Removed CLLocationManagerDelegate
    @Published var notificationPermissionGranted = false
    @Published var cameraPermissionGranted = false
    @Published var isConnected = true
    @Published var allPermissionsGranted = false
    
    @Published var notificationPermissionRequested = false
    @Published var cameraPermissionRequested = false
    
    private var networkMonitor = NWPathMonitor()
    private let mainQueue = DispatchQueue.main
    
    override init() {
        super.init()
    }
    
    // Uygulama ilk açıldığında izinleri kontrol et
    func checkInitialPermissions() {
        checkNotificationPermission()
        checkCameraPermission()
    }
    
    // Bildirim izni kontrolü ve isteme
    func requestNotificationPermission() {
        notificationPermissionRequested = true
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.notificationPermissionGranted = (settings.authorizationStatus == .authorized)
                if settings.authorizationStatus == .notDetermined {
                    center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
                        DispatchQueue.main.async {
                            self.notificationPermissionGranted = granted
                            self.updateAllPermissionsStatus()
                        }
                    }
                } else {
                    self.updateAllPermissionsStatus()
                }
            }
        }
    }
    
    private func checkNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.notificationPermissionGranted = (settings.authorizationStatus == .authorized)
                self.updateAllPermissionsStatus()
            }
        }
    }
    
    // Kamera izni kontrolü ve isteme
    func requestCameraPermission() {
        cameraPermissionRequested = true
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    self.cameraPermissionGranted = granted
                    self.updateAllPermissionsStatus()
                }
            }
        } else {
            DispatchQueue.main.async {
                self.cameraPermissionGranted = (status == .authorized)
                self.updateAllPermissionsStatus()
            }
        }
    }
    
    private func checkCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        DispatchQueue.main.async {
            self.cameraPermissionGranted = (status == .authorized)
            self.updateAllPermissionsStatus()
        }
    }
    
    // Tüm izinlerin verilip verilmediğini kontrol et
    private func updateAllPermissionsStatus() {
        allPermissionsGranted = notificationPermissionGranted && cameraPermissionGranted && isConnected
    }
    
    // İnternet bağlantısını dinleme
    func startMonitoringNetwork() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            self?.mainQueue.async {
                self?.isConnected = (path.status == .satisfied)
                self?.updateAllPermissionsStatus()
            }
        }
        networkMonitor.start(queue: mainQueue)
    }
    
    // İnternet bağlantısı dinlemeyi durdur
    func stopMonitoringNetwork() {
        networkMonitor.cancel()
    }
    
    deinit {
        stopMonitoringNetwork()
    }
}
