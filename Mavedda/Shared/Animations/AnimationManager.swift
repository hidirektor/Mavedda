//
//  AnimationManager.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 6.04.2025.
//

import SwiftUI
import Combine

class AnimationManager: ObservableObject {
    @Published var animatedText: String = ""
    private var fullText: String = ""
    private var animationTimer: AnyCancellable?

    func animateText(text: String, durationPerCharacter: TimeInterval = 0.05) {
        fullText = text
        animatedText = ""
        animationTimer?.cancel()

        var currentIndex = 0
        animationTimer = Timer.publish(every: durationPerCharacter, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if currentIndex < self.fullText.count {
                    let nextCharacter = String(self.fullText[self.fullText.index(self.fullText.startIndex, offsetBy: currentIndex)])
                    self.animatedText += nextCharacter
                    currentIndex += 1
                } else {
                    self.animationTimer?.cancel()
                }
            }
    }
}
