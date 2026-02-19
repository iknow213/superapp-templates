import SwiftUI

struct ShowCard: View {
    let show: Show
    var width: CGFloat = 120
    var height: CGFloat = 170

    var body: some View {
        ZStack(alignment: .topLeading) {
            posterBackground
            badgeOverlay
            titleOverlay
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    private var posterBackground: some View {
        ZStack {
            if let urlStr = show.imageURL, let url = URL(string: urlStr) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFill()
                    default:
                        show.color
                    }
                }
            } else {
                show.color
                LinearGradient(
                    colors: [show.color.opacity(0.3), show.color, show.color.opacity(0.8)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
    }

    private var badgeOverlay: some View {
        NetflixNBadge(size: 14)
            .padding(6)
    }

    private var titleOverlay: some View {
        VStack {
            Spacer()
            Text(show.title)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.8), radius: 3, x: 0, y: 1)
                .multilineTextAlignment(.leading)
                .padding(8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct Top10Card: View {
    let show: Show
    let rank: Int
    private let cardWidth: CGFloat = 140
    private let cardHeight: CGFloat = 200

    var body: some View {
        HStack(alignment: .bottom, spacing: -20) {
            rankNumber
            posterCard
        }
    }

    private var rankNumber: some View {
        Text("\(rank)")
            .font(.system(size: 120, weight: .heavy))
            .foregroundStyle(.clear)
            .overlay(
                Text("\(rank)")
                    .font(.system(size: 120, weight: .heavy))
                    .foregroundStyle(.black)
                    .overlay(
                        Text("\(rank)")
                            .font(.system(size: 120, weight: .heavy))
                            .foregroundStyle(
                                .linearGradient(
                                    colors: [Color.gray.opacity(0.6), Color.gray.opacity(0.3)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .shadow(color: .white.opacity(0.2), radius: 1, x: -1, y: 0)
                    )
            )
            .offset(y: 10)
    }

    private var posterCard: some View {
        ZStack(alignment: .topLeading) {
            if let urlStr = show.imageURL, let url = URL(string: urlStr) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFill()
                    default:
                        show.color
                    }
                }
            } else {
                show.color
            }
            NetflixNBadge(size: 14).padding(6)
            VStack {
                Spacer()
                Text(show.title)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.8), radius: 3, x: 0, y: 1)
                    .multilineTextAlignment(.leading)
                    .padding(8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: cardWidth, height: cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}
