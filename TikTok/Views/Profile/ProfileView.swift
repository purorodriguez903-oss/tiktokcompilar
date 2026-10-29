import SwiftUI

struct ProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    @ObservedObject var languageManager = LanguageManager.shared
    
    let columns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    
    var currentGridVideos: [UserVideoThumbnail] {
        switch profileViewModel.selectedTab {
        case 0: return profileViewModel.user.videos
        case 1: return profileViewModel.user.privateVideos
        case 2: return profileViewModel.user.savedVideos
        case 3: return profileViewModel.user.likedVideos
        default: return []
        }
    }
    
    var body: some View {
        ZStack {
            TikTokTheme.darkBg.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Bar
                HStack {
                    Image(systemName: "person.badge.plus")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text(profileViewModel.user.name)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Image(systemName: "eye")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        
                        Button(action: {
                            TikTokTheme.haptic(.light)
                            profileViewModel.showSettings = true
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 50)
                .padding(.bottom, 12)
                
                ScrollView {
                    VStack(spacing: 14) {
                        // Avatar
                        ZStack(alignment: .bottomTrailing) {
                            AsyncImage(url: URL(string: profileViewModel.user.avatarUrl)) { phase in
                                if let img = phase.image {
                                    img.resizable().scaledToFill()
                                } else {
                                    Circle().fill(Color.gray)
                                }
                            }
                            .frame(width: 96, height: 96)
                            .clipShape(Circle())
                            
                            Button(action: { profileViewModel.showEditProfile = true }) {
                                Circle()
                                    .fill(TikTokTheme.cyan)
                                    .frame(width: 24, height: 24)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundColor(.black)
                                    )
                            }
                        }
                        
                        // Handle & Verified badge
                        HStack(spacing: 4) {
                            Text(profileViewModel.user.handle)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color(white: 0.8))
                            
                            if profileViewModel.user.isVerified {
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(TikTokTheme.cyan)
                            }
                        }
                        
                        // Stats Row: Siguiendo | Seguidores | Me gusta
                        HStack(spacing: 36) {
                            VStack(spacing: 4) {
                                Text("\(profileViewModel.user.followingCount)")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.white)
                                Text(languageManager.t("profile_following"))
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            
                            VStack(spacing: 4) {
                                Text(TikTokTheme.formatCount(profileViewModel.user.followersCount))
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.white)
                                Text(languageManager.t("profile_followers"))
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            
                            VStack(spacing: 4) {
                                Text(TikTokTheme.formatCount(profileViewModel.user.likesCount))
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.white)
                                Text(languageManager.t("profile_likes"))
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                        
                        // Action Buttons: Editar Perfil | Compartir Perfil
                        HStack(spacing: 8) {
                            Button(action: {
                                profileViewModel.showEditProfile = true
                            }) {
                                Text(languageManager.t("profile_edit"))
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(width: 140, height: 42)
                                    .background(Color(white: 0.18))
                                    .cornerRadius(6)
                            }
                            
                            Button(action: {
                                profileViewModel.showShareProfileSheet = true
                            }) {
                                Text(languageManager.t("profile_share"))
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(width: 140, height: 42)
                                    .background(Color(white: 0.18))
                                    .cornerRadius(6)
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "person.badge.plus")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .frame(width: 42, height: 42)
                                    .background(Color(white: 0.18))
                                    .cornerRadius(6)
                            }
                        }
                        
                        // Bio Text
                        Text(profileViewModel.user.bio)
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                        
                        // Tabs: Videos | Lock | Bookmark | Heart
                        HStack(spacing: 0) {
                            TabButton(icon: "rectangle.grid.3x2.fill", index: 0, selectedIndex: $profileViewModel.selectedTab)
                            TabButton(icon: "lock.fill", index: 1, selectedIndex: $profileViewModel.selectedTab)
                            TabButton(icon: "bookmark.fill", index: 2, selectedIndex: $profileViewModel.selectedTab)
                            TabButton(icon: "heart.fill", index: 3, selectedIndex: $profileViewModel.selectedTab)
                        }
                        .padding(.top, 8)
                        
                        // 3-Column Video Grid
                        LazyVGrid(columns: columns, spacing: 2) {
                            ForEach(currentGridVideos) { video in
                                ZStack(alignment: .bottomLeading) {
                                    Rectangle()
                                        .fill(Color(hex: video.coverColorHex))
                                        .frame(height: 150)
                                    
                                    if video.isPinned {
                                        Text("Fijado")
                                            .font(.system(size: 9, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 4)
                                            .padding(.vertical, 2)
                                            .background(TikTokTheme.red)
                                            .cornerRadius(3)
                                            .padding(6)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    }
                                    
                                    // View Count
                                    HStack(spacing: 4) {
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 10))
                                            .foregroundColor(.white)
                                        Text(video.viewCount)
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    .padding(6)
                                }
                            }
                        }
                        .padding(.bottom, 80)
                    }
                }
            }
        }
        .sheet(isPresented: $profileViewModel.showEditProfile) {
            EditProfileView(profileViewModel: profileViewModel)
        }
        .sheet(isPresented: $profileViewModel.showSettings) {
            SettingsView()
        }
    }
}

struct TabButton: View {
    let icon: String
    let index: Int
    @Binding var selectedIndex: Int
    
    var isSelected: Bool { selectedIndex == index }
    
    var body: some View {
        Button(action: {
            TikTokTheme.haptic(.light)
            selectedIndex = index
        }) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(isSelected ? .white : .gray)
                
                Rectangle()
                    .fill(isSelected ? Color.white : Color.clear)
                    .frame(height: 2)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

// Hex color helper
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 60, 60, 60)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
