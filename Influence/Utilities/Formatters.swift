import Foundation

enum Formatters {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    static func currency(_ value: Double) -> String {
        currency.string(from: NSNumber(value: value)) ?? "$0"
    }
}
