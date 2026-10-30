import SwiftUI
import UIKit
import AudioToolbox

struct FreeFireTheme {
    // Classic 2019 Palette
    static let gold = Color(red: 255/255, green: 175/255, blue: 10/255)
    static let darkGold = Color(red: 200/255, green: 130/255, blue: 0/255)
    static let booyahYellow = Color(red: 255/255, green: 225/255, blue: 30/255)
    static let darkBg = Color(red: 14/255, green: 16/255, blue: 20/255)
    static let backgroundDark = Color(red: 14/255, green: 16/255, blue: 20/255)
    static let secondaryDark = Color(red: 24/255, green: 28/255, blue: 35/255)
    static let panelBg = Color(red: 24/255, green: 28/255, blue: 35/255)
    static let cardBorder = Color(red: 80/255, green: 70/255, blue: 50/255)
    static let militaryCamo = Color(red: 35/255, green: 42/255, blue: 32/255)
    static let damageRed = Color(red: 255/255, green: 45/255, blue: 45/255)
    static let bloodRed = Color(red: 200/255, green: 20/255, blue: 25/255)
    static let headshotRed = Color(red: 255/255, green: 10/255, blue: 30/255)
    static let hpGreen = Color(red: 45/255, green: 215/255, blue: 85/255)
    static let epYellow = Color(red: 255/255, green: 205/255, blue: 40/255)
    static let safeZoneBlue = Color(red: 40/255, green: 180/255, blue: 255/255)
    static let glooWallCyan = Color(red: 90/255, green: 220/255, blue: 255/255)
    
    // Haptics & System Sounds
    static func gunshotHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred(intensity: 1.0)
        AudioServicesPlaySystemSound(1104)
    }
    
    static func headshotHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.error)
        AudioServicesPlaySystemSound(1052)
    }
    
    static func glooWallHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
        AudioServicesPlaySystemSound(1057)
    }
    
    static func booyahVictoryHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
        AudioServicesPlaySystemSound(1025)
    }
}

final class SoundManager {
    static let shared = SoundManager()
    private init() {}
    
    func playButtonClick() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred(intensity: 0.6)
        AudioServicesPlaySystemSound(1104)
    }
}
