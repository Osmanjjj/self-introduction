import SwiftUI

struct IntroGeneratorView: View {
    let scenario: Scenario
    @StateObject private var vm = IntroGeneratorViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var quotaVM: QuotaViewModel
    @State private var hints: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("興味・補足を入力 (任意)", text: $hints, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            Button("生成する") {
                Task {
                    let profile = authVM.profile ?? .init(id: UUID(), displayName: "Anon")
                    await vm.generate(for: scenario, profile: profile, hints: hints, quotaVM: quotaVM)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.isGenerating)
            if vm.isGenerating { ProgressView("生成中…") }
            else {
                List(vm.outputCandidates, id: \ .self) { para in
                    Text(para).padding(8).contextMenu { Button("コピー") { UIPasteboard.general.string = para } }
                }
            }
        }
        .padding()
        .navigationTitle(scenario.title)
        .sheet(isPresented: $quotaVM.showPaywall) { PaywallView() }
    }
}
