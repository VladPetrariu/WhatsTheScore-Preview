# Why I built WhatsTheScore?

## It started as a shared note

For the last few years, my friends and I have kept a shared note in iCloud Notes that tracks our "rank" across the games we play together: pool, darts, chess, whatever's in front of us that night. Every hangout, after the games, somebody pulls it up and updates it: who played, who won, who climbed, who dropped a tier.

That's the whole origin story. There was no plan. We just started keeping score one night and never stopped.

## The surprising part is that it worked

Most things you set up with friends die in a week. You start a fantasy league, you set up a recurring calendar invite, you make a Discord server, and then everyone forgets. The note didn't die. It became one of the most-used "apps" in our group chat. People referenced it at the start of games to see who needed to win to climb. People argued about it. People checked it after a few drinks. It just kept getting opened.

Year after year, hangout after hangout, no maintenance, no buy-in meetings. That's the thing I trust about this idea. It isn't a guess at whether a friend-group ranking system works. We've been running the experiment for years. The answer is yes.

## Where the note hit its limits

What the note couldn't do, by being a note:

- **The math.** Every update was hand-arithmetic and somebody always got it wrong. "Wait, was that +25 or +50?"
- **The rank had no visual weight.** It was a list of numbers we'd mentally translated into tier names. The actual *feeling* of being Gold 2, the badge, the color, the progress bar to the next division, wasn't there. The system worked, but it didn't *look* like it was working.
- **Multiple groups didn't fit.** The same people overlap across "Friday pool", "Wednesday Catan", and "office FIFA", but they can't share one ladder cleanly. We ended up with multiple notes, none of them current.
- **Match history was unreadable.** It was buried in a wall of bullet points stretching back years. You couldn't really browse it.
- **Adding a friend meant explaining the whole system from scratch**, then sharing the note, then hoping they didn't accidentally edit somebody's score.

So WhatsTheScore? is that note, built for the job. The math runs itself. The ranks have illustrated badges and tier colors. Multiple leaderboards are first-class. Match history is paginated and tappable. Joining is a 6-character invite code, not "let me share my note with you."

## Same loop, just an app

Three principles I tried to hold to as I built it:

- **Logging a match has to be fast.** If the flow takes longer than the time between racking the next pool game, it won't get used. Pick game, pick players, enter placements, done.
- **No social directory.** No friend search, no usernames to look up. Invite codes only. The note had this property for free, and I didn't want to lose it.
- **Group competition, not global.** Each leaderboard is its own world. Your Iron 1 in the Catan group isn't the same thing as your Diamond 2 in the FIFA group, and they shouldn't pretend to be.

If WhatsTheScore? works the way the note did, quietly opened every hangout for years, that's the validation. If a few other friend groups pick it up too, that's the bonus.
