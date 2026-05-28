import Foundation
import MapKit

@MainActor
final class GameViewModel: ObservableObject {
    @Published private(set) var player: PlayerProfile
    @Published private(set) var availableProperties: [PropertyAsset]
    @Published private(set) var careerPaths: [CareerPath]
    @Published private(set) var politicalOpportunities: [PoliticalOpportunity]
    @Published private(set) var latestEvent: GameEvent?
    @Published private(set) var currentMonth = 1

    init() {
        let city = MockGameData.orangeBeach
        self.player = PlayerProfile(
            name: "New Citizen",
            homeCity: city,
            cash: 275_000,
            monthlyIncome: 2_500,
            influence: 12,
            reputation: 8,
            politicalCapital: 0,
            ownedProperties: [],
            businesses: [],
            currentCareerPath: nil
        )
        self.availableProperties = MockGameData.properties
        self.careerPaths = MockGameData.careerPaths
        self.politicalOpportunities = MockGameData.politicalOpportunities
    }

    var mapRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: player.homeCity.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        )
    }

    var totalAssetIncome: Double {
        player.ownedProperties.reduce(0) { $0 + $1.monthlyRevenue }
            + player.businesses.reduce(0) { $0 + $1.monthlyRevenue }
    }

    var totalInfluenceContribution: Int {
        player.ownedProperties.reduce(0) { $0 + $1.influenceBoost }
            + player.businesses.reduce(0) { $0 + $1.influenceBoost }
    }

    var nextSuggestedAction: String {
        if player.currentCareerPath == nil {
            return "Choose a career path to define how you build influence."
        }

        if player.ownedProperties.isEmpty {
            return "Acquire a first visible local asset from the map."
        }

        if player.businesses.isEmpty {
            return "Start a business from an owned property."
        }

        if unlockedOpportunities.isEmpty {
            return "Advance months to grow influence toward your first civic opening."
        }

        return "Use your growing base to pursue civic power."
    }

    var influenceMetrics: [InfluenceMetric] {
        [
            InfluenceMetric(title: "Influence", value: player.influence, systemImage: "sparkles"),
            InfluenceMetric(title: "Reputation", value: player.reputation, systemImage: "person.2.fill"),
            InfluenceMetric(title: "Political", value: player.politicalCapital, systemImage: "building.columns.fill")
        ]
    }

    var unlockedOpportunities: [PoliticalOpportunity] {
        politicalOpportunities.filter(isUnlocked)
    }

    func chooseCareer(_ career: CareerPath) {
        guard player.currentCareerPath?.id != career.id else { return }
        player.currentCareerPath = career
        player.monthlyIncome = career.startingIncome
        player.influence += career.startingInfluence
        player.reputation += career.startingReputation
    }

    func purchase(_ property: PropertyAsset) {
        guard property.ownerStatus == .purchasable, player.cash >= property.purchasePrice else { return }
        guard let index = availableProperties.firstIndex(where: { $0.id == property.id }) else { return }

        player.cash -= property.purchasePrice
        availableProperties[index].ownerStatus = .owned
        player.ownedProperties.append(availableProperties[index])
    }

    func startBusiness(from property: PropertyAsset) {
        guard player.ownedProperties.contains(where: { $0.id == property.id }) else { return }
        guard !player.businesses.contains(where: { $0.propertyID == property.id }) else { return }

        let business = BusinessAsset(
            name: businessName(for: property),
            propertyID: property.id,
            industry: property.type.rawValue,
            monthlyRevenue: max(1_200, property.monthlyRevenue * 0.72),
            jobsCreated: max(2, property.influenceBoost / 2),
            reputationBoost: max(1, property.influenceBoost / 3),
            influenceBoost: max(2, property.influenceBoost / 2)
        )

        player.businesses.append(business)
        player.reputation += business.reputationBoost
        player.influence += business.influenceBoost
    }

    func advanceMonth() {
        currentMonth += 1

        let careerIncome = player.monthlyIncome
        let assetIncome = totalAssetIncome
        let careerModifier = player.currentCareerPath?.incomeModifier ?? 1.0
        let income = (careerIncome + assetIncome) * careerModifier

        player.cash += income
        player.influence += max(1, totalInfluenceContribution / 2)
        player.reputation += player.businesses.reduce(0) { $0 + $1.reputationBoost }
        player.politicalCapital += max(1, player.influence / 35)

        if let event = MockGameData.events.randomElement() {
            latestEvent = event
            player.influence += event.influenceChange
            player.reputation += event.reputationChange
            player.politicalCapital += event.politicalCapitalChange
        }
    }

    func isUnlocked(_ opportunity: PoliticalOpportunity) -> Bool {
        player.influence >= opportunity.requiredInfluence
            && player.reputation >= opportunity.requiredReputation
            && player.politicalCapital >= opportunity.requiredPoliticalCapital
    }

    private func businessName(for property: PropertyAsset) -> String {
        switch property.type {
        case .waterfrontRetail:
            return "Harbor Market Group"
        case .officeSuite:
            return "Civic Strategy Office"
        case .restaurantSpace:
            return "Gulf Table Hospitality"
        case .residentialLot:
            return "Workforce Homes Initiative"
        case .marinaParcel:
            return "Marina Services Co."
        }
    }
}
