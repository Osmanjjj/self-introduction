import SwiftUI
import Combine

@MainActor
final class QuotaViewModel: ObservableObject {
    @Published private(set) var remaining = 3 // 無料枠
    @Published var showPaywall = false

    var canGenerate: Bool { remaining > 0 || isSubscriber }
    private var isSubscriber: Bool {
        (SupabaseService.shared.getUser()?.appMetadata["is_subscriber"] as? Bool) ?? false
    }

    func consume() { if !isSubscriber { remaining -= 1 } }
}
