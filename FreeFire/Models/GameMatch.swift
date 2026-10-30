import SwiftUI

enum MatchPhase {
    case inPlane
    case parachuting
    case fighting
    case victory
    case defeated
}

struct EnemyBot: Identifiable {
    let id = UUID()
    let name: String
    var position: CGPoint
    var hp: Int = 100
    var isAlive: Bool = true
    let weaponName: String
}

struct GlooWallEntity: Identifiable {
    let id = UUID()
    let position: CGPoint
    let rotation: Double
    var hp: Int = 300
}

struct DamageIndicator: Identifiable {
    let id = UUID()
    let text: String
    let isHeadshot: Bool
    let position: CGPoint
    var opacity: Double = 1.0
    var offsetY: CGFloat = 0.0
}

