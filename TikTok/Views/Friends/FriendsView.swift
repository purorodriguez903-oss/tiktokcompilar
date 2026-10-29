import SwiftUI

struct FriendsView: View {
    @ObservedObject var languageManager = LanguageManager.shared
    
    struct SuggestedFriend: Identifiable {
        let id = UUID()
        let name: String
        let handle: String
        let avatarUrl: String
        let mutualFriends: Int
        var isFollowing: Bool = false
    }
    
    @State private var suggested: [SuggestedFriend] = [
        SuggestedFriend(name: "David Silva", handle: "@davidsilva", avatarUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200", mutualFriends: 14),
        SuggestedFriend(name: "Lucia Mendes", handle: "@luciamendes", avatarUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200", mutualFriends: 22),
        SuggestedFriend(name: "Martin Romero", handle: "@martinromero", avatarUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200", mutualFriends: 8),
        SuggestedFriend(name: "Andrea Vega", handle: "@andreavega", avatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200", mutualFriends: 31)
    ]
    
    var body: some View {
        ZStack {
            TikTokTheme.darkBg.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header
                HStack {
                    Text(languageManager.t("friends_title"))
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 50)
                .padding(.bottom, 12)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Sync Contacts Banner
                        HStack(spacing: 14) {
                            Circle()
                                .fill(TikTokTheme.cyan.opacity(0.15))
                                .frame(width: 48, height: 48)
                                .overlay(
                                    Image(systemName: "person.crop.circle.badge.plus")
                                        .font(.system(size: 22))
                                        .foregroundColor(TikTokTheme.cyan)
                                )
                            
                            VStack(alignment: .leading, spacing: 3) {
                                Text(languageManager.t("friends_connect"))
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Encuentra amigos de tus contactos telefónicos")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                TikTokTheme.hapticNotification(.success)
                            }) {
                                Text(languageManager.t("friends_sync"))
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 7)
                                    .background(TikTokTheme.cyan)
                                    .cornerRadius(6)
                            }
                        }
                        .padding(14)
                        .background(Color(white: 0.12))
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                        
                        // Suggested Accounts
                        VStack(alignment: .leading, spacing: 12) {
                            Text(languageManager.t("friends_suggested"))
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                            
                            ForEach($suggested) { $friend in
                                HStack(spacing: 12) {
                                    AsyncImage(url: URL(string: friend.avatarUrl)) { phase in
                                        if let img = phase.image {
                                            img.resizable().scaledToFill()
                                        } else {
                                            Circle().fill(Color.gray)
                                        }
                                    }
                                    .frame(width: 46, height: 46)
                                    .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(friend.name)
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.white)
                                        
                                        Text("\(friend.mutualFriends) amigos en común")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        TikTokTheme.haptic(.medium)
                                        friend.isFollowing.toggle()
                                    }) {
                                        Text(friend.isFollowing ? "Siguiendo" : languageManager.t("friends_follow"))
                                            .font(.system(size: 13, weight: .bold))
                                            .foregroundColor(friend.isFollowing ? .white : .white)
                                            .padding(.horizontal, 18)
                                            .padding(.vertical, 7)
                                            .background(friend.isFollowing ? Color(white: 0.25) : TikTokTheme.red)
                                            .cornerRadius(6)
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 80)
                }
            }
        }
    }
}
