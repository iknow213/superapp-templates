import SwiftUI

struct CachedAsyncImage: View {
    let url: String?
    let cornerRadius: CGFloat
    var placeholder: Color

    init(url: String?, cornerRadius: CGFloat = 0, placeholder: Color = Color(white: 0.2)) {
        self.url = url
        self.cornerRadius = cornerRadius
        self.placeholder = placeholder
    }

    var body: some View {
        if let urlStr = url, let imageURL = URL(string: urlStr) {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure:
                    placeholderView
                case .empty:
                    shimmerView
                @unknown default:
                    placeholderView
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        } else {
            placeholderView
        }
    }

    private var placeholderView: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(placeholder.gradient)
    }

    private var shimmerView: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(placeholder.opacity(0.5))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
            )
    }
}
