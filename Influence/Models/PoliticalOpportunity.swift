import Foundation

struct PoliticalOpportunity: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let summary: String
    let requiredInfluence: Int
    let requiredReputation: Int
    let requiredPoliticalCapital: Int
}
