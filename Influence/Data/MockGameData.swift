import CoreLocation
import Foundation

enum MockGameData {
    static let orangeBeach = City(
        name: "Orange Beach",
        state: "AL",
        coordinate: CLLocationCoordinate2D(latitude: 30.2697, longitude: -87.5868),
        population: 8_300,
        economicHealth: 72,
        civicTrust: 58,
        dominantIndustries: ["Tourism", "Hospitality", "Marine Services"],
        localIssues: ["Coastal resilience", "Seasonal traffic", "Workforce housing"]
    )

    static let properties: [PropertyAsset] = [
        PropertyAsset(
            name: "Canal Road Retail Strip",
            type: .waterfrontRetail,
            coordinate: CLLocationCoordinate2D(latitude: 30.2802, longitude: -87.5907),
            purchasePrice: 185_000,
            monthlyRevenue: 2_350,
            influenceBoost: 5
        ),
        PropertyAsset(
            name: "Beachside Cafe Space",
            type: .restaurantSpace,
            coordinate: CLLocationCoordinate2D(latitude: 30.2586, longitude: -87.6282),
            purchasePrice: 240_000,
            monthlyRevenue: 3_200,
            influenceBoost: 8
        ),
        PropertyAsset(
            name: "Marina Service Parcel",
            type: .marinaParcel,
            coordinate: CLLocationCoordinate2D(latitude: 30.2891, longitude: -87.5524),
            purchasePrice: 320_000,
            monthlyRevenue: 4_100,
            influenceBoost: 11
        ),
        PropertyAsset(
            name: "Town Center Office Suite",
            type: .officeSuite,
            coordinate: CLLocationCoordinate2D(latitude: 30.2716, longitude: -87.5794),
            purchasePrice: 155_000,
            monthlyRevenue: 1_850,
            influenceBoost: 4
        ),
        PropertyAsset(
            name: "Back Bay Residential Lot",
            type: .residentialLot,
            coordinate: CLLocationCoordinate2D(latitude: 30.3054, longitude: -87.6010),
            purchasePrice: 125_000,
            monthlyRevenue: 1_250,
            influenceBoost: 3
        )
    ]

    static let careerPaths: [CareerPath] = [
        CareerPath(
            name: "Real Estate Investor",
            summary: "Builds influence by controlling visible local property and shaping development.",
            incomeModifier: 1.18,
            influenceStyle: "Property ownership and neighborhood visibility",
            startingIncome: 3_400,
            startingInfluence: 8,
            startingReputation: 4
        ),
        CareerPath(
            name: "Restaurant Owner",
            summary: "Builds influence through jobs, hospitality, and daily community touchpoints.",
            incomeModifier: 1.10,
            influenceStyle: "Jobs, foot traffic, and public goodwill",
            startingIncome: 3_000,
            startingInfluence: 6,
            startingReputation: 8
        ),
        CareerPath(
            name: "Community Organizer",
            summary: "Builds influence by connecting residents, surfacing local issues, and earning trust.",
            incomeModifier: 0.92,
            influenceStyle: "Relationships, issue advocacy, and civic trust",
            startingIncome: 2_400,
            startingInfluence: 10,
            startingReputation: 10
        )
    ]

    static let politicalOpportunities: [PoliticalOpportunity] = [
        PoliticalOpportunity(
            title: "Chamber of Commerce",
            summary: "Join the local business circle and gain access to civic deal flow.",
            requiredInfluence: 20,
            requiredReputation: 10,
            requiredPoliticalCapital: 0
        ),
        PoliticalOpportunity(
            title: "Planning Board",
            summary: "Shape land use debates and become visible to property owners.",
            requiredInfluence: 40,
            requiredReputation: 25,
            requiredPoliticalCapital: 8
        ),
        PoliticalOpportunity(
            title: "City Council",
            summary: "Run for a city seat with a local base and campaign network.",
            requiredInfluence: 75,
            requiredReputation: 45,
            requiredPoliticalCapital: 20
        ),
        PoliticalOpportunity(
            title: "Mayor",
            summary: "Lead the city agenda after building broad public trust.",
            requiredInfluence: 130,
            requiredReputation: 75,
            requiredPoliticalCapital: 45
        )
    ]

    static let events: [GameEvent] = [
        GameEvent(
            title: "Local Spotlight",
            summary: "A neighborhood newsletter featured one of your investments.",
            influenceChange: 4,
            reputationChange: 2,
            politicalCapitalChange: 1
        ),
        GameEvent(
            title: "Hiring Push",
            summary: "Your local operations added visible seasonal jobs.",
            influenceChange: 3,
            reputationChange: 4,
            politicalCapitalChange: 1
        ),
        GameEvent(
            title: "Civic Forum",
            summary: "You showed up at a public meeting and backed a practical compromise.",
            influenceChange: 5,
            reputationChange: 3,
            politicalCapitalChange: 3
        )
    ]
}
