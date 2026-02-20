import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeFeedView()
                .tag(0)
                .tabItem { Image(systemName: selectedTab == 0 ? "house.fill" : "house") }
            PlaceholderView(title: "Reels", icon: "play.rectangle.fill")
                .tag(1)
                .tabItem { Image(systemName: "play.rectangle") }
            PlaceholderView(title: "Create", icon: "paperplane.fill")
                .tag(2)
                .tabItem { Image(systemName: "paperplane") }
            PlaceholderView(title: "Explore", icon: "magnifyingglass")
                .tag(3)
                .tabItem { Image(systemName: "magnifyingglass") }
            PlaceholderView(title: "Profile", icon: "person.crop.circle")
                .tag(4)
                .tabItem { ProfileTabIcon() }
        }
        .tint(.white)
    }
}

struct ProfileTabIcon: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(systemName: "person.crop.circle")
            Circle()
                .fill(.red)
                .frame(width: 8, height: 8)
                .offset(x: 2, y: 2)
        }
    }
}
