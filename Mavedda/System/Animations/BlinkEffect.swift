//
//  BlinkEffect.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

struct Blink: ViewModifier {
    @State private var isVisible = false
    let duration: Double = 0.5

    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: duration).repeatForever()) {
                    isVisible = true
                }
            }
    }
}

extension View {
    func blink() -> some View {
        self.modifier(Blink())
    }
}
