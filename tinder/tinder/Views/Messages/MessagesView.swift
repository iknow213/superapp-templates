import SwiftUI

struct MessagesView: View {
    @State private var matches = Match.sampleMatches
    @State private var searchText = ""
    @State private var selectedMatch: Match?

    private var newMatches: [Match] {
        matches.filter { $0.messages.isEmpty }
    }
    private var conversations: [Match] {
        let filtered = matches.filter { !$0.messages.isEmpty }
        if searchText.isEmpty { return filtered }
        return filtered.filter { $0.profile.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header
                Divider()
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        newMatchesSection
                        Divider().padding(.horizontal, 16)
                        messagesSection
                    }
                }
            }
            .background(Color(.systemBackground))
            .navigationDestination(item: $selectedMatch) { match in
                ChatView(match: match)
            }
        }
    }

    // MARK: - Header
    private var header: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Sparks")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(colors: [Color(red: 0.99, green: 0.27, blue: 0.35), Color(red: 0.99, green: 0.5, blue: 0.2)],
                                       startPoint: .leading, endPoint: .trailing)
                    )
                Spacer()
                Button {
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color(red: 0.99, green: 0.27, blue: 0.35))
                }
            }
            .padding(.horizontal, 16)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("Search matches...", text: $searchText)
                    .font(.system(size: 16))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 16)
        }
        .padding(.top, 16)
        .padding(.bottom, 12)
    }

    // MARK: - New Matches Row
    @ViewBuilder
    private var newMatchesSection: some View {
        if !newMatches.isEmpty {
            VStack(alignment: .leading, spacing: 10) {
                Text("New Matches")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 16)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(newMatches) { match in
                            NewMatchBubble(match: match)
                                .onTapGesture { selectedMatch = match }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 4)
                }
            }
            .padding(.vertical, 14)
        }
    }

    // MARK: - Messages Section
    private var messagesSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Messages")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.secondary)
                .padding(.horizontal, 16)
                .padding(.top, 14)
                .padding(.bottom, 6)

            ForEach(conversations) { match in
                ConversationRow(match: match)
                    .onTapGesture { selectedMatch = match }
                Divider().padding(.leading, 76)
            }
        }
    }
}

// MARK: - New Match Bubble
struct NewMatchBubble: View {
    let match: Match

    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .bottomTrailing) {
                ProfileAvatarView(url: match.profile.photoURLs.first, size: 64)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(colors: [Color(red: 0.99, green: 0.27, blue: 0.35), Color(red: 0.99, green: 0.5, blue: 0.2)],
                                               startPoint: .topLeading, endPoint: .bottomTrailing),
                                lineWidth: 2.5
                            )
                    )
                if match.profile.isActive {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 14, height: 14)
                        .overlay(Circle().stroke(Color(.systemBackground), lineWidth: 2))
                        .offset(x: 2, y: 2)
                }
            }
            Text(match.profile.name)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.primary)
        }
    }
}

// MARK: - Conversation Row
struct ConversationRow: View {
    let match: Match

    var body: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                ProfileAvatarView(url: match.profile.photoURLs.first, size: 56)
                if match.profile.isActive {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 13, height: 13)
                        .overlay(Circle().stroke(Color(.systemBackground), lineWidth: 2))
                        .offset(x: 1, y: 1)
                }
            }

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(match.profile.name)
                        .font(.system(size: 16, weight: match.hasUnread ? .bold : .semibold))
                    Spacer()
                    Text(timeAgo(match.lastMessage?.sentAt ?? match.matchedAt))
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                if let last = match.lastMessage {
                    Text(last.text)
                        .font(.system(size: 14))
                        .foregroundColor(match.hasUnread ? .primary : .secondary)
                        .lineLimit(1)
                } else {
                    Text("Say hi! 👋")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .italic()
                }
            }

            if match.hasUnread {
                Circle()
                    .fill(Color(red: 0.99, green: 0.27, blue: 0.35))
                    .frame(width: 10, height: 10)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
    }

    private func timeAgo(_ date: Date) -> String {
        let diff = Date().timeIntervalSince(date)
        if diff < 3600 { return "\(Int(diff / 60))m" }
        if diff < 86400 { return "\(Int(diff / 3600))h" }
        return "\(Int(diff / 86400))d"
    }
}
