import SwiftUI

struct PostView: View {
    let post: FeedPost
    @State private var isLiked = false
    @State private var isBookmarked = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PostHeader(post: post)
            if let url = post.imageURL { postImage(url: url) }
            if !post.content.isEmpty { postContent }
            PostActions(isLiked: $isLiked, isBookmarked: $isBookmarked)
            postFooter
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black)
    }

    private func postImage(url: String) -> some View {
        GeometryReader { geo in
            CachedImageView(url: url, contentMode: .fill)
                .frame(width: geo.size.width, height: geo.size.width)
                .clipped()
        }
        .aspectRatio(1, contentMode: .fit)
    }

    private var postContent: some View {
        Text(post.content)
            .font(.subheadline)
            .foregroundStyle(.white)
            .padding(.horizontal, 14)
            .padding(.top, 10)
            .lineSpacing(3)
    }

    private var postFooter: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(post.likesCount.formatted()) likes")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
            Text(post.timeAgo + " ago")
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 14)
        .padding(.top, 6)
        .padding(.bottom, 14)
    }
}

struct PostHeader: View {
    let post: FeedPost

    var body: some View {
        HStack(spacing: 10) {
            AvatarView(url: post.avatarURL, size: 36)
            headerText
            Spacer()
            moreButton
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
    }

    private var headerText: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Text(post.username)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                if post.isVerified {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
            }
            if !post.subtitle.isEmpty {
                Text(post.subtitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
        }
    }

    private var moreButton: some View {
        Image(systemName: "ellipsis")
            .foregroundStyle(.white)
            .font(.subheadline)
    }
}

struct PostActions: View {
    @Binding var isLiked: Bool
    @Binding var isBookmarked: Bool

    var body: some View {
        HStack(spacing: 16) {
            actionButton(icon: isLiked ? "heart.fill" : "heart", tint: isLiked ? .red : .white) {
                isLiked.toggle()
            }
            actionButton(icon: "bubble.right", tint: .white) {}
            actionButton(icon: "paperplane", tint: .white) {}
            Spacer()
            actionButton(icon: isBookmarked ? "bookmark.fill" : "bookmark", tint: .white) {
                isBookmarked.toggle()
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, 10)
    }

    private func actionButton(icon: String, tint: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(tint)
        }
    }
}
