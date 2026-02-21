import SwiftUI
import Combine

class UserProfileStore: ObservableObject {
    @Published var name: String = "Alex"
    @Published var age: Int = 26
    @Published var bio: String = "Designer by day ✏️ | Coffee snob ☕ | Always down for a spontaneous adventure 🌍"
    @Published var occupation: String = "Product Designer"
    @Published var school: String = "NYU"
    @Published var minAge: Double = 20
    @Published var maxAge: Double = 32
    @Published var maxDistance: Double = 25
    @Published var showMeOptions: [String] = ["Women", "Men", "Everyone"]
    @Published var selectedShowMe: String = "Everyone"
    @Published var photos: [ProfilePhoto] = ProfilePhoto.defaults
    @Published var isEditing: Bool = false
}

struct ProfilePhoto: Identifiable {
    let id = UUID()
    var urlString: String?

    static let defaults: [ProfilePhoto] = [
        ProfilePhoto(urlString: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&q=80"),
        ProfilePhoto(urlString: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80"),
        ProfilePhoto(urlString: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400&q=80"),
        ProfilePhoto(urlString: nil),
        ProfilePhoto(urlString: nil),
        ProfilePhoto(urlString: nil)
    ]
}
