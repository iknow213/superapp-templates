import SwiftUI

final class MiniPlayerViewModel: ObservableObject {
    @Published var isPlaying: Bool = true
    @Published var songTitle: String = SampleData.nowPlaying.title
    @Published var artist: String = SampleData.nowPlaying.artist
    @Published var device: String = SampleData.nowPlaying.device
    @Published var accentColor: Color = Color(red: 0.7, green: 0.15, blue: 0.2)
    @Published var albumImageURL: String? = SampleData.nowPlaying.imageURL

    func togglePlayback() {
        isPlaying.toggle()
    }
}
