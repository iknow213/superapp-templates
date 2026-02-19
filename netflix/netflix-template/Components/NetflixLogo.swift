import SwiftUI

struct NetflixNBadge: View {
    var size: CGFloat = 16
    var body: some View {
        Text("N")
            .font(.system(size: size, weight: .black))
            .foregroundStyle(Color(red: 0.89, green: 0.07, blue: 0.14))
            .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
    }
}

struct FilterChipsBar: View {
    let chips = ["Shows", "Movies", "Categories"]
    var body: some View {
        HStack(spacing: 8) {
            ForEach(chips, id: \.self) { chip in
                chipButton(chip)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }

    private func chipButton(_ title: String) -> some View {
        let isCategory = title == "Categories"
        return HStack(spacing: 4) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
            if isCategory {
                Image(systemName: "chevron.down")
                    .font(.caption2)
            }
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .stroke(Color.white.opacity(0.4), lineWidth: 1)
        )
    }
}
