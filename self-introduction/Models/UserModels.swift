import Foundation

struct UserProfile: Identifiable, Codable {
    var id: UUID
    var displayName: String
    var jobTitle: String?
    var hobbies: [String] = []
    var languages: [String] = [Locale.current.language.languageCode?.identifier ?? "ja"]
}

struct Scenario: Identifiable, Codable {
    let id: Int
    let category: String
    let title: String
    let promptTemplate: String
    let language: String
}

struct Generation: Identifiable, Codable {
    let id: UUID
    let scenarioID: Int
    let inputMeta: [String: String]
    let outputText: String
    let createdAt: Date
}
