import SwiftUI

struct Show: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
    let initials: String
    var imageURL: String? = nil
}

struct ContentRow: Identifiable {
    let id = UUID()
    let title: String
    let shows: [Show]
    let isTop10: Bool
}

enum SampleData {
    static let featuredShow = Show(
        title: "Stranger Things",
        color: .red,
        initials: "ST",
        imageURL: "https://static.wikia.nocookie.net/strangerthings8338/images/5/51/Season_5_Teaser_Poster.jpg/revision/latest?cb=20250715203311"
    )

    static let trendingNow: [Show] = [
        Show(title: "Suits", color: Color(red: 0.2, green: 0.25, blue: 0.35), initials: "SU",
             imageURL: "https://upload.wikimedia.org/wikipedia/en/c/cf/Suits_season_5_dvd.jpg"),
        Show(title: "Stranger Things", color: Color(red: 0.4, green: 0.1, blue: 0.15), initials: "ST",
             imageURL: "https://upload.wikimedia.org/wikipedia/en/7/78/Stranger_Things_season_4.jpg"),
        Show(title: "The Lincoln Lawyer", color: Color(red: 0.3, green: 0.35, blue: 0.3), initials: "LL",
             imageURL: "https://www.michaelconnelly.com/wp-content/uploads/2024/10/EN-US_TLNLR-S3_Main_Square_1X1_RGB_POST.jpg"),
        Show(title: "Peaky Blinders", color: Color(red: 0.15, green: 0.15, blue: 0.18), initials: "PB",
             imageURL: "https://static.posters.cz/image/1300/132718.jpg"),
        Show(title: "Breaking Bad", color: Color(red: 0.15, green: 0.25, blue: 0.15), initials: "BB",
             imageURL: "https://m.media-amazon.com/images/I/91EtQD0P0dL._AC_UF894,1000_QL80_.jpg"),
    ]

    static let romanticKDrama: [Show] = [
        Show(title: "Twenty Five\nTwenty One", color: Color(red: 0.5, green: 0.4, blue: 0.3), initials: "25"),
        Show(title: "The Interest\nof Love", color: Color(red: 0.25, green: 0.2, blue: 0.35), initials: "IL"),
        Show(title: "It's Okay to\nNot Be Okay", color: Color(red: 0.3, green: 0.25, blue: 0.25), initials: "OK"),
        Show(title: "Crash Landing\non You", color: Color(red: 0.2, green: 0.35, blue: 0.3), initials: "CL"),
        Show(title: "Hometown Cha\nCha Cha", color: Color(red: 0.4, green: 0.35, blue: 0.2), initials: "HC"),
    ]

    static let top10Films: [Show] = [
        Show(title: "Luther:\nThe Fallen Sun", color: Color(red: 0.35, green: 0.2, blue: 0.15), initials: "LF"),
        Show(title: "We Have\na Ghost", color: Color(red: 0.15, green: 0.25, blue: 0.3), initials: "WG"),
        Show(title: "Far From\nHome", color: Color(red: 0.3, green: 0.15, blue: 0.15), initials: "FH"),
        Show(title: "Glass Onion", color: Color(red: 0.4, green: 0.3, blue: 0.1), initials: "GO"),
        Show(title: "The Pale\nBlue Eye", color: Color(red: 0.15, green: 0.2, blue: 0.35), initials: "PB"),
    ]

    static let continueWatching: [Show] = [
        Show(title: "Wednesday", color: Color(red: 0.2, green: 0.15, blue: 0.3), initials: "WD"),
        Show(title: "Emily in Paris", color: Color(red: 0.5, green: 0.25, blue: 0.35), initials: "EP"),
        Show(title: "You", color: Color(red: 0.3, green: 0.15, blue: 0.15), initials: "YO"),
        Show(title: "The Crown", color: Color(red: 0.35, green: 0.3, blue: 0.15), initials: "TC"),
    ]

    static let myList: [Show] = [
        Show(title: "Dark", color: Color(red: 0.15, green: 0.18, blue: 0.22), initials: "DK"),
        Show(title: "Ozark", color: Color(red: 0.1, green: 0.25, blue: 0.2), initials: "OZ"),
        Show(title: "Mindhunter", color: Color(red: 0.2, green: 0.18, blue: 0.25), initials: "MH"),
        Show(title: "Narcos", color: Color(red: 0.3, green: 0.25, blue: 0.1), initials: "NC"),
    ]

    static let rows: [ContentRow] = [
        ContentRow(title: "Trending Now", shows: trendingNow, isTop10: false),
        ContentRow(title: "Romantic Korean TV Programmes", shows: romanticKDrama, isTop10: false),
        ContentRow(title: "Top 10 Films Today", shows: top10Films, isTop10: true),
        ContentRow(title: "Continue Watching", shows: continueWatching, isTop10: false),
        ContentRow(title: "My List", shows: myList, isTop10: false),
    ]
}
