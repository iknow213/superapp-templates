import SwiftUI

struct InputBarView: View {
    @Binding var text: String
    var isLoading: Bool = false
    var onSend: () -> Void
    private let borderColor = Color(red: 0.898, green: 0.898, blue: 0.918)
    private let placeholderColor = Color(red: 0.235, green: 0.235, blue: 0.235).opacity(0.3)
    private let micColor = Color(red: 0.235, green: 0.235, blue: 0.263).opacity(0.6)

    var body: some View {
        HStack(spacing: 12) {
            addButton
            inputField
            sendOrHeadphonesButton
        }
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    private var addButton: some View {
        Button {} label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.black)
        }
        .frame(width: 24, height: 24)
    }

    @ViewBuilder
    private var inputField: some View {
        HStack(spacing: 8) {
            TextField("Message", text: $text)
                .font(.system(size: 17))
                .foregroundColor(.black)
                .submitLabel(.send)
                .onSubmit { if !isLoading { onSend() } }
                .disabled(isLoading)
            Button {} label: {
                Image(systemName: "mic.fill")
                    .font(.system(size: 16))
                    .foregroundColor(micColor)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 38)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(borderColor, lineWidth: 1)
        )
    }

    @ViewBuilder
    private var sendOrHeadphonesButton: some View {
        let hasText = !text.trimmingCharacters(in: .whitespaces).isEmpty
        if hasText && !isLoading {
            Button { onSend() } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.black)
            }
            .frame(width: 28, height: 28)
        } else if isLoading {
            ProgressView()
                .frame(width: 24, height: 24)
        } else {
            Button {} label: {
                Image(systemName: "headphones")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.black)
            }
            .frame(width: 24, height: 24)
        }
    }
}
