import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)

            NewHotView()
                .tabItem {
                    Image(systemName: "play.rectangle.on.rectangle.fill")
                    Text("New & Hot")
                }
                .tag(1)

            FastLaughsView()
                .tabItem {
                    Image(systemName: "face.smiling")
                    Text("Fast Laughs")
                }
                .tag(2)

            DownloadsView()
                .tabItem {
                    Image(systemName: "arrow.down.circle")
                    Text("Downloads")
                }
                .tag(3)
        }
        .tint(.white)
    }
}
