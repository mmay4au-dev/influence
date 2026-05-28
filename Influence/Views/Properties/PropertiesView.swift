import SwiftUI

struct PropertiesView: View {
    @EnvironmentObject private var game: GameViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    totals
                    ownedProperties
                    businesses
                }
                .padding()
            }
            .background(InfluenceTheme.background.ignoresSafeArea())
            .navigationTitle("Assets")
        }
    }

    private var totals: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            StatCard(title: "Asset Income", value: Formatters.currency(game.totalAssetIncome), systemImage: "chart.bar.fill", accent: InfluenceTheme.success)
            StatCard(title: "Influence Output", value: "+\(game.totalInfluenceContribution)", systemImage: "sparkles")
        }
    }

    private var ownedProperties: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Owned Properties")
                .font(.headline)

            if game.player.ownedProperties.isEmpty {
                emptyState("No properties owned yet.")
            } else {
                ForEach(game.player.ownedProperties) { property in
                    SectionCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(property.name)
                                .font(.headline)
                            Text(property.type.rawValue)
                                .font(.caption)
                                .foregroundStyle(InfluenceTheme.textSecondary)
                            HStack {
                                Label(Formatters.currency(property.monthlyRevenue), systemImage: "dollarsign.circle.fill")
                                Spacer()
                                Label("+\(property.influenceBoost)", systemImage: "sparkles")
                            }
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(InfluenceTheme.textSecondary)

                            Button {
                                game.startBusiness(from: property)
                            } label: {
                                Label("Start Business", systemImage: "plus.circle.fill")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .tint(InfluenceTheme.influence)
                            .disabled(game.player.businesses.contains(where: { $0.propertyID == property.id }))
                        }
                    }
                }
            }
        }
    }

    private var businesses: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Businesses")
                .font(.headline)

            if game.player.businesses.isEmpty {
                emptyState("Owned properties can become income-producing businesses.")
            } else {
                ForEach(game.player.businesses) { business in
                    SectionCard {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(business.name)
                                .font(.headline)
                            Text("\(business.industry) • \(business.jobsCreated) jobs")
                                .font(.caption)
                                .foregroundStyle(InfluenceTheme.textSecondary)
                            HStack {
                                Label(Formatters.currency(business.monthlyRevenue), systemImage: "dollarsign.circle.fill")
                                Spacer()
                                Label("+\(business.influenceBoost)", systemImage: "sparkles")
                                Spacer()
                                Label("+\(business.reputationBoost)", systemImage: "person.2.fill")
                            }
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(InfluenceTheme.textSecondary)
                        }
                    }
                }
            }
        }
    }

    private func emptyState(_ message: String) -> some View {
        Text(message)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .foregroundStyle(InfluenceTheme.textSecondary)
            .background(InfluenceTheme.panel, in: RoundedRectangle(cornerRadius: 8))
    }
}
