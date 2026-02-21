import Foundation

struct VideoPost: Identifiable {
    let id = UUID()
    let username: String
    let displayName: String
    let caption: String
    let soundName: String
    let likes: Int
    let comments: Int
    let bookmarks: Int
    let shares: Int
    let gradientColors: [String]
    let imageURL: String
    let avatarURL: String

    var likesText: String { formatCount(likes) }
    var commentsText: String { formatCount(comments) }
    var bookmarksText: String { formatCount(bookmarks) }
    var sharesText: String { formatCount(shares) }

    private func formatCount(_ count: Int) -> String {
        if count >= 1_000_000 {
            return String(format: "%.1fM", Double(count) / 1_000_000)
        } else if count >= 1_000 {
            return String(format: "%.1fK", Double(count) / 1_000)
        }
        return "\(count)"
    }
}

extension VideoPost {
    static let samples: [VideoPost] = [
        VideoPost(
            username: "@nathanhodgson",
            displayName: "Nathan Hodgson",
            caption: "Figma just launched Figma Make, an AI tool that turns ideas into interacti... more",
            soundName: "ai tools to make money",
            likes: 628, comments: 5, bookmarks: 586, shares: 103,
            gradientColors: ["3A1C71", "D76D77"],
            imageURL: "https://picsum.photos/id/1025/800/1600",
            avatarURL: "https://i.pravatar.cc/150?img=11"
        ),
        VideoPost(
            username: "@designwithsara",
            displayName: "Sara Chen",
            caption: "3 design tricks that will make your app look 10x better instantly ✨ #design #ux",
            soundName: "original sound - Sara Chen",
            likes: 12400, comments: 231, bookmarks: 8900, shares: 1540,
            gradientColors: ["0F2027", "2C5364"],
            imageURL: "https://picsum.photos/id/1035/800/1600",
            avatarURL: "https://i.pravatar.cc/150?img=5"
        ),
        VideoPost(
            username: "@codewithmax",
            displayName: "Max Developer",
            caption: "Built this entire app in 24 hours using SwiftUI 🔥 Here's how #coding #swift",
            soundName: "Chill Coding Beats",
            likes: 45600, comments: 892, bookmarks: 23100, shares: 5670,
            gradientColors: ["1A1A2E", "0F3460"],
            imageURL: "https://picsum.photos/id/180/800/1600",
            avatarURL: "https://i.pravatar.cc/150?img=12"
        ),
        VideoPost(
            username: "@techreviews",
            displayName: "Alex Tech",
            caption: "iPhone 16 Pro Max vs Samsung S25 Ultra camera test! The results surprised me 📱",
            soundName: "Tech Review Soundtrack",
            likes: 89300, comments: 2100, bookmarks: 15600, shares: 8900,
            gradientColors: ["2D1B69", "9B59B6"],
            imageURL: "https://picsum.photos/id/1060/800/1600",
            avatarURL: "https://i.pravatar.cc/150?img=8"
        ),
        VideoPost(
            username: "@travelwithme",
            displayName: "Emma Travels",
            caption: "Found this hidden gem in Bali 🌴 Save for your next trip! #travel #bali",
            soundName: "Island Vibes - DJ Tropical",
            likes: 156000, comments: 3400, bookmarks: 67800, shares: 12300,
            gradientColors: ["134E5E", "2ECC71"],
            imageURL: "https://picsum.photos/id/1015/800/1600",
            avatarURL: "https://i.pravatar.cc/150?img=9"
        ),
        VideoPost(
            username: "@fitnessjay",
            displayName: "Jay Fitness",
            caption: "This 10-minute morning routine changed my life 💪 try it for 30 days #fitness",
            soundName: "Motivational Beats",
            likes: 234000, comments: 5600, bookmarks: 98000, shares: 18700,
            gradientColors: ["141E30", "243B55"],
            imageURL: "https://picsum.photos/id/1074/800/1600",
            avatarURL: "https://i.pravatar.cc/150?img=3"
        )
    ]
}
