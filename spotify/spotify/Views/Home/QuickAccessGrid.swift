import SwiftUI

struct QuickAccessGrid: View {
    let items: [MediaItem]

    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(items) { item in
                QuickAccessCell(item: item)
            }
        }
        .padding(.horizontal, 16)
    }
}

struct QuickAccessCell: View {
    let item: MediaItem

    var body: some View {
        HStack(spacing: 0) {
            thumbnailView
            titleSection
        }
        .frame(height: 56)
        .background(Color(white: 0.15))
        .cornerRadius(6)
    }

    private var thumbnailView: some View {
        ZStack {
            if item.icon != nil {
                Rectangle().fill(item.color.gradient)
            }
            CachedAsyncImage(url: item.imageURL, placeholder: item.color)
                .frame(width: 56, height: 56)
                .clipped()
            if let icon = item.icon {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 56, height: 56)
    }

    private var titleSection: some View {
        HStack(spacing: 4) {
            Text(item.title)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .lineLimit(2)
                .padding(.horizontal, 8)
            Spacer(minLength: 0)
            if item.hasEqualizer {
                equalizerIcon.padding(.trailing, 8)
            }
        }
    }

    private var equalizerIcon: some View {
        HStack(spacing: 2) {
            ForEach(0..<3, id: \.self) { i in
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color(red: 0.11, green: 0.84, blue: 0.38))
                    .frame(width: 3, height: CGFloat([8, 14, 10][i]))
            }
        }
    }
}
