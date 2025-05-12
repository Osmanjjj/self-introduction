import Foundation

struct OpenAIService {
    static func generateIntro(for scenario: Scenario, profile: UserProfile, hints: String?) async throws -> [String] {
        // Supabase Edge Function にリクエストを転送（GPT-4o ⇔ 秘匿）
        var request = URLRequest(url: URL(string: "https://YOUR_PROJECT.functions.supabase.co/generate-intro")!) // ←差し替え
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let payload: [String: Any] = [
            "scenario_id": scenario.id,
            "profile": try JSONEncoder().encode(profile).base64EncodedString(),
            "hints": hints ?? ""
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: payload)

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([String].self, from: data) // 3 paragraphs
    }
}
