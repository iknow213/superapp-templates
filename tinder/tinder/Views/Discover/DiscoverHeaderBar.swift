import SwiftUI

struct DiscoverHeaderBar: View {
    private let tinderPink = Color(red: 0.99, green: 0.27, blue: 0.35)

    var body: some View {
        HStack {
            logoSection
            Spacer()
            headerButtons
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }

    private var logoSection: some View {
        HStack(spacing: 4) {
            Image(systemName: "flame.fill")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(tinderPink)
            Text("tinder")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(tinderPink)
        }
    }

    private var headerButtons: some View {
        HStack(spacing: 16) {
            Button(action: {}) {
                Image(systemName: "bell.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
            Button(action: {}) {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 20))
                    .foregroundColor(.orange)
            }
        }
    }
}
