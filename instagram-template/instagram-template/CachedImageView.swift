import SwiftUI

struct CachedImageView: View {
    let url: String
    var contentMode: ContentMode = .fill

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .success(let image):
                image.resizable().aspectRatio(contentMode: contentMode)
            case .failure:
                fallbackView
            case .empty:
                loadingView
            @unknown default:
                loadingView
            }
        }
    }

    private var loadingView: some View {
        Rectangle()
            .fill(Color(white: 0.15))
            .overlay(ProgressView().tint(.gray))
    }

    private var fallbackView: some View {
        Rectangle()
            .fill(Color(white: 0.15))
            .overlay(
                Image(systemName: "photo")
                    .foregroundStyle(.gray)
            )
    }
}

struct AvatarView: View {
    let url: String
    let size: CGFloat

    var body: some View {
        CachedImageView(url: url)
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}
