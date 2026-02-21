import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    @State private var selectedFilter = "All"
    @State private var likedIDs: Set<UUID> = []

    private let filters = ["All", "Near Me", "Active", "New", "Trending"]
    private let columns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]

    private var filteredCards: [ExploreCard] {
        let pool = (ExploreCard.trending + ExploreCard.nearby)
            .uniqued()
        if searchText.isEmpty { return pool }
        return pool.filter { $0.profile.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    searchBar
                    filterBarSection
                    categoriesSection
                    trendingSection
                    nearbySection
                    gridSection
                    Spacer(minLength: 32)
                }
            }
            .background(Color(.systemBackground))
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    // MARK: - Sections
    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search people, interests…", text: $searchText)
                .font(.subheadline)
        }
        .padding(.horizontal, 14).padding(.vertical, 11)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, 20)
        .padding(.top, 8).padding(.bottom, 12)
    }

    private var filterBarSection: some View {
        ExploreFilterBar(selected: $selectedFilter, options: filters)
            .padding(.bottom, 20)
    }

    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Browse by Vibe")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(ExploreCategory.all) { cat in
                        CategoryPill(category: cat)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.bottom, 24)
    }

    private var trendingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("🔥 Trending Near You")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(ExploreCard.trending) { card in
                        ZStack {
                            ExploreFeaturedCard(card: card)
                            if likedIDs.contains(card.profile.id) {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 36))
                                    .foregroundColor(.white)
                                    .shadow(radius: 4)
                                    .transition(.scale.combined(with: .opacity))
                            }
                        }
                        .onTapGesture { triggerLike(card.profile.id) }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.bottom, 24)
    }

    private var nearbySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("📍 Closest to You")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(ExploreCard.nearby) { card in
                        ExploreFeaturedCard(card: card)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.bottom, 24)
    }

    private var gridSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("✨ Discover Everyone")
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(filteredCards) { card in
                    ExploreGridCard(card: card) { triggerLike(card.profile.id) }
                }
            }
            .padding(.horizontal, 20)
        }
    }

    // MARK: - Helpers
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .padding(.horizontal, 20)
    }

    private func triggerLike(_ id: UUID) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            likedIDs.insert(id)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
            withAnimation(.easeOut) {
                _ = likedIDs.remove(id)
            }
        }
    }
}

// MARK: - Category Pill
private struct CategoryPill: View {
    let category: ExploreCategory

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                LinearGradient(colors: category.gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                Image(systemName: category.icon)
                    .font(.system(size: 22))
                    .foregroundColor(.white)
            }
            Text(category.title)
                .font(.caption.weight(.medium))
                .foregroundColor(.primary)
        }
        .frame(width: 72)
    }
}

// MARK: - Array uniqued helper
private extension Array where Element == ExploreCard {
    func uniqued() -> [ExploreCard] {
        var seen: Set<UUID> = []
        return filter { seen.insert($0.profile.id).inserted }
    }
}
