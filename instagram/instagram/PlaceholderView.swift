import SwiftUI

struct PlaceholderView: View {
    let title: String
    let icon: String

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 56))
                    .foregroundStyle(.gray.opacity(0.5))
                Text(title)
                    .font(.title2).fontWeight(.semibold)
                    .foregroundStyle(.gray.opacity(0.7))
                Text("Coming soon")
                    .font(.subheadline)
                    .foregroundStyle(.gray.opacity(0.4))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
