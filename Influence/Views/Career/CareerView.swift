import SwiftUI

struct CareerView: View {
    @EnvironmentObject private var game: GameViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    Text("Choose the social engine that will turn work into influence.")
                        .foregroundStyle(InfluenceTheme.textSecondary)
                        .padding(.horizontal)

                    ForEach(game.careerPaths) { career in
                        careerCard(career)
                    }
                }
                .padding(.vertical)
            }
            .background(InfluenceTheme.background.ignoresSafeArea())
            .navigationTitle("Career")
        }
    }

    private func careerCard(_ career: CareerPath) -> some View {
        let selected = game.player.currentCareerPath?.id == career.id

        return SectionCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(career.name)
                            .font(.title3.weight(.bold))
                        Text(career.influenceStyle)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(InfluenceTheme.influence)
                    }
                    Spacer()
                    Image(systemName: selected ? "checkmark.seal.fill" : "briefcase.fill")
                        .foregroundStyle(selected ? InfluenceTheme.success : InfluenceTheme.civic)
                }

                Text(career.summary)
                    .foregroundStyle(InfluenceTheme.textSecondary)

                HStack {
                    Label(Formatters.currency(career.startingIncome), systemImage: "dollarsign.circle.fill")
                    Spacer()
                    Label("+\(career.startingInfluence)", systemImage: "sparkles")
                    Spacer()
                    Label("+\(career.startingReputation)", systemImage: "person.2.fill")
                }
                .font(.caption.weight(.semibold))
                .foregroundStyle(InfluenceTheme.textSecondary)

                Button {
                    game.chooseCareer(career)
                } label: {
                    Text(selected ? "Selected" : "Choose Path")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(selected ? InfluenceTheme.success : InfluenceTheme.influence)
                .disabled(selected)
            }
        }
        .padding(.horizontal)
    }
}
