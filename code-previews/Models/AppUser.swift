import Foundation

struct AppUser: Identifiable, Codable, Equatable {
    var id: String // Firebase UID
    var displayName: String
    var email: String
    var createdAt: Date
    var leaderboardIds: [String]
    var statsResetGamesPlayed: Int
    var statsResetWins: Int
    var statsResetAt: Date?

    static func new(id: String, displayName: String, email: String) -> AppUser {
        AppUser(
            id: id,
            displayName: displayName,
            email: email,
            createdAt: Date(),
            leaderboardIds: [],
            statsResetGamesPlayed: 0,
            statsResetWins: 0,
            statsResetAt: nil
        )
    }

    init(id: String, displayName: String, email: String, createdAt: Date, leaderboardIds: [String], statsResetGamesPlayed: Int = 0, statsResetWins: Int = 0, statsResetAt: Date? = nil) {
        self.id = id
        self.displayName = displayName
        self.email = email
        self.createdAt = createdAt
        self.leaderboardIds = leaderboardIds
        self.statsResetGamesPlayed = statsResetGamesPlayed
        self.statsResetWins = statsResetWins
        self.statsResetAt = statsResetAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        displayName = try container.decode(String.self, forKey: .displayName)
        email = try container.decode(String.self, forKey: .email)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        leaderboardIds = try container.decode([String].self, forKey: .leaderboardIds)
        statsResetGamesPlayed = try container.decodeIfPresent(Int.self, forKey: .statsResetGamesPlayed) ?? 0
        statsResetWins = try container.decodeIfPresent(Int.self, forKey: .statsResetWins) ?? 0
        statsResetAt = try container.decodeIfPresent(Date.self, forKey: .statsResetAt)
    }
}
