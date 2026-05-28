import Foundation

struct CareerPath: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let summary: String
    let incomeModifier: Double
    let influenceStyle: String
    let startingIncome: Double
    let startingInfluence: Int
    let startingReputation: Int
}
