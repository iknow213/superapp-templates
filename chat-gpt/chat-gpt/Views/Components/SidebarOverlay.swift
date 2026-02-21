import SwiftUI

struct SidebarOverlay: View {
    @Binding var showSidebar: Bool
    private let sidebarWidth: CGFloat = 300
    @StateObject private var storage = LocalStorageService.shared
    @State private var showPaywall = false
    @ObservedObject private var rc = RevenueCatService.shared

    var body: some View {
        if showSidebar {
            ZStack(alignment: .leading) {
                dimBackground
                sidebarContent
            }
            .transition(.opacity)
            .onAppear { storage.loadConversations() }
        }
    }

    @ViewBuilder
    private var dimBackground: some View {
        Color.black.opacity(0.3)
            .ignoresSafeArea()
            .onTapGesture { withAnimation(.easeInOut(duration: 0.25)) { showSidebar = false } }
    }

    @ViewBuilder
    private var sidebarContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            sidebarHeader
            Divider()
            conversationList
            Spacer()
            if !rc.isProUser { upgradeCard }
            userFooter
        }
        .frame(width: sidebarWidth)
        .background(Color.white)
        .ignoresSafeArea()
        .transition(.move(edge: .leading))
        .sheet(isPresented: $showPaywall) { PaywallView() }
    }

    @ViewBuilder
    private var sidebarHeader: some View {
        HStack {
            Text("History")
                .font(.system(size: 22, weight: .bold))
            Spacer()
            Button { withAnimation { showSidebar = false } } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 70)
        .padding(.bottom, 16)
    }

    @ViewBuilder
    private var conversationList: some View {
        if storage.conversations.isEmpty {
            emptyHistory
        } else {
            List {
                ForEach(storage.conversations) { conv in
                    conversationRow(conv)
                }
            }
            .listStyle(.plain)
        }
    }

    @ViewBuilder
    private var emptyHistory: some View {
        VStack(spacing: 8) {
            Spacer()
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 32))
                .foregroundColor(.gray.opacity(0.4))
            Text("No conversations yet")
                .font(.system(size: 15))
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private func conversationRow(_ conv: Conversation) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(conv.title)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .lineLimit(1)
            Text(conv.model)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }

    @ViewBuilder
    private var userFooter: some View {
        let name = storage.currentUser.displayName
        VStack(spacing: 12) {
            Divider()
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.blue.opacity(0.15))
                    .frame(width: 36, height: 36)
                    .overlay(
                        Text(String(name.prefix(1)).uppercased())
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.blue)
                    )
                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.black)
                }
                Spacer()
                Image(systemName: "gearshape")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 40)
    }

    @ViewBuilder
    private var upgradeCard: some View {
        Button { showPaywall = true } label: {
            HStack(spacing: 10) {
                Image(systemName: "sparkles")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Upgrade to Pro")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.white)
                    Text("Unlock all features")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.6))
            }
            .padding(14)
            .background(
                LinearGradient(colors: [Color(hex: "6C5CE7"), Color(hex: "A855F7")], startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}
