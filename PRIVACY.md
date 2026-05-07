# Privacy Policy for WhatsTheScore?

**Effective date:** May 7, 2026
**Last updated:** May 7, 2026

WhatsTheScore? ("the app", "we", "our") is an iOS app for tracking competitive game results among friends. This policy explains exactly what data the app collects, why, where it goes, and how you can remove it.

We do not sell your data. We do not share it with advertisers. We do not run analytics on you. The data we collect exists for one reason: to run the leaderboards you and your friends participate in.

## 1. Data we collect

### From Sign in with Apple

When you sign in, Apple shares the following with the app:

- **Your name** (only on first sign-in, and only if you choose to share it). You can edit or hide it. If you use Apple's "Hide My Name" option, we never receive a real name.
- **Your email address.** If you use Apple's "Hide My Email" option, we receive a private relay address (`...@privaterelay.appleid.com`) and never see your real email. The app does not send you any email regardless.
- **A unique Apple identifier** (used to create your Firebase Auth user ID).

You can revoke Sign in with Apple access at any time via iOS Settings, Apple ID, Sign-In with Apple.

### Created by you in the app

- **Display name** (defaults to the name from Apple, editable later).
- **Leaderboards** you create or join: the leaderboard name, invite code, the games you play, point systems you save, the list of members, and the date you joined.
- **Matches** you record: the game type, who played, finishing order, points earned, and the timestamp.
- **Stats reset markers**: if you choose to reset your stats, we store the reset date and a snapshot of your games and wins counts at that moment, so we can show "since reset" totals.
- **Pokes** you send or receive: a small notification record (sender display name, target leaderboard, timestamp, read status).

### Stored locally on your device only

- **`pinnedLeaderboardId`** (in iOS UserDefaults): the ID of the leaderboard you pinned to the top of your home screen. This never leaves your device. Uninstalling the app removes it.

### What we do NOT collect

- No precise location.
- No contacts.
- No photos or media.
- No microphone or camera input.
- No advertising identifier (IDFA).
- No analytics events, crash analytics, or usage telemetry.
- No tracking across other apps or websites.

## 2. How we use the data

We use the data above only to:

- Sign you in and keep you signed in.
- Show you the leaderboards you belong to and let other members of those leaderboards see your display name, rank, and stats inside that leaderboard.
- Record and display match results.
- Send pokes between members of the same leaderboard.
- Honor a stats reset request.
- Honor an account deletion request.

We do not use your data to advertise, profile, train models, or build derivative products.

## 3. Who can see your data

- **Other members of a leaderboard you have joined** can see your display name, your rank in that leaderboard, your match history within that leaderboard, and your stats (games, wins, win rate, streak, peak rank). They cannot see your email or your other leaderboards.
- **No one outside a leaderboard you have joined** can read your data. Firestore security rules enforce this server-side.
- **You** can see all of your own data inside the app.

We do not share data with any third party for marketing, analytics, or advertising purposes.

## 4. Third-party services

The app uses two third-party services, both required for the app to function:

- **Sign in with Apple** (Apple Inc.). Used to authenticate you. Apple's privacy policy: https://www.apple.com/legal/privacy/
- **Firebase Authentication and Cloud Firestore** (Google LLC). Used to store your account, your leaderboards, and your match history, and to keep them in sync across your devices. Google's privacy policy: https://policies.google.com/privacy

That is the complete list. There are no analytics SDKs, no advertising SDKs, no crash reporters, no attribution tools, and no other backend services.

## 5. Where data is stored

Data is stored in Google Cloud Firestore, on infrastructure operated by Google. Firestore replicates data across Google data centers for durability. Data is encrypted in transit (TLS) and at rest.

## 6. How long we keep it

- **Account data** (your user record, your memberships, your match history) persists while your account exists.
- **Leaderboards you created** persist while at least one member remains. If you delete your account and you were the creator, ownership transfers to the longest-tenured remaining member. If you were the only member, the leaderboard and its match history are deleted along with your account.
- **Pokes** persist until you delete them or your account.

## 7. Deleting your account

You can permanently delete your account from inside the app:

> **Profile, Delete Account**

This action:

1. Re-authenticates you with Apple (required by Firebase).
2. Revokes your Apple Sign-In token (required by Apple guideline 5.1.1(v)).
3. Removes you from every leaderboard you belong to. Where you were the creator and other members remain, ownership is transferred to the longest-tenured remaining member. Where you were the only member, the leaderboard and its matches are deleted.
4. Deletes your notifications.
5. Deletes your user document.
6. Deletes your Firebase Authentication record.

Once complete, your data is gone from our systems. You will need to sign up again from scratch if you want to use the app later. Note that match records in shared leaderboards (showing your past placements) may still reference your former display name, since those records belong to the leaderboard, not solely to you.

## 8. Your rights

Depending on where you live, you may have additional rights under privacy laws such as the EU's GDPR or California's CCPA, including the right to access, correct, export, or delete your data. The in-app delete flow described above satisfies the right to delete. For access, correction, or export requests, email us at the address below and we will respond within 30 days.

## 9. Children

WhatsTheScore? is not directed at children under 13 (or under 16 in the EEA / UK), and we do not knowingly collect data from them. If you believe a child has signed up, contact us and we will delete the account.

## 10. Security

- All network traffic uses TLS.
- Firestore security rules limit reads of a leaderboard to its members and limit writes (creation, joining, leaving, ownership transfer, match recording) to the user who is performing the action.
- Sign in with Apple, plus a fresh re-authentication requirement before deletion, protects against unauthorized account changes.

No system is perfectly secure. If we learn of a breach affecting your data, we will notify affected users and take corrective action.

## 11. Changes to this policy

If this policy changes in a material way, we will update the "Last updated" date above and, where reasonable, surface a notice in the app. Continued use of the app after a change constitutes acceptance.

## 12. Contact

Questions, requests, or concerns:

**Email:** petrariuvlad0707@gmail.com

This is a single-developer app. Replies usually arrive within a few days.
