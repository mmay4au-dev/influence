import CoreLocation
import Foundation

enum PropertyType: String, CaseIterable {
    case waterfrontRetail = "Waterfront Retail"
    case officeSuite = "Office Suite"
    case restaurantSpace = "Restaurant Space"
    case residentialLot = "Residential Lot"
    case marinaParcel = "Marina Parcel"
}

enum OwnerStatus: String {
    case purchasable = "Available"
    case owned = "Owned"
}

struct PropertyAsset: Identifiable, Hashable {
    let id: UUID
    let name: String
    let type: PropertyType
    let coordinate: CLLocationCoordinate2D
    let purchasePrice: Double
    let monthlyRevenue: Double
    let influenceBoost: Int
    var ownerStatus: OwnerStatus

    init(
        id: UUID = UUID(),
        name: String,
        type: PropertyType,
        coordinate: CLLocationCoordinate2D,
        purchasePrice: Double,
        monthlyRevenue: Double,
        influenceBoost: Int,
        ownerStatus: OwnerStatus = .purchasable
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.coordinate = coordinate
        self.purchasePrice = purchasePrice
        self.monthlyRevenue = monthlyRevenue
        self.influenceBoost = influenceBoost
        self.ownerStatus = ownerStatus
    }

    static func == (lhs: PropertyAsset, rhs: PropertyAsset) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
