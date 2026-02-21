import SwiftUI

struct ActionSidebar: View {
    let post: VideoPost
    @State private var isLiked = false
    @State private var isBookmarked = false

    var body: some View {
        VStack(spacing: 18) {
            avatarButton
            likeButton
            actionButton(icon: "ellipsis.bubble.fill", label: post.commentsText)
            bookmarkButton
            actionButton(icon: "arrowshape.turn.up.right.fill", label: post.sharesText)
            musicDisc
        }
    }

    private var likeButton: some View {
        actionButton(
            icon: "heart.fill", label: post.likesText,
            isActive: isLiked, activeColor: Color(hex: "FE2C55")
        ) { isLiked.toggle() }
    }

    private var bookmarkButton: some View {
        actionButton(
            icon: "bookmark.fill", label: post.bookmarksText,
            isActive: isBookmarked, activeColor: .yellow
        ) { isBookmarked.toggle() }
    }

    private var avatarButton: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: post.avatarURL)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                default:
                    Image(systemName: "person.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
            }
            .frame(width: 46, height: 46)
            .clipShape(Circle())
            .overlay(Circle().stroke(.white, lineWidth: 1.5))
            plusBadge
        }
        .padding(.bottom, 6)
    }

    private var plusBadge: some View {
        Circle()
            .fill(Color(hex: "FE2C55"))
            .frame(width: 20, height: 20)
            .overlay(
                Image(systemName: "plus")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
            )
            .offset(y: 10)
    }

    private func actionButton(
        icon: String, label: String,
        isActive: Bool = false, activeColor: Color = .white,
        action: @escaping () -> Void = {}
    ) -> some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Image(systemName: icon)
                    .font(.system(size: 26))
                    .foregroundColor(isActive ? activeColor : .white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                Text(label)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
            }
        }
    }

    private var musicDisc: some View {
        AsyncImage(url: URL(string: post.avatarURL)) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFill()
                    .frame(width: 28, height: 28)
                    .clipShape(Circle())
            default:
                Image(systemName: "music.note")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 40, height: 40)
        .background(Color.black.opacity(0.7))
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.gray.opacity(0.4), lineWidth: 6)
        )
    }
}
