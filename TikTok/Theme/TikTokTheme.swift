import SwiftUI
import UIKit

struct TikTokTheme {
    static let red = Color(red: 254/255, green: 44/255, blue: 85/255)
    static let cyan = Color(red: 37/255, green: 244/255, blue: 238/255)
    static let yellow = Color(red: 255/255, green: 204/255, blue: 0/255)
    static let darkBg = Color(red: 12/255, green: 12/255, blue: 14/255)
    static let darkCard = Color(red: 24/255, green: 24/255, blue: 28/255)
    static let darkBorder = Color(white: 0.22)
    static let lightGray = Color(white: 0.75)
    static let dimWhite = Color(white: 0.9)
    static let textSecondary = Color(white: 0.6)
    
    // Haptics
    static func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    static func hapticNotification(_ type: UINotificationFeedbackGenerator.FeedbackType = .success) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    
    // Number formatting: 12500 -> 12.5K, 1200000 -> 1.2M
    static func formatCount(_ count: Int) -> String {
        if count >= 1_000_000 {
            let formatted = Double(count) / 1_000_000.0
            return String(format: "%.1fM", formatted)
        } else if count >= 1_000 {
            let formatted = Double(count) / 1_000.0
            return String(format: "%.1fK", formatted)
        } else {
            return "\(count)"
        }
    }
}
