import Foundation

@MainActor
final class LocalStorageService: ObservableObject {
    static let shared = LocalStorageService()

    @Published var conversations: [Conversation] = []
    @Published var currentUser: AppUser

    private let conversationsKey = "stored_conversations"
    private let messagesKeyPrefix = "messages_"
    private let userKey = "stored_user"

    private init() {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let user = try? JSONDecoder.iso.decode(AppUser.self, from: data) {
            currentUser = user
        } else {
            let newUser = AppUser()
            currentUser = newUser
            if let data = try? JSONEncoder.iso.encode(newUser) {
                UserDefaults.standard.set(data, forKey: userKey)
            }
        }
        loadConversations()
    }

    // MARK: - Conversations

    func loadConversations() {
        guard let data = UserDefaults.standard.data(forKey: conversationsKey),
              let convos = try? JSONDecoder.iso.decode([Conversation].self, from: data) else {
            conversations = []
            return
        }
        conversations = convos.sorted { $0.updatedAt > $1.updatedAt }
    }

    func createConversation(title: String, model: String) -> Conversation {
        let conv = Conversation(userId: currentUser.id, title: title, model: model)
        conversations.insert(conv, at: 0)
        saveConversations()
        return conv
    }

    func updateConversationTitle(_ id: UUID, title: String) {
        guard let idx = conversations.firstIndex(where: { $0.id == id }) else { return }
        conversations[idx].title = title
        conversations[idx].updatedAt = Date()
        saveConversations()
    }

    private func saveConversations() {
        if let data = try? JSONEncoder.iso.encode(conversations) {
            UserDefaults.standard.set(data, forKey: conversationsKey)
        }
    }

    // MARK: - Messages

    func loadMessages(for conversationId: UUID) -> [ChatMessage] {
        let key = messagesKeyPrefix + conversationId.uuidString
        guard let data = UserDefaults.standard.data(forKey: key),
              let msgs = try? JSONDecoder.iso.decode([ChatMessage].self, from: data) else {
            return []
        }
        return msgs.sorted { $0.timestamp < $1.timestamp }
    }

    func saveMessage(_ message: ChatMessage, conversationId: UUID) {
        var msgs = loadMessages(for: conversationId)
        msgs.append(message)
        let key = messagesKeyPrefix + conversationId.uuidString
        if let data = try? JSONEncoder.iso.encode(msgs) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

private extension JSONDecoder {
    static var iso: JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }
}

private extension JSONEncoder {
    static var iso: JSONEncoder {
        let e = JSONEncoder()
        e.dateEncodingStrategy = .iso8601
        return e
    }
}
