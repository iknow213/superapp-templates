import SwiftUI

struct ActionButtonsBar: View {
    let onAction: (CardAction) -> Void

    var body: some View {
        HStack(spacing: 16) {
            SmallActionButton(icon: "arrow.uturn.backward", color: .orange, size: 42) {
                onAction(.rewind)
            }
            LargeActionButton(icon: "xmark", color: Color(red: 0.99, green: 0.27, blue: 0.35), size: 54) {
                onAction(.nope)
            }
            SmallActionButton(icon: "star.fill", color: .blue, size: 42) {
                onAction(.superLike)
            }
            LargeActionButton(icon: "heart.fill", color: Color(red: 0.3, green: 0.85, blue: 0.45), size: 54) {
                onAction(.like)
            }
            SmallActionButton(icon: "bolt.fill", color: .purple, size: 42) {
                onAction(.boost)
            }
        }
        .padding(.horizontal, 24)
    }
}

struct SmallActionButton: View {
    let icon: String
    let color: Color
    let size: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size * 0.35, weight: .bold))
                .foregroundColor(color)
                .frame(width: size, height: size)
                .background(Circle().fill(.white).shadow(color: color.opacity(0.2), radius: 4, y: 2))
        }
    }
}

struct LargeActionButton: View {
    let icon: String
    let color: Color
    let size: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size * 0.38, weight: .bold))
                .foregroundColor(color)
                .frame(width: size, height: size)
                .background(Circle().fill(.white).shadow(color: color.opacity(0.25), radius: 6, y: 3))
        }
    }
}
