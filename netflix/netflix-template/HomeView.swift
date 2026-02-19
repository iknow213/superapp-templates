import SwiftUI

struct HomeView: View {
    private let bgColor = Color(red: 0.07, green: 0.07, blue: 0.07)

    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    headerBar
                    filterChips
                    heroSection
                    contentRows
                }
            }
        }
    }

    private var headerBar: some View {
        HStack {
            Text("For JudyS.")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Spacer()
            headerIcons
        }
        .padding(.horizontal, 16)
        .padding(.top, 4)
    }

    private var headerIcons: some View {
        HStack(spacing: 20) {
            Image(systemName: "tv.badge.wifi").font(.title3)
            Image(systemName: "arrow.down.to.line").font(.title3)
            Image(systemName: "magnifyingglass").font(.title3)
        }
        .foregroundStyle(.white)
    }

    private var filterChips: some View {
        FilterChipsBar()
            .padding(.vertical, 8)
    }

    private var heroSection: some View {
        HeroSection(show: SampleData.featuredShow)
            .padding(.top, 4)
    }

    private var contentRows: some View {
        LazyVStack(spacing: 24) {
            ForEach(SampleData.rows) { row in
                ContentRowView(row: row)
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 40)
    }
}
