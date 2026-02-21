import SwiftUI

struct CreateView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        heroCard
                        createOptionsSection
                        yourPlaylistsSection
                        Spacer(minLength: 80)
                    }
                    .padding(.top, 8)
                }
            }
            .navigationTitle("Create")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }

    // MARK: - Hero

    private var heroCard: some View {
        VStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.12, green: 0.84, blue: 0.38), Color(red: 0.07, green: 0.45, blue: 0.24)],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 180)
                VStack(spacing: 8) {
                    Image(systemName: "music.note.list")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                    Text("Create your first playlist")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                    Text("It's easy, we'll help you")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                    createButton
                }
            }
        }
        .padding(.horizontal, 16)
    }

    private var createButton: some View {
        Button {} label: {
            Text("Create playlist")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background(.white)
                .clipShape(Capsule())
        }
        .padding(.top, 4)
    }

    // MARK: - Options

    private var createOptionsSection: some View {
        VStack(spacing: 0) {
            ForEach(Array(CreateOption.all.enumerated()), id: \.element.id) { _, option in
                CreateOptionRow(option: option)
                if option.title != CreateOption.all.last?.title {
                    Divider().background(Color(white: 0.15)).padding(.leading, 64)
                }
            }
        }
        .padding(.horizontal, 16)
    }

    // MARK: - Your playlists

    private var yourPlaylistsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Your playlists")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
            ForEach(CreateData.playlists) { pl in
                PlaylistRow(playlist: pl)
            }
        }
    }
}
