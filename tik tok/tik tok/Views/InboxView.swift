import SwiftUI

struct InboxView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    inboxHeader
                    activitySection
                    messagesSection
                }
                .padding(.bottom, 90)
            }
        }
    }

    private var inboxHeader: some View {
        HStack {
            Text("Inbox")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "paperplane")
                .font(.system(size: 20))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }

    private var activitySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            ActivityRow(
                icon: "heart.fill",
                iconColor: Color(hex: "FE2C55"),
                title: "Activity",
                subtitle: "codewithmax liked your video",
                time: "2h"
            )
            ActivityRow(
                icon: "person.fill.badge.plus",
                iconColor: Color(hex: "25F4EE"),
                title: "New followers",
                subtitle: "lunakim_art and 3 others",
                time: "5h"
            )
            ActivityRow(
                icon: "at",
                iconColor: Color(hex: "FFC107"),
                title: "Mentions & Tags",
                subtitle: "designwithsara mentioned you",
                time: "1d"
            )
        }
        .padding(.top, 16)
    }

    private var messagesSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Messages")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Text("Requests (3)")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 12)

            ForEach(InboxMessage.samples) { msg in
                MessageRow(message: msg)
            }
        }
    }
}

// MARK: - Activity Row
private struct ActivityRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let time: String

    var body: some View {
        HStack(spacing: 12) {
            iconBubble
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            Spacer()
            Text(time)
                .font(.system(size: 12))
                .foregroundColor(.gray)
            Image(systemName: "chevron.right")
                .font(.system(size: 12))
                .foregroundColor(.gray.opacity(0.5))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }

    private var iconBubble: some View {
        ZStack {
            Circle()
                .fill(iconColor.opacity(0.15))
                .frame(width: 48, height: 48)
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(iconColor)
        }
    }
}

// MARK: - Message Row
private struct MessageRow: View {
    let message: InboxMessage

    var body: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: message.avatarURL)) { img in
                    img.resizable().scaledToFill()
                } placeholder: {
                    Circle().fill(Color.gray.opacity(0.3))
                }
                .frame(width: 52, height: 52)
                .clipShape(Circle())

                if message.isOnline {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 12, height: 12)
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                }
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(message.displayName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                Text(message.lastMessage)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(message.time)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                if message.unread > 0 {
                    Text("\(message.unread)")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                        .background(Color(hex: "FE2C55"))
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

// MARK: - Model
struct InboxMessage: Identifiable {
    let id = UUID()
    let displayName: String
    let avatarURL: String
    let lastMessage: String
    let time: String
    let unread: Int
    let isOnline: Bool

    static let samples: [InboxMessage] = [
        .init(displayName: "Sara Chen", avatarURL: "https://i.pravatar.cc/150?img=5",
              lastMessage: "Loved the new design! Can you share the file? 🎨", time: "2m", unread: 2, isOnline: true),
        .init(displayName: "Max Developer", avatarURL: "https://i.pravatar.cc/150?img=12",
              lastMessage: "Check out this SwiftUI trick", time: "15m", unread: 1, isOnline: true),
        .init(displayName: "Emma Travels", avatarURL: "https://i.pravatar.cc/150?img=9",
              lastMessage: "The Bali trip was amazing!! 🌴", time: "1h", unread: 0, isOnline: false),
        .init(displayName: "Jay Fitness", avatarURL: "https://i.pravatar.cc/150?img=3",
              lastMessage: "Let's collab on the next workout video", time: "3h", unread: 0, isOnline: false),
        .init(displayName: "Alex Tech", avatarURL: "https://i.pravatar.cc/150?img=8",
              lastMessage: "Did you see the new iPhone leak? 📱", time: "5h", unread: 0, isOnline: true),
        .init(displayName: "Luna Kim", avatarURL: "https://i.pravatar.cc/150?img=44",
              lastMessage: "Thanks for the shoutout!! 💕", time: "1d", unread: 0, isOnline: false),
        .init(displayName: "Nathan Hodgson", avatarURL: "https://i.pravatar.cc/150?img=11",
              lastMessage: "Sent you the AI tools list", time: "2d", unread: 0, isOnline: false),
    ]
}
