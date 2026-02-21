import SwiftUI

struct ProfileView: View {
    @StateObject private var store = UserProfileStore()
    @State private var showEditSheet = false

    private let pink = Color(red: 0.99, green: 0.27, blue: 0.35)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    headerCard
                    photoSection
                    infoSection
                    PreferencesSection()
                        .environmentObject(store)
                    settingsSection
                    Spacer(minLength: 40)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { editButton }
            .sheet(isPresented: $showEditSheet) {
                EditProfileSheet().environmentObject(store)
            }
        }
    }

    // MARK: Header
    private var headerCard: some View {
        ZStack(alignment: .bottomLeading) {
            avatarImage
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.65)],
                startPoint: .center, endPoint: .bottom
            )
            .frame(height: 300)

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text("\(store.name), \(store.age)")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.blue)
                }
                if !store.occupation.isEmpty {
                    Label(store.occupation, systemImage: "briefcase.fill")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                }
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private var avatarImage: some View {
        if let url = store.photos.first?.urlString, let u = URL(string: url) {
            AsyncImage(url: u) { phase in
                switch phase {
                case .success(let img): img.resizable().scaledToFill()
                default: gradientFallback
                }
            }
        } else {
            gradientFallback
        }
    }

    private var gradientFallback: some View {
        LinearGradient(colors: [pink, Color(red: 0.5, green: 0.1, blue: 0.7)],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    // MARK: Photos
    private var photoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("Photos")
            PhotoGridView().environmentObject(store)
        }
        .padding(.top, 20)
    }

    // MARK: Info
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            sectionHeader("About Me")
                .padding(.horizontal, 16)
            infoCard {
                VStack(alignment: .leading, spacing: 12) {
                    Text(store.bio.isEmpty ? "Add a bio to let people know who you are…" : store.bio)
                        .font(.body)
                        .foregroundStyle(store.bio.isEmpty ? .secondary : .primary)
                    if !store.school.isEmpty {
                        Divider()
                        Label(store.school, systemImage: "graduationcap.fill")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(16)
            }
            .padding(.horizontal, 16)
        }
        .padding(.top, 4)
    }

    private func infoCard<C: View>(@ViewBuilder content: () -> C) -> some View {
        content()
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: Settings
    private var settingsSection: some View {
        VStack(spacing: 0) {
            sectionHeader("Settings")
                .padding(.horizontal, 16)
                .padding(.top, 8)

            VStack(spacing: 0) {
                settingsRow(icon: "bell.fill", color: Color(red: 1, green: 0.6, blue: 0), title: "Notifications")
                Divider().padding(.leading, 52)
                settingsRow(icon: "lock.fill", color: Color(red: 0.2, green: 0.7, blue: 0.4), title: "Privacy")
                Divider().padding(.leading, 52)
                settingsRow(icon: "questionmark.circle.fill", color: Color(red: 0.4, green: 0.6, blue: 1.0), title: "Help & Support")
                Divider().padding(.leading, 52)
                settingsRow(icon: "arrow.right.square.fill", color: Color(.systemGray), title: "Log Out", destructive: true)
            }
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 16)
        }
    }

    private func settingsRow(icon: String, color: Color, title: String, destructive: Bool = false) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            Text(title)
                .font(.body)
                .foregroundColor(destructive ? .red : .primary)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.footnote.weight(.semibold))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
            .padding(.top, 20)
    }

    private var editButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Edit") { showEditSheet = true }
                .foregroundColor(pink)
                .fontWeight(.semibold)
        }
    }
}
