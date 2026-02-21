import SwiftUI

struct PlaceholderTabView: View {
    let title: String
    let icon: String

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 48))
                    .foregroundColor(.gray.opacity(0.5))
                Text(title)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Text("Coming soon")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CreatePlaceholderView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                Image(systemName: "video.badge.plus")
                    .font(.system(size: 56))
                    .foregroundColor(Color(hex: "FE2C55"))
                Text("Create a video")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Text("Record, edit and share your story")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Button(action: { dismiss() }) {
                    Text("Close")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "FE2C55"))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
    }
}
