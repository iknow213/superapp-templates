import SwiftUI

struct SplashView: View {
    @State private var scale: CGFloat = 0.6
    @State private var opacity: Double = 0
    @State private var shadowRadius: CGFloat = 0
    @State private var isDone = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            netflixLogo
        }
        .onAppear(perform: animate)
        .fullScreenCover(isPresented: $isDone) {
            MainTabView()
                .preferredColorScheme(.dark)
        }
    }

    private var netflixLogo: some View {
        Text("N")
            .font(.system(size: 140, weight: .heavy, design: .default))
            .italic()
            .foregroundStyle(
                LinearGradient(
                    colors: [Color(red: 0.9, green: 0.05, blue: 0.05), Color(red: 0.7, green: 0.0, blue: 0.0)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .shadow(color: Color(red: 0.85, green: 0.0, blue: 0.0).opacity(0.8), radius: shadowRadius, x: 0, y: 0)
            .scaleEffect(scale)
            .opacity(opacity)
    }

    private func animate() {
        // Fade + scale in
        withAnimation(.spring(response: 0.5, dampingFraction: 0.65)) {
            scale = 1.0
            opacity = 1.0
        }
        // Glow pulse
        withAnimation(.easeInOut(duration: 0.6).delay(0.3)) {
            shadowRadius = 30
        }
        withAnimation(.easeInOut(duration: 0.4).delay(0.9)) {
            shadowRadius = 6
        }
        // Scale up and fade out
        withAnimation(.easeIn(duration: 0.35).delay(1.4)) {
            scale = 12
            opacity = 0
        }
        // Transition to main app
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
            isDone = true
        }
    }
}
