import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var blink = false

    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()

            VStack {
                VStack(spacing: 20) {
                    Image("logo_mavedda_light")
                        .resizable()
                        .frame(width: 280, height: 280)
                        .opacity(blink ? 1 : 0.3) // Blink effect
                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: blink)
                }
                .padding(.bottom, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                blink = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            //LoginView(onComplete: { })
            WelcomeView()
        }
    }
}

#Preview {
    SplashView()
}
