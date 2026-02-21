import Foundation

@MainActor
final class RevenueCatService: ObservableObject {
    static let shared = RevenueCatService()

    @Published var isProUser = false

    private init() {}

    func configure() {
        // RevenueCat removed — re-add the SDK to enable purchases
        NSLog("RevenueCat service: stub mode")
    }
}
