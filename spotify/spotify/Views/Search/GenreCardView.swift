import SwiftUI

struct GenreCardView: View {
    let card: GenreCard

    var body: some View {
        ZStack(alignment: .topLeading) {
            card.color
            imageOverlay
            Text(card.title)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
                .padding(10)
                .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 1)
        }
        .frame(height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var imageOverlay: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                CachedAsyncImage(url: card.imageURL, cornerRadius: 4, placeholder: card.color)
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(20))
                    .offset(x: 10, y: 10)
            }
        }
    }
}
