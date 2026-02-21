import SwiftUI

struct CreatePlaceholderView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 48, weight: .light))
                    .foregroundColor(.gray)
                Text("Create")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Text("Make playlists and share your taste")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
