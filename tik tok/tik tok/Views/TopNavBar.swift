import SwiftUI

struct TopNavBar: View {
    @Binding var selectedTab: String
    private let tabs = ["LIVE", "Explore", "Berlin", "Following", "Shop", "For You"]

    var body: some View {
        HStack(spacing: 0) {
            tabScrollView
            searchButton
        }
        .padding(.horizontal, 8)
    }

    private var tabScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(tabs, id: \.self) { tab in
                    TopTabItem(
                        title: tab,
                        isSelected: selectedTab == tab,
                        isLive: tab == "LIVE",
                        hasDot: tab == "Following" || tab == "Shop"
                    )
                    .onTapGesture { selectedTab = tab }
                }
            }
            .padding(.horizontal, 8)
        }
    }

    private var searchButton: some View {
        Button(action: {}) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.leading, 8)
    }
}

private struct TopTabItem: View {
    let title: String
    let isSelected: Bool
    let isLive: Bool
    let hasDot: Bool

    var body: some View {
        VStack(spacing: 4) {
            label
            if isSelected {
                Capsule().fill(Color.white)
                    .frame(width: 24, height: 3)
            }
        }
    }

    @ViewBuilder
    private var label: some View {
        if isLive {
            liveLabel
        } else {
            textLabel
        }
    }

    private var liveLabel: some View {
        HStack(spacing: 2) {
            Image(systemName: "tv")
                .font(.system(size: 14, weight: .bold))
            Text("LIVE")
                .font(.system(size: 14, weight: .bold))
        }
        .foregroundColor(isSelected ? .white : .white.opacity(0.6))
    }

    private var textLabel: some View {
        ZStack(alignment: .topTrailing) {
            Text(title)
                .font(.system(size: 16, weight: isSelected ? .bold : .regular))
                .foregroundColor(isSelected ? .white : .white.opacity(0.6))
            if hasDot {
                Circle().fill(Color(hex: "FE2C55"))
                    .frame(width: 6, height: 6)
                    .offset(x: 6, y: -2)
            }
        }
    }
}
