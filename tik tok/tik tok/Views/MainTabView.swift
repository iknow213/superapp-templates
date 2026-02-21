import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    @State private var showCreateSheet = false

    var body: some View {
        ZStack(alignment: .bottom) {
            TabContent(selectedTab: appState.selectedTab)
            CustomTabBar(
                selectedTab: $appState.selectedTab,
                onCreateTap: { showCreateSheet = true }
            )
        }
        .ignoresSafeArea(.keyboard)
        .sheet(isPresented: $showCreateSheet) {
            CreatePlaceholderView()
        }
    }
}

private struct TabContent: View {
    let selectedTab: Int

    var body: some View {
        ZStack {
            switch selectedTab {
            case 0: HomeFeedView()
            case 1: FriendsView()
            case 3: InboxView()
            case 4: ProfileView()
            default: HomeFeedView()
            }
        }
    }
}
