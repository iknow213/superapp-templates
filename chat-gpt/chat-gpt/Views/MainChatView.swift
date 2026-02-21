import SwiftUI

struct MainChatView: View {
    @Binding var showSidebar: Bool
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = []
    @State private var selectedModel: ChatModel = .appleIntelligence
    @State private var currentConversation: Conversation?
    @StateObject private var aiService = AppleIntelligenceService.shared
    @StateObject private var storage = LocalStorageService.shared

    var body: some View {
        VStack(spacing: 0) {
            NavigationBarView(showSidebar: $showSidebar, selectedModel: $selectedModel)
            if messages.isEmpty {
                emptyStateContent
            } else {
                messagesList
            }
            inputBarSection
        }
        .background(Color.white)
    }

    @ViewBuilder
    private var emptyStateContent: some View {
        VStack(spacing: 0) {
            Spacer()
            LogoAnimation().padding(.bottom, 12)
            aiBadge.padding(.bottom, 28)
            PromptExamplesRow { prompt in sendMessage(prompt) }
            Spacer()
        }
    }

    @ViewBuilder
    private var aiBadge: some View {
        let available = aiService.isAvailable
        let badgeText = available ? "Apple Intelligence Active" : "Apple Intelligence – Requires iOS 26"
        let badgeIcon = available ? "apple.intelligence" : "info.circle"
        let badgeColors: [Color] = available
            ? [Color(hex: "6C5CE7"), Color(hex: "A855F7")]
            : [Color.gray.opacity(0.5), Color.gray.opacity(0.7)]
        HStack(spacing: 6) {
            Image(systemName: badgeIcon)
                .font(.system(size: 12, weight: .semibold))
            Text(badgeText)
                .font(.system(size: 12, weight: .semibold))
        }
        .foregroundColor(.white)
        .padding(.horizontal, 14)
        .padding(.vertical, 7)
        .background(LinearGradient(colors: badgeColors, startPoint: .leading, endPoint: .trailing))
        .clipShape(Capsule())
    }

    @ViewBuilder
    private var messagesList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(messages) { msg in
                        MessageBubble(message: msg).id(msg.id)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 8)
            }
            .onChange(of: messages.count) { _, _ in
                if let last = messages.last?.id {
                    withAnimation(.easeOut(duration: 0.2)) { proxy.scrollTo(last, anchor: .bottom) }
                }
            }
        }
    }

    @ViewBuilder
    private var inputBarSection: some View {
        InputBarView(text: $messageText, isLoading: aiService.isGenerating) {
            guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
            sendMessage(messageText)
            messageText = ""
        }
        .padding(.bottom, 8)
    }

    private func ensureConversation() -> Conversation {
        if let conv = currentConversation { return conv }
        let conv = storage.createConversation(title: "New Chat", model: selectedModel.rawValue)
        currentConversation = conv
        return conv
    }

    private func sendMessage(_ text: String) {
        let conv = ensureConversation()
        let userMsg = ChatMessage(id: UUID(), role: .user, content: text)
        messages.append(userMsg)
        storage.saveMessage(userMsg, conversationId: conv.id)

        Task {
            let replyId = UUID()
            let stream = aiService.streamMessage(text)
            var fullResponse = ""
            for await chunk in stream {
                fullResponse = chunk
                let updated = ChatMessage(id: replyId, role: .assistant, content: fullResponse)
                if let idx = messages.firstIndex(where: { $0.id == replyId }) {
                    messages[idx] = updated
                } else {
                    messages.append(updated)
                }
            }
            if fullResponse.isEmpty {
                fullResponse = "I couldn't generate a response. Please try again."
                let fb = ChatMessage(id: replyId, role: .assistant, content: fullResponse)
                if let idx = messages.firstIndex(where: { $0.id == replyId }) {
                    messages[idx] = fb
                } else {
                    messages.append(fb)
                }
            }
            let finalMsg = ChatMessage(id: replyId, role: .assistant, content: fullResponse)
            storage.saveMessage(finalMsg, conversationId: conv.id)
        }
    }
}
