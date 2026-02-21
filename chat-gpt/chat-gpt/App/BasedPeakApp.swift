import SwiftUI

@main
struct BasedPeakApp: App {
    @State private var showSidebar = false
    @StateObject private var rcService = RevenueCatService.shared

    init() {
        RevenueCatService.shared.configure()
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                MainChatView(showSidebar: $showSidebar)
                SidebarOverlay(showSidebar: $showSidebar)
            }
            .environmentObject(rcService)
        }
    }
}
