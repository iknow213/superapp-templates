import SwiftUI

struct Match: Identifiable, Hashable {
    let id = UUID()
    let profile: Profile
    let matchedAt: Date
    var messages: [ChatMessage]

    var lastMessage: ChatMessage? { messages.last }
    var hasUnread: Bool { messages.last?.isFromMe == false && messages.last != nil }

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: Match, rhs: Match) -> Bool { lhs.id == rhs.id }
}

struct ChatMessage: Identifiable, Equatable, Hashable {
    let id = UUID()
    let text: String
    let isFromMe: Bool
    let sentAt: Date

    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool { lhs.id == rhs.id }
}

extension Match {
    static let sampleMatches: [Match] = [
        Match(
            profile: Profile.sampleProfiles[0],
            matchedAt: Date().addingTimeInterval(-3600),
            messages: [
                ChatMessage(text: "Hey! We matched 😊", isFromMe: false, sentAt: Date().addingTimeInterval(-3500)),
                ChatMessage(text: "Hey Sabrina! How's your day going?", isFromMe: true, sentAt: Date().addingTimeInterval(-3400)),
                ChatMessage(text: "Pretty great! Just got back from dance class 💃", isFromMe: false, sentAt: Date().addingTimeInterval(-3300))
            ]
        ),
        Match(
            profile: Profile.sampleProfiles[2],
            matchedAt: Date().addingTimeInterval(-7200),
            messages: [
                ChatMessage(text: "Your photos are amazing! Are you a photographer?", isFromMe: true, sentAt: Date().addingTimeInterval(-7000)),
                ChatMessage(text: "Yes!! I love street photography 📸", isFromMe: false, sentAt: Date().addingTimeInterval(-6900)),
                ChatMessage(text: "We should shoot together sometime!", isFromMe: false, sentAt: Date().addingTimeInterval(-6800))
            ]
        ),
        Match(
            profile: Profile.sampleProfiles[5],
            matchedAt: Date().addingTimeInterval(-86400),
            messages: []
        ),
        Match(
            profile: Profile.sampleProfiles[3],
            matchedAt: Date().addingTimeInterval(-172800),
            messages: [
                ChatMessage(text: "Med school must keep you super busy!", isFromMe: true, sentAt: Date().addingTimeInterval(-170000)),
                ChatMessage(text: "Haha yes but I always make time for good people 😄", isFromMe: false, sentAt: Date().addingTimeInterval(-169000))
            ]
        ),
        Match(
            profile: Profile.sampleProfiles[1],
            matchedAt: Date().addingTimeInterval(-259200),
            messages: [
                ChatMessage(text: "Do you do yoga outdoors? That sounds amazing", isFromMe: true, sentAt: Date().addingTimeInterval(-258000))
            ]
        ),
        Match(
            profile: Profile.sampleProfiles[6],
            matchedAt: Date().addingTimeInterval(-345600),
            messages: []
        )
    ]
}
