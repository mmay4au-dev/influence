import SwiftUI

struct PoliticsView: View {
    @EnvironmentObject private var game: GameViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    Text("Political power unlocks after you become visible, trusted, and connected.")
                        .foregroundStyle(InfluenceTheme.textSecondary)
                        .padding(.horizontal)

                    ForEach(game.politicalOpportunities) { opportunity in
                        opportunityCard(opportunity)
                    }
                }
                .padding(.vertical)
            }
            .background(InfluenceTheme.background.ignoresSafeArea())
            .navigationTitle("Politics")
        }
    }

    private func opportunityCard(_ opportunity: PoliticalOpportunity) -> some View {
        let unlocked = game.isUnlocked(opportunity)

        return SectionCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(opportunity.title)
                            .font(.title3.weight(.bold))
                        Text(unlocked ? "Unlocked" : "Locked")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(unlocked ? InfluenceTheme.success : InfluenceTheme.influence)
                    }
                    Spacer()
                    Image(systemName: unlocked ? "lock.open.fill" : "lock.fill")
                        .foregroundStyle(unlocked ? InfluenceTheme.success : InfluenceTheme.textSecondary)
                }

                Text(opportunity.summary)
                    .foregroundStyle(InfluenceTheme.textSecondary)

                VStack(spacing: 8) {
                    requirementRow("Influence", current: game.player.influence, required: opportunity.requiredInfluence, icon: "sparkles")
                    requirementRow("Reputation", current: game.player.reputation, required: opportunity.requiredReputation, icon: "person.2.fill")
                    requirementRow("Political", current: game.player.politicalCapital, required: opportunity.requiredPoliticalCapital, icon: "building.columns.fill")
                }
            }
        }
        .padding(.horizontal)
    }

    private func requirementRow(_ title: String, current: Int, required: Int, icon: String) -> some View {
        HStack {
            Label(title, systemImage: icon)
            Spacer()
            Text("\(min(current, required))/\(required)")
                .monospacedDigit()
                .foregroundStyle(current >= required ? InfluenceTheme.success : InfluenceTheme.textSecondary)
        }
        .font(.caption.weight(.semibold))
    }
}
