import SwiftUI

struct InboxView: View {
    @ObservedObject var languageManager = LanguageManager.shared
    @State private var items: [InboxItem] = InboxItem.sampleInbox
    @State private var selectedChat: InboxItem? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                TikTokTheme.darkBg.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text(languageManager.t("inbox_title"))
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            TikTokTheme.haptic(.light)
                        }) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 50)
                    .padding(.bottom, 12)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            // Category Quick Pills
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    QuickInboxCategory(icon: "person.crop.circle.badge.plus", title: "Seguidores", color: TikTokTheme.cyan)
                                    QuickInboxCategory(icon: "heart.circle.fill", title: "Actividad", color: TikTokTheme.red)
                                    QuickInboxCategory(icon: "bag.circle.fill", title: "TikTok Shop", color: TikTokTheme.yellow)
                                    QuickInboxCategory(icon: "bell.circle.fill", title: "Sistema", color: .purple)
                                }
                                .padding(.horizontal, 16)
                            }
                            
                            Divider().background(Color(white: 0.18))
                            
                            // Messages List
                            VStack(alignment: .leading, spacing: 6) {
                                Text(languageManager.t("inbox_messages"))
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 16)
                                
                                ForEach(items) { item in
                                    Button(action: {
                                        selectedChat = item
                                    }) {
                                        HStack(spacing: 12) {
                                            // Avatar
                                            ZStack(alignment: .bottomTrailing) {
                                                AsyncImage(url: URL(string: item.avatarUrl)) { phase in
                                                    if let img = phase.image {
                                                        img.resizable().scaledToFill()
                                                    } else {
                                                        Circle().fill(Color.gray)
                                                    }
                                                }
                                                .frame(width: 48, height: 48)
                                                .clipShape(Circle())
                                                
                                                if item.isUnread {
                                                    Circle()
                                                        .fill(TikTokTheme.cyan)
                                                        .frame(width: 12, height: 12)
                                                        .overlay(Circle().stroke(TikTokTheme.darkBg, lineWidth: 2))
                                                }
                                            }
                                            
                                            // Content
                                            VStack(alignment: .leading, spacing: 4) {
                                                HStack {
                                                    Text(item.senderName)
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(.white)
                                                    
                                                    Spacer()
                                                    
                                                    Text(item.timeAgo)
                                                        .font(.system(size: 12))
                                                        .foregroundColor(.gray)
                                                }
                                                
                                                Text(item.message)
                                                    .font(.system(size: 13))
                                                    .foregroundColor(item.isUnread ? .white : .gray)
                                                    .lineLimit(2)
                                                    .multilineTextAlignment(.leading)
                                            }
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                    }
                                }
                            }
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 80)
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $selectedChat) { chat in
                ChatDetailView(inboxItem: chat)
            }
        }
    }
}

struct QuickInboxCategory: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 6) {
            Circle()
                .fill(color.opacity(0.18))
                .frame(width: 52, height: 52)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(color)
                )
            
            Text(title)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.white)
        }
        .frame(width: 72)
    }
}
