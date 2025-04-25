//
//  PermissionsService.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import Foundation
import CoreLocation
import AVFoundation
import UserNotifications

class PermissionsService: NSObject, CLLocationManagerDelegate {
    // İzinlerle ilgili işlemler (örneğin, konum, kamera, bildirim)
    private let locationManager = CLLocationManager()
    private var completionHandlers: [String: (Bool) -> Void] = [:]

    override init() {
        super.init()
        locationManager.delegate = self
    }

    // Bildirim izni isteme
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        completionHandlers["notification"] = completion
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            DispatchQueue.main.async {
                completion(granted)
                self.completionHandlers["notification"] = nil // Clean up
            }
        }
    }

    // Kamera izni isteme
    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        completionHandlers["camera"] = completion
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                    self.completionHandlers["camera"] = nil
                }
            }
        } else {
            DispatchQueue.main.async {
                let granted = (status == .authorized)
                completion(granted)
                self.completionHandlers["camera"] = nil
            }
        }
    }
    // Diğer izinlerle ilgili fonksiyonlar
}
