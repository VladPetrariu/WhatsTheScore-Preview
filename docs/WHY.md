# Why I built WhatsTheScore?

## The conversation that always happens

Every friend group has the same conversation eventually: *"Wait, who's actually won the most?"*

You play pool every Friday for a year and nobody can remember if Alex was up 4–2 or 6–4. You start a Notes app tally that nobody updates. You try a Google Sheet — same outcome. You give up and go back to playing without keeping score, which is fine, until two months later when the conversation starts again.

The problem isn't that you need a smarter spreadsheet. The problem is that **flat tallies don't feel like anything.** A 12–9 lead doesn't sting. A win doesn't carry. There's nothing to defend, nothing to chase.

## What competitive games already figured out

Ranked ladders in games like Valorant, League, CS, Apex, Dota — they all converged on the same shape because that shape works. A visible tier identity ("Gold 2", "Diamond 1") does three things at once:

1. **It compresses your history into something memorable.** You don't remember your last 50 games; you remember you're Gold.
2. **It creates loss aversion.** The thought of dropping a tier is more motivating than the thought of climbing one. You play one more match.
3. **It makes bragging legible.** "I hit Diamond" is something you can say at the table. "I'm 38–22 lifetime" isn't.

Notice what those mechanics have nothing to do with: the genre of the game, the platform, whether it's online or on a couch. They're a scoring shape, not a videogame feature.

## So I pointed it at the games we actually play

WhatsTheScore? takes that ranked-ladder shape and applies it to the games friends actually play together — pool, darts, chess, Catan, Mario Kart, Monopoly, FIFA, whatever. You log a match in about ten seconds. The 24-tier ladder does everything else: the math, the visible identity, the loss aversion, the bragging rights.

Three principles I tried to keep:

- **Logging a match has to be instant.** If it takes longer than the time between racking the next pool game, it won't get used. The whole flow is: pick game → pick players → enter placements → done.
- **No social directory.** No friend search, no usernames to look up. Leaderboards are joined with a 6-character invite code, full stop. That keeps the surface area small and the privacy story simple.
- **Group competition, not global.** This isn't a worldwide ranking system. Each leaderboard is its own world. Your Iron 1 in the Tuesday Catan group is a totally different thing from your Diamond 2 in the office FIFA group, and they should feel that way.

## What it is not (and that's the point)

It is **not** trying to be a stats platform, a tournament organizer, a betting app, a social network, a chat app, or anything you'd schedule a meeting about. It's a ladder. You log a result, the ladder moves, you go play another game.

That narrowness is the feature.

## What's next

If the ladder loop works for the people who use it, the next interesting question is **seasons** — does the loop get sharper if everything resets every few months and the ladder starts over? My instinct says yes; it works in every other ranked game. But that's a question to answer with real friend-group data after it ships, not before.
