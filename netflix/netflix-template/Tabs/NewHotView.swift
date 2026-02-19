import SwiftUI

struct NewHotView: View {
    var body: some View {
        ZStack {
            Color(red: 0.07, green: 0.07, blue: 0.07).ignoresSafeArea()
            emptyState
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "flame.fill")
                .font(.system(size: 48))
                .foregroundStyle(.red.opacity(0.6))
            Text("New & Hot")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Text("Coming soon & trending content\nwill appear here.")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
        }
    }
}
