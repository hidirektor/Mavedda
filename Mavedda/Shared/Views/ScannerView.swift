//
//  ScannerView.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 5.04.2025.
//

import SwiftUI
import AVFoundation
import Vision

struct ScannerView: View {
    @Binding var isShowingScanner: Bool
    let completion: (Double?) -> Void
    @ObservedObject var cameraManager: CameraManager
    let scanAreaSize: CGFloat = 250
    let scanAreaCornerRadius: CGFloat = 20
    @State private var lastRecognizedAmount: Double? = nil

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            if let previewLayer = cameraManager.previewLayer {
                LiveCameraView(previewLayer: previewLayer)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text(cameraManager.authorizationState == .notDetermined ? "scanner.camera_permission_pending".localized : "scanner.camera_permission_denied".localized)
                    .foregroundColor(.white)
            }

            RoundedRectangle(cornerRadius: scanAreaCornerRadius)
                .stroke(Color.green, lineWidth: 2)
                .frame(width: scanAreaSize, height: scanAreaSize)

            VStack {
                HStack {
                    Button {
                        isShowingScanner = false
                        completion(nil)
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                    }
                    .padding(.top)
                    Spacer()
                }
                .padding()
                Spacer()
                Text("scanner.align_receipt".localized)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .shadow(radius: 2)
                    .padding(.bottom, 5)
                if let amount = lastRecognizedAmount {
                    Text(String(format: "scanner.last_read_amount".localized, amount))
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                        .shadow(radius: 2)
                        .padding(.bottom)
                } else {
                    Text("scanner.reading_amount".localized)
                        .font(.headline)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                        .padding(.bottom)
                }
                Button {
                    if let amount = lastRecognizedAmount {
                        completion(amount)
                        isShowingScanner = false
                    }
                } label: {
                    Text(lastRecognizedAmount != nil ? "scanner.use_this_amount".localized : "scanner.scanning".localized)
                        .font(.headline)
                        .foregroundColor(Color("borderAndDivider"))
                        .padding()
                        .background(Color("bodyPrimary"))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }
                .disabled(lastRecognizedAmount == nil)
                .padding(.bottom)
            }
        }
        .onAppear(perform: cameraManager.checkPermissions)
        .onChange(of: cameraManager.recognizedAmount) { newValue in
            if let newValue = newValue {
                lastRecognizedAmount = newValue
            }
        }
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
