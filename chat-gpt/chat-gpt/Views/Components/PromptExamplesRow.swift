import SwiftUI

struct PromptExample: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

struct PromptExamplesRow: View {
    var onTap: (String) -> Void
    private let examples = [
        PromptExample(title: "Design a database schema", subtitle: "for an online merch store"),
        PromptExample(title: "Explain airplane", subtitle: "to someone 5 years old"),
        PromptExample(title: "Write a Python script", subtitle: "to automate file renaming")
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(examples) { ex in
                    PromptCard(example: ex, onTap: onTap)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

private struct PromptCard: View {
    let example: PromptExample
    let onTap: (String) -> Void
    private let cardBg = Color(red: 0.965, green: 0.965, blue: 0.965)
    private let subtitleColor = Color(red: 0.235, green: 0.235, blue: 0.263).opacity(0.6)

    var body: some View {
        Button { onTap("\(example.title) \(example.subtitle)") } label: {
            VStack(alignment: .leading, spacing: 1) {
                Text(example.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Text(example.subtitle)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(subtitleColor)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 13)
            .frame(height: 69)
            .background(cardBg)
            .cornerRadius(14)
        }
    }
}
