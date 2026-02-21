import SwiftUI

struct FilterChipsRow: View {
    @Binding var selected: FilterChip

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(FilterChip.allCases) { chip in
                    chipButton(chip)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    private func chipButton(_ chip: FilterChip) -> some View {
        let isSelected = selected == chip
        return Button { selected = chip } label: {
            Text(chip.rawValue)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(isSelected ? .black : .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color(red: 0.11, green: 0.84, blue: 0.38) : Color(white: 0.18))
                .clipShape(Capsule())
        }
    }
}
