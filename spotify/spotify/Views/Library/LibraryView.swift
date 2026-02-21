import SwiftUI

struct LibraryView: View {
    @State private var selectedFilter: LibraryFilter? = nil
    @State private var sortOption: LibrarySortOption = .recents
    @State private var isGridView = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 0) {
                    filterRow
                    sortRow
                    listContent
                }
            }
            .navigationTitle("Your Library")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar { toolbarItems }
        }
    }

    // MARK: - Filter chips

    private var filterRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                if selectedFilter != nil {
                    Button { withAnimation { selectedFilter = nil } } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .background(Color(white: 0.22))
                            .clipShape(Circle())
                    }
                }
                ForEach(LibraryFilter.allCases) { filter in
                    LibFilterChip(title: filter.rawValue, isSelected: selectedFilter == filter) {
                        withAnimation { selectedFilter = selectedFilter == filter ? nil : filter }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }

    // MARK: - Sort

    private var sortRow: some View {
        HStack {
            Button { cycleSortOption() } label: {
                HStack(spacing: 4) {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.system(size: 12))
                    Text(sortOption.rawValue)
                        .font(.system(size: 13, weight: .medium))
                }
                .foregroundColor(.white)
            }
            Spacer()
            Button { withAnimation { isGridView.toggle() } } label: {
                Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }

    // MARK: - Content

    private var listContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if isGridView {
                gridLayout
            } else {
                listLayout
            }
        }
    }

    var filteredItems: [LibraryItem] {
        guard let filter = selectedFilter else { return LibraryData.items }
        switch filter {
        case .playlists: return LibraryData.items.filter { $0.type == .playlist }
        case .artists: return LibraryData.items.filter { $0.type == .artist }
        case .albums: return LibraryData.items.filter { $0.type == .album }
        case .podcastsShows: return LibraryData.items.filter { $0.type == .podcast }
        }
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    private var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {} label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
            }
        }
    }

    private func cycleSortOption() {
        let all = LibrarySortOption.allCases
        let idx = all.firstIndex(of: sortOption) ?? 0
        sortOption = all[(idx + 1) % all.count]
    }
}
