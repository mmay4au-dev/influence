import Foundation

struct PlayerProfile {
    var name: String
    var homeCity: City
    var cash: Double
    var monthlyIncome: Double
    var influence: Int
    var reputation: Int
    var politicalCapital: Int
    var ownedProperties: [PropertyAsset]
    var businesses: [BusinessAsset]
    var currentCareerPath: CareerPath?
}
