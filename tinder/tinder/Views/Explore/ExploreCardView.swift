import SwiftUI

// MARK: - Grid Card
struct ExploreGridCard: View {
    let card: ExploreCard
    let onLike: () -> Void

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            photoLayer
            gradientOverlay
            infoLayer
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 3)
    }

    private var photoLayer: some View {
        AsyncImage(url: URL(string: card.profile.photoURLs.first ?? "")) { img in
            img.resizable().scaledToFill()
        } placeholder: {
            LinearGradient(colors: card.profile.gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .frame(height: 200)
        .clipped()
    }

    private var gradientOverlay: some View {
        LinearGradient(
            colors: [.clear, .black.opacity(0.65)],
            startPoint: .center, endPoint: .bottom
        )
    }

    private var infoLayer: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Text(card.tag)
                    .font(.caption2.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .background(card.tagColor.opacity(0.85))
                    .clipShape(Capsule())
                Spacer()
                likeButton
            }
            Text("\(card.profile.name), \(card.profile.age)")
                .font(.subheadline.bold())
                .foregroundColor(.white)
            Text(card.profile.distance)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(10)
    }

    private var likeButton: some View {
        Button(action: onLike) {
            Image(systemName: "heart.fill")
                .font(.system(size: 13))
                .foregroundColor(.white)
                .padding(7)
                .background(Color(red:0.99,green:0.27,blue:0.35).opacity(0.9))
                .clipShape(Circle())
        }
    }
}

// MARK: - Horizontal Scroll Card
struct ExploreFeaturedCard: View {
    let card: ExploreCard

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: card.profile.photoURLs.first ?? "")) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                LinearGradient(colors: card.profile.gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
            }
            .frame(width: 160, height: 220)
            .clipped()

            LinearGradient(colors: [.clear, .black.opacity(0.7)], startPoint: .center, endPoint: .bottom)

            VStack(alignment: .leading, spacing: 2) {
                Text(card.tag)
                    .font(.caption2.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 6).padding(.vertical, 3)
                    .background(card.tagColor.opacity(0.85))
                    .clipShape(Capsule())
                Text("\(card.profile.name), \(card.profile.age)")
                    .font(.subheadline.bold()).foregroundColor(.white)
            }
            .padding(10)
        }
        .frame(width: 160, height: 220)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}
