import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "0A0A0A"), Color(hex: "1A1A2E")],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                HStack {
                    Spacer()
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(.white.opacity(0.5))
                    }
                }
                .padding(.top, 8)

                headerSection
                featuresSection
                Spacer()

                Text("Restore Purchases")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
    }

    @ViewBuilder private var headerSection: some View {
        VStack(spacing: 12) {
            Image(systemName: "sparkles")
                .font(.system(size: 48))
                .foregroundStyle(proGradient)
            Text("Upgrade to Pro")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
            Text("Coming soon — unlock unlimited\nAI conversations and premium features")
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
    }

    @ViewBuilder private var featuresSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            featureRow(icon: "infinity", text: "Unlimited messages")
            featureRow(icon: "bolt.fill", text: "Access to all AI models")
            featureRow(icon: "photo.stack", text: "Image generation")
            featureRow(icon: "clock.arrow.circlepath", text: "Priority response speed")
        }
        .padding(20)
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var proGradient: LinearGradient {
        LinearGradient(colors: [Color(hex: "6C5CE7"), Color(hex: "A855F7")], startPoint: .leading, endPoint: .trailing)
    }

    private func featureRow(icon: String, text: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(proGradient)
                .frame(width: 24)
            Text(text)
                .font(.system(size: 16))
                .foregroundColor(.white)
        }
    }
}

extension Color {
    init(hex: String) {
        let cleaned = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
