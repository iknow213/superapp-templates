import SwiftUI

struct SearchTickerBar: View {
    let text: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.7))
            Text("Search · \(text)")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.7))
                .lineLimit(1)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.1))
        .clipShape(Capsule())
        .padding(.horizontal, 12)
    }
}
