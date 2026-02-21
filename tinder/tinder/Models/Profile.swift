import SwiftUI

struct Profile: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let age: Int
    let isVerified: Bool
    let isActive: Bool
    let bio: String
    let distance: String
    let photoURLs: [String]
    let gradient: [Color]

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: Profile, rhs: Profile) -> Bool { lhs.id == rhs.id }
}

extension Profile {
    static let sampleProfiles: [Profile] = [
        Profile(
            name: "Sabrina", age: 21, isVerified: true, isActive: true,
            bio: "Dancer 💃 | Coffee addict ☕ | Let's explore the city together",
            distance: "2 miles away",
            photoURLs: [
                "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=600&q=80"
            ],
            gradient: [Color(red: 0.95, green: 0.6, blue: 0.3), Color(red: 0.85, green: 0.2, blue: 0.4)]
        ),
        Profile(
            name: "Emma", age: 24, isVerified: true, isActive: false,
            bio: "Yoga lover 🧘‍♀️ | Travel junkie ✈️ | Dog mom 🐕",
            distance: "5 miles away",
            photoURLs: [
                "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=600&q=80"
            ],
            gradient: [Color(red: 0.4, green: 0.7, blue: 0.9), Color(red: 0.2, green: 0.3, blue: 0.8)]
        ),
        Profile(
            name: "Olivia", age: 23, isVerified: false, isActive: true,
            bio: "Photographer 📸 | Sushi enthusiast 🍣 | Night owl 🦉",
            distance: "3 miles away",
            photoURLs: [
                "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=600&q=80"
            ],
            gradient: [Color(red: 0.8, green: 0.4, blue: 0.7), Color(red: 0.5, green: 0.2, blue: 0.6)]
        ),
        Profile(
            name: "Mia", age: 22, isVerified: true, isActive: true,
            bio: "Med student 🩺 | Bookworm 📚 | Sunset chaser 🌅",
            distance: "1 mile away",
            photoURLs: [
                "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=600&q=80"
            ],
            gradient: [Color(red: 0.3, green: 0.8, blue: 0.6), Color(red: 0.1, green: 0.5, blue: 0.5)]
        ),
        Profile(
            name: "Ava", age: 25, isVerified: true, isActive: false,
            bio: "Chef in training 👩‍🍳 | Vinyl collector 🎵 | Adventure seeker",
            distance: "8 miles away",
            photoURLs: [
                "https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=600&q=80"
            ],
            gradient: [Color(red: 0.9, green: 0.5, blue: 0.5), Color(red: 0.7, green: 0.2, blue: 0.3)]
        ),
        Profile(
            name: "Sofia", age: 26, isVerified: true, isActive: true,
            bio: "Artist 🎨 | Hiking enthusiast 🏔 | Foodie 🍕",
            distance: "4 miles away",
            photoURLs: [
                "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600&q=80"
            ],
            gradient: [Color(red: 0.6, green: 0.3, blue: 0.8), Color(red: 0.9, green: 0.5, blue: 0.2)]
        ),
        Profile(
            name: "Lily", age: 22, isVerified: false, isActive: true,
            bio: "Music producer 🎧 | Cat mom 🐱 | Matcha obsessed 🍵",
            distance: "6 miles away",
            photoURLs: [
                "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=600&q=80"
            ],
            gradient: [Color(red: 0.2, green: 0.6, blue: 0.8), Color(red: 0.1, green: 0.3, blue: 0.6)]
        )
    ]
}
