import SwiftUI

struct RecentSearchRow: View {
    let name: String
    let detail: String
    let imageURL: String

    var body: some View {
        HStack(spacing: 12) {
            CachedAsyncImage(url: imageURL, cornerRadius: isArtist ? 25 : 4, placeholder: Color(white: 0.2))
                .frame(width: 50, height: 50)
                .clipShape(isArtist ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: 4)))
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                Text(detail)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            Spacer()
            Button {
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 2)
    }

    private var isArtist: Bool {
        detail == "Artist"
    }
}
