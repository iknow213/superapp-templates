import SwiftUI

struct MediaItem: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
    let icon: String?
    let hasEqualizer: Bool
    let imageURL: String?

    init(title: String, color: Color, icon: String? = nil, hasEqualizer: Bool = false, imageURL: String? = nil) {
        self.title = title
        self.color = color
        self.icon = icon
        self.hasEqualizer = hasEqualizer
        self.imageURL = imageURL
    }
}

struct PodcastEpisode: Identifiable {
    let id = UUID()
    let showTitle: String
    let episodeTitle: String
    let description: String
    let color: Color
    let imageURL: String?

    init(showTitle: String, episodeTitle: String, description: String, color: Color, imageURL: String? = nil) {
        self.showTitle = showTitle
        self.episodeTitle = episodeTitle
        self.description = description
        self.color = color
        self.imageURL = imageURL
    }
}

struct PlaylistCover: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
    let imageURL: String?

    init(title: String, color: Color, imageURL: String? = nil) {
        self.title = title
        self.color = color
        self.imageURL = imageURL
    }
}

enum FilterChip: String, CaseIterable, Identifiable {
    case all = "All"
    case music = "Music"
    case podcasts = "Podcasts"
    var id: String { rawValue }
}
