import SwiftUI

// MARK: - Explore Category
struct ExploreCategory: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
    let gradient: [Color]
}

extension ExploreCategory {
    static let all: [ExploreCategory] = [
        ExploreCategory(title: "Near Me",    icon: "location.fill",      color: .pink,   gradient: [Color(red:0.99,green:0.27,blue:0.35), Color(red:0.95,green:0.1,blue:0.5)]),
        ExploreCategory(title: "Active Now", icon: "bolt.fill",          color: .green,  gradient: [Color(red:0.2,green:0.8,blue:0.5),   Color(red:0.1,green:0.6,blue:0.4)]),
        ExploreCategory(title: "Trending",   icon: "flame.fill",         color: .orange, gradient: [Color(red:0.99,green:0.6,blue:0.1),  Color(red:0.95,green:0.3,blue:0.1)]),
        ExploreCategory(title: "New Here",   icon: "sparkles",           color: .purple, gradient: [Color(red:0.6,green:0.3,blue:0.9),   Color(red:0.4,green:0.1,blue:0.7)]),
        ExploreCategory(title: "Coffee ☕",  icon: "cup.and.saucer.fill", color: .brown,  gradient: [Color(red:0.7,green:0.45,blue:0.2),  Color(red:0.5,green:0.3,blue:0.1)]),
        ExploreCategory(title: "Outdoors 🏔", icon: "leaf.fill",         color: .teal,   gradient: [Color(red:0.2,green:0.65,blue:0.6),  Color(red:0.1,green:0.4,blue:0.45)])
    ]
}

// MARK: - Explore Profile Card (lightweight)
struct ExploreCard: Identifiable {
    let id = UUID()
    let profile: Profile
    let tag: String
    let tagColor: Color
}

extension ExploreCard {
    static let trending: [ExploreCard] = [
        ExploreCard(profile: Profile.sampleProfiles[0], tag: "🔥 Hot",     tagColor: Color(red:0.99,green:0.27,blue:0.35)),
        ExploreCard(profile: Profile.sampleProfiles[2], tag: "✨ New",      tagColor: Color(red:0.6,green:0.3,blue:0.9)),
        ExploreCard(profile: Profile.sampleProfiles[4], tag: "⚡ Active",   tagColor: Color(red:0.2,green:0.75,blue:0.45)),
        ExploreCard(profile: Profile.sampleProfiles[1], tag: "🔥 Hot",     tagColor: Color(red:0.99,green:0.27,blue:0.35)),
        ExploreCard(profile: Profile.sampleProfiles[6], tag: "✨ New",      tagColor: Color(red:0.6,green:0.3,blue:0.9)),
        ExploreCard(profile: Profile.sampleProfiles[3], tag: "⚡ Active",   tagColor: Color(red:0.2,green:0.75,blue:0.45))
    ]

    static let nearby: [ExploreCard] = [
        ExploreCard(profile: Profile.sampleProfiles[5], tag: "📍 0.5 mi",  tagColor: .blue),
        ExploreCard(profile: Profile.sampleProfiles[3], tag: "📍 1 mi",    tagColor: .blue),
        ExploreCard(profile: Profile.sampleProfiles[0], tag: "📍 2 mi",    tagColor: .blue),
        ExploreCard(profile: Profile.sampleProfiles[6], tag: "📍 3 mi",    tagColor: .blue)
    ]
}
