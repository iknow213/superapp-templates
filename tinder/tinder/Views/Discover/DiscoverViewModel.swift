import SwiftUI

class DiscoverViewModel: ObservableObject {
    @Published var profiles: [Profile] = Profile.sampleProfiles

    func removeTop(direction: SwipeDirection) {
        guard !profiles.isEmpty else { return }
        withAnimation(.easeInOut(duration: 0.3)) {
            profiles.removeLast()
        }
    }

    func handleAction(_ action: CardAction) {
        switch action {
        case .rewind:
            break
        case .nope:
            removeTop(direction: .left)
        case .superLike:
            removeTop(direction: .up)
        case .like:
            removeTop(direction: .right)
        case .boost:
            break
        }
    }
}

enum SwipeDirection {
    case left, right, up
}

enum CardAction {
    case rewind, nope, superLike, like, boost
}
