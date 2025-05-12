import SwiftUI
import Supabase

@main
struct self_introductionApp: App {
    @StateObject private var authVM = AuthViewModel()
    @StateObject private var scenarioVM = ScenarioListViewModel()
    @StateObject private var quotaVM = QuotaViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authVM)
                .environmentObject(scenarioVM)
                .environmentObject(quotaVM)
        }
    }
}
