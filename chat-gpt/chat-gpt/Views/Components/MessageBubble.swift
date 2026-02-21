import SwiftUI

struct MessageBubble: View {
    let message: ChatMessage
    private var isUser: Bool { message.role == .user }

    var body: some View {
        HStack {
            if isUser { Spacer(minLength: 60) }
            if !isUser { assistantAvatar }
            textContent
            if !isUser { Spacer(minLength: 60) }
        }
    }

    @ViewBuilder
    private var assistantAvatar: some View {
        ZStack {
            Circle()
                .fill(Color.black)
                .frame(width: 28, height: 28)
            Image(systemName: "atom")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
        }
    }

    @ViewBuilder
    private var textContent: some View {
        let bgColor: Color = isUser ? Color(red: 0.965, green: 0.965, blue: 0.965) : .clear
        Text(message.content)
            .font(.system(size: 16))
            .foregroundColor(.black)
            .padding(.horizontal, isUser ? 16 : 8)
            .padding(.vertical, isUser ? 12 : 4)
            .background(bgColor)
            .cornerRadius(18)
    }
}
