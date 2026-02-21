import SwiftUI

struct NewMusicSection: View {
    let playlists: [PlaylistCover]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle
            horizontalScroll
        }
    }

    private var sectionTitle: some View {
        Text("It's New Music Friday!")
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 16)
    }

    private var horizontalScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(playlists) { playlist in
                    PlaylistCard(playlist: playlist)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct PlaylistCard: View {
    let playlist: PlaylistCover

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            artworkView
        }
        .frame(width: 160)
    }

    private var artworkView: some View {
        ZStack(alignment: .topLeading) {
            CachedAsyncImage(url: playlist.imageURL, cornerRadius: 6, placeholder: playlist.color)
                .frame(width: 160, height: 160)
            spotifyBadge
        }
    }

    private var spotifyBadge: some View {
        Circle()
            .fill(Color(red: 0.11, green: 0.84, blue: 0.38))
            .frame(width: 22, height: 22)
            .overlay(
                Image(systemName: "music.note")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
            )
            .padding(8)
    }
}
