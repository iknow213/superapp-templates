import SwiftUI

@main
struct NetflixApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView()
                .preferredColorScheme(.dark)
        }
    }
}
