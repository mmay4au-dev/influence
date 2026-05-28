# Influence

Influence is a couch-playable strategic life and influence simulator built on a real-world map.

The player starts as an ordinary citizen in a real town, chooses a career or business path, buys virtual properties tied to real map locations, opens businesses, generates revenue, builds reputation, creates jobs, and grows influence. Influence is the primary currency. Political opportunities unlock later based on influence, reputation, wealth, relationships, and local visibility.

Influence is not a GPS travel game, a city builder, or a deep business simulator. The MVP is a premium strategy shell that uses Apple MapKit as the real-world foundation while keeping gameplay high-level and local-only.

## MVP Scope

- SwiftUI app using MapKit and MVVM.
- No GPS or location permission requirements.
- No multiplayer, Firebase, backend, or API keys.
- Local mock data only.
- Starter city: Orange Beach, Alabama.
- Core gameplay loop:
  - Choose a career path.
  - Buy properties.
  - Start businesses from owned properties.
  - Advance the month.
  - Earn income.
  - Gain influence and reputation.
  - Watch political opportunities unlock.

## Screens

- Dashboard: player stats, current city, and next suggested action.
- Map: real Apple map centered on Orange Beach with purchasable property annotations.
- Career: starting path selection with different influence styles.
- Properties: owned properties, businesses, income, and influence contribution.
- Politics: locked and unlocked civic opportunities.

## Future Phases

1. Deeper local economy simulation with industry cycles and neighborhood traits.
2. Relationship, donor, and public visibility systems.
3. Expanded career and business paths.
4. Political campaigns for city council, mayor, county, state, and national offices.
5. Persistent multiplayer U.S. simulation across real geography.
6. Cloud persistence, authentication, and live elections.

## Build Instructions

1. Open `Influence.xcodeproj` in Xcode.
2. Select an iPhone simulator.
3. Build and run.

The project has no external dependencies and requires no API keys.
