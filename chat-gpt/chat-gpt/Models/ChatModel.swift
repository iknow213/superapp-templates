import Foundation

enum ChatModel: String, CaseIterable, Identifiable {
    case appleIntelligence = "Apple Intelligence"
    case gpt4o = "GPT-4o"
    case gpt4oMini = "GPT-4o mini"

    var id: String { rawValue }

    var displayName: String {
        rawValue
    }

    var subtitle: String {
        switch self {
        case .appleIntelligence:
            return "On-Device"
        case .gpt4o:
            return "4o"
        case .gpt4oMini:
            return "4o mini"
        }
    }

    var iconName: String {
        switch self {
        case .appleIntelligence:
            return "apple.intelligence"
        case .gpt4o, .gpt4oMini:
            return "brain"
        }
    }
}
