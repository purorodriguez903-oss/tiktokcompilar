import SwiftUI
import AVFoundation

@main
struct TikTokApp: App {
    @StateObject private var languageManager = LanguageManager.shared
    
    init() {
        // Configure AVAudioSession for smooth background and audio playback
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AudioSession setup failed: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(.dark)
                .environmentObject(languageManager)
        }
    }
}

