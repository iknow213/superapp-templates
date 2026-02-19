import SwiftUI

struct FastLaughsView: View {
    var body: some View {
        ZStack {
            Color(red: 0.07, green: 0.07, blue: 0.07).ignoresSafeArea()
            emptyState
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "face.smiling.inverse")
                .font(.system(size: 48))
                .foregroundStyle(.yellow.opacity(0.6))
            Text("Fast Laughs")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Text("Short funny clips from Netflix\nshows & films.")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
        }
    }
}
