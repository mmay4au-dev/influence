import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var game: GameViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    header
                    statsGrid
                    cityCard
                    actionCard
                    PrimaryActionButton(title: "Advance Month", systemImage: "calendar.badge.clock") {
                        game.advanceMonth()
                    }
                }
                .padding()
            }
            .background(InfluenceTheme.background.ignoresSafeArea())
            .navigationTitle("Influence")
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Month \(game.currentMonth)")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(InfluenceTheme.influence)
            Text(game.player.name)
                .font(.largeTitle.weight(.bold))
            Text(game.player.currentCareerPath?.name ?? "No career path selected")
                .foregroundStyle(InfluenceTheme.textSecondary)
        }
    }

    private var statsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            StatCard(title: "Cash", value: Formatters.currency(game.player.cash), systemImage: "dollarsign.circle.fill", accent: InfluenceTheme.success)
            StatCard(title: "Monthly Income", value: Formatters.currency(game.player.monthlyIncome + game.totalAssetIncome), systemImage: "arrow.up.right.circle.fill", accent: InfluenceTheme.success)
            StatCard(title: "Influence", value: "\(game.player.influence)", systemImage: "sparkles")
            StatCard(title: "Reputation", value: "\(game.player.reputation)", systemImage: "person.2.fill", accent: InfluenceTheme.civic)
            StatCard(title: "Political Capital", value: "\(game.player.politicalCapital)", systemImage: "building.columns.fill", accent: InfluenceTheme.civic)
            StatCard(title: "Assets", value: "\(game.player.ownedProperties.count + game.player.businesses.count)", systemImage: "building.2.fill")
        }
    }

    private var cityCard: some View {
        SectionCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("\(game.player.homeCity.name), \(game.player.homeCity.state)")
                    .font(.title3.weight(.bold))
                Text("Population \(game.player.homeCity.population.formatted())")
                    .foregroundStyle(InfluenceTheme.textSecondary)
                HStack {
                    Label("Economy \(game.player.homeCity.economicHealth)", systemImage: "chart.line.uptrend.xyaxis")
                    Spacer()
                    Label("Trust \(game.player.homeCity.civicTrust)", systemImage: "hand.raised.fill")
                }
                .font(.caption.weight(.semibold))
                .foregroundStyle(InfluenceTheme.textSecondary)
                Text(game.player.homeCity.localIssues.joined(separator: " • "))
                    .font(.footnote)
                    .foregroundStyle(InfluenceTheme.textSecondary)
            }
        }
    }

    private var actionCard: some View {
        SectionCard {
            VStack(alignment: .leading, spacing: 8) {
                Label("Next Move", systemImage: "target")
                    .font(.headline)
                    .foregroundStyle(InfluenceTheme.influence)
                Text(game.nextSuggestedAction)
                    .foregroundStyle(.white)
                if let event = game.latestEvent {
                    Divider().overlay(Color.white.opacity(0.1))
                    Text(event.title)
                        .font(.subheadline.weight(.bold))
                    Text(event.summary)
                        .font(.footnote)
                        .foregroundStyle(InfluenceTheme.textSecondary)
                }
            }
        }
    }
}
