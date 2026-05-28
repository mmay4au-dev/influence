import Foundation

struct BusinessAsset: Identifiable, Hashable {
    let id: UUID
    let name: String
    let propertyID: UUID
    let industry: String
    let monthlyRevenue: Double
    let jobsCreated: Int
    let reputationBoost: Int
    let influenceBoost: Int

    init(
        id: UUID = UUID(),
        name: String,
        propertyID: UUID,
        industry: String,
        monthlyRevenue: Double,
        jobsCreated: Int,
        reputationBoost: Int,
        influenceBoost: Int
    ) {
        self.id = id
        self.name = name
        self.propertyID = propertyID
        self.industry = industry
        self.monthlyRevenue = monthlyRevenue
        self.jobsCreated = jobsCreated
        self.reputationBoost = reputationBoost
        self.influenceBoost = influenceBoost
    }
}
