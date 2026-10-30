import SwiftUI

struct ProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    @ObservedObject var languageManager = LanguageManager.shared
    @State private var selectedProfileTab: Int = 0
    @State private var showSwitchAccountSheet: Bool = false
    @State private var activeAccount: String = "atx_alexrod1"
    
    let columns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    
    var body: some View {
        ZStack {
            TikTokTheme.darkBg.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Bar (Frame 013)
                HStack(spacing: 16) {
                    // Edit pencil icon
                    Button(action: {
                        TikTokTheme.haptic(.light)
                        profileViewModel.showEditProfile = true
                    }) {
                        Image(systemName: "pencil")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    // Top Right Icons: Profile Visitors (1) | Add User | Hamburger Menu
                    HStack(spacing: 18) {
                        // Profile Visitors Eye / Icon with count '1'
                        HStack(spacing: 3) {
                            Image(systemName: "person.2")
                                .font(.system(size: 15))
                            Text("1")
                                .font(.system(size: 12, weight: .bold))
                        }
                        .foregroundColor(.white)
                        
                        // Add Friends
                        Button(action: {}) {
                            Image(systemName: "person.badge.plus")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                        }
                        
                        // Settings Hamburger Menu
                        Button(action: {
                            TikTokTheme.haptic(.light)
                            profileViewModel.showSettings = true
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 48)
                .padding(.bottom, 12)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        // User Profile Header: Left Info + Right Avatar with "What's up?" bubble
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                // Username with dropdown arrow (Frame 013)
                                Button(action: {
                                    TikTokTheme.haptic(.light)
                                    showSwitchAccountSheet = true
                                }) {
                                    HStack(spacing: 4) {
                                        Text(activeAccount)
                                            .font(.system(size: 22, weight: .bold))
                                            .foregroundColor(.white)
                                        
                                        Circle()
                                            .fill(TikTokTheme.red)
                                            .frame(width: 6, height: 6)
                                        
                                        Image(systemName: "chevron.down")
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                }
                                
                                Text("@\(activeAccount)")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                                
                                // Stats: Following | Followers | Likes
                                HStack(spacing: 18) {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("15")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.white)
                                        Text("Following")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("3,610")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.white)
                                        Text("Followers")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("9,575")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.white)
                                        Text("Likes")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.top, 6)
                                
                                // Bio
                                Text("Atx")
                                    .font(.system(size: 13))
                                    .foregroundColor(.white)
                                    .padding(.top, 4)
                                
                                // TikTok Studio Button
                                HStack(spacing: 6) {
                                    Image(systemName: "person.crop.circle.badge.checkmark")
                                        .font(.system(size: 12))
                                        .foregroundColor(TikTokTheme.red)
                                    Text("TikTok Studio")
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 7)
                                .background(Color(white: 0.16))
                                .cornerRadius(6)
                                .padding(.top, 6)
                            }
                            
                            Spacer()
                            
                            // Right Avatar with "What's up?" thought bubble (Frame 013)
                            VStack(spacing: 4) {
                                // Thought bubble
                                Text("What's up?")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color(white: 0.25))
                                    .cornerRadius(12)
                                
                                ZStack(alignment: .bottomTrailing) {
                                    CachedAsyncImageView(
                                        urlString: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300",
                                        targetSize: CGSize(width: 82, height: 82)
                                    )
                                    .frame(width: 82, height: 82)
                                    .clipShape(Circle())
                                    
                                    // Cyan plus badge
                                    Circle()
                                        .fill(TikTokTheme.cyan)
                                        .frame(width: 22, height: 22)
                                        .overlay(
                                            Image(systemName: "plus")
                                                .font(.system(size: 12, weight: .bold))
                                                .foregroundColor(.black)
                                        )
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        // 6 Profile Tabs (Frame 013: ||| ▾, 💥, 🔒, 🔁, 🔖, 🤍)
                        HStack(spacing: 0) {
                            ProfileTabIcon(icon: "line.3.horizontal.decrease", title: "▾", index: 0, selectedIndex: $selectedProfileTab)
                            ProfileTabIcon(icon: "sparkles", title: "", index: 1, selectedIndex: $selectedProfileTab)
                            ProfileTabIcon(icon: "lock.fill", title: "", index: 2, selectedIndex: $selectedProfileTab)
                            ProfileTabIcon(icon: "arrow.triangle.2.circlepath", title: "", index: 3, selectedIndex: $selectedProfileTab)
                            ProfileTabIcon(icon: "bookmark.fill", title: "", index: 4, selectedIndex: $selectedProfileTab)
                            ProfileTabIcon(icon: "heart.fill", title: "", index: 5, selectedIndex: $selectedProfileTab)
                        }
                        .padding(.top, 12)
                        
                        // Tab Content
                        if selectedProfileTab == 0 {
                            // User's video post from video: "Aunque no soy de feria!" ▷ 151.1K
                            LazyVGrid(columns: columns, spacing: 2) {
                                ZStack(alignment: .bottomLeading) {
                                    LinearGradient(
                                        colors: [Color(red: 0.25, green: 0.15, blue: 0.2), Color(red: 0.1, green: 0.05, blue: 0.12)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                    .frame(height: 180)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Aunque no soy de feria!")
                                            .font(.system(size: 11, weight: .semibold))
                                            .foregroundColor(.white)
                                            .shadow(radius: 2)
                                        
                                        HStack(spacing: 4) {
                                            Image(systemName: "play")
                                                .font(.system(size: 11, weight: .bold))
                                                .foregroundColor(.white)
                                            Text("151.1K")
                                                .font(.system(size: 12, weight: .bold))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .padding(8)
                                }
                            }
                            
                            // "No more results" centered text (Frame 013)
                            VStack {
                                Text("No more results")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 24)
                            }
                        } else {
                            // Empty tab with TikTok loader animation (Frame 015 & 016)
                            VStack(spacing: 16) {
                                TikTokLoaderView()
                                    .padding(.top, 40)
                                Text("Loading videos...")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.bottom, 80)
                }
            }
        }
        .sheet(isPresented: $showSwitchAccountSheet) {
            switchAccountModal
                .presentationDetents([.fraction(0.36)])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $profileViewModel.showEditProfile) {
            EditProfileView(profileViewModel: profileViewModel)
        }
        .sheet(isPresented: $profileViewModel.showSettings) {
            SettingsView()
        }
    }
    
    // Switch Account Modal (Frame 012)
    private var switchAccountModal: some View {
        VStack(spacing: 14) {
            // Header
            ZStack {
                Text("Switch account")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                
                HStack {
                    Spacer()
                    Button(action: { showSwitchAccountSheet = false }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(8)
                    }
                }
            }
            .padding(.top, 12)
            .padding(.horizontal, 16)
            
            // Accounts List
            VStack(spacing: 12) {
                // Account 1: d66rafa_ (9+)
                AccountRow(
                    name: "d66rafa_",
                    badgeText: "9+",
                    isSelected: activeAccount == "d66rafa_",
                    onSelect: {
                        activeAccount = "d66rafa_"
                        showSwitchAccountSheet = false
                    }
                )
                
                // Account 2: atx_alexrod1 (selected ✓)
                AccountRow(
                    name: "atx_alexrod1",
                    badgeText: nil,
                    isSelected: activeAccount == "atx_alexrod1",
                    onSelect: {
                        activeAccount = "atx_alexrod1"
                        showSwitchAccountSheet = false
                    }
                )
                
                // Account 3: josejr9292
                AccountRow(
                    name: "josejr9292",
                    badgeText: nil,
                    isSelected: activeAccount == "josejr9292",
                    onSelect: {
                        activeAccount = "josejr9292"
                        showSwitchAccountSheet = false
                    }
                )
                
                // Add account button
                Button(action: {}) {
                    HStack(spacing: 14) {
                        Circle()
                            .fill(Color(white: 0.2))
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: "plus")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                            )
                        
                        Text("Add account")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
            }
            
            Spacer()
        }
        .background(TikTokTheme.darkBg.ignoresSafeArea())
    }
}

struct AccountRow: View {
    let name: String
    let badgeText: String?
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: {
            TikTokTheme.haptic(.medium)
            onSelect()
        }) {
            HStack(spacing: 14) {
                Circle()
                    .fill(Color(white: 0.25))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Text(String(name.prefix(1)).uppercased())
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    )
                
                Text(name)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
                
                if let badge = badgeText {
                    Text(badge)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(TikTokTheme.red)
                        .cornerRadius(10)
                }
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(TikTokTheme.red)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct ProfileTabIcon: View {
    let icon: String
    let title: String
    let index: Int
    @Binding var selectedIndex: Int
    
    var isSelected: Bool { selectedIndex == index }
    
    var body: some View {
        Button(action: {
            TikTokTheme.haptic(.light)
            selectedIndex = index
        }) {
            VStack(spacing: 6) {
                HStack(spacing: 2) {
                    Image(systemName: icon)
                        .font(.system(size: 17))
                    if !title.isEmpty {
                        Text(title)
                            .font(.system(size: 10))
                    }
                }
                .foregroundColor(isSelected ? .white : .gray)
                
                Rectangle()
                    .fill(isSelected ? Color.white : Color.clear)
                    .frame(height: 2)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
