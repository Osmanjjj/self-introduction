import SwiftUI
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published private(set) var isSignedIn = false
    @Published var profile: UserProfile?

    func signIn(email: String, password: String) async throws {
        try await SupabaseService.shared.signInEmail(email: email, password: password)
        isSignedIn = SupabaseService.shared.getUser() != nil
    }

    func signUp(email: String, password: String) async throws {
        try await SupabaseService.shared.signUpEmail(email: email, password: password)
        isSignedIn = SupabaseService.shared.getUser() != nil
    }
}
