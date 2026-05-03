import SwiftUI

extension RankTier {
    /// Asset-catalog name for the illustrated rank badge.
    /// SVG assets live in Assets.xcassets/RankBadges/ with "Preserve Vector Data" enabled.
    var badgeAssetName: String {
        switch self {
        case .iron:      return "rank-iron"
        case .bronze:    return "rank-bronze"
        case .silver:    return "rank-silver"
        case .gold:      return "rank-gold"
        case .platinum:  return "rank-platinum"
        case .diamond:   return "rank-diamond"
        case .ascendant: return "rank-ascendant"
        case .immortal:  return "rank-immortal"
        }
    }
}

/// Renders the illustrated tier badge from Assets.xcassets/RankBadges.
/// The SVGs include their own gradients and soft glow — never tint them.
struct RankBadgeView: View {
    let rank: Rank
    var size: CGFloat = 40
    var showShadow: Bool = true

    var body: some View {
        Image(rank.tier.badgeAssetName)
            .resizable()
            .renderingMode(.original)
            .interpolation(.high)
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .shadow(color: .black.opacity(showShadow ? 0.35 : 0), radius: showShadow ? 6 : 0, x: 0, y: showShadow ? 4 : 0)
            .accessibilityLabel("\(rank.tier.rawValue) division \(rank.division)")
    }
}
