import Supabase
import Foundation

final class SupabaseService {
    static let shared = SupabaseService()
    private init() {}

    private let client: SupabaseClient = {
        let url = URL(string: "任意のURL")!
        let key = "任意のURL"
        return SupabaseClient(supabaseURL: url, supabaseKey: key)
    }()

    // Auth
    func signInWithApple() async throws {
        try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: ""))
    }
    func getUser() -> User? { client.auth.currentUser }

    // Scenario Fetch (library ≥1.1)
    func fetchScenarios() async throws -> [Scenario] {
        try await client
            .from("SCENARIOS")
            .select()
            .execute()
            .value
    }


    // Generation persistence
    func saveGeneration(_ generation: Generation) async {
        _ = try? await client.database.from("GENERATIONS").insert(generation).execute()
    }
}
