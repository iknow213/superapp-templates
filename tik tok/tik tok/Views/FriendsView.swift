import SwiftUI

struct FriendsView: View {
    @State private var searchText = ""

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    header
                    searchBar
                    suggestedSection
                    contactsList
                }
                .padding(.bottom, 90)
            }
        }
    }

    private var header: some View {
        HStack {
            Text("Friends")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "person.badge.plus")
                .font(.system(size: 20))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }

    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search friends", text: $searchText)
                .foregroundColor(.white)
                .font(.system(size: 15))
        }
        .padding(10)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }

    private var suggestedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Suggested for you", actionTitle: "See all")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(FriendSuggestion.samples) { s in
                        SuggestionCard(suggestion: s)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.top, 20)
    }

    private var contactsList: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionHeader(title: "Contacts on TikTok", actionTitle: "Invite")
                .padding(.top, 20)
            ForEach(FriendContact.samples) { c in
                ContactRow(contact: c)
            }
        }
    }
}

// MARK: - Section Header
private struct SectionHeader: View {
    let title: String
    let actionTitle: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
            Spacer()
            Text(actionTitle)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(hex: "FE2C55"))
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Suggestion Card
private struct SuggestionCard: View {
    let suggestion: FriendSuggestion
    @State private var followed = false

    var body: some View {
        VStack(spacing: 10) {
            dismissHeader
            avatarSection
            nameSection
            followButton
        }
        .frame(width: 160)
        .padding(.vertical, 14)
        .background(Color.white.opacity(0.06))
        .cornerRadius(12)
    }

    private var dismissHeader: some View {
        HStack {
            Spacer()
            Image(systemName: "xmark")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.gray)
                .padding(.trailing, 10)
        }
    }

    private var avatarSection: some View {
        AsyncImage(url: URL(string: suggestion.avatarURL)) { img in
            img.resizable().scaledToFill()
        } placeholder: {
            Color.gray.opacity(0.3)
        }
        .frame(width: 64, height: 64)
        .clipShape(Circle())
    }

    private var nameSection: some View {
        VStack(spacing: 2) {
            Text(suggestion.displayName)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)
            Text(suggestion.mutualText)
                .font(.system(size: 11))
                .foregroundColor(.gray)
        }
    }

    private var followButton: some View {
        Button {
            withAnimation(.spring(response: 0.3)) { followed.toggle() }
        } label: {
            Text(followed ? "Friends" : "Follow")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(followed ? .white : .white)
                .frame(width: 120, height: 34)
                .background(followed ? Color.white.opacity(0.15) : Color(hex: "FE2C55"))
                .cornerRadius(4)
        }
    }
}

// MARK: - Contact Row
private struct ContactRow: View {
    let contact: FriendContact
    @State private var added = false

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: contact.avatarURL)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                Circle().fill(Color.gray.opacity(0.3))
            }
            .frame(width: 48, height: 48)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(contact.displayName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                Text(contact.username)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            Spacer()
            Button {
                withAnimation(.spring(response: 0.3)) { added.toggle() }
            } label: {
                Text(added ? "Friends" : "Add")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(added ? .white : .white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 7)
                    .background(added ? Color.white.opacity(0.15) : Color(hex: "FE2C55"))
                    .cornerRadius(4)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

// MARK: - Models
struct FriendSuggestion: Identifiable {
    let id = UUID()
    let displayName: String
    let avatarURL: String
    let mutualText: String

    static let samples: [FriendSuggestion] = [
        .init(displayName: "Olivia Parker", avatarURL: "https://i.pravatar.cc/150?img=32", mutualText: "5 mutual friends"),
        .init(displayName: "Jake Mitchell", avatarURL: "https://i.pravatar.cc/150?img=15", mutualText: "Followed by Sara"),
        .init(displayName: "Mia Thompson", avatarURL: "https://i.pravatar.cc/150?img=25", mutualText: "12 mutual friends"),
        .init(displayName: "Ethan Brooks", avatarURL: "https://i.pravatar.cc/150?img=53", mutualText: "3 mutual friends"),
    ]
}

struct FriendContact: Identifiable {
    let id = UUID()
    let displayName: String
    let username: String
    let avatarURL: String

    static let samples: [FriendContact] = [
        .init(displayName: "Sara Chen", username: "@designwithsara", avatarURL: "https://i.pravatar.cc/150?img=5"),
        .init(displayName: "Max Developer", username: "@codewithmax", avatarURL: "https://i.pravatar.cc/150?img=12"),
        .init(displayName: "Emma Travels", username: "@travelwithme", avatarURL: "https://i.pravatar.cc/150?img=9"),
        .init(displayName: "Jay Fitness", username: "@fitnessjay", avatarURL: "https://i.pravatar.cc/150?img=3"),
        .init(displayName: "Alex Tech", username: "@techreviews", avatarURL: "https://i.pravatar.cc/150?img=8"),
        .init(displayName: "Luna Kim", username: "@lunakim_art", avatarURL: "https://i.pravatar.cc/150?img=44"),
    ]
}
