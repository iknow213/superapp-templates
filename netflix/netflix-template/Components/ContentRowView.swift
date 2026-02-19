import SwiftUI

struct ContentRowView: View {
    let row: ContentRow

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(row.title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            if row.isTop10 {
                top10Scroll
            } else {
                standardScroll
            }
        }
    }

    private var standardScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(row.shows) { show in
                    ShowCard(show: show)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    private var top10Scroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(Array(row.shows.enumerated()), id: \.element.id) { index, show in
                    Top10Card(show: show, rank: index + 1)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
