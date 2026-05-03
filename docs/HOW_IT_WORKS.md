# How WhatsTheScore? works

Walkthrough of the app from first launch to logging your hundredth match.

## 1. Sign in

Tap **Sign in with Apple**. That's it — no email, no password, no second screen. Behind the scenes, Apple hands the app a signed identity token, which the app exchanges for a Firebase credential. A user document is created in Firestore on first sign-in.

If you've signed in before, the app skips the login screen entirely and drops you on Home.

## 2. Home — your leaderboards

Home is a list of every leaderboard you belong to, with your current rank shown for each one. From here you can:

- **Open a leaderboard** to see its rankings, history, and details
- **Create a new leaderboard** for a new game or a new friend group
- **Join an existing leaderboard** by entering a 6-character invite code

## 3. Create a leaderboard

Three quick steps:

1. **Name it.** "Friday Pool", "Office FIFA", "Family Catan". Whatever.
2. **Pick which games it tracks.** Choose from presets (Pool, Darts, Chess, Monopoly) or add your own. A leaderboard can track multiple games.
3. **Pick the starting points.** Default is 0 (everyone starts at Iron 1). You can start everyone higher if you want them to begin at a different tier.

When you tap **Create**, the app generates a 6-character invite code and adds you as the first member. The invite code is unique, alphanumeric, and avoids lookalike characters (no `0`/`O`/`1`/`I`).

## 4. Invite friends

Share the code by any means — text, AirDrop, scream it across the table. Friends enter it in their **Join Leaderboard** screen and they're added to the ladder, starting at the leaderboard's starting points.

## 5. Log a match

Tap **New Match** on any leaderboard:

1. **Pick the game** from the leaderboard's game list.
2. **Pick 2–6 players** from the leaderboard's members.
3. **Pick a point system.** You get presets per player count (Standard, High Stakes), or you can roll your own custom system (e.g. "+30 / +5 / -5 / -30") and even save it for next time.
4. **Enter the placements.** Drag-to-reorder or tap-to-assign 1st, 2nd, 3rd, … The app shows the resulting point delta for each player so there are no surprises.
5. **Submit.** The app applies the deltas in a batched read-modify-write, so the leaderboard, every player's points, every player's `gamesPlayed`, and the winner's `wins` count all update together. Match goes into history.

## 6. The leaderboard view

Open any leaderboard to see:

- **Rankings** — sorted by points, highest first. Each row shows the player's rank badge (e.g. Gold 2), name, points, and a glance at recent change.
- **History** — paginated match log. Tap a match to see who played, who placed where, and what the point change was.
- **Head-to-head** — pick two players and see the lifetime record between them (great for the rivalries).
- **Achievements** — milestones unlocked by you and others on this ladder.

A real-time Firestore snapshot listener keeps the rankings live — when a friend on the other side of town logs a match, the ranking on your phone updates without a refresh.

## 7. Player profile

Tap any member to see their profile: current rank, total games, win rate, history of matches in this leaderboard. From your own profile you can:

- Reset your stats on a leaderboard (snapshots a "stats reset on \<date\>" marker so other players see context for the change)
- Leave the leaderboard
- Sign out

## 8. Pokes

Hasn't your friend played in a while? Tap **Poke** on their profile to drop a notification into their inbox. (Useful for "we're doing pool tonight, get over here" or just trash talk.)

## 9. Offline behavior

Firestore is configured with a 100MB persistent cache. You can open the app, view rankings, and even log a match with no signal — it'll sync to the cloud the next time you're online. The match history, leaderboard state, and your profile are all readable from cache.

## 10. Where the data lives

Three Firestore collections, no custom backend:

- `users/{uid}` — your account doc
- `leaderboards/{id}` — leaderboard with members embedded
- `leaderboards/{id}/matches/{id}` — match history as a sub-collection

That's the whole thing. No servers, no functions, no queues. Architecture details in [`ARCHITECTURE.md`](ARCHITECTURE.md).
