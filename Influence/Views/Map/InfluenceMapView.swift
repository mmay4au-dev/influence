import MapKit
import SwiftUI

struct InfluenceMapView: View {
    @EnvironmentObject private var game: GameViewModel
    @State private var selectedProperty: PropertyAsset?
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Map(position: $cameraPosition) {
                    ForEach(game.availableProperties) { property in
                        Annotation(property.name, coordinate: property.coordinate) {
                            Button {
                                selectedProperty = property
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: property.ownerStatus == .owned ? "building.2.fill" : "mappin.circle.fill")
                                        .font(.title2)
                                    Text(property.ownerStatus == .owned ? "Owned" : Formatters.currency(property.purchasePrice))
                                        .font(.caption2.weight(.bold))
                                }
                                .foregroundStyle(property.ownerStatus == .owned ? InfluenceTheme.success : InfluenceTheme.influence)
                                .padding(8)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                .ignoresSafeArea(edges: .bottom)

                mapOverlay
                    .padding()
            }
            .navigationTitle("Orange Beach")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                cameraPosition = .region(game.mapRegion)
            }
            .sheet(item: $selectedProperty) { property in
                PropertyDetailSheet(property: property)
                    .environmentObject(game)
                    .presentationDetents([.medium])
            }
        }
    }

    private var mapOverlay: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Influence Map")
                    .font(.headline)
                Text("Acquire visible local assets")
                    .font(.caption)
                    .foregroundStyle(InfluenceTheme.textSecondary)
            }
            Spacer()
            Text("\(game.player.influence)")
                .font(.title3.weight(.bold))
                .foregroundStyle(InfluenceTheme.influence)
                .monospacedDigit()
        }
        .padding(14)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct PropertyDetailSheet: View {
    @EnvironmentObject private var game: GameViewModel
    let property: PropertyAsset

    private var latestProperty: PropertyAsset {
        game.availableProperties.first(where: { $0.id == property.id }) ?? property
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 6) {
                Text(latestProperty.type.rawValue)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(InfluenceTheme.influence)
                Text(latestProperty.name)
                    .font(.title2.weight(.bold))
            }

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                StatCard(title: "Price", value: Formatters.currency(latestProperty.purchasePrice), systemImage: "tag.fill", accent: InfluenceTheme.success)
                StatCard(title: "Revenue", value: Formatters.currency(latestProperty.monthlyRevenue), systemImage: "chart.bar.fill", accent: InfluenceTheme.success)
                StatCard(title: "Influence", value: "+\(latestProperty.influenceBoost)", systemImage: "sparkles")
                StatCard(title: "Status", value: latestProperty.ownerStatus.rawValue, systemImage: "key.fill", accent: InfluenceTheme.civic)
            }

            Button {
                game.purchase(latestProperty)
            } label: {
                Label(latestProperty.ownerStatus == .owned ? "Already Owned" : "Purchase Property", systemImage: "cart.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(InfluenceTheme.influence)
            .disabled(latestProperty.ownerStatus == .owned || game.player.cash < latestProperty.purchasePrice)

            Spacer()
        }
        .padding()
        .background(InfluenceTheme.background)
    }
}
