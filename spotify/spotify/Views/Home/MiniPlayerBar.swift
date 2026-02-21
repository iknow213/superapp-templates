import SwiftUI

struct MiniPlayerBar: View {
    @EnvironmentObject var playerVM: MiniPlayerViewModel

    var body: some View {
        VStack(spacing: 0) {
            playerContent
        }
        .background(playerVM.accentColor)
        .cornerRadius(10)
    }

    private var playerContent: some View {
        HStack(spacing: 10) {
            albumArt
            trackInfo
            Spacer()
            controlButtons
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
    }

    private var albumArt: some View {
        CachedAsyncImage(url: playerVM.albumImageURL, cornerRadius: 4, placeholder: .orange)
            .frame(width: 42, height: 42)
    }

    private var trackInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(playerVM.songTitle) · \(playerVM.artist)")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)
            deviceLabel
        }
    }

    private var deviceLabel: some View {
        HStack(spacing: 4) {
            Image(systemName: "hifispeaker")
                .font(.system(size: 9))
                .foregroundColor(Color(red: 0.11, green: 0.84, blue: 0.38))
            Text(playerVM.device)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(Color(red: 0.11, green: 0.84, blue: 0.38))
        }
    }

    private var controlButtons: some View {
        HStack(spacing: 16) {
            Image(systemName: "laptopcomputer.and.iphone")
                .font(.system(size: 16))
                .foregroundColor(.white)
            Button { playerVM.togglePlayback() } label: {
                Image(systemName: playerVM.isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
        }
    }
}
