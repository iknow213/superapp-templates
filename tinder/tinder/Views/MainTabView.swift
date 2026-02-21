import SwiftUI
// MessagesView is now in Views/Messages/MessagesView.swift

struct MainTabView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            DiscoverView()
                .tag(AppState.Tab.discover)
                .tabItem { tabLabel(icon: "flame.fill", title: "Discover") }

            ExploreView()
                .tag(AppState.Tab.explore)
                .tabItem { tabLabel(icon: "magnifyingglass", title: "Explore") }

            GoldView()
                .tag(AppState.Tab.gold)
                .tabItem { tabLabel(icon: "star.fill", title: "Gold") }

            MessagesView()
                .tag(AppState.Tab.messages)
                .tabItem { tabLabel(icon: "bubble.left.and.bubble.right.fill", title: "Messages") }

            ProfileView()
                .tag(AppState.Tab.profile)
                .tabItem { tabLabel(icon: "person.fill", title: "Profile") }
        }
        .tint(Color(red: 0.99, green: 0.27, blue: 0.35))
    }

    private func tabLabel(icon: String, title: String) -> some View {
        Label(title, systemImage: icon)
    }
}
