import SwiftUI

struct SampleData {
    static let quickAccessItems: [MediaItem] = [
        MediaItem(title: "Liked Songs", color: .purple, icon: "heart.fill",
                  imageURL: nil),
        MediaItem(title: "Мікс рок-музики", color: .orange, hasEqualizer: true,
                  imageURL: "https://picsum.photos/seed/rockmix/120/120"),
        MediaItem(title: "Мікс дня 3", color: .blue,
                  imageURL: "https://picsum.photos/seed/dailymix3/120/120"),
        MediaItem(title: "daylist", color: Color(red: 0.9, green: 0.7, blue: 0.2),
                  imageURL: "https://picsum.photos/seed/daylist/120/120"),
        MediaItem(title: "#491 — OpenClaw: The...", color: .gray,
                  imageURL: "https://picsum.photos/seed/lexfridman/120/120"),
        MediaItem(title: "Discover Weekly", color: Color(red: 0.2, green: 0.6, blue: 0.3),
                  imageURL: "https://picsum.photos/seed/discover/120/120"),
        MediaItem(title: "The Last Dinner Party", color: .pink,
                  imageURL: "https://picsum.photos/seed/dinnerparty/120/120"),
        MediaItem(title: "Coco", color: Color(red: 0.6, green: 0.5, blue: 0.4),
                  imageURL: "https://picsum.photos/seed/coco/120/120"),
    ]

    static let podcastEpisode = PodcastEpisode(
        showTitle: "Outpacing the Internet",
        episodeTitle: "Ben Horowitz: xAI Executive Exodus, Ap...",
        description: "In this episode, the ma...",
        color: Color(red: 0.8, green: 0.7, blue: 0.2),
        imageURL: "https://picsum.photos/seed/podcast491/320/320"
    )

    static let newMusicPlaylists: [PlaylistCover] = [
        PlaylistCover(title: "New Music Friday",
                      color: Color(red: 0.8, green: 0.3, blue: 0.3),
                      imageURL: "https://picsum.photos/seed/nmf1/320/320"),
        PlaylistCover(title: "New Music Friday UK",
                      color: Color(red: 0.5, green: 0.2, blue: 0.6),
                      imageURL: "https://picsum.photos/seed/nmf2/320/320"),
        PlaylistCover(title: "Release Radar",
                      color: Color(red: 0.2, green: 0.5, blue: 0.7),
                      imageURL: "https://picsum.photos/seed/radar/320/320"),
        PlaylistCover(title: "Fresh Finds",
                      color: Color(red: 0.3, green: 0.7, blue: 0.5),
                      imageURL: "https://picsum.photos/seed/freshfinds/320/320"),
    ]

    static let nowPlaying = (
        title: "Click and Advance",
        artist: "Favourite People",
        device: "MacBook Pro (5)",
        imageURL: "https://picsum.photos/seed/nowplaying/100/100"
    )
}
