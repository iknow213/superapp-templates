import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                    .tabItem { Label("Home", systemImage: "house.fill") }
                SearchView()
                    .tag(1)
                    .tabItem { Label("Search", systemImage: "magnifyingglass") }
                LibraryView()
                    .tag(2)
                    .tabItem { Label("Your Library", systemImage: "rectangle.fill.on.rectangle.fill") }
                CreateView()
                    .tag(3)
                    .tabItem { Label("Create", systemImage: "plus") }
            }
            .tint(.white)
        }
    }
}
