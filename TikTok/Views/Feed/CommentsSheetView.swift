import SwiftUI

struct CommentsSheetView: View {
    let video: VideoItem
    @ObservedObject var viewModel: FeedViewModel
    @ObservedObject var languageManager = LanguageManager.shared
    @Environment(\.dismiss) var dismiss
    
    @State private var commentText: String = ""
    
    var currentComments: [CommentItem] {
        viewModel.comments[video.id] ?? []
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            ZStack {
                Text("\(currentComments.count) \(languageManager.t("feed_comments"))")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(12)
                    }
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 10)
            
            Divider()
                .background(Color(white: 0.2))
            
            // Comments List
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(currentComments) { comment in
                        HStack(alignment: .top, spacing: 12) {
                            // Avatar
                            AsyncImage(url: URL(string: comment.authorAvatarUrl)) { phase in
                                if let img = phase.image {
                                    img.resizable().scaledToFill()
                                } else {
                                    Circle().fill(Color.gray)
                                }
                            }
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                            
                            // Comment Content
                            VStack(alignment: .leading, spacing: 4) {
                                HStack(spacing: 6) {
                                    Text(comment.authorHandle)
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(Color(white: 0.7))
                                    
                                    if comment.isCreator {
                                        Text("Creador")
                                            .font(.system(size: 10, weight: .bold))
                                            .padding(.horizontal, 5)
                                            .padding(.vertical, 2)
                                            .background(TikTokTheme.red)
                                            .foregroundColor(.white)
                                            .cornerRadius(4)
                                    }
                                }
                                
                                Text(comment.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                
                                HStack(spacing: 12) {
                                    Text(comment.timeAgo)
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                    
                                    Button("Responder") {
                                        commentText = "\(comment.authorHandle) "
                                    }
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                }
                                .padding(.top, 2)
                            }
                            
                            Spacer()
                            
                            // Like Comment Button
                            Button(action: {
                                viewModel.toggleCommentLike(videoId: video.id, commentId: comment.id)
                            }) {
                                VStack(spacing: 3) {
                                    Image(systemName: comment.isLiked ? "heart.fill" : "heart")
                                        .font(.system(size: 15))
                                        .foregroundColor(comment.isLiked ? TikTokTheme.red : .gray)
                                    
                                    if comment.likeCount > 0 {
                                        Text(TikTokTheme.formatCount(comment.likeCount))
                                            .font(.system(size: 11))
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.vertical, 14)
            }
            
            Divider()
                .background(Color(white: 0.2))
            
            // Comment Input Bar
            HStack(spacing: 10) {
                // User Avatar
                Circle()
                    .fill(Color(white: 0.3))
                    .frame(width: 34, height: 34)
                    .overlay(
                        Text("P")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    )
                
                // TextField
                HStack {
                    TextField(languageManager.t("feed_add_comment"), text: $commentText)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 10) {
                        Text("@")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.gray)
                        
                        Image(systemName: "face.smiling")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(white: 0.16))
                .cornerRadius(20)
                
                // Send Button
                if !commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Button(action: {
                        viewModel.addComment(videoId: video.id, text: commentText)
                        commentText = ""
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(TikTokTheme.red)
                    }
                    .transition(.scale)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(white: 0.1))
        }
        .background(TikTokTheme.darkBg.ignoresSafeArea())
    }
}
