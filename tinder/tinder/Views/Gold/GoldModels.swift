import SwiftUI

// MARK: - Gold Plan
struct GoldPlan: Identifiable {
    let id = UUID()
    let duration: String
    let price: String
    let perMonth: String
    let badge: String?
    let isPopular: Bool
}

extension GoldPlan {
    static let plans: [GoldPlan] = [
        GoldPlan(duration: "1 Month",  price: "$29.99", perMonth: "$29.99/mo", badge: nil,          isPopular: false),
        GoldPlan(duration: "6 Months", price: "$89.99", perMonth: "$15.00/mo", badge: "BEST VALUE",  isPopular: true),
        GoldPlan(duration: "12 Months",price: "$149.99",perMonth: "$12.50/mo", badge: "SAVE 58%",    isPopular: false)
    ]
}

// MARK: - Boost Type
struct BoostItem: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let description: String
    let color: Color
    let gradient: [Color]
    let price: String
    let multiplier: String
}

extension BoostItem {
    static let all: [BoostItem] = [
        BoostItem(
            name: "Boost",
            icon: "bolt.fill",
            description: "Be a top profile for 30 minutes",
            color: Color(red: 0.55, green: 0.35, blue: 0.95),
            gradient: [Color(red: 0.55, green: 0.35, blue: 0.95), Color(red: 0.35, green: 0.15, blue: 0.75)],
            price: "$3.99",
            multiplier: "10×"
        ),
        BoostItem(
            name: "Super Boost",
            icon: "flame.fill",
            description: "Top profile for 3 hours",
            color: Color(red: 0.99, green: 0.45, blue: 0.1),
            gradient: [Color(red: 0.99, green: 0.55, blue: 0.1), Color(red: 0.85, green: 0.2, blue: 0.1)],
            price: "$9.99",
            multiplier: "100×"
        ),
        BoostItem(
            name: "Super Like",
            icon: "star.fill",
            description: "Stand out from the crowd",
            color: Color(red: 0.1, green: 0.6, blue: 0.95),
            gradient: [Color(red: 0.2, green: 0.65, blue: 0.99), Color(red: 0.1, green: 0.35, blue: 0.8)],
            price: "$0.99",
            multiplier: "3×"
        )
    ]
}

// MARK: - Gold Feature
struct GoldFeature: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
    let color: Color
}

extension GoldFeature {
    static let all: [GoldFeature] = [
        GoldFeature(icon: "heart.fill",        title: "See Who Likes You",    description: "Skip the guessing — see everyone who already swiped right on you",   color: Color(red:0.99,green:0.27,blue:0.35)),
        GoldFeature(icon: "arrow.uturn.left",  title: "Unlimited Rewinds",    description: "Accidentally swiped left? Take it back instantly",                  color: Color(red:0.99,green:0.6,blue:0.1)),
        GoldFeature(icon: "checkmark.seal.fill", title: "Passport",             description: "Match with anyone, anywhere in the world",                           color: Color(red:0.55,green:0.35,blue:0.95)),
        GoldFeature(icon: "eye.slash.fill",    title: "Incognito Mode",       description: "Browse profiles without being seen until you like them",             color: Color(red:0.2,green:0.2,blue:0.2)),
        GoldFeature(icon: "bolt.fill",         title: "1 Free Boost/Month",   description: "Get seen by up to 10× more people every month",                     color: Color(red:0.99,green:0.45,blue:0.1)),
        GoldFeature(icon: "hand.thumbsup.fill", title: "Priority Likes",      description: "Your profile gets shown first to the people you like",               color: Color(red:0.1,green:0.7,blue:0.45))
    ]
}

// MARK: - Liker (blurred profile who liked you)
struct Liker: Identifiable {
    let id = UUID()
    let profile: Profile
    let timeAgo: String
    let isNew: Bool
}

extension Liker {
    static let all: [Liker] = [
        Liker(profile: Profile.sampleProfiles[0], timeAgo: "2m ago",  isNew: true),
        Liker(profile: Profile.sampleProfiles[2], timeAgo: "15m ago", isNew: true),
        Liker(profile: Profile.sampleProfiles[4], timeAgo: "1h ago",  isNew: false),
        Liker(profile: Profile.sampleProfiles[1], timeAgo: "2h ago",  isNew: false),
        Liker(profile: Profile.sampleProfiles[6], timeAgo: "3h ago",  isNew: false),
        Liker(profile: Profile.sampleProfiles[3], timeAgo: "5h ago",  isNew: false),
        Liker(profile: Profile.sampleProfiles[5], timeAgo: "8h ago",  isNew: false),
        Liker(profile: Profile.sampleProfiles[0], timeAgo: "1d ago",  isNew: false),
        Liker(profile: Profile.sampleProfiles[2], timeAgo: "1d ago",  isNew: false)
    ]
}
