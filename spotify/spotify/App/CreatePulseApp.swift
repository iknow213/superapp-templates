import SwiftUI

@main
struct CreatePulseApp: App {
    @StateObject private var playerVM = MiniPlayerViewModel()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(playerVM)
                .preferredColorScheme(.dark)
        }
    }
}
