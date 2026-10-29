import SwiftUI

struct CommentsSheetView: View {
    let video: VideoItem
    @ObservedObject var viewModel: FeedViewModel
    @ObservedObject var languageManager = LanguageManager.shared
    @Environment(\.dismiss) var dismiss
    
    @State private var commentText: String = ""
    
    struct FullComment: Identifiable {
        let id = UUID()
        let name: String
        let avatarUrl: String
        let text: String
        let timeAgo: String
        var likes: Int
        var isLiked: Bool = false
        var isDisliked: Bool = false
        let isCreator: Bool
        let isFirstComment: Bool
        let replyCount: Int
    }
    
    @State private var demoComments: [FullComment] = [
        FullComment(
            name: "Maria.Yesenia",
            avatarUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200",
            text: "Pero que chingón canto 😌",
            timeAgo: "2h",
            likes: 2,
            isCreator: false,
            isFirstComment: false,
            replyCount: 2
        ),
        FullComment(
            name: "icela 🥀✨",
            avatarUrl: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200",
            text: "Que canción es",
            timeAgo: "5h",
            likes: 3,
            isCreator: false,
            isFirstComment: false,
            replyCount: 0
        ),
        FullComment(
            name: "Ruben",
            avatarUrl: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200",
            text: "Vas A Llorar",
            timeAgo: "4h",
            likes: 5,
            isCreator: false,
            isFirstComment: false,
            replyCount: 1
        ),
        FullComment(
            name: "Mayra De La Rosa 🌹",
            avatarUrl: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=200",
            text: "Tu fuiste.?",
            timeAgo: "8h",
            likes: 0,
            isCreator: false,
            isFirstComment: true,
            replyCount: 0
        ),
        FullComment(
            name: "Laura 🍒❤️",
            avatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200",
            text: "Sii estuvo padrísimo el show! 😂",
            timeAgo: "1h",
            likes: 18,
            isCreator: true,
            isFirstComment: false,
            replyCount: 0
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Search pill inside comments sheet (as shown in TikTok video)
            HStack(spacing: 6) {
                Text("Search: ")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.gray)
                Text(video.searchQuery ?? "brincos dieras dallas")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(TikTokTheme.cyan)
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 6)
            
            // Header: "21 comments ☰" + Close 'X'
            ZStack {
                HStack(spacing: 4) {
                    Text("\(demoComments.count * 4 + 1) comments")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(8)
                    }
                }
            }
            .padding(.horizontal, 12)
            
            Divider().background(Color(white: 0.18))
            
            // Comments Scroll
            ScrollView {
                LazyVStack(spacing: 18) {
                    ForEach($demoComments) { $comment in
                        HStack(alignment: .top, spacing: 12) {
                            // Avatar
                            AsyncImage(url: URL(string: comment.avatarUrl)) { phase in
                                if let img = phase.image {
                                    img.resizable().scaledToFill()
                                } else {
                                    Circle().fill(Color.gray)
                                }
                            }
                            .frame(width: 34, height: 34)
                            .clipShape(Circle())
                            
                            // Comment Body
                            VStack(alignment: .leading, spacing: 4) {
                                HStack(spacing: 6) {
                                    Text(comment.name)
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundColor(Color(white: 0.8))
                                    
                                    if comment.isCreator {
                                        Text("• Creator")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(TikTokTheme.red)
                                    }
                                }
                                
                                Text(comment.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                
                                if comment.isFirstComment {
                                    Text("First comment")
                                        .font(.system(size: 10, weight: .semibold))
                                        .foregroundColor(Color(white: 0.85))
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 2)
                                        .background(Color(white: 0.25))
                                        .cornerRadius(4)
                                }
                                
                                HStack(spacing: 14) {
                                    Text(comment.timeAgo)
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                    
                                    Button("Reply") {
                                        commentText = "@\(comment.name) "
                                    }
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                }
                                .padding(.top, 2)
                                
                                if comment.replyCount > 0 {
                                    Button(action: {}) {
                                        HStack(spacing: 4) {
                                            Rectangle()
                                                .fill(Color.gray)
                                                .frame(width: 20, height: 1)
                                            Text("View \(comment.replyCount) replies ⌵")
                                                .font(.system(size: 12, weight: .semibold))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding(.top, 4)
                                }
                            }
                            
                            Spacer()
                            
                            // Likes & Dislike icons
                            VStack(spacing: 12) {
                                Button(action: {
                                    TikTokTheme.haptic(.light)
                                    comment.isLiked.toggle()
                                    comment.likes += comment.isLiked ? 1 : -1
                                }) {
                                    VStack(spacing: 2) {
                                        Image(systemName: comment.isLiked ? "heart.fill" : "heart")
                                            .font(.system(size: 14))
                                            .foregroundColor(comment.isLiked ? TikTokTheme.red : .gray)
                                        if comment.likes > 0 {
                                            Text("\(comment.likes)")
                                                .font(.system(size: 10))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                
                                Button(action: {
                                    TikTokTheme.haptic(.light)
                                    comment.isDisliked.toggle()
                                }) {
                                    Image(systemName: comment.isDisliked ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                                        .font(.system(size: 13))
                                        .foregroundColor(comment.isDisliked ? .white : .gray)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.vertical, 12)
            }
            
            Divider().background(Color(white: 0.18))
            
            // Bottom Add Comment Pill (matching TikTok video)
            HStack(spacing: 12) {
                // User Avatar
                Circle()
                    .fill(Color(white: 0.3))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Text("A")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                    )
                
                // Input Pill
                HStack(spacing: 10) {
                    TextField("Add comment...", text: $commentText)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                    
                    Image(systemName: "photo")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    
                    Image(systemName: "face.smiling")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    
                    Text("@")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Color(white: 0.18))
                .cornerRadius(22)
                
                if !commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Button(action: {
                        TikTokTheme.haptic(.medium)
                        let newC = FullComment(
                            name: "atx_alexrod1",
                            avatarUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200",
                            text: commentText,
                            timeAgo: "Just now",
                            likes: 0,
                            isCreator: false,
                            isFirstComment: false,
                            replyCount: 0
                        )
                        demoComments.insert(newC, at: 0)
                        commentText = ""
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(TikTokTheme.red)
                    }
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(TikTokTheme.darkCard)
        }
        .background(TikTokTheme.darkBg.ignoresSafeArea())
    }
}
