import SwiftUI

struct ChatView: View {
    let match: Match
    @State private var messageText = ""
    @State private var messages: [ChatMessage]
    @FocusState private var isInputFocused: Bool
    @Environment(\.dismiss) private var dismiss

    init(match: Match) {
        self.match = match
        self._messages = State(initialValue: match.messages)
    }

    var body: some View {
        VStack(spacing: 0) {
            chatHeader
            Divider()
            messagesList
            inputBar
        }
        .navigationBarHidden(true)
        .background(Color(.systemBackground))
    }

    // MARK: - Header
    private var chatHeader: some View {
        HStack(spacing: 12) {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(red: 0.99, green: 0.27, blue: 0.35))
            }
            Spacer()
            VStack(spacing: 2) {
                ProfileAvatarView(url: match.profile.photoURLs.first, size: 40)
                Text(match.profile.name)
                    .font(.system(size: 14, weight: .semibold))
            }
            Spacer()
            Button {
                // Safety feature placeholder
            } label: {
                Image(systemName: "shield.fill")
                    .font(.system(size: 18))
                    .foregroundColor(.gray.opacity(0.5))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
    }

    // MARK: - Messages List
    private var messagesList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                if messages.isEmpty {
                    emptyChat
                } else {
                    LazyVStack(spacing: 8) {
                        ForEach(messages) { msg in
                            MessageBubble(message: msg)
                                .id(msg.id)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
            }
            .onChange(of: messages) { _ in
                if let last = messages.last {
                    withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                }
            }
        }
    }

    // MARK: - Empty Chat
    private var emptyChat: some View {
        VStack(spacing: 16) {
            ProfileAvatarView(url: match.profile.photoURLs.first, size: 80)
            Text("You matched with \(match.profile.name)!")
                .font(.system(size: 18, weight: .bold))
            Text("Say something nice to start the conversation 💬")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding(.top, 60)
    }

    // MARK: - Input Bar
    private var inputBar: some View {
        HStack(spacing: 12) {
            TextField("Message \(match.profile.name)...", text: $messageText)
                .focused($isInputFocused)
                .font(.system(size: 16))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color(.secondarySystemBackground))
                .clipShape(Capsule())

            Button(action: sendMessage) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(sendButtonStyle)
            }
            .disabled(messageText.isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
    }

    private var sendButtonStyle: some ShapeStyle {
        if messageText.isEmpty {
            return AnyShapeStyle(Color.gray.opacity(0.4))
        }
        return AnyShapeStyle(LinearGradient(
            colors: [Color(red: 0.99, green: 0.27, blue: 0.35), Color(red: 0.99, green: 0.5, blue: 0.2)],
            startPoint: .topLeading, endPoint: .bottomTrailing
        ))
    }

    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let msg = ChatMessage(text: messageText, isFromMe: true, sentAt: Date())
        withAnimation { messages.append(msg) }
        messageText = ""
    }
}

// MARK: - Message Bubble
struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isFromMe { Spacer(minLength: 60) }
            Text(message.text)
                .font(.system(size: 16))
                .foregroundColor(message.isFromMe ? .white : .primary)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(bubbleBg)
                .clipShape(BubbleShape(isFromMe: message.isFromMe))
            if !message.isFromMe { Spacer(minLength: 60) }
        }
    }

    @ViewBuilder
    private var bubbleBg: some View {
        if message.isFromMe {
            LinearGradient(
                colors: [Color(red: 0.99, green: 0.27, blue: 0.35), Color(red: 0.99, green: 0.5, blue: 0.2)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        } else {
            Color(.secondarySystemBackground)
        }
    }
}

// MARK: - Bubble Shape
struct BubbleShape: Shape {
    let isFromMe: Bool
    func path(in rect: CGRect) -> Path {
        let r: CGFloat = 18
        let tail: CGFloat = 6
        var path = Path()
        if isFromMe {
            path.addRoundedRect(in: CGRect(x: rect.minX, y: rect.minY, width: rect.width - tail, height: rect.height), cornerSize: CGSize(width: r, height: r))
        } else {
            path.addRoundedRect(in: CGRect(x: rect.minX + tail, y: rect.minY, width: rect.width - tail, height: rect.height), cornerSize: CGSize(width: r, height: r))
        }
        return path
    }
}

// MARK: - Profile Avatar
struct ProfileAvatarView: View {
    let url: String?
    let size: CGFloat

    var body: some View {
        Group {
            if let urlStr = url, let imageURL = URL(string: urlStr) {
                AsyncImage(url: imageURL) { phase in
                    if let img = phase.image {
                        img.resizable().scaledToFill()
                    } else {
                        Circle().fill(Color(.systemGray4))
                    }
                }
            } else {
                Circle().fill(Color(.systemGray4))
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}
