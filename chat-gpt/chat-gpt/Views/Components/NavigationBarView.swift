import SwiftUI

struct NavigationBarView: View {
    @Binding var showSidebar: Bool
    @Binding var selectedModel: ChatModel
    @State private var showModelPicker = false
    @State private var showPaywall = false
    @ObservedObject private var rc = RevenueCatService.shared
    private let subtitleColor = Color(red: 0.235, green: 0.235, blue: 0.263).opacity(0.6)

    var body: some View {
        HStack {
            menuButton
            Spacer()
            titleSection
            Spacer()
            proOrEditButton
        }
        .padding(.horizontal, 20)
        .frame(height: 44)
        .sheet(isPresented: $showPaywall) { PaywallView() }
    }

    @ViewBuilder
    private var menuButton: some View {
        Button { showSidebar = true } label: {
            VStack(alignment: .leading, spacing: 6) {
                RoundedRectangle(cornerRadius: 1)
                    .frame(width: 18, height: 2.2)
                RoundedRectangle(cornerRadius: 1)
                    .frame(width: 13, height: 2.2)
            }
            .foregroundColor(.black)
        }
        .frame(width: 24, height: 24)
    }

    @ViewBuilder
    private var titleSection: some View {
        Menu {
            ForEach(ChatModel.allCases) { model in
                Button {
                    selectedModel = model
                } label: {
                    HStack {
                        Text(model.displayName)
                        if selectedModel == model {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack(spacing: 4) {
                Text("ChatGPT")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)
                Text(selectedModel.subtitle)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(subtitleColor)
                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(subtitleColor)
            }
        }
    }

    @ViewBuilder
    private var proOrEditButton: some View {
        if rc.isProUser {
            Button {} label: {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color(red: 0.235, green: 0.235, blue: 0.235))
            }
            .frame(width: 24, height: 24)
        } else {
            Button { showPaywall = true } label: {
                HStack(spacing: 4) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 12, weight: .bold))
                    Text("Pro")
                        .font(.system(size: 13, weight: .bold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(
                    LinearGradient(colors: [Color(hex: "6C5CE7"), Color(hex: "A855F7")], startPoint: .leading, endPoint: .trailing)
                )
                .clipShape(Capsule())
            }
        }
    }
}
