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

    func getUser() -> User? { client.auth.currentUser }

    // ---------------- Email 認証 ----------------
    func signUpEmail(email: String, password: String) async throws {
        _ = try await client.auth.signUp(email: email, password: password)
    }

    func signInEmail(email: String, password: String) async throws {
        _ = try await client.auth.signIn(email: email, password: password)
    }

    // ---------------- Scenario 取得 -------------
    func fetchScenarios() async throws -> [Scenario] {
        try await client
            .from("SCENARIOS")
            .select()
            .execute()
            .value
    }

    // ---------------- 生成履歴保存 -------------
    func saveGeneration(_ generation: Generation) async {
        _ = try? await client.from("GENERATIONS").insert(generation).execute()
    }
}
