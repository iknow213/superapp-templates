import Foundation
#if canImport(FoundationModels)
import FoundationModels
#endif

@MainActor
class AppleIntelligenceService: ObservableObject {
    static let shared = AppleIntelligenceService()
    
    @Published var isAvailable = false
    @Published var isGenerating = false
    
    private init() {
        checkAvailability()
    }
    
    func checkAvailability() {
        #if canImport(FoundationModels)
        if #available(iOS 26.0, *) {
            let availability = SystemLanguageModel.default.availability
            switch availability {
            case .available:
                isAvailable = true
            case .unavailable:
                isAvailable = false
            default:
                isAvailable = false
            }
        } else {
            isAvailable = false
        }
        #else
        isAvailable = false
        #endif
    }
    
    func sendMessage(_ text: String) async -> String {
        #if canImport(FoundationModels)
        if #available(iOS 26.0, *) {
            return await sendWithFoundationModels(text)
        }
        #endif
        return fallbackResponse()
    }
    
    func streamMessage(_ text: String) -> AsyncStream<String> {
        AsyncStream { continuation in
            Task { @MainActor in
                #if canImport(FoundationModels)
                if #available(iOS 26.0, *) {
                    await self.streamWithFoundationModels(text, continuation: continuation)
                    return
                }
                #endif
                let fb = self.fallbackResponse()
                continuation.yield(fb)
                continuation.finish()
            }
        }
    }
    
    func resetSession() {
        // Session is created per-call now
    }
    
    #if canImport(FoundationModels)
    @available(iOS 26.0, *)
    private func sendWithFoundationModels(_ text: String) async -> String {
        isGenerating = true
        defer { isGenerating = false }
        do {
            let session = LanguageModelSession(instructions: "You are Andi, a helpful, concise, and friendly AI assistant. Answer questions clearly. Keep responses focused and well-structured.")
            let response = try await session.respond(to: text)
            return response.content
        } catch {
            NSLog("Apple Intelligence error: \(error)")
            return "Sorry, I couldn't process that request. Please try again."
        }
    }
    
    @available(iOS 26.0, *)
    private func streamWithFoundationModels(_ text: String, continuation: AsyncStream<String>.Continuation) async {
        isGenerating = true
        do {
            let session = LanguageModelSession(instructions: "You are Andi, a helpful, concise, and friendly AI assistant. Answer questions clearly. Keep responses focused and well-structured.")
            let stream = session.streamResponse(to: text)
            var fullText = ""
            for try await partial in stream {
                fullText = partial.content
                continuation.yield(fullText)
            }
            continuation.finish()
        } catch {
            NSLog("Apple Intelligence stream error: \(error)")
            continuation.yield("Sorry, I couldn't process that. Please try again.")
            continuation.finish()
        }
        isGenerating = false
    }
    #endif
    
    private func fallbackResponse() -> String {
        return "Apple Intelligence requires an iPhone or iPad with Apple Silicon running iOS 26 or later. Please update your device to use on-device AI."
    }
}
