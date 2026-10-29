import SwiftUI

struct MainTabView: View {
    @StateObject var feedViewModel = FeedViewModel()
    @ObservedObject var languageManager = LanguageManager.shared
    @State private var selectedTab: Int = 0
    @State private var showCameraSheet: Bool = false
    @State private var showSplashScreen: Bool = true
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(white: 0.04, alpha: 0.98)
        appearance.shadowColor = UIColor(white: 0.15, alpha: 1.0)
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                // 1. Home Feed (Frame 002 & 004)
                FeedView(viewModel: feedViewModel)
                    .tag(0)
                    .tabItem {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        Text("Home")
                    }
                
                // 2. Friends Tab (Frame 008)
                FriendsView()
                    .tag(1)
                    .tabItem {
                        Image(systemName: selectedTab == 1 ? "person.2.fill" : "person.2")
                        Text("Friends")
                    }
                
                // 3. Create '+' Center Button
                Color.clear
                    .tag(2)
                    .tabItem {
                        Image(systemName: "plus.app.fill")
                        Text("")
                    }
                
                // 4. Inbox Tab (Frame 011 with '16' badge)
                InboxView()
                    .tag(3)
                    .tabItem {
                        ZStack {
                            Image(systemName: "bubble.right.fill")
                        }
                        Text("Inbox")
                    }
                    .badge(16)
                
                // 5. Profile Tab (Frame 013)
                ProfileView()
                    .tag(4)
                    .tabItem {
                        Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        Text("Profile")
                    }
            }
            .accentColor(.white)
            
            // Custom overlay center TikTok '+' button (Frame 002, 005, 010)
            Button(action: {
                TikTokTheme.haptic(.medium)
                showCameraSheet = true
            }) {
                TikTokPlusButton()
            }
            .offset(y: -14)
            
            // TikTok Launch Splash Screen (Frame 001)
            if showSplashScreen {
                TikTokSplashScreen(isPresented: $showSplashScreen)
                    .zIndex(100)
            }
        }
        .fullScreenCover(isPresented: $showCameraSheet) {
            CameraView()
        }
    }
}
