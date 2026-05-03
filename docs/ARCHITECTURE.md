# Architecture

A short technical write-up of how WhatsTheScore? is structured. The goal of these decisions: ship a competitive multiplayer ladder app with no custom backend.

## Stack

- **UI:** SwiftUI exclusively. No UIKit views in the app surface (one small UIKit hack for keyboard pre-warming in `WhatsTheScore_App.swift`).
- **Auth:** Sign in with Apple → Firebase Auth via `OAuthProvider.appleCredential`.
- **Database:** Cloud Firestore. Real-time sync via `addSnapshotListener`. Offline cache via `PersistentCacheSettings(sizeBytes: 100MB)`.
- **No backend.** No custom server, no Cloud Functions. All business logic runs on-device; Firestore is the source of truth and the sync layer.
- **No local persistence layer.** All data flows through Firestore. The Firestore offline cache covers the offline use case.

## Pattern

MVVM, with one variant per layer:

- **Models** — plain `Codable` structs (`AppUser`, `Leaderboard`, `Match`, `Rank`, `PointSystem`, `Achievement`, `AppNotification`).
- **Services** — singletons (`.shared`) that wrap Firestore. They expose `async` methods for one-shots and `addSnapshotListener`-based callbacks for live data.
- **ViewModels** — `@MainActor ObservableObject` classes that own listeners and `@Published` state. Most are created per-view; `AuthViewModel` is the root, injected as `@EnvironmentObject` from the App entry point.
- **Views** — SwiftUI, organized by feature folder (`Auth/`, `Home/`, `Leaderboard/`, `Match/`, `Profile/`, `Notifications/`).

## Data model

```
users/{uid}                                  // AppUser
  ├── displayName, email, createdAt
  ├── leaderboardIds: [String]               // for fast "my leaderboards" lookup
  └── statsResetAt, statsResetWins, ...      // reset snapshot

  notifications/{notificationId}             // sub-collection: pokes etc.
    └── fromUserId, type, createdAt, ...

leaderboards/{leaderboardId}                 // Leaderboard
  ├── name, creatorId, inviteCode, createdAt
  ├── gameTypes: [String]
  ├── startingPoints: Int
  ├── members: [LeaderboardMember]           // embedded array (the key call)
  ├── memberIds: [String]                    // duplicated for security rules
  └── savedPointSystems: [SavedPointSystem]

  matches/{matchId}                          // sub-collection: Match
    ├── gameType, playerCount, pointSystemName
    ├── status: pending | completed
    └── players: [PlayerResult]
```

### Why members are embedded in the leaderboard doc

A naive design would put each member in a sub-collection. That means rendering the rankings screen requires N+1 reads.

Embedding members in the leaderboard doc means rendering the rankings is **one document read**. Member updates (after a match) are a read-modify-write on that one doc. Firestore docs cap at 1MB; a `LeaderboardMember` is small enough that this comfortably supports hundreds of members per ladder, far more than the app needs.

The trade-off: writing requires reading the whole doc first. For a leaderboard with dozens of members, that's still a single round trip — and the `MatchService` batches the entire post-match update (every affected member's points, gamesPlayed, wins) into one write.

### Why matches are a sub-collection

Match history grows unboundedly. If matches were embedded in the leaderboard doc, the doc would inflate over time and eventually hit the 1MB limit. As a sub-collection, matches are paginated independently — the `LeaderboardViewModel` listens to the most recent 15 and lazy-loads older pages on scroll.

### Why `memberIds` is duplicated

The `members` array of structs can't be queried directly in Firestore security rules (you can only check primitive arrays for membership). Duplicating member IDs into a flat `memberIds: [String]` lets the rule say `request.auth.uid in resource.data.memberIds` for read/write authorization.

The `Leaderboard.swift` `Codable` init has a backwards-compatible decoder that derives `memberIds` from `members` if it's missing — important because earlier versions of the app didn't write the field.

## Real-time pattern

Both `LeaderboardService` and `MatchService` expose `listenTo*` methods that return a `ListenerRegistration`. View models hold the registration and remove it on `deinit`:

```swift
init(leaderboard: Leaderboard) {
    self.leaderboard = leaderboard
    startListening()
}

deinit {
    leaderboardListener?.remove()
    matchesListener?.remove()
}
```

Snapshot callbacks dispatch to the main actor before mutating `@Published` state. See [`code-previews/ViewModels/LeaderboardViewModel.swift`](../code-previews/ViewModels/LeaderboardViewModel.swift).

## Auth flow

Sign in with Apple is implemented manually (not via the FirebaseUI wrapper):

1. Generate a random nonce, SHA-256 it, attach to the Apple authorization request.
2. On success, take the Apple identity token + raw nonce and build an `OAuthProvider.appleCredential`.
3. Hand that credential to `Auth.auth().signIn(with:)`.
4. On first sign-in, write a fresh `AppUser` doc to Firestore.

The nonce step is what prevents replay attacks against the credential exchange. See [`code-previews/Services/AuthService.swift`](../code-previews/Services/AuthService.swift).

## Security rules

See [`code-previews/Security/firestore.rules`](../code-previews/Security/firestore.rules). The shape:

- **Users:** read/write only your own doc. Notifications sub-collection: anyone can create (so others can poke you), only the recipient can read/update/delete.
- **Leaderboards:** any authed user can read (needed so an invite-code lookup doesn't fail before joining). Any authed user can create. Updates require being a member, OR the request adds you to `memberIds` (the join case). Only the creator can delete.
- **Matches:** any authed user can read/write (the rule is liberal because match writes are scoped through `LeaderboardService` and there's no harm in another member's view of the data).

## Constraints worth knowing

- **Firestore `in` queries cap at 30 items.** `LeaderboardService.fetchUserLeaderboards` chunks `leaderboardIds` into groups of 30 to handle users in many leaderboards.
- **Document size cap is 1MB.** Embedded members are fine for friend groups; if the app ever needed thousands of members per ladder, this would have to flip to a sub-collection.
- **No transactional batching across documents in `MatchService`.** Currently uses sequential writes. For the volume this app sees (one game at a time, friend-group scale), it's a non-issue. If contention ever became real, this would move to a `runTransaction`.

## Project layout

```
WhatsTheScore?/
├── WhatsTheScore_App.swift     // @main entry, Firebase init, root routing
├── Models/                     // Codable structs
├── Services/                   // Firebase singletons (Auth, Leaderboard, Match, Notification)
├── ViewModels/                 // @MainActor ObservableObject classes
├── Views/                      // SwiftUI, organized by feature
│   ├── Auth/
│   ├── Home/
│   ├── Leaderboard/
│   ├── Match/
│   ├── Notifications/
│   └── Profile/
├── Theme/                      // Design system: colors, gradients, card style, rank badge
├── Utils/                      // InviteCodeGenerator, MatchAnalytics
└── Assets.xcassets/            // Colors, app icon, illustrated rank badges
```
