import SwiftUI

struct ProfileView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    profileHeader
                    statsRow
                    actionButtons
                    bioSection
                    contentTabs
                    videoGrid
                }
                .padding(.bottom, 90)
            }
        }
    }

    private var profileHeader: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "person.badge.plus")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                Spacer()
                Text("@myprofile")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)

            AsyncImage(url: URL(string: "https://i.pravatar.cc/150?img=33")) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                Circle().fill(Color.gray.opacity(0.3))
            }
            .frame(width: 96, height: 96)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white.opacity(0.1), lineWidth: 1))
        }
    }

    private var statsRow: some View {
        HStack(spacing: 28) {
            StatItem(value: "127", label: "Following")
            StatItem(value: "14.2K", label: "Followers")
            StatItem(value: "328K", label: "Likes")
        }
        .padding(.top, 16)
    }

    private var actionButtons: some View {
        HStack(spacing: 8) {
            ProfileActionButton(title: "Edit profile", isPrimary: true)
            ProfileActionButton(title: "Share profile", isPrimary: false)
            bookmarkButton
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

    private var bookmarkButton: some View {
        Image(systemName: "bookmark")
            .font(.system(size: 14))
            .foregroundColor(.white)
            .frame(width: 44, height: 38)
            .background(Color.white.opacity(0.1))
            .cornerRadius(4)
    }

    private var bioSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Creative developer & designer ✨")
                .font(.system(size: 13))
                .foregroundColor(.white)
            Text("Building cool stuff with SwiftUI 🚀")
                .font(.system(size: 13))
                .foregroundColor(.white)
            HStack(spacing: 4) {
                Image(systemName: "link")
                    .font(.system(size: 11))
                Text("myportfolio.design")
                    .font(.system(size: 13))
            }
            .foregroundColor(Color(hex: "25F4EE"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }

    private var contentTabs: some View {
        HStack(spacing: 0) {
            ProfileTabButton(icon: "squareshape.split.3x3", isSelected: selectedTab == 0)
                .onTapGesture { selectedTab = 0 }
            ProfileTabButton(icon: "lock", isSelected: selectedTab == 1)
                .onTapGesture { selectedTab = 1 }
            ProfileTabButton(icon: "heart", isSelected: selectedTab == 2)
                .onTapGesture { selectedTab = 2 }
        }
        .padding(.top, 20)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.white.opacity(0.08)).frame(height: 0.5)
        }
    }

    private var videoGrid: some View {
        ProfileVideoGrid(tabIndex: selectedTab)
    }
}

// MARK: - Stat Item
private struct StatItem: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Action Button
private struct ProfileActionButton: View {
    let title: String
    let isPrimary: Bool

    var body: some View {
        Text(title)
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 38)
            .background(isPrimary ? Color(hex: "FE2C55") : Color.white.opacity(0.1))
            .cornerRadius(4)
    }
}

// MARK: - Tab Button
private struct ProfileTabButton: View {
    let icon: String
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(isSelected ? .white : .gray)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
            Rectangle()
                .fill(isSelected ? Color.white : Color.clear)
                .frame(height: 1.5)
        }
    }
}

// MARK: - Video Grid
private struct ProfileVideoGrid: View {
    let tabIndex: Int
    private let columns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]

    var body: some View {
        Group {
            if tabIndex == 0 {
                gridContent
            } else if tabIndex == 1 {
                emptyState(icon: "lock.fill", text: "Private videos")
            } else {
                emptyState(icon: "heart.fill", text: "Liked videos are private")
            }
        }
    }

    private var gridContent: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(ProfileVideo.samples) { video in
                ProfileVideoThumbnail(video: video)
            }
        }
        .padding(.top, 2)
    }

    private func emptyState(icon: String, text: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 36))
                .foregroundColor(.gray.opacity(0.4))
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }
}

// MARK: - Video Thumbnail
private struct ProfileVideoThumbnail: View {
    let video: ProfileVideo

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: video.thumbnailURL)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                Rectangle().fill(Color.gray.opacity(0.2))
            }
            .frame(height: 160)
            .clipped()

            HStack(spacing: 3) {
                Image(systemName: "play.fill")
                    .font(.system(size: 9))
                Text(video.viewsText)
                    .font(.system(size: 12, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding(4)
        }
    }
}

// MARK: - Model
struct ProfileVideo: Identifiable {
    let id = UUID()
    let thumbnailURL: String
    let views: Int

    var viewsText: String {
        if views >= 1_000_000 {
            return String(format: "%.1fM", Double(views) / 1_000_000)
        } else if views >= 1_000 {
            return String(format: "%.1fK", Double(views) / 1_000)
        }
        return "\(views)"
    }

    static let samples: [ProfileVideo] = [
        .init(thumbnailURL: "https://picsum.photos/id/237/400/600", views: 45200),
        .init(thumbnailURL: "https://picsum.photos/id/1015/400/600", views: 128000),
        .init(thumbnailURL: "https://picsum.photos/id/1025/400/600", views: 8900),
        .init(thumbnailURL: "https://picsum.photos/id/1035/400/600", views: 234000),
        .init(thumbnailURL: "https://picsum.photos/id/180/400/600", views: 67400),
        .init(thumbnailURL: "https://picsum.photos/id/1060/400/600", views: 12100),
        .init(thumbnailURL: "https://picsum.photos/id/1074/400/600", views: 890000),
        .init(thumbnailURL: "https://picsum.photos/id/119/400/600", views: 3400),
        .init(thumbnailURL: "https://picsum.photos/id/164/400/600", views: 56700),
    ]
}
