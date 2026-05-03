import SwiftUI

// MARK: - Hex helper

extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}

// MARK: - Tier color pair

struct TierColor {
    let base: Color
    let bright: Color

    init(_ base: UInt32, _ bright: UInt32) {
        self.base = Color(hex: base)
        self.bright = Color(hex: bright)
    }

    var gradient: LinearGradient {
        LinearGradient(colors: [bright, base], startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    var gradientVertical: LinearGradient {
        LinearGradient(colors: [bright, base], startPoint: .top, endPoint: .bottom)
    }
}

// MARK: - Arcade palette

struct AppColors {
    // Brand
    static let brandPrimary    = Color(hex: 0x2663EB) // royal blue (links, nav, secondary CTAs)
    static let brandSuccess    = Color(hex: 0x33B866) // wins, positive deltas
    static let brandDanger     = Color(hex: 0xD10000) // losses, destructive
    static let brandTrophyGold = Color(hex: 0xF2BF1A) // hero accent across the app

    // Surfaces — dark (primary mode)
    static let bgDark      = Color(hex: 0x0F172A)
    static let bgDark2     = Color(hex: 0x0A0E1A)
    static let cardDark    = Color.white.opacity(0.05)
    static let cardDarkBd  = Color.white.opacity(0.10)
    static let ruleDark    = Color.white.opacity(0.08)
    static let textDark    = Color.white
    static let mutedDark   = Color.white.opacity(0.60)
    static let subtleDark  = Color.white.opacity(0.40)

    // Tier base+bright pairs
    static let iron      = TierColor(0x595E66, 0x8C94A1)
    static let bronze    = TierColor(0xB87333, 0xE4A36A)
    static let silver    = TierColor(0xBFC7D1, 0xE3E8EF)
    static let gold      = TierColor(0xF2BF1A, 0xFFD84D)
    static let platinum  = TierColor(0x26AEB8, 0x33D1E0)
    static let diamond   = TierColor(0x4FACFE, 0x73BFFF)
    static let ascendant = TierColor(0x1A994D, 0x59CC40)
    static let immortal  = TierColor(0xB31A26, 0xE6338C)

    // Convenience aliases for legacy view code
    static let flame    = brandPrimary
    static let amber    = Color(hex: 0x3B82F5)
    static let sunlight = Color(hex: 0x60A5FA)
    static let primary  = brandPrimary
    static let accent   = amber
    static let positive = brandSuccess
    static let negative = brandDanger
    static let pageBackground = bgDark
    static let cardBackground = bgDark2
    static let glassBorder    = cardDarkBd
    static let warmWhiteLight = Color(hex: 0xF0F5FF)

    // Gold gradient — the signature Arcade move
    static let goldGradient: LinearGradient = AppColors.gold.gradient

    // Action gradient (legacy blue) — kept for old call sites
    static let actionGradient = LinearGradient(
        colors: [brandPrimary, amber],
        startPoint: .leading, endPoint: .trailing
    )
    static let heroGradient = LinearGradient(
        colors: [brandPrimary, amber],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let warmGradient = LinearGradient(
        colors: [amber, sunlight],
        startPoint: .leading, endPoint: .trailing
    )
    static let trophyGradient = LinearGradient(
        colors: [brandPrimary, amber],
        startPoint: .top, endPoint: .bottom
    )
    static let cardAccentGradient = LinearGradient(
        colors: [sunlight, brandPrimary],
        startPoint: .top, endPoint: .bottom
    )
    static let dangerGradient = LinearGradient(
        colors: [Color(hex: 0xE63946), brandDanger],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let successGradient = LinearGradient(
        colors: [Color(hex: 0x4ADE80), brandSuccess],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    static let tabBarSurface = bgDark2
    static let subtleBorder  = cardDarkBd
    static let sectionHeader = Color.white.opacity(0.6)
}

// MARK: - Rank theme bridge

struct RankTheme {
    static func tier(for tier: RankTier) -> TierColor {
        switch tier {
        case .iron:      return AppColors.iron
        case .bronze:    return AppColors.bronze
        case .silver:    return AppColors.silver
        case .gold:      return AppColors.gold
        case .platinum:  return AppColors.platinum
        case .diamond:   return AppColors.diamond
        case .ascendant: return AppColors.ascendant
        case .immortal:  return AppColors.immortal
        }
    }

    static func gradientColors(for tier: RankTier) -> [Color] {
        let t = self.tier(for: tier)
        return [t.bright, t.base]
    }

    static func gradient(for tier: RankTier) -> LinearGradient {
        self.tier(for: tier).gradient
    }

    static func color(for tier: RankTier) -> Color {
        self.tier(for: tier).base
    }

    // Position (1st/2nd/3rd) accent helpers
    static func positionColor(_ position: Int) -> Color {
        switch position {
        case 1: return AppColors.brandTrophyGold
        case 2: return AppColors.silver.bright
        case 3: return AppColors.bronze.bright
        default: return AppColors.mutedDark
        }
    }

    static func positionGradient(_ position: Int) -> LinearGradient {
        switch position {
        case 1: return AppColors.gold.gradientVertical
        case 2: return AppColors.silver.gradientVertical
        case 3: return AppColors.bronze.gradientVertical
        default:
            return LinearGradient(
                colors: [AppColors.mutedDark, AppColors.subtleDark],
                startPoint: .top, endPoint: .bottom
            )
        }
    }

    static func positionGlowColor(_ position: Int) -> Color {
        switch position {
        case 1: return Color(hex: 0xF6D365) // medal gold
        case 2: return Color(hex: 0xBDC3C7)
        case 3: return Color(hex: 0xCD7F32)
        default: return .clear
        }
    }
}

// MARK: - Card style modifier (glass)

struct CardStyle: ViewModifier {
    var padding: CGFloat = 14
    var cornerRadius: CGFloat = 16
    var rotation: Double = 0
    var showAccentLine: Bool = false

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(AppColors.cardDark)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(AppColors.cardDarkBd, lineWidth: 1.5)
            )
            .rotationEffect(.degrees(rotation))
    }
}

extension View {
    func cardStyle(padding: CGFloat = 14, cornerRadius: CGFloat = 16, rotation: Double = 0, showAccentLine: Bool = false) -> some View {
        modifier(CardStyle(padding: padding, cornerRadius: cornerRadius, rotation: rotation, showAccentLine: showAccentLine))
    }
}

// MARK: - Themed background

struct ThemedBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppColors.bgDark.ignoresSafeArea())
    }
}

extension View {
    func themedBackground() -> some View {
        modifier(ThemedBackground())
    }
}

// MARK: - Section header style

struct SectionHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 10, weight: .heavy))
            .tracking(1.5)
            .textCase(.uppercase)
            .foregroundStyle(AppColors.mutedDark)
    }
}

extension View {
    func sectionHeaderStyle() -> some View {
        modifier(SectionHeaderStyle())
    }
}

// MARK: - Legacy gradient-button shim (still used by some screens)

struct GradientButtonStyle: ButtonStyle {
    var fullWidth: Bool = true

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14, weight: .heavy))
            .tracking(0.8)
            .textCase(.uppercase)
            .foregroundStyle(Color(hex: 0x0F172A))
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .padding(.vertical, 14)
            .padding(.horizontal, fullWidth ? 0 : 24)
            .background(AppColors.goldGradient)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: AppColors.brandTrophyGold.opacity(0.45), radius: 18, x: 0, y: 8)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.22, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Glow modifier

struct GlowModifier: ViewModifier {
    let color: Color
    var radius: CGFloat = 16

    func body(content: Content) -> some View {
        content.shadow(color: color.opacity(0.55), radius: radius, x: 0, y: 0)
    }
}

extension View {
    func glowEffect(color: Color, radius: CGFloat = 16) -> some View {
        modifier(GlowModifier(color: color, radius: radius))
    }
}

// MARK: - Rank progress info

struct RankProgressInfo {
    let currentPoints: Int
    let currentThreshold: Int
    let nextThreshold: Int
    let progress: Double
    let nextLabel: String

    static func calculate(for points: Int) -> RankProgressInfo {
        let rank = Rank.fromPoints(points)
        let currentThreshold = Rank.pointsForRank(tier: rank.tier, division: rank.division)

        let nextTier: RankTier
        let nextDivision: Int
        let nextThreshold: Int

        if rank.tier == .immortal && rank.division == 3 {
            nextTier = rank.tier
            nextDivision = rank.division
            nextThreshold = currentThreshold + 100
        } else if rank.division == 3 {
            let nextTierIndex = rank.tier.index + 1
            if nextTierIndex < RankTier.allCases.count {
                nextTier = RankTier.allCases[nextTierIndex]
                nextDivision = 1
                nextThreshold = Rank.pointsForRank(tier: nextTier, division: 1)
            } else {
                nextTier = rank.tier
                nextDivision = rank.division
                nextThreshold = currentThreshold + 100
            }
        } else {
            nextTier = rank.tier
            nextDivision = rank.division + 1
            nextThreshold = Rank.pointsForRank(tier: nextTier, division: nextDivision)
        }

        let range = nextThreshold - currentThreshold
        let progress: Double
        if rank.tier == .immortal && rank.division == 3 {
            progress = 1.0
        } else if range <= 0 {
            progress = 1.0
        } else {
            progress = min(1.0, max(0.0, Double(points - currentThreshold) / Double(range)))
        }

        let nextLabel = "\(nextTier.rawValue.uppercased()) \(nextDivision)"

        return RankProgressInfo(
            currentPoints: points,
            currentThreshold: currentThreshold,
            nextThreshold: nextThreshold,
            progress: progress,
            nextLabel: nextLabel
        )
    }
}
