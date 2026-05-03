# Ranking system

The 24-tier ladder, the math behind it, and the point systems available per match.

## Tiers

8 tier names × 3 divisions each = **24 ranks**. Each division spans 100 points. Each tier spans 300.

| Rank | Division 1 | Division 2 | Division 3 |
|------|-----------:|-----------:|-----------:|
| Iron      | 0–99      | 100–199   | 200–299   |
| Bronze    | 300–399   | 400–499   | 500–599   |
| Silver    | 600–699   | 700–799   | 800–899   |
| Gold      | 900–999   | 1000–1099 | 1100–1199 |
| Platinum  | 1200–1299 | 1300–1399 | 1400–1499 |
| Diamond   | 1500–1599 | 1600–1699 | 1700–1799 |
| Ascendant | 1800–1899 | 1900–1999 | 2000–2099 |
| Immortal  | 2100–2199 | 2200–2299 | 2300+     |

### How a point total maps to a rank

The math is intentionally simple — `Rank.fromPoints(_:)` does it in two integer divisions:

```swift
static func fromPoints(_ points: Int) -> Rank {
    if points < 0 {
        return Rank(tier: .iron, division: 1)
    }
    let tierIndex = points / 300
    let divisionOffset = (points % 300) / 100

    if tierIndex >= RankTier.allCases.count {
        return Rank(tier: .immortal, division: 3)
    }
    let tier = RankTier.allCases[tierIndex]
    let division = divisionOffset + 1
    return Rank(tier: tier, division: division)
}
```

So the code is the spec — there's no separate lookup table. See [`code-previews/Models/Rank.swift`](../code-previews/Models/Rank.swift).

## Edge cases

- **Negative points display as Iron 1.** Internally the system tracks the actual number, so you have to climb back above 0 before the system will rank you up. This means a really bad streak can take real games to dig out of, which is the point.
- **Immortal 3 is uncapped.** Anything above 2300 stays Immortal 3. There's no Radiant, no Challenger — Immortal 3 is the bragging tier and its meaning is "highest possible rank visible". Internal points keep climbing for the absurd flex of "I'm sitting on 4,200 points".
- **Stats resets are voluntary.** If you reset your stats on a leaderboard, your points return to the leaderboard's starting points and your `gamesPlayed`/`wins` are zeroed. The reset date is snapshotted so other players see context ("Stats reset 3 weeks ago: 12 games, 7 wins since reset").

## Point systems per match

When you create a match, you pick a point system that matches the player count. Presets are defined in [`code-previews/Models/PointSystem.swift`](../code-previews/Models/PointSystem.swift).

### 2 players (head-to-head)

| Preset | 1st | 2nd |
|---|---:|---:|
| Standard (±25) | +25 | -25 |
| High Stakes (±50) | +50 | -50 |
| Custom | user-defined | user-defined |

### 3 players

| Preset | 1st | 2nd | 3rd |
|---|---:|---:|---:|
| Standard | +25 | 0 | -25 |
| High Stakes | +50 | 0 | -50 |
| Custom | user-defined per position | | |

### 4 players

| Preset | 1st | 2nd | 3rd | 4th |
|---|---:|---:|---:|---:|
| Standard | +25 | +10 | -10 | -25 |
| High Stakes | +50 | +15 | -15 | -50 |

### 5 players

| Preset | 1st | 2nd | 3rd | 4th | 5th |
|---|---:|---:|---:|---:|---:|
| Standard | +30 | +15 | 0 | -15 | -30 |
| High Stakes | +50 | +25 | 0 | -25 | -50 |

### 6 players

| Preset | 1st | 2nd | 3rd | 4th | 5th | 6th |
|---|---:|---:|---:|---:|---:|---:|
| Standard | +30 | +15 | +5 | -5 | -15 | -30 |
| High Stakes | +50 | +25 | +10 | -10 | -25 | -50 |

### Custom point systems

Every preset can be replaced with a custom integer per placement. Sum doesn't have to be zero — if you want a leaderboard where everyone gains points and the loser just gains less, that's allowed. Custom systems can be **saved** to the leaderboard so they show up next time as a one-tap preset (`SavedPointSystem` on the leaderboard doc).

## Why it works

The math is dull. That's a feature. The interesting design choices live one level up:

- **Loss is real.** Negative points mean a bad night actually costs you. Without that, the ladder is one-way and the system loses its tension.
- **Standard ±25 is calibrated for ~12 games to rank up.** That's enough to feel like progress takes effort, not so much that a casual group never sees a tier change.
- **High Stakes is for short sessions.** When the group only plays 3-4 games in a night, ±50 makes those games matter.
- **Custom systems exist for asymmetric games.** Some games (Catan, Mario Kart) have placements that aren't really "winners and losers" — they're a spread. Letting players define their own curve handles those without baking opinions into the app.

## Rank visuals

Each tier has an illustrated badge in the asset catalog (`Assets.xcassets/RankBadges/rank-iron`, `rank-bronze`, …). The badge view never tints them — gradient and glow are baked in. See [`code-previews/Theme/RankBadge.swift`](../code-previews/Theme/RankBadge.swift).

Each tier also has a base + bright color pair used for gradients elsewhere in the app (rank progress bars, podium accents, hero treatments). See [`code-previews/Theme/AppTheme.swift`](../code-previews/Theme/AppTheme.swift).
