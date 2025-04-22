//
//  GlassMorphicCard.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import SwiftUI

struct GlassMorphicCard<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        let width = UIScreen.main.bounds.width

        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .opacity(0.1)
                .background(
                    Color.white
                        .opacity(0.08)
                        .blur(radius: 10)
                )
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                            .linearGradient(.init(colors: [
                                Color("glassMorphicPrimary"),
                                Color("glassMorphicSecondary").opacity(0.5),
                                .clear,
                                .clear,
                                Color("glassMorphicPrimary"),
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            , lineWidth: 2.5
                        )
                        .padding(2)
                )
                .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)

            content()
        }
    }
}
