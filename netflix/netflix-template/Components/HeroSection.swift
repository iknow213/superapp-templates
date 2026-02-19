import SwiftUI

struct HeroSection: View {
    let show: Show

    var body: some View {
        ZStack(alignment: .topLeading) {
            cardImage
            netflixBadge
            bottomOverlay
        }
        .frame(height: 500)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        )
        .padding(.horizontal, 16)
    }

    private var cardImage: some View {
        ZStack {
            Color(red: 0.1, green: 0.05, blue: 0.15)
            if let urlStr = show.imageURL, let url = URL(string: urlStr) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFill()
                    } else {
                        Color(red: 0.1, green: 0.05, blue: 0.15)
                    }
                }
            }
        }
        .frame(height: 500)
        .clipped()
    }

    private var netflixBadge: some View {
        NetflixNBadge(size: 24)
            .padding(.leading, 14)
            .padding(.top, 14)
    }

    private var bottomOverlay: some View {
        VStack {
            Spacer()
            bottomGradient
        }
    }

    private var bottomGradient: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [.clear, .black.opacity(0.85), .black.opacity(0.95)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 200)
            bottomContent
        }
    }

    private var bottomContent: some View {
        VStack(spacing: 10) {
            titleText
            subtitleText
            buttonRow
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 18)
    }

    private var titleText: some View {
        Text(show.title.uppercased())
            .font(.system(size: 28, weight: .black, design: .default))
            .tracking(3)
            .foregroundStyle(.white)
            .shadow(color: .black.opacity(0.8), radius: 6, x: 0, y: 2)
            .multilineTextAlignment(.center)
    }

    private var subtitleText: some View {
        Text("Watch Season 5 Now")
            .font(.subheadline)
            .foregroundStyle(.white.opacity(0.8))
    }

    private var buttonRow: some View {
        HStack(spacing: 10) {
            playButton
            myListButton
        }
    }

    private var playButton: some View {
        HStack(spacing: 6) {
            Image(systemName: "play.fill").font(.callout)
            Text("Play").font(.callout).fontWeight(.semibold)
        }
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 6))
    }

    private var myListButton: some View {
        HStack(spacing: 6) {
            Image(systemName: "plus").font(.callout)
            Text("My List").font(.callout).fontWeight(.semibold)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 6))
    }
}
