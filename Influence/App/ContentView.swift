import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem { Label("Dashboard", systemImage: "chart.pie.fill") }

            InfluenceMapView()
                .tabItem { Label("Map", systemImage: "map.fill") }

            CareerView()
                .tabItem { Label("Career", systemImage: "briefcase.fill") }

            PropertiesView()
                .tabItem { Label("Assets", systemImage: "building.2.fill") }

            PoliticsView()
                .tabItem { Label("Politics", systemImage: "building.columns.fill") }
        }
        .tint(InfluenceTheme.influence)
        .preferredColorScheme(.dark)
    }
}
