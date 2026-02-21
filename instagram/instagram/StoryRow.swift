import SwiftUI

struct StoryRow: View {
    let stories: [StoryItem]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(stories) { story in
                    StoryBubble(story: story)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
        }
    }
}

struct StoryBubble: View {
    let story: StoryItem

    var body: some View {
        VStack(spacing: 6) {
            avatarView
            usernameLabel
        }
        .frame(width: 76)
    }

    private var avatarView: some View {
        ZStack(alignment: .bottomTrailing) {
            avatarCircle
            if story.isYourStory { plusBadge }
        }
    }

    private var avatarCircle: some View {
        ZStack {
            let grad = LinearGradient(
                colors: story.isYourStory ? [.clear] : story.gradientColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Circle().stroke(grad, lineWidth: story.isYourStory ? 0 : 3)
                .frame(width: 72, height: 72)

            AvatarView(url: story.avatarURL, size: 64)
        }
    }

    private var plusBadge: some View {
        ZStack {
            Circle().fill(.black).frame(width: 24, height: 24)
            Circle().fill(.white).frame(width: 20, height: 20)
            Image(systemName: "plus")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(.black)
        }
        .offset(x: 2, y: 2)
    }

    private var usernameLabel: some View {
        Text(story.username)
            .font(.caption2)
            .foregroundStyle(.white.opacity(0.85))
            .lineLimit(1)
    }
}
