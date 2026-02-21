import SwiftUI

struct LibraryPlaceholderView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: "rectangle.fill.on.rectangle.fill")
                    .font(.system(size: 48, weight: .light))
                    .foregroundColor(.gray)
                Text("Your Library")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Text("Save music and podcasts to your library")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
