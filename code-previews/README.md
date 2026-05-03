# Code previews

A curated slice of the WhatsTheScore? source — enough to show the architecture and code style, not the whole app. The files here are unmodified copies of what ships.

## Layout

```
code-previews/
├── Models/         Plain Codable structs (Rank math, Leaderboard, Match, etc.)
├── Services/       Firebase wrappers (Auth, Leaderboard CRUD)
├── ViewModels/     @MainActor ObservableObjects with snapshot listeners
├── Theme/          Design system + rank badge view
├── Utils/          Invite code generator
└── Security/       Production Firestore rules
```

## What's here, what's not

**Included.** Models, the auth flow, the leaderboard service, one representative view model, the design system, the rank badge view, the invite code generator, and the Firestore security rules. The "interesting" architectural pieces.

**Not included.** All SwiftUI views (login, home, create-match flow, leaderboard detail, match history, head-to-head, achievements, profile, notifications), the second service layer (`MatchService`, `NotificationService`), the achievements logic, the assets catalog (icon, illustrated rank badges), and the Xcode project files.

This is a portfolio showcase, not a redistributable codebase. Please don't copy or republish.

## Reading order

If you're looking through these for the first time, an order that flows well:

1. [`Models/Rank.swift`](Models/Rank.swift) — the smallest piece, but the conceptual core
2. [`Models/Leaderboard.swift`](Models/Leaderboard.swift) — the central data shape
3. [`Models/Match.swift`](Models/Match.swift), [`Models/PointSystem.swift`](Models/PointSystem.swift) — what a logged match looks like
4. [`Services/LeaderboardService.swift`](Services/LeaderboardService.swift) — how Firestore is actually used
5. [`Services/AuthService.swift`](Services/AuthService.swift) — Sign in with Apple done by hand
6. [`ViewModels/LeaderboardViewModel.swift`](ViewModels/LeaderboardViewModel.swift) — the live-listener pattern
7. [`Theme/AppTheme.swift`](Theme/AppTheme.swift) — colors, gradients, the card modifier
8. [`Security/firestore.rules`](Security/firestore.rules) — the production access rules
