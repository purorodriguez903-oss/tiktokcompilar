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
    var rotation: Double = 0.0
    var hp: Int = 300
    
    init(position: CGPoint, rotation: Double = 0.0, hp: Int = 300) {
        self.position = position
        self.rotation = rotation
        self.hp = hp
    }
}

struct DamageIndicator: Identifiable {
    let id = UUID()
    let text: String
    let isHeadshot: Bool
    let position: CGPoint
    var opacity: Double = 1.0
    var offsetY: CGFloat = 0.0
    
    init(text: String, isHeadshot: Bool, position: CGPoint, opacity: Double = 1.0, offsetY: CGFloat = 0.0) {
        self.text = text
        self.isHeadshot = isHeadshot
        self.position = position
        self.opacity = opacity
        self.offsetY = offsetY
    }
}
