# WhatsTheScore?

> A competitive leaderboard for friends. Track every match, climb the ranks, settle every "wait, who's actually winning?" once and for all.

**Status:** Coming soon to the App Store. iOS 16.5+, built in SwiftUI, backed by Firebase.

> This is a public **preview repository**, a showcase of the app, with documentation and a curated set of source files. The full source is kept private.

---

## Preview

> Video and screenshots will be dropped in here.

| Preview Video | Screenshots |
|---|---|
| `media/loop.mp4` *(coming soon)* | `screenshots/` *(coming soon)* |

---

## What it is

WhatsTheScore? turns any recurring friend-group competition like pool nights, chess matches, Mario Kart, Catan, Monopoly, into a real **ranked ladder**. Every game you log moves players up or down a 24-tier system inspired by competitive games (Iron → Bronze → … → Immortal). Friends join your ladder via a 6-character invite code, and the leaderboard updates live for everyone.

It's the "rank up" loop from your favorite competitive game, but for the games you and your friends actually play in person.

### Highlights

- **Sign in with Apple** — one tap, no email/password
- **Multiple leaderboards** — separate ladders for separate friend groups or game types
- **Invite codes** — 6 characters, no friend search, no exposed user directory
- **24-tier ranking system** — 8 tiers × 3 divisions (Iron 1 through Immortal 3)
- **2–6 player matches** — head-to-head or small group games
- **Flexible scoring** — pick a preset (±25, ±50) or define custom points per placement
- **Match history with stats** — full timeline, head-to-head records, achievements
- **Real-time sync** — Firestore snapshot listeners keep every device current
- **Offline-friendly** — 100MB persistent cache; log a match without signal, syncs when you're back
- **In-app pokes** — nudge a friend who hasn't played in a while

---

## Why I built this

For the last few years, my friends and I have kept a shared iCloud note tracking our "rank" across the games we play together: pool, darts, chess, whatever's in front of us. Every hangout, somebody updates it. It just kept working. Year after year, it became one of the most-used "apps" in our group chat.

This isn't a guess at whether a friend-group ranking system works. We've been running the experiment for years. The answer is yes, and the note had earned being a real app.

WhatsTheScore? is that note, built for the job: the math runs itself, the ranks have actual visuals, multiple games and groups are first-class, history is browsable, and joining is a 6-character invite code instead of "let me share my note with you." Same loop, same reason it works.

> Full story in [`docs/WHY.md`](docs/WHY.md).

---

## How it works

1. **Sign in with Apple** — one tap to create an account.
2. **Create a leaderboard** — name it, pick which games it tracks (Pool, Darts, Chess, etc.), and the app generates an invite code.
3. **Share the code** — friends enter it in the Join screen and they're added to the ladder.
4. **Log a match** — pick the game, pick the players (2–6), pick a point system, then enter the placements (1st, 2nd, 3rd…). The app calculates and applies point changes in one shot.
5. **Watch the ranks shift** — every member's tier updates live. Match history, head-to-head records, and achievements update too.
6. **Repeat forever.** That's it.

> Full walkthrough with screen-by-screen flow in [`docs/HOW_IT_WORKS.md`](docs/HOW_IT_WORKS.md).

---

## Ranking system

8 tiers × 3 divisions = **24 ranks**, plus an uncapped Immortal 3 ceiling.

| Rank | Division 1 | Division 2 | Division 3 |
|------|-----------:|-----------:|-----------:|
| Iron | 0–99 | 100–199 | 200–299 |
| Bronze | 300–399 | 400–499 | 500–599 |
| Silver | 600–699 | 700–799 | 800–899 |
| Gold | 900–999 | 1000–1099 | 1100–1199 |
| Platinum | 1200–1299 | 1300–1399 | 1400–1499 |
| Diamond | 1500–1599 | 1600–1699 | 1700–1799 |
| Ascendant | 1800–1899 | 1900–1999 | 2000–2099 |
| Immortal | 2100–2199 | 2200–2299 | 2300+ |

Points can go negative. You'll still display as Iron 1, but you have to climb back above 0 before the system will rank you up. **Immortal 3 has no ceiling**, it's the bragging-rights tier.

> Deep dive (point systems, math, edge cases) in [`docs/RANKING_SYSTEM.md`](docs/RANKING_SYSTEM.md).

---

## Tech stack

| Layer | Technology |
|---|---|
| UI | SwiftUI (no UIKit) |
| Auth | Sign in with Apple → Firebase Auth |
| Database | Cloud Firestore (real-time listeners + offline cache) |
| Backend | Firebase only — no custom server |
| Package manager | Swift Package Manager |
| Min iOS | 16.5 |
| Language | Swift 5 |
| Pattern | MVVM with `@MainActor ObservableObject` view models |

> Full architecture write-up in [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md).

---

## Code previews

Curated source files live in [`code-previews/`](code-previews/). They're the same code that ships in the app, organized by layer:

| File | What it shows |
|---|---|
| [`Models/Rank.swift`](code-previews/Models/Rank.swift) | Pure-function ranking math: points → tier × division |
| [`Models/Leaderboard.swift`](code-previews/Models/Leaderboard.swift) | Embedded-members data shape with backwards-compatible `Codable` |
| [`Models/Match.swift`](code-previews/Models/Match.swift) | Match + per-player placement model |
| [`Models/PointSystem.swift`](code-previews/Models/PointSystem.swift) | Preset point systems for 2–6 players |
| [`Models/AppUser.swift`](code-previews/Models/AppUser.swift) | User document + reset-stats snapshotting |
| [`Services/AuthService.swift`](code-previews/Services/AuthService.swift) | Sign in with Apple → Firebase credential exchange (with nonce) |
| [`Services/LeaderboardService.swift`](code-previews/Services/LeaderboardService.swift) | Firestore CRUD, batched read-modify-write, real-time listener |
| [`ViewModels/LeaderboardViewModel.swift`](code-previews/ViewModels/LeaderboardViewModel.swift) | Snapshot-listener pattern + paginated match history |
| [`Theme/AppTheme.swift`](code-previews/Theme/AppTheme.swift) | Design system: tier color pairs, gradients, card style modifier |
| [`Theme/RankBadge.swift`](code-previews/Theme/RankBadge.swift) | Illustrated badge view (asset-catalog driven) |
| [`Utils/InviteCodeGenerator.swift`](code-previews/Utils/InviteCodeGenerator.swift) | 6-char alphanumeric, lookalike chars (0/O/1/I) excluded |
| [`Security/firestore.rules`](code-previews/Security/firestore.rules) | Production Firestore security rules |

These are representative excerpts, not the whole app. The full source — including all views, the match-creation flow, achievements, notifications, and the asset catalog — stays in the private repo.

---

## Roadmap

Shipped:
- Apple Sign In + Firebase Auth
- 24-rank tier system, 2–6 player matches
- Flexible point systems (presets + custom)
- Match history, head-to-head records, achievements
- In-app pokes
- Offline persistence
- Stats reset (per leaderboard)

Considering:
- Seasons (rank decay + leaderboard resets)
- Push notifications (rank up, you got beaten, friend pinged you)
- Profile photos
- Per-leaderboard chat
- Statistics graphs
- iPad layout
- An Android sibling

---

## License

All rights reserved. The code in [`code-previews/`](code-previews/) is shown for portfolio purposes only — please don't redistribute or republish it.

---

## Contact

Built by Vlad Petrariu. *https://www.linkedin.com/in/vladpetrariu777/*
