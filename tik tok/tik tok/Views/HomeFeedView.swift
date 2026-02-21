import SwiftUI

struct HomeFeedView: View {
    @State private var currentIndex = 0
    @State private var selectedTopTab = "For You"
    private let posts = VideoPost.samples

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            verticalFeed
            overlayUI
        }
    }

    private var verticalFeed: some View {
        GeometryReader { geo in
            VerticalPager(
                pageCount: posts.count,
                currentIndex: $currentIndex,
                pageSize: geo.size
            ) {
                ForEach(Array(posts.enumerated()), id: \.element.id) { _, post in
                    VideoCardView(post: post)
                        .frame(width: geo.size.width, height: geo.size.height)
                }
            }
        }
        .ignoresSafeArea()
    }

    private var overlayUI: some View {
        VStack {
            TopNavBar(selectedTab: $selectedTopTab)
                .padding(.top, 8)
            Spacer()
            SearchTickerBar(text: "ai tools to make money")
                .padding(.bottom, 70)
        }
    }
}
