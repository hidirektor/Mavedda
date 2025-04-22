//
//  CameraManager.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 5.04.2025.
//

import SwiftUI
import AVFoundation
import Vision

class CameraManager: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    var previewLayer: AVCaptureVideoPreviewLayer?
    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    @Published var authorizationState: AVAuthorizationStatus = .notDetermined
    @Published var recognizedAmount: Double? = nil

    private let textRecognizer = VNRecognizeTextRequest()

    override init() {
        super.init()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        textRecognizer.recognitionLevel = .accurate
        textRecognizer.minimumTextHeight = 0.01
        textRecognizer.usesLanguageCorrection = true
    }

    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            authorizationState = .authorized
            setupCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    self?.authorizationState = granted ? .authorized : .denied
                    if granted {
                        self?.setupCamera()
                    }
                }
            }
        case .denied, .restricted:
            DispatchQueue.main.async {
                self.authorizationState = .denied
            }
        @unknown default:
            DispatchQueue.main.async {
                self.authorizationState = .denied
            }
        }
    }

    private func setupCamera() {
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("scanner.camera_not_found".localized)
            return
        }

        do {
            let videoInput = try AVCaptureDeviceInput(device: videoDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            } else {
                print("Video input eklenemedi.")
                return
            }

            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            } else {
                print("Video output eklenemedi.")
                return
            }

            DispatchQueue.main.async {
                self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                self.previewLayer?.videoGravity = .resizeAspectFill
                do {
                    self.captureSession.startRunning()
                } catch {
                    print("AVCaptureSession başlatılırken hata oluştu: \(error.localizedDescription)")
                }
            }

        } catch {
            print(String(format: "scanner.camera_setup_error".localized, error.localizedDescription))
        }
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: [:])

        do {
            try imageRequestHandler.perform([textRecognizer])
        } catch {
            print(String(format: "scanner.image_processing_request_error".localized, error.localizedDescription))
            return
        }

        guard let results = textRecognizer.results as? [VNRecognizedTextObservation] else { return }

        var bestMatch: (text: String, confidence: Float)? = nil

        for observation in results {
            guard let topCandidate = observation.topCandidates(1).first else { continue }
            if bestMatch == nil || topCandidate.confidence > bestMatch!.confidence {
                bestMatch = (topCandidate.string, topCandidate.confidence)
            }
        }

        if let bestMatchText = bestMatch?.text {
            if let amount = extractAmount(from: bestMatchText) {
                DispatchQueue.main.async {
                    self.recognizedAmount = amount
                }
            }
        }
    }

    private func extractAmount(from text: String) -> Double? {
        let lowercasedText = text.lowercased()
        if lowercasedText.contains("total") || lowercasedText.contains("toplam") {
            let components = lowercasedText.components(separatedBy: CharacterSet.decimalDigits.inverted)
            for component in components {
                if let number = Double(component) {
                    return number
                }
            }
        } else {
            if let range = text.rangeOfCharacter(from: .decimalDigits) {
                let sub = text[range.lowerBound...]
                let numberString = String(sub.prefix(while: { $0.isNumber || $0 == "." || $0 == "," }))
                if let amount = Double(numberString.replacingOccurrences(of: ",", with: ".")) {
                    return amount
                }
            }
        }
        return nil
    }
}

struct LiveCameraView: UIViewRepresentable {
    let previewLayer: AVCaptureVideoPreviewLayer

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        previewLayer.frame = uiView.bounds
    }
}
