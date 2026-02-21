import SwiftUI

struct DiscoverView: View {
    @StateObject private var viewModel = DiscoverViewModel()

    var body: some View {
        VStack(spacing: 0) {
            DiscoverHeaderBar()
            ZStack {
                if viewModel.profiles.isEmpty {
                    EmptyStateView()
                } else {
                    cardStack
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 8)
            .padding(.top, 4)

            ActionButtonsBar(onAction: viewModel.handleAction)
                .padding(.top, 8)
                .padding(.bottom, 4)
        }
        .background(Color(.systemGray6).opacity(0.5))
    }

    private var cardStack: some View {
        ZStack {
            ForEach(viewModel.profiles.suffix(3).reversed()) { profile in
                let isTop = profile.id == viewModel.profiles.last?.id
                SwipeCardView(
                    profile: profile,
                    isTop: isTop,
                    onSwiped: { direction in
                        viewModel.removeTop(direction: direction)
                    }
                )
            }
        }
    }
}
