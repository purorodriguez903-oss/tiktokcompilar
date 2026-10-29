import SwiftUI

struct MainTabView: View {
    @StateObject var feedViewModel = FeedViewModel()
    @ObservedObject var languageManager = LanguageManager.shared
    @State private var selectedTab: Int = 0
    @State private var showCameraSheet: Bool = false
    
    init() {
        // Customize UITabBar appearance for authentic TikTok dark translucent look
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(white: 0.05, alpha: 0.98)
        appearance.shadowColor = UIColor(white: 0.15, alpha: 1.0)
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                // 1. Home Feed
                FeedView(viewModel: feedViewModel)
                    .tag(0)
                    .tabItem {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        Text(languageManager.t("tab_home"))
                    }
                
                // 2. TikTok Shop
                ShopView()
                    .tag(1)
                    .tabItem {
                        Image(systemName: selectedTab == 1 ? "bag.fill" : "bag")
                        Text(languageManager.t("tab_shop"))
                    }
                
                // 3. Create Button (dummy tab, intercepted by onChange or custom button)
                Color.clear
                    .tag(2)
                    .tabItem {
                        Image(systemName: "plus.app.fill")
                        Text("")
                    }
                
                // 4. Inbox
                InboxView()
                    .tag(3)
                    .tabItem {
                        Image(systemName: selectedTab == 3 ? "ellipsis.bubble.fill" : "ellipsis.bubble")
                        Text(languageManager.t("tab_inbox"))
                    }
                    .badge(2)
                
                // 5. Profile
                ProfileView()
                    .tag(4)
                    .tabItem {
                        Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        Text(languageManager.t("tab_profile"))
                    }
            }
            .accentColor(.white)
            
            // Custom overlay center TikTok '+' button
            Button(action: {
                TikTokTheme.haptic(.medium)
                showCameraSheet = true
            }) {
                TikTokPlusButton()
            }
            .offset(y: -14)
        }
        .fullScreenCover(isPresented: $showCameraSheet) {
            CameraView()
        }
    }
}
