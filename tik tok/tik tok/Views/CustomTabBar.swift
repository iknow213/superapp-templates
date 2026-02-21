import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let onCreateTap: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(icon: "house.fill", label: "Home", isSelected: selectedTab == 0)
                .onTapGesture { selectedTab = 0 }
            TabBarButton(icon: "person.2.fill", label: "Friends", isSelected: selectedTab == 1)
                .onTapGesture { selectedTab = 1 }
            CreateButton(onTap: onCreateTap)
            TabBarButton(icon: "message.fill", label: "Inbox", isSelected: selectedTab == 3, badgeCount: 1)
                .onTapGesture { selectedTab = 3 }
            TabBarButton(icon: "person.fill", label: "Profile", isSelected: selectedTab == 4)
                .onTapGesture { selectedTab = 4 }
        }
        .padding(.top, 8)
        .padding(.bottom, 20)
        .background(tabBackground)
    }

    private var tabBackground: some View {
        LinearGradient(
            colors: [Color.black.opacity(0.95), Color.black],
            startPoint: .top, endPoint: .bottom
        )
        .ignoresSafeArea(edges: .bottom)
    }
}

private struct TabBarButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    var badgeCount: Int = 0

    var body: some View {
        VStack(spacing: 2) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                if badgeCount > 0 { badge }
            }
            Text(label)
                .font(.system(size: 10))
        }
        .foregroundColor(isSelected ? .white : .gray)
        .frame(maxWidth: .infinity)
    }

    private var badge: some View {
        Text("\(badgeCount)")
            .font(.system(size: 9, weight: .bold))
            .foregroundColor(.white)
            .padding(3)
            .background(Color.red)
            .clipShape(Circle())
            .offset(x: 8, y: -4)
    }
}

private struct CreateButton: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: "25F4EE"))
                    .frame(width: 42, height: 28)
                    .offset(x: -4)
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: "FE2C55"))
                    .frame(width: 42, height: 28)
                    .offset(x: 4)
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .frame(width: 42, height: 28)
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
