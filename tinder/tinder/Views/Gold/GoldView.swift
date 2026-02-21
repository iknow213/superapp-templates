import SwiftUI

struct GoldView: View {
    @State private var isSubscribed = false
    @State private var showPaywall = false

    private let gold = Color(red: 0.85, green: 0.62, blue: 0.12)
    private let goldLight = Color(red: 0.99, green: 0.85, blue: 0.4)

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    goldHeroBanner
                    LikesGridView(likers: Liker.all, isUnlocked: isSubscribed, showPaywall: $showPaywall)
                    Divider().padding(.horizontal, 16)
                    BoostSectionView()
                    if isSubscribed {
                        subscribedBadge
                    }
                    Spacer(minLength: 30)
                }
                .padding(.top, 8)
            }
            .background(Color(.systemBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
        }
        .sheet(isPresented: $showPaywall) {
            GoldPaywallSheet(isPresented: $showPaywall, isSubscribed: $isSubscribed)
        }
    }

    // MARK: Hero Banner
    private var goldHeroBanner: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [Color(red:0.12,green:0.08,blue:0.02), Color(red:0.3,green:0.2,blue:0.05)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .frame(height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 22))

            // Decorative circles
            Circle().fill(goldLight.opacity(0.08)).frame(width: 180, height: 180)
                .offset(x: 220, y: -30)
            Circle().fill(gold.opacity(0.12)).frame(width: 100, height: 100)
                .offset(x: 270, y: 20)

            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(LinearGradient(colors: [goldLight, gold], startPoint: .topLeading, endPoint: .bottomTrailing))
                        Text("Tinder Gold™")
                            .font(.system(size: 22, weight: .black))
                            .foregroundStyle(LinearGradient(colors: [goldLight, gold], startPoint: .leading, endPoint: .trailing))
                    }
                    Text(isSubscribed ? "Active subscription ✓" : "See who likes you — instantly")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.75))
                }
                Spacer()
                if !isSubscribed {
                    Button { showPaywall = true } label: {
                        Text("Upgrade")
                            .font(.subheadline.bold())
                            .foregroundStyle(.black)
                            .padding(.horizontal, 18).padding(.vertical, 10)
                            .background(LinearGradient(colors: [goldLight, gold], startPoint: .leading, endPoint: .trailing))
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(20)
        }
        .padding(.horizontal, 16)
    }

    // MARK: Subscribed Badge
    private var subscribedBadge: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.seal.fill")
                .foregroundStyle(LinearGradient(colors: [goldLight, gold], startPoint: .topLeading, endPoint: .bottomTrailing))
                .font(.title3)
            VStack(alignment: .leading, spacing: 2) {
                Text("Gold Member")
                    .font(.callout.bold())
                Text("Renews Jan 15, 2025 · 6 Month Plan")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button("Manage") {}
                .font(.caption.bold())
                .foregroundStyle(gold)
        }
        .padding(16)
        .background(gold.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }

    // MARK: Toolbar
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            HStack(spacing: 6) {
                Image(systemName: "star.fill")
                    .foregroundStyle(LinearGradient(colors: [goldLight, gold], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .font(.subheadline.bold())
                Text("Gold")
                    .font(.headline.bold())
                    .foregroundStyle(LinearGradient(colors: [goldLight, gold], startPoint: .leading, endPoint: .trailing))
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Text("\(Liker.all.count)")
                .font(.caption.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 8).padding(.vertical, 4)
                .background(Color(red: 0.99, green: 0.27, blue: 0.35))
                .clipShape(Capsule())
        }
    }
}
