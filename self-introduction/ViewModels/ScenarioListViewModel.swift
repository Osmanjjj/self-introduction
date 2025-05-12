import SwiftUI
import Combine

@MainActor
final class ScenarioListViewModel: ObservableObject {
    @Published var scenarios: [Scenario] = []
    @Published var isLoading = false

    func load() async {
        isLoading = true
        defer { isLoading = false }
        do { scenarios = try await SupabaseService.shared.fetchScenarios() }
        catch { print("Scenario fetch error: \(error)") }
    }
}
