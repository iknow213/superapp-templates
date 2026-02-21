import SwiftUI

struct PreferencesSection: View {
    @EnvironmentObject var store: UserProfileStore

    var body: some View {
        VStack(spacing: 0) {
            sectionHeader("Discovery Preferences")

            preferenceCard {
                VStack(spacing: 16) {
                    showMeRow
                    Divider()
                    distanceRow
                    Divider()
                    ageRangeRow
                }
                .padding(16)
            }
        }
        .padding(.horizontal, 16)
    }

    private var showMeRow: some View {
        HStack {
            prefLabel(icon: "eye.fill", color: Color(red: 0.99, green: 0.27, blue: 0.35), title: "Show Me")
            Spacer()
            Picker("", selection: $store.selectedShowMe) {
                ForEach(store.showMeOptions, id: \.self) { Text($0).tag($0) }
            }
            .pickerStyle(.menu)
            .tint(Color(red: 0.99, green: 0.27, blue: 0.35))
        }
    }

    private var distanceRow: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                prefLabel(icon: "location.fill", color: Color(red: 0.4, green: 0.6, blue: 1.0), title: "Max Distance")
                Spacer()
                Text("\(Int(store.maxDistance)) mi")
                    .font(.subheadline.bold())
                    .foregroundColor(Color(red: 0.99, green: 0.27, blue: 0.35))
            }
            Slider(value: $store.maxDistance, in: 1...100, step: 1)
                .tint(Color(red: 0.99, green: 0.27, blue: 0.35))
        }
    }

    private var ageRangeRow: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                prefLabel(icon: "calendar", color: Color(red: 0.6, green: 0.3, blue: 0.9), title: "Age Range")
                Spacer()
                Text("\(Int(store.minAge)) – \(Int(store.maxAge))")
                    .font(.subheadline.bold())
                    .foregroundColor(Color(red: 0.99, green: 0.27, blue: 0.35))
            }
            HStack(spacing: 12) {
                Text("Min")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(width: 24)
                Slider(value: $store.minAge, in: 18...Double(store.maxAge - 1), step: 1)
                    .tint(Color(red: 0.99, green: 0.27, blue: 0.35))
            }
            HStack(spacing: 12) {
                Text("Max")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(width: 24)
                Slider(value: $store.maxAge, in: Double(store.minAge + 1)...60, step: 1)
                    .tint(Color(red: 0.99, green: 0.27, blue: 0.35))
            }
        }
    }

    private func prefLabel(icon: String, color: Color, title: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 13))
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 7))
            Text(title)
                .font(.subheadline)
        }
    }

    private func preferenceCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.footnote.weight(.semibold))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
            .padding(.top, 20)
    }
}
