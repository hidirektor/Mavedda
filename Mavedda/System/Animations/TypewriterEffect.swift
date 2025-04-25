//
//  TypewriterEffect.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct TypewriterText: View {
    @State private var displayedText = ""
    let fullText: String
    let speed: Double

    init(text: String, speed: Double = 0.05) {
        self.fullText = text
        self.speed = speed
    }

    var body: some View {
        Text(displayedText)
            .onAppear {
                Task {
                    await animateText()
                }
            }
    }

    func animateText() async {
        for (index, character) in fullText.enumerated() {
            displayedText.append(character)
            do {
                try await Task.sleep(nanoseconds: UInt64(speed * 1_000_000_000))
            } catch {
                // Task iptal edildiğinde veya uyku kesintiye uğradığında
                return
            }
            if Task.isCancelled {
                return
            }
        }
    }
}
