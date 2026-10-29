import SwiftUI

struct ShareSheetView: View {
    let video: VideoItem
    @ObservedObject var languageManager = LanguageManager.shared
    @Environment(\.dismiss) var dismiss
    @State private var copied: Bool = false
    
    struct FriendShare: Identifiable {
        let id = UUID()
        let name: String
        let avatarUrl: String
    }
    
    let friends: [FriendShare] = [
        FriendShare(name: "Sofia", avatarUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200"),
        FriendShare(name: "Lucas", avatarUrl: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200"),
        FriendShare(name: "Camila", avatarUrl: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200"),
        FriendShare(name: "Alex", avatarUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200"),
        FriendShare(name: "Elena", avatarUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200")
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            // Drag indicator
            Capsule()
                .fill(Color(white: 0.3))
                .frame(width: 36, height: 4)
                .padding(.top, 8)
            
            Text(languageManager.t("feed_share_to"))
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
            
            // Friends row
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    ForEach(friends) { friend in
                        VStack(spacing: 6) {
                            AsyncImage(url: URL(string: friend.avatarUrl)) { phase in
                                if let img = phase.image {
                                    img.resizable().scaledToFill()
                                } else {
                                    Circle().fill(Color.gray)
                                }
                            }
                            .frame(width: 52, height: 52)
                            .clipShape(Circle())
                            
                            Text(friend.name)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.white)
                                .lineLimit(1)
                            
                            Text("Enviar")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 3)
                                .background(TikTokTheme.red)
                                .cornerRadius(12)
                        }
                        .frame(width: 64)
                    }
                }
                .padding(.horizontal, 16)
            }
            
            Divider()
                .background(Color(white: 0.2))
            
            // App actions row (Copy Link, WhatsApp, etc.)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    // Copy Link
                    Button(action: {
                        TikTokTheme.hapticNotification(.success)
                        UIPasteboard.general.string = "https://tiktok.com/@\(video.authorHandle)/video/\(video.id)"
                        copied = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            copied = false
                            dismiss()
                        }
                    }) {
                        VStack(spacing: 6) {
                            ZStack {
                                Circle()
                                    .fill(Color(white: 0.2))
                                    .frame(width: 50, height: 50)
                                Image(systemName: copied ? "checkmark" : "link")
                                    .font(.system(size: 20))
                                    .foregroundColor(copied ? .green : .white)
                            }
                            Text(copied ? "¡Copiado!" : languageManager.t("feed_copy_link"))
                                .font(.system(size: 11))
                                .foregroundColor(Color(white: 0.8))
                                .lineLimit(1)
                        }
                        .frame(width: 68)
                    }
                    
                    // WhatsApp
                    VStack(spacing: 6) {
                        Circle()
                            .fill(Color(red: 37/255, green: 211/255, blue: 102/255))
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "phone.bubble.left.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                            )
                        Text("WhatsApp")
                            .font(.system(size: 11))
                            .foregroundColor(Color(white: 0.8))
                    }
                    .frame(width: 68)
                    
                    // Save Video
                    VStack(spacing: 6) {
                        Circle()
                            .fill(Color(white: 0.2))
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "arrow.down.to.line")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            )
                        Text(languageManager.t("feed_save_video"))
                            .font(.system(size: 11))
                            .foregroundColor(Color(white: 0.8))
                    }
                    .frame(width: 68)
                    
                    // Duet
                    VStack(spacing: 6) {
                        Circle()
                            .fill(Color(white: 0.2))
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "person.2.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            )
                        Text(languageManager.t("feed_duet"))
                            .font(.system(size: 11))
                            .foregroundColor(Color(white: 0.8))
                    }
                    .frame(width: 68)
                    
                    // Stitch
                    VStack(spacing: 6) {
                        Circle()
                            .fill(Color(white: 0.2))
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "square.split.2x1.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            )
                        Text(languageManager.t("feed_stitch"))
                            .font(.system(size: 11))
                            .foregroundColor(Color(white: 0.8))
                    }
                    .frame(width: 68)
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 20)
        }
        .background(TikTokTheme.darkBg.ignoresSafeArea())
    }
}

