import SwiftUI
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published private(set) var isSignedIn = false
    @Published var profile: UserProfile?

    func signIn() async {
        do {
            try await SupabaseService.shared.signInWithApple()
            isSignedIn = SupabaseService.shared.getUser() != nil
        } catch { print("Auth error: \(error)") }
    }
}
