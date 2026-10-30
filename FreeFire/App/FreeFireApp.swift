import SwiftUI

@main
struct FreeFireApp: App {
    @State private var isGameLoaded = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isGameLoaded {
                    LobbyView()
                        .transition(.opacity)
                } else {
                    SplashScreenView(isGameLoaded: $isGameLoaded)
                        .transition(.opacity)
                }
            }
            .preferredColorScheme(.dark)
            .animation(.easeInOut(duration: 0.5), value: isGameLoaded)
        }
    }
}
