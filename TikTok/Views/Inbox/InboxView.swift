import SwiftUI

struct InboxView: View {
    @ObservedObject var languageManager = LanguageManager.shared
    @State private var selectedChat: InboxItem? = nil
    
    struct ContactRowItem: Identifiable {
        let id = UUID()
        let name: String
        let subtitle: String
        let avatarUrl: String
        let isActiveNow: Bool
        let hasStoryRing: Bool
    }
    
    let contacts: [ContactRowItem] = [
        ContactRowItem(name: "Mallory", subtitle: "Active 15m ago", avatarUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200", isActiveNow: false, hasStoryRing: true),
        ContactRowItem(name: "edy 🐺", subtitle: "Sent 3d ago", avatarUrl: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200", isActiveNow: false, hasStoryRing: false),
        ContactRowItem(name: "Mia 💭", subtitle: "Active now", avatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200", isActiveNow: true, hasStoryRing: false),
        ContactRowItem(name: "480_china", subtitle: "Say hi to 480_china", avatarUrl: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200", isActiveNow: false, hasStoryRing: false),
        ContactRowItem(name: "Ellyanna 🎀", subtitle: "Active 6h ago", avatarUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200", isActiveNow: false, hasStoryRing: false),
        ContactRowItem(name: "alisson", subtitle: "Active 27m ago", avatarUrl: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=200", isActiveNow: false, hasStoryRing: false),
        ContactRowItem(name: "__ale ☆", subtitle: "Active 1h ago", avatarUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200", isActiveNow: false, hasStoryRing: false),
        ContactRowItem(name: ".", subtitle: "Say hi to .", avatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200", isActiveNow: false, hasStoryRing: false),
        ContactRowItem(name: "aly.gon48", subtitle: "Say hi to aly.gon48", avatarUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200", isActiveNow: false, hasStoryRing: false)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                TikTokTheme.darkBg.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header (Frame 011)
                    HStack {
                        // Left: Add friends + user icon
                        HStack(spacing: 6) {
                            Image(systemName: "person.2.badge.plus")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                            
                            Circle()
                                .fill(Color(white: 0.3))
                                .frame(width: 22, height: 22)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 11))
                                        .foregroundColor(.white)
                                )
                        }
                        
                        Spacer()
                        
                        // Center: Inbox with green dot & dropdown
                        HStack(spacing: 4) {
                            Text("Inbox")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                            Circle()
                                .fill(Color.green)
                                .frame(width: 7, height: 7)
                            Image(systemName: "chevron.down")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        // Right: Search Icon
                        Button(action: { TikTokTheme.haptic(.light) }) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 48)
                    .padding(.bottom, 10)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            // Account updates notification banner (Frame 011)
                            HStack(spacing: 12) {
                                Circle()
                                    .fill(TikTokTheme.cyan.opacity(0.2))
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        Image(systemName: "bell.fill")
                                            .font(.system(size: 18))
                                            .foregroundColor(TikTokTheme.cyan)
                                    )
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Account updates: Your account...")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.white)
                                    Text("Security alert and creator tips • 1d")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            
                            Divider().background(Color(white: 0.16))
                            
                            // Direct Message List with Camera icons
                            LazyVStack(spacing: 14) {
                                ForEach(contacts) { contact in
                                    HStack(spacing: 12) {
                                        // Avatar with active green dot or story ring (Frame 011)
                                        ZStack(alignment: .bottomTrailing) {
                                            AsyncImage(url: URL(string: contact.avatarUrl)) { phase in
                                                if let img = phase.image {
                                                    img.resizable().scaledToFill()
                                                } else {
                                                    Circle().fill(Color.gray)
                                                }
                                            }
                                            .frame(width: 52, height: 52)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle()
                                                    .stroke(contact.hasStoryRing ? TikTokTheme.cyan : Color.clear, lineWidth: 2)
                                            )
                                            
                                            if contact.isActiveNow {
                                                Circle()
                                                    .fill(Color.green)
                                                    .frame(width: 14, height: 14)
                                                    .overlay(Circle().stroke(TikTokTheme.darkBg, lineWidth: 2))
                                            }
                                        }
                                        
                                        // Name & Subtitle
                                        VStack(alignment: .leading, spacing: 3) {
                                            Text(contact.name)
                                                .font(.system(size: 15, weight: .bold))
                                                .foregroundColor(.white)
                                            
                                            Text(contact.subtitle)
                                                .font(.system(size: 13))
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        // Camera Quick Reply Icon (Frame 011)
                                        Button(action: {
                                            TikTokTheme.haptic(.light)
                                        }) {
                                            Image(systemName: "camera")
                                                .font(.system(size: 20))
                                                .foregroundColor(.gray)
                                                .padding(6)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                        }
                        .padding(.top, 4)
                        .padding(.bottom, 80)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}
