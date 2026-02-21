import SwiftUI

struct PhotoGridView: View {
    @EnvironmentObject var store: UserProfileStore

    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(store.photos.indices, id: \.self) { i in
                photoCell(store.photos[i], index: i)
            }
        }
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    private func photoCell(_ photo: ProfilePhoto, index: Int) -> some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let url = photo.urlString, let u = URL(string: url) {
                    AsyncImage(url: u) { phase in
                        switch phase {
                        case .success(let img):
                            img.resizable().scaledToFill()
                        default:
                            placeholderBg
                        }
                    }
                } else {
                    placeholderBg
                }
            }
            .frame(height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color(.systemGray5), lineWidth: 0.5))

            if photo.urlString != nil {
                Image(systemName: "minus.circle.fill")
                    .foregroundStyle(.white, Color(red: 0.99, green: 0.27, blue: 0.35))
                    .font(.system(size: 22))
                    .offset(x: 6, y: 6)
            } else {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(.white, Color(red: 0.99, green: 0.27, blue: 0.35))
                    .font(.system(size: 22))
                    .offset(x: 6, y: 6)
            }
        }
    }

    private var placeholderBg: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(Color(.systemGray6))
            .frame(height: 120)
            .overlay(
                Image(systemName: "camera.fill")
                    .font(.system(size: 22))
                    .foregroundColor(Color(.systemGray3))
            )
    }
}
