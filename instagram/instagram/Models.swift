import SwiftUI

struct StoryItem: Identifiable {
    let id = UUID()
    let username: String
    let avatarURL: String
    let gradientColors: [Color]
    let isYourStory: Bool
    let isSeen: Bool

    init(username: String, avatarURL: String = "", gradientColors: [Color] = [.orange, .pink, .purple], isYourStory: Bool = false, isSeen: Bool = false) {
        self.username = username
        self.avatarURL = avatarURL
        self.gradientColors = gradientColors
        self.isYourStory = isYourStory
        self.isSeen = isSeen
    }
}

struct FeedPost: Identifiable {
    let id = UUID()
    let username: String
    let avatarURL: String
    let isVerified: Bool
    let subtitle: String
    let content: String
    let likesCount: Int
    let commentsCount: Int
    let timeAgo: String
    let imageURL: String?

    init(username: String, avatarURL: String = "", isVerified: Bool = false, subtitle: String = "", content: String, likesCount: Int, commentsCount: Int, timeAgo: String, imageURL: String? = nil) {
        self.username = username
        self.avatarURL = avatarURL
        self.isVerified = isVerified
        self.subtitle = subtitle
        self.content = content
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        self.timeAgo = timeAgo
        self.imageURL = imageURL
    }
}

struct SampleData {
    static let stories: [StoryItem] = [
        StoryItem(username: "Your story", avatarURL: "https://i.pravatar.cc/150?img=12", gradientColors: [.gray], isYourStory: true),
        StoryItem(username: "monsieurhiver", avatarURL: "https://i.pravatar.cc/150?img=3", gradientColors: [.orange, .red, .purple]),
        StoryItem(username: "dariaslabs", avatarURL: "https://i.pravatar.cc/150?img=5", gradientColors: [.orange, .pink, .purple]),
        StoryItem(username: "anastasija.to", avatarURL: "https://i.pravatar.cc/150?img=9", gradientColors: [.yellow, .orange, .red]),
        StoryItem(username: "techvibes", avatarURL: "https://i.pravatar.cc/150?img=11", gradientColors: [.blue, .purple, .pink]),
        StoryItem(username: "jess_designs", avatarURL: "https://i.pravatar.cc/150?img=23", gradientColors: [.green, .blue, .purple]),
        StoryItem(username: "marco.dev", avatarURL: "https://i.pravatar.cc/150?img=33", gradientColors: [.red, .orange, .yellow]),
    ]

    static let posts: [FeedPost] = [
        FeedPost(
            username: "artificialintelligenceee",
            avatarURL: "https://i.pravatar.cc/150?img=45",
            subtitle: ".diedlonely, Jay Karin · home",
            content: "",
            likesCount: 4821,
            commentsCount: 312,
            timeAgo: "2h",
            imageURL: "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80"
        ),
        FeedPost(
            username: "Ejaaz",
            avatarURL: "https://i.pravatar.cc/150?img=7",
            isVerified: true,
            subtitle: "@cryptopunk7213",
            content: "Apple's genius move to win AI was... do nothing.\n\n> didn't spend $100Bs on ai capex = saved $100Bs while their competitors burned cash in a race to zero.\n\n> *laughs in free cash flow and positive earnings*\n\n> pick the winning model (in this case gemini) and build the greatest AI app and hardware ecosystem the world has ever seen",
            likesCount: 18432,
            commentsCount: 1203,
            timeAgo: "5h"
        ),
        FeedPost(
            username: "swiftdev_daily",
            avatarURL: "https://i.pravatar.cc/150?img=60",
            isVerified: true,
            subtitle: "@swiftdev",
            content: "SwiftUI tip of the day:\n\nUse .sensoryFeedback() in iOS 17+ instead of UIImpactFeedbackGenerator.\n\nCleaner API, less boilerplate, and it works beautifully with animations. 🚀",
            likesCount: 2104,
            commentsCount: 89,
            timeAgo: "8h"
        ),
        FeedPost(
            username: "designmilk",
            avatarURL: "https://i.pravatar.cc/150?img=15",
            subtitle: "Featured · Architecture",
            content: "This floating house in Norway is absolutely unreal. Built on a fjord with floor-to-ceiling glass walls reflecting the mountains. Sustainable living at its finest. 🏔️",
            likesCount: 34210,
            commentsCount: 567,
            timeAgo: "12h",
            imageURL: "https://images.unsplash.com/photo-1518780664697-55e3ad937233?w=800&q=80"
        ),
        FeedPost(
            username: "natgeo",
            avatarURL: "https://i.pravatar.cc/150?img=50",
            isVerified: true,
            subtitle: "National Geographic",
            content: "The Northern Lights dancing over Iceland's glacial lagoon. Nature's most spectacular light show. 🌌",
            likesCount: 89400,
            commentsCount: 2341,
            timeAgo: "1d",
            imageURL: "https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=800&q=80"
        ),
    ]
}
