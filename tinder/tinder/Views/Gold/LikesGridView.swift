import SwiftUI

struct LikesGridView: View {
    let likers: [Liker]
    let isUnlocked: Bool
    @Binding var showPaywall: Bool

    private let columns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerRow
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(likers) { liker in
                    LikerCardView(liker: liker, isUnlocked: isUnlocked, showPaywall: $showPaywall)
                }
            }
        }
        .padding(.horizontal, 16)
    }

    private var headerRow: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Likes You")
                    .font(.title3.bold())
                Text("\(likers.count) people liked your profile")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if !isUnlocked {
                Button { showPaywall = true } label: {
                    Text("See All")
                        .font(.caption.bold())
                        .foregroundStyle(Color(red: 0.85, green: 0.62, blue: 0.12))
                }
            }
        }
    }
}

struct LikerCardView: View {
    let liker: Liker
    let isUnlocked: Bool
    @Binding var showPaywall: Bool

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            profileImage
            bottomOverlay
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(alignment: .topTrailing) { if liker.isNew { newBadge } }
        .onTapGesture { if !isUnlocked { showPaywall = true } }
    }

    private var profileImage: some View {
        AsyncImage(url: URL(string: liker.profile.photoURLs.first ?? "")) { img in
            img.resizable().scaledToFill()
        } placeholder: {
            Rectangle().fill(LinearGradient(colors: liker.profile.gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        .frame(height: 180)
        .clipped()
        .overlay { if !isUnlocked { blurOverlay } }
    }

    private var blurOverlay: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .overlay {
                Image(systemName: "lock.fill")
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundStyle(Color(red: 0.85, green: 0.62, blue: 0.12))
            }
    }

    private var bottomOverlay: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(isUnlocked ? "\(liker.profile.name), \(liker.profile.age)" : "???")
                .font(.callout.bold())
                .foregroundStyle(.white)
            Text(liker.timeAgo)
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
        )
    }

    private var newBadge: some View {
        Text("NEW")
            .font(.system(size: 9, weight: .black))
            .foregroundStyle(.white)
            .padding(.horizontal, 6).padding(.vertical, 3)
            .background(Color(red: 0.99, green: 0.27, blue: 0.35))
            .clipShape(Capsule())
            .padding(8)
    }
}
