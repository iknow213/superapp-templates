import SwiftUI

struct CaptionOverlay: View {
    let post: VideoPost

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(post.displayName)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
            Text(post.caption)
                .font(.system(size: 14))
                .foregroundColor(.white)
                .lineLimit(2)
                .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
            musicRow
        }
        .padding(.trailing, 8)
    }

    private var musicRow: some View {
        HStack(spacing: 6) {
            Image(systemName: "music.note")
                .font(.system(size: 12))
                .foregroundColor(.white)
            Text("Original Sound — \(post.displayName)")
                .font(.system(size: 13))
                .foregroundColor(.white)
                .lineLimit(1)
        }
        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
    }
}
