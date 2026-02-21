import SwiftUI

enum LibraryFilter: String, CaseIterable, Identifiable {
    case playlists = "Playlists"
    case artists = "Artists"
    case albums = "Albums"
    case podcastsShows = "Podcasts & Shows"
    var id: String { rawValue }
}

enum LibrarySortOption: String, CaseIterable {
    case recents = "Recents"
    case recentlyAdded = "Recently Added"
    case alphabetical = "Alphabetical"
    case creator = "Creator"
}

struct LibraryItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageURL: String
    let isPinned: Bool
    let type: LibraryItemType
}

enum LibraryItemType {
    case playlist, artist, album, podcast
}

struct LibraryData {
    static let items: [LibraryItem] = [
        LibraryItem(title: "Liked Songs", subtitle: "Playlist • 247 songs", imageURL: "", isPinned: true, type: .playlist),
        LibraryItem(title: "Your Episodes", subtitle: "Saved & downloaded episodes", imageURL: "", isPinned: true, type: .podcast),
        LibraryItem(title: "Discover Weekly", subtitle: "Playlist • Spotify", imageURL: "https://picsum.photos/seed/libdiscover/120/120", isPinned: false, type: .playlist),
        LibraryItem(title: "The Weeknd", subtitle: "Artist", imageURL: "https://picsum.photos/seed/libweeknd/120/120", isPinned: false, type: .artist),
        LibraryItem(title: "Chill Vibes", subtitle: "Playlist • Spotify", imageURL: "https://picsum.photos/seed/libchill/120/120", isPinned: false, type: .playlist),
        LibraryItem(title: "Dua Lipa", subtitle: "Artist", imageURL: "https://picsum.photos/seed/libdua/120/120", isPinned: false, type: .artist),
        LibraryItem(title: "Future Nostalgia", subtitle: "Album • Dua Lipa", imageURL: "https://picsum.photos/seed/libfuture/120/120", isPinned: false, type: .album),
        LibraryItem(title: "Lex Fridman Podcast", subtitle: "Podcast • Lex Fridman", imageURL: "https://picsum.photos/seed/liblex/120/120", isPinned: false, type: .podcast),
        LibraryItem(title: "RapCaviar", subtitle: "Playlist • Spotify", imageURL: "https://picsum.photos/seed/librapcav/120/120", isPinned: false, type: .playlist),
        LibraryItem(title: "Taylor Swift", subtitle: "Artist", imageURL: "https://picsum.photos/seed/libtaylor/120/120", isPinned: false, type: .artist),
        LibraryItem(title: "After Hours", subtitle: "Album • The Weeknd", imageURL: "https://picsum.photos/seed/libafterhrs/120/120", isPinned: false, type: .album),
        LibraryItem(title: "Daily Drive", subtitle: "Playlist • Spotify", imageURL: "https://picsum.photos/seed/libdaily/120/120", isPinned: false, type: .playlist),
    ]
}
