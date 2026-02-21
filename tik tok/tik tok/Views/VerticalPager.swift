import SwiftUI

struct VerticalPager<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let pageSize: CGSize
    let content: Content

    @GestureState private var dragOffset: CGFloat = 0

    init(pageCount: Int, currentIndex: Binding<Int>, pageSize: CGSize, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.pageSize = pageSize
        self.content = content()
    }

    var body: some View {
        let offset = -CGFloat(currentIndex) * pageSize.height + dragOffset
        VStack(spacing: 0) {
            content
        }
        .offset(y: offset)
        .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.86), value: currentIndex)
        .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.86), value: dragOffset)
        .gesture(dragGesture)
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                state = value.translation.height
            }
            .onEnded { value in
                let threshold: CGFloat = pageSize.height * 0.2
                let predicted = value.predictedEndTranslation.height
                if predicted < -threshold && currentIndex < pageCount - 1 {
                    currentIndex += 1
                } else if predicted > threshold && currentIndex > 0 {
                    currentIndex -= 1
                }
            }
    }
}
