import SwiftUI

struct GenreCard: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
    let imageURL: String
}

struct SearchData {
    static let recentSearches: [(String, String, String)] = [
        ("The Weeknd", "Artist", "https://picsum.photos/seed/weeknd/80/80"),
        ("Blinding Lights", "Song • The Weeknd", "https://picsum.photos/seed/blinding/80/80"),
        ("Dua Lipa", "Artist", "https://picsum.photos/seed/dualipa/80/80"),
        ("Anti-Hero", "Song • Taylor Swift", "https://picsum.photos/seed/antihero/80/80"),
    ]

    static let topGenres: [GenreCard] = [
        GenreCard(title: "Music", color: Color(red: 0.88, green: 0.17, blue: 0.45), imageURL: "https://picsum.photos/seed/genremusic/200/200"),
        GenreCard(title: "Podcasts", color: Color(red: 0.0, green: 0.45, blue: 0.24), imageURL: "https://picsum.photos/seed/genrepod/200/200"),
        GenreCard(title: "Live Events", color: Color(red: 0.54, green: 0.17, blue: 0.89), imageURL: "https://picsum.photos/seed/genrelive/200/200"),
        GenreCard(title: "Made for You", color: Color(red: 0.07, green: 0.31, blue: 0.68), imageURL: "https://picsum.photos/seed/genreforyou/200/200"),
    ]

    static let browseAll: [GenreCard] = [
        GenreCard(title: "Pop", color: Color(red: 0.68, green: 0.17, blue: 0.89), imageURL: "https://picsum.photos/seed/gpop/200/200"),
        GenreCard(title: "Hip-Hop", color: Color(red: 0.85, green: 0.55, blue: 0.13), imageURL: "https://picsum.photos/seed/ghiphop/200/200"),
        GenreCard(title: "Rock", color: Color(red: 0.83, green: 0.22, blue: 0.22), imageURL: "https://picsum.photos/seed/grock/200/200"),
        GenreCard(title: "Latin", color: Color(red: 0.18, green: 0.72, blue: 0.53), imageURL: "https://picsum.photos/seed/glatin/200/200"),
        GenreCard(title: "Dance / Electronic", color: Color(red: 0.0, green: 0.56, blue: 0.75), imageURL: "https://picsum.photos/seed/gdance/200/200"),
        GenreCard(title: "Mood", color: Color(red: 0.32, green: 0.76, blue: 0.18), imageURL: "https://picsum.photos/seed/gmood/200/200"),
        GenreCard(title: "Indie", color: Color(red: 0.96, green: 0.67, blue: 0.23), imageURL: "https://picsum.photos/seed/gindie/200/200"),
        GenreCard(title: "Workout", color: Color(red: 0.15, green: 0.78, blue: 0.85), imageURL: "https://picsum.photos/seed/gworkout/200/200"),
        GenreCard(title: "Chill", color: Color(red: 0.57, green: 0.44, blue: 0.86), imageURL: "https://picsum.photos/seed/gchill/200/200"),
        GenreCard(title: "R&B", color: Color(red: 0.76, green: 0.13, blue: 0.51), imageURL: "https://picsum.photos/seed/grnb/200/200"),
        GenreCard(title: "Country", color: Color(red: 0.88, green: 0.62, blue: 0.32), imageURL: "https://picsum.photos/seed/gcountry/200/200"),
        GenreCard(title: "Jazz", color: Color(red: 0.24, green: 0.24, blue: 0.55), imageURL: "https://picsum.photos/seed/gjazz/200/200"),
        GenreCard(title: "K-Pop", color: Color(red: 0.95, green: 0.33, blue: 0.55), imageURL: "https://picsum.photos/seed/gkpop/200/200"),
        GenreCard(title: "Classical", color: Color(red: 0.44, green: 0.37, blue: 0.62), imageURL: "https://picsum.photos/seed/gclassical/200/200"),
    ]
}
