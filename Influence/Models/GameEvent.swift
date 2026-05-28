import Foundation

struct GameEvent: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let summary: String
    let influenceChange: Int
    let reputationChange: Int
    let politicalCapitalChange: Int
}
