import SwiftUI

struct GoldPaywallSheet: View {
    @Binding var isPresented: Bool
    @Binding var isSubscribed: Bool
    @State private var selectedPlan = 1 // default to 6-month
    @State private var isPurchasing = false

    private let gold = Color(red: 0.85, green: 0.62, blue: 0.12)
    private let goldLight = Color(red: 0.99, green: 0.85, blue: 0.4)

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    heroSection
                    featuresGrid
                    plansSection
                    purchaseButton
                    legalText
                }
                .padding(.bottom, 40)
            }
            .background(Color(.systemBackground))
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { isPresented = false } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }

    // MARK: Hero
    private var heroSection: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red:0.12,green:0.08,blue:0.02), Color(red:0.25,green:0.18,blue:0.04)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [goldLight, gold], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 80, height: 80)
                        .shadow(color: gold.opacity(0.6), radius: 20)
                    Image(systemName: "star.fill")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundStyle(.black.opacity(0.5))
                }
                Text("Tinder Gold™")
                    .font(.system(size: 30, weight: .black))
                    .foregroundStyle(LinearGradient(colors: [goldLight, gold], startPoint: .topLeading, endPoint: .bottomTrailing))
                Text("See who likes you.\nMatch instantly.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 40)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding(.horizontal, 16)
    }

    // MARK: Features
    private var featuresGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(GoldFeature.all) { f in
                HStack(spacing: 10) {
                    Image(systemName: f.icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(f.color)
                        .frame(width: 32, height: 32)
                        .background(f.color.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Text(f.title)
                        .font(.caption.bold())
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                    Spacer()
                }
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
        .padding(.horizontal, 16)
    }

    // MARK: Plans
    private var plansSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Choose Your Plan")
                .font(.title3.bold())
                .padding(.horizontal, 16)
            ForEach(Array(GoldPlan.plans.enumerated()), id: \.element.id) { idx, plan in
                PlanRow(plan: plan, isSelected: selectedPlan == idx, gold: gold) {
                    withAnimation(.spring(response: 0.3)) { selectedPlan = idx }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    // MARK: CTA
    private var purchaseButton: some View {
        Button {
            isPurchasing = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isPurchasing = false
                isSubscribed = true
                isPresented = false
            }
        } label: {
            HStack {
                if isPurchasing {
                    ProgressView().tint(.black)
                } else {
                    Text("Get Gold — \(GoldPlan.plans[selectedPlan].price)")
                        .font(.headline.bold())
                }
            }
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(LinearGradient(colors: [goldLight, gold], startPoint: .leading, endPoint: .trailing))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: gold.opacity(0.5), radius: 12, x: 0, y: 6)
        }
        .padding(.horizontal, 16)
        .disabled(isPurchasing)
    }

    private var legalText: some View {
        Text("Subscription renews automatically. Cancel anytime in Settings.")
            .font(.caption2)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
    }
}

struct PlanRow: View {
    let plan: GoldPlan
    let isSelected: Bool
    let gold: Color
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(isSelected ? LinearGradient(colors: [Color(red:0.99,green:0.85,blue:0.4), gold], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [Color(.secondarySystemBackground)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 22, height: 22)
                    if isSelected {
                        Circle().fill(.black.opacity(0.4)).frame(width: 10, height: 10)
                    }
                }
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text(plan.duration)
                            .font(.callout.bold())
                        if let badge = plan.badge {
                            Text(badge)
                                .font(.system(size: 9, weight: .black))
                                .foregroundStyle(.black)
                                .padding(.horizontal, 6).padding(.vertical, 2)
                                .background(LinearGradient(colors: [Color(red:0.99,green:0.85,blue:0.4), gold], startPoint: .leading, endPoint: .trailing))
                                .clipShape(Capsule())
                        }
                    }
                    Text(plan.perMonth)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text(plan.price)
                    .font(.callout.bold())
                    .foregroundStyle(isSelected ? gold : .primary)
            }
            .padding(16)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(isSelected ? gold : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}
