import SwiftUI

struct SearchPlaceholderView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 48, weight: .light))
                    .foregroundColor(.gray)
                Text("Search")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Text("Find songs, artists, podcasts and more")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
