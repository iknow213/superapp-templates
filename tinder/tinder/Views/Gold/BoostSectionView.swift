import SwiftUI

struct BoostSectionView: View {
    @State private var activatingBoost: BoostItem? = nil
    @State private var boostActive = false
    @State private var boostTimeLeft = 1800 // 30 min in seconds

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Power-Ups")
                .font(.title3.bold())
                .padding(.horizontal, 16)

            if boostActive {
                activeBoostBanner
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(BoostItem.all) { boost in
                        BoostCard(boost: boost, isActive: boostActive && activatingBoost?.id == boost.id) {
                            withAnimation(.spring(response: 0.4)) {
                                activatingBoost = boost
                                boostActive = true
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private var activeBoostBanner: some View {
        HStack(spacing: 12) {
            Image(systemName: "bolt.fill")
                .font(.title3)
                .foregroundStyle(Color(red: 0.55, green: 0.35, blue: 0.95))
            VStack(alignment: .leading, spacing: 2) {
                Text("Boost Active!")
                    .font(.callout.bold())
                Text("You're a top profile right now")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(timeString(boostTimeLeft))
                .font(.callout.monospacedDigit().bold())
                .foregroundStyle(Color(red: 0.55, green: 0.35, blue: 0.95))
        }
        .padding(14)
        .background(Color(red: 0.55, green: 0.35, blue: 0.95).opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, 16)
    }

    private func timeString(_ s: Int) -> String {
        String(format: "%02d:%02d", s / 60, s % 60)
    }
}

struct BoostCard: View {
    let boost: BoostItem
    let isActive: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(colors: boost.gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 44, height: 44)
                        Image(systemName: boost.icon)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    Text(boost.multiplier)
                        .font(.system(size: 13, weight: .black))
                        .foregroundStyle(boost.color)
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .background(boost.color.opacity(0.15))
                        .clipShape(Capsule())
                }
                Text(boost.name)
                    .font(.callout.bold())
                    .foregroundStyle(.primary)
                Text(boost.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Text(isActive ? "Active ✓" : boost.price)
                    .font(.subheadline.bold())
                    .foregroundStyle(isActive ? .white : boost.color)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(isActive ? LinearGradient(colors: boost.gradient, startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [boost.color.opacity(0.15)], startPoint: .leading, endPoint: .trailing))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(16)
            .frame(width: 170, height: 200)
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(isActive ? boost.color : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}
