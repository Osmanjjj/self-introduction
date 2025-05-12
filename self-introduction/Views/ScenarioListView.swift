import SwiftUI

struct ScenarioListView: View {
    @EnvironmentObject var scenarioVM: ScenarioListViewModel
    var body: some View {
        NavigationStack {
            List(scenarioVM.scenarios) { scenario in
                NavigationLink(scenario.title) { IntroGeneratorView(scenario: scenario) }
            }
            .navigationTitle("シナリオ")
            .overlay { if scenarioVM.isLoading { ProgressView() } }
        }
        .task { await scenarioVM.load() }
    }
}
