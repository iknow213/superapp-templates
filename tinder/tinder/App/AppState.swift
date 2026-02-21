import SwiftUI

class AppState: ObservableObject {
    @Published var selectedTab: Tab = .discover

    enum Tab: Int, CaseIterable {
        case discover, explore, gold, messages, profile
    }
}
