import SwiftUI

struct SwipeCardView: View {
    let profile: Profile
    let isTop: Bool
    let onSwiped: (SwipeDirection) -> Void

    @State private var offset: CGSize = .zero
    @State private var rotation: Double = 0

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                guard isTop else { return }
                offset = value.translation
                rotation = Double(value.translation.width / 20)
            }
            .onEnded { value in
                guard isTop else { return }
                handleSwipeEnd(translation: value.translation)
            }
    }

    var body: some View {
        CardContent(profile: profile, offset: offset)
            .offset(x: offset.width, y: offset.height)
            .rotationEffect(.degrees(rotation))
            .gesture(dragGesture)
            .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.7), value: offset)
    }

    private func handleSwipeEnd(translation: CGSize) {
        let threshold: CGFloat = 120
        if translation.width > threshold {
            offset = CGSize(width: 600, height: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { onSwiped(.right) }
        } else if translation.width < -threshold {
            offset = CGSize(width: -600, height: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { onSwiped(.left) }
        } else if translation.height < -threshold {
            offset = CGSize(width: 0, height: -600)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { onSwiped(.up) }
        } else {
            offset = .zero
            rotation = 0
        }
    }
}
