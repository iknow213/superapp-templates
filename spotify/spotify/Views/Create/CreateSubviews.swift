import SwiftUI

// MARK: - Create Option Model

struct CreateOption: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let subtitle: String
    let iconColor: Color

    static let all: [CreateOption] = [
        CreateOption(icon: "music.note.list", title: "Playlist", subtitle: "Build a playlist with songs you love", iconColor: Color(red: 0.12, green: 0.84, blue: 0.38)),
        CreateOption(icon: "person.2.fill", title: "Blend", subtitle: "Combine tastes with friends", iconColor: .orange),
        CreateOption(icon: "mic.fill", title: "Podcast Playlist", subtitle: "Create a playlist of podcast episodes", iconColor: .purple),
        CreateOption(icon: "waveform", title: "AI Playlist", subtitle: "Let AI make the perfect mix for you", iconColor: .cyan),
    ]
}

// MARK: - Option Row

struct CreateOptionRow: View {
    let option: CreateOption

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: option.icon)
                .font(.system(size: 18))
                .foregroundColor(option.iconColor)
                .frame(width: 40, height: 40)
                .background(Color(white: 0.15))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 2) {
                Text(option.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                Text(option.subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 13))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 12)
    }
}

// MARK: - Playlist data

struct CreatePlaylistItem: Identifiable {
    let id = UUID()
    let title: String
    let songCount: Int
    let imageURL: String
}

struct CreateData {
    static let playlists: [CreatePlaylistItem] = [
        CreatePlaylistItem(title: "Road Trip Mix", songCount: 34, imageURL: "https://picsum.photos/seed/cpl1/120/120"),
        CreatePlaylistItem(title: "Workout Energy", songCount: 52, imageURL: "https://picsum.photos/seed/cpl2/120/120"),
        CreatePlaylistItem(title: "Late Night Chill", songCount: 28, imageURL: "https://picsum.photos/seed/cpl3/120/120"),
        CreatePlaylistItem(title: "Focus Flow", songCount: 41, imageURL: "https://picsum.photos/seed/cpl4/120/120"),
    ]
}

// MARK: - Playlist Row

struct PlaylistRow: View {
    let playlist: CreatePlaylistItem

    var body: some View {
        HStack(spacing: 12) {
            CachedAsyncImage(url: playlist.imageURL, cornerRadius: 4, placeholder: Color(white: 0.2))
                .frame(width: 56, height: 56)
            VStack(alignment: .leading, spacing: 2) {
                Text(playlist.title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text("Playlist • \(playlist.songCount) songs")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "ellipsis")
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}
