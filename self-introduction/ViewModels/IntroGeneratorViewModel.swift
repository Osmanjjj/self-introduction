import SwiftUI
import Combine

@MainActor
final class IntroGeneratorViewModel: ObservableObject {
    @Published var outputCandidates: [String] = []
    @Published var isGenerating = false

    func generate(for scenario: Scenario, profile: UserProfile, hints: String?, quotaVM: QuotaViewModel) async {
        guard quotaVM.canGenerate else { quotaVM.showPaywall = true; return }
        isGenerating = true
        defer { isGenerating = false }
        do {
            outputCandidates = try await OpenAIService.generateIntro(for: scenario, profile: profile, hints: hints)
            quotaVM.consume()
        } catch { print("Generation error: \(error)") }
    }
}
