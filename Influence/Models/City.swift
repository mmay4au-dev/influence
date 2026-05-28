import CoreLocation
import Foundation

struct City: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let state: String
    let coordinate: CLLocationCoordinate2D
    let population: Int
    let economicHealth: Int
    let civicTrust: Int
    let dominantIndustries: [String]
    let localIssues: [String]

    static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
