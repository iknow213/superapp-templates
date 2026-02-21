import SwiftUI

struct SearchView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        if searchText.isEmpty {
                            recentSection
                            topGenresSection
                            browseAllSection
                        } else {
                            searchResultsPlaceholder
                        }
                        Spacer(minLength: 80)
                    }
                    .padding(.top, 8)
                }
            }
            .navigationTitle("Search")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .searchable(text: $searchText, prompt: "What do you want to listen to?")
        }
    }

    // MARK: - Sections

    @ViewBuilder
    private var recentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent searches")
                .font(.headline).foregroundColor(.white)
                .padding(.horizontal, 16)
            ForEach(Array(SearchData.recentSearches.enumerated()), id: \.offset) { _, item in
                RecentSearchRow(name: item.0, detail: item.1, imageURL: item.2)
            }
        }
    }

    @ViewBuilder
    private var topGenresSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your top genres")
                .font(.headline).foregroundColor(.white)
                .padding(.horizontal, 16)
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)], spacing: 12) {
                ForEach(SearchData.topGenres) { card in
                    GenreCardView(card: card)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    @ViewBuilder
    private var browseAllSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Browse all")
                .font(.headline).foregroundColor(.white)
                .padding(.horizontal, 16)
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)], spacing: 12) {
                ForEach(SearchData.browseAll) { card in
                    GenreCardView(card: card)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    @ViewBuilder
    private var searchResultsPlaceholder: some View {
        VStack(spacing: 16) {
            Spacer(minLength: 60)
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundColor(.gray)
            Text("Search for \"\(searchText)\"")
                .font(.title3.bold())
                .foregroundColor(.white)
            Text("Find songs, artists, podcasts and more")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
    }
}
