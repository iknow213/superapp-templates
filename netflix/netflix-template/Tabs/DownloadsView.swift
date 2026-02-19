import SwiftUI

struct DownloadsView: View {
    var body: some View {
        ZStack {
            Color(red: 0.07, green: 0.07, blue: 0.07).ignoresSafeArea()
            emptyState
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "arrow.down.circle")
                .font(.system(size: 48))
                .foregroundStyle(.blue.opacity(0.6))
            Text("Downloads")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Text("Shows and films that you\ndownload will appear here.")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
            Button(action: {}) {
                Text("Find Something to Download")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.white, in: RoundedRectangle(cornerRadius: 4))
            }
            .padding(.top, 8)
        }
    }
}
