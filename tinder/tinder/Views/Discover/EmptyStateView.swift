import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "flame.fill")
                .font(.system(size: 60))
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color(red: 0.99, green: 0.27, blue: 0.35), .orange],
                        startPoint: .top, endPoint: .bottom
                    )
                )
            Text("No more profiles")
                .font(.title2.bold())
                .foregroundColor(.primary)
            Text("Come back later for new\npeople in your area")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            refreshButton
        }
        .padding(40)
    }

    private var refreshButton: some View {
        Button(action: {}) {
            Text("Refresh")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 14)
                .background(
                    LinearGradient(
                        colors: [Color(red: 0.99, green: 0.27, blue: 0.35), .orange],
                        startPoint: .leading, endPoint: .trailing
                    )
                )
                .clipShape(Capsule())
        }
    }
}
