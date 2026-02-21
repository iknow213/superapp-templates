import SwiftUI

struct PodcastSection: View {
    let episode: PodcastEpisode

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle
            episodeCard
        }
        .padding(.horizontal, 16)
    }

    private var sectionTitle: some View {
        Text("The next episode awaits")
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.white)
    }

    private var episodeCard: some View {
        HStack(alignment: .top, spacing: 0) {
            podcastArtwork
            episodeInfo
        }
        .background(Color(white: 0.12))
        .cornerRadius(10)
    }

    private var podcastArtwork: some View {
        ZStack(alignment: .topLeading) {
            CachedAsyncImage(url: episode.imageURL, cornerRadius: 10, placeholder: episode.color)
                .frame(width: 155, height: 155)
            VStack {
                Text("Outpacing\nthe Internet")
                    .font(.system(size: 13, weight: .heavy))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.7), radius: 4, x: 0, y: 2)
                    .multilineTextAlignment(.leading)
                    .padding(10)
                Spacer()
            }
        }
        .frame(width: 155, height: 155)
    }

    private var episodeInfo: some View {
        VStack(alignment: .leading, spacing: 6) {
            headerWithMenu
            Text(episode.episodeTitle)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .lineLimit(2)
            Text(episode.description)
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .lineLimit(1)
            Spacer()
            actionButtons
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var headerWithMenu: some View {
        HStack {
            Text("Episode")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            Spacer()
            Image(systemName: "ellipsis")
                .foregroundColor(.gray)
        }
    }

    private var actionButtons: some View {
        HStack {
            Image(systemName: "plus.circle")
                .font(.system(size: 24))
                .foregroundColor(Color(white: 0.5))
            Spacer()
            Circle()
                .fill(Color.black)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "play.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                )
        }
    }
}
