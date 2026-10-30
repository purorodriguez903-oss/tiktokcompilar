import SwiftUI
import AVFoundation

@main
struct TikTokApp: App {
    @StateObject private var languageManager = LanguageManager.shared
    
    init() {
        // 1. Configure High-Performance Network & Media Cache (60MB RAM / 250MB Disk)
        let memoryCapacity = 60 * 1024 * 1024
        let diskCapacity = 250 * 1024 * 1024
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "tiktok_media_cache")
        URLCache.shared = cache
        
        // 2. Configure AVAudioSession for low-latency playback
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AudioSession setup failed: \(error)")
        }
        
        // 3. Auto-purge image memory cache on low-memory warnings
        NotificationCenter.default.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: nil,
            queue: .main
        ) { _ in
            ImageCacheManager.shared.clearMemory()
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
