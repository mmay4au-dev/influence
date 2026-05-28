# Codex Guidelines For Influence

## Product Direction

Influence is a strategic life and influence simulator on a real-world map. Keep gameplay high-level, readable, and couch-playable. Do not turn the MVP into a GPS travel app, city builder, or detailed business accounting tool.

## Architecture

- Use SwiftUI and MVVM.
- Keep `GameViewModel` as the central app state owner until the simulation becomes too large.
- Keep models plain and local-first.
- Use `Data/MockGameData.swift` for starter content.
- Avoid network calls, API keys, Firebase, and external dependencies unless explicitly requested.

## UI Direction

- Dark premium civic/strategy style.
- Influence should feel like the primary currency.
- Prefer compact cards, clear stat hierarchy, and map-first interaction.
- Keep map annotations meaningful and uncluttered.
- Avoid generic template UI or marketing-style landing screens.

## Code Style

- Keep files small and organized by feature folder.
- Add comments only when they clarify non-obvious game logic.
- Prefer computed properties on models or the view model for derived totals.
- Keep mock data deterministic.
- Use Apple frameworks only for the MVP.

## Gameplay Guardrails

- Property purchases should affect cash, monthly income, and influence potential.
- Businesses should require owned property.
- Advancing the month should generate income, influence, reputation, and simple events.
- Political opportunities should unlock from influence, reputation, and political capital.
