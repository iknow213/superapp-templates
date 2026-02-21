import SwiftUI

struct ExploreFilterBar: View {
    @Binding var selected: String
    let options: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(options, id: \.self) { option in
                    filterChip(option)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
        }
    }

    private func filterChip(_ title: String) -> some View {
        let isSelected = selected == title
        return Button {
            withAnimation(.spring(response: 0.3)) { selected = title }
        } label: {
            Text(title)
                .font(.subheadline.weight(isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    isSelected
                        ? AnyShapeStyle(LinearGradient(
                            colors: [Color(red:0.99,green:0.27,blue:0.35), Color(red:0.85,green:0.1,blue:0.45)],
                            startPoint: .leading, endPoint: .trailing))
                        : AnyShapeStyle(Color(.secondarySystemBackground))
                )
                .clipShape(Capsule())
                .shadow(color: isSelected ? Color(red:0.99,green:0.27,blue:0.35).opacity(0.35) : .clear, radius: 6, x: 0, y: 2)
        }
    }
}
