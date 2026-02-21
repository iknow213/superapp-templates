import SwiftUI

struct HomeFeedView: View {
    let stories = SampleData.stories
    let posts = SampleData.posts

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    StoryRow(stories: stories)
                    feedDivider
                    ForEach(posts) { post in
                        PostView(post: post)
                        feedDivider
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.black)
            .toolbar { toolbarLeading }
            .toolbar { toolbarCenter }
            .toolbar { toolbarTrailing }
            .toolbarBackground(.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    private var feedDivider: some View {
        Rectangle()
            .fill(Color(white: 0.15))
            .frame(height: 0.5)
    }

    @ToolbarContentBuilder
    private var toolbarLeading: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Image(systemName: "plus")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white)
        }
    }

    @ToolbarContentBuilder
    private var toolbarCenter: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            HStack(spacing: 4) {
                Text("For you")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.white)
                Image(systemName: "chevron.down")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white)
            }
        }
    }

    @ToolbarContentBuilder
    private var toolbarTrailing: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Image(systemName: "heart")
                .font(.title3)
                .foregroundStyle(.white)
        }
    }
}
