import SwiftUI

struct VideoCardView: View {
    let post: VideoPost

    var body: some View {
        ZStack {
            videoBackground
            bottomGradientOverlay
            contentOverlay
        }
        .clipped()
    }

    private var videoBackground: some View {
        let colors = post.gradientColors.map { Color(hex: $0) }
        return ZStack {
            LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
            AsyncImage(url: URL(string: post.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .transition(.opacity.animation(.easeIn(duration: 0.3)))
                default:
                    EmptyView()
                }
            }
        }
    }

    private var bottomGradientOverlay: some View {
        VStack {
            Spacer()
            LinearGradient(
                colors: [.clear, .black.opacity(0.5), .black.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 300)
        }
    }

    private var contentOverlay: some View {
        VStack {
            Spacer()
            HStack(alignment: .bottom, spacing: 8) {
                CaptionOverlay(post: post)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ActionSidebar(post: post)
            }
            .padding(.leading, 16)
            .padding(.trailing, 12)
            .padding(.bottom, 140)
        }
    }
}
