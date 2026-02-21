import SwiftUI

// MARK: - List layout
extension LibraryView {
    var listLayout: some View {
        LazyVStack(spacing: 2) {
            ForEach(filteredItems) { item in
                LibraryListRow(item: item)
            }
            Spacer(minLength: 80)
        }
    }

    var gridLayout: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 20) {
            ForEach(filteredItems) { item in
                LibraryGridCell(item: item)
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 80)
    }
}

// MARK: - Row

struct LibraryListRow: View {
    let item: LibraryItem

    var body: some View {
        HStack(spacing: 12) {
            itemImage
            VStack(alignment: .leading, spacing: 2) {
                titleRow
                Text(item.subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
    }

    @ViewBuilder
    private var itemImage: some View {
        if item.title == "Liked Songs" {
            likedSongsIcon
        } else if item.title == "Your Episodes" {
            yourEpisodesIcon
        } else {
            let isCircle = item.type == .artist
            CachedAsyncImage(url: item.imageURL, cornerRadius: isCircle ? 28 : 4, placeholder: Color(white: 0.2))
                .frame(width: 56, height: 56)
                .clipShape(isCircle ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: 4)))
        }
    }

    private var likedSongsIcon: some View {
        LinearGradient(colors: [.blue, .purple, .white.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 56, height: 56)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .overlay(
                Image(systemName: "heart.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
            )
    }

    private var yourEpisodesIcon: some View {
        Color(red: 0.0, green: 0.45, blue: 0.24)
            .frame(width: 56, height: 56)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .overlay(
                Image(systemName: "bookmark.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
            )
    }

    private var titleRow: some View {
        HStack(spacing: 6) {
            if item.isPinned {
                Image(systemName: "pin.fill")
                    .font(.system(size: 10))
                    .foregroundColor(Color(red: 0.12, green: 0.84, blue: 0.38))
            }
            Text(item.title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
                .lineLimit(1)
        }
    }
}

// MARK: - Grid Cell

struct LibraryGridCell: View {
    let item: LibraryItem

    var body: some View {
        VStack(spacing: 8) {
            imageView
            Text(item.title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
    }

    @ViewBuilder
    private var imageView: some View {
        let isCircle = item.type == .artist
        if item.title == "Liked Songs" {
            LinearGradient(colors: [.blue, .purple, .white.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .aspectRatio(1, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(Image(systemName: "heart.fill").foregroundColor(.white).font(.system(size: 30)))
        } else if item.title == "Your Episodes" {
            Color(red: 0.0, green: 0.45, blue: 0.24)
                .aspectRatio(1, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(Image(systemName: "bookmark.fill").foregroundColor(.white).font(.system(size: 30)))
        } else {
            CachedAsyncImage(url: item.imageURL, cornerRadius: isCircle ? 100 : 8, placeholder: Color(white: 0.2))
                .aspectRatio(1, contentMode: .fit)
                .clipShape(isCircle ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: 8)))
        }
    }
}
