import SwiftUI

struct HomeView: View {
    @EnvironmentObject var playerVM: MiniPlayerViewModel
    @State private var selectedFilter: FilterChip = .all

    var body: some View {
        ZStack(alignment: .bottom) {
            mainContent
            MiniPlayerBar()
                .padding(.horizontal, 8)
                .padding(.bottom, 0)
        }
        .background(Color.black)
    }

    private var mainContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                headerRow
                FilterChipsRow(selected: $selectedFilter)
                QuickAccessGrid(items: SampleData.quickAccessItems)
                PodcastSection(episode: SampleData.podcastEpisode)
                NewMusicSection(playlists: SampleData.newMusicPlaylists)
                Spacer(minLength: 120)
            }
            .padding(.top, 8)
        }
    }

    private var headerRow: some View {
        HStack(spacing: 12) {
            profileAvatar
            Spacer()
        }
        .padding(.horizontal, 16)
    }

    private var profileAvatar: some View {
        Circle()
            .fill(Color(white: 0.25))
            .frame(width: 36, height: 36)
            .overlay(
                Text("J")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
            )
    }
}
