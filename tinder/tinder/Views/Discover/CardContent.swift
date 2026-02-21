import SwiftUI

struct CardContent: View {
    let profile: Profile
    let offset: CGSize

    var body: some View {
        ZStack(alignment: .bottom) {
            cardBackground
            cardOverlays
            profileInfoOverlay
            swipeLabels
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }

    private var cardBackground: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(colors: profile.gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                if let urlString = profile.photoURLs.first, let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipped()
                        case .failure:
                            fallbackIcon(size: geo.size)
                        default:
                            shimmer(size: geo.size)
                        }
                    }
                } else {
                    fallbackIcon(size: geo.size)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }

    private func fallbackIcon(size: CGSize) -> some View {
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFit()
            .frame(width: size.width * 0.4)
            .foregroundColor(.white.opacity(0.4))
            .frame(width: size.width, height: size.height)
    }

    private func shimmer(size: CGSize) -> some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .frame(width: size.width, height: size.height)
            .overlay(
                ProgressView()
                    .tint(.white)
            )
    }

    private var cardOverlays: some View {
        VStack {
            Spacer()
            LinearGradient(
                colors: [.clear, .black.opacity(0.75)],
                startPoint: .top, endPoint: .bottom
            )
            .frame(height: 220)
        }
    }

    @ViewBuilder
    private var profileInfoOverlay: some View {
        VStack(alignment: .leading, spacing: 6) {
            Spacer()
            activeTag
            nameRow
        }
        .padding(16)
    }

    private var activeTag: some View {
        Group {
            if profile.isActive {
                HStack(spacing: 4) {
                    Circle().fill(Color.green).frame(width: 8, height: 8)
                    Text("Active").font(.caption).fontWeight(.medium)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
            }
        }
    }

    private var nameRow: some View {
        HStack(alignment: .bottom) {
            HStack(spacing: 6) {
                Text(profile.name).font(.system(size: 28, weight: .bold))
                Text("\(profile.age)").font(.system(size: 24, weight: .regular))
                if profile.isVerified {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 18))
                }
            }
            .foregroundColor(.white)
            Spacer()
            infoButton
        }
    }

    private var infoButton: some View {
        Button(action: {}) {
            Image(systemName: "arrow.up.circle.fill")
                .font(.system(size: 28))
                .foregroundColor(.white.opacity(0.8))
        }
    }

    private var swipeLabels: some View {
        ZStack {
            likeLabel.opacity(Double(offset.width / 100).clamped(to: 0...1))
            nopeLabel.opacity(Double(-offset.width / 100).clamped(to: 0...1))
            superLikeLabel.opacity(Double(-offset.height / 100).clamped(to: 0...1))
        }
    }

    private var likeLabel: some View {
        swipeLabel(text: "LIKE", color: .green, rotation: -15, alignment: .topLeading)
    }

    private var nopeLabel: some View {
        swipeLabel(text: "NOPE", color: .red, rotation: 15, alignment: .topTrailing)
    }

    private var superLikeLabel: some View {
        swipeLabel(text: "SUPER\nLIKE", color: .blue, rotation: 0, alignment: .center)
    }

    private func swipeLabel(text: String, color: Color, rotation: Double, alignment: Alignment) -> some View {
        Text(text)
            .font(.system(size: 36, weight: .heavy))
            .foregroundColor(color)
            .multilineTextAlignment(.center)
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(color, lineWidth: 4)
            )
            .rotationEffect(.degrees(rotation))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .padding(30)
    }
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
