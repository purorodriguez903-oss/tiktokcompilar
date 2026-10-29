import SwiftUI

struct FeedOverlayView: View {
    let video: VideoItem
    @ObservedObject var viewModel: FeedViewModel
    @ObservedObject var languageManager = LanguageManager.shared
    @State private var heartBounce: Bool = false
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            // Left Column: User info, caption, tags, sound
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                
                // Username & Verified Badge
                HStack(spacing: 6) {
                    Text(video.authorHandle)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    
                    if video.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 14))
                            .foregroundColor(TikTokTheme.cyan)
                    }
                }
                
                // Caption / Description
                Text(video.description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
                
                // Hashtags
                HStack(spacing: 6) {
                    ForEach(video.tags.prefix(4), id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                // TikTok Shop Pill (if relevant or for shop videos)
                if video.id == "vid_03" {
                    HStack(spacing: 6) {
                        Image(systemName: "bag.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                        Text("TikTok Shop • 50% DTO.")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.black)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(TikTokTheme.yellow)
                    .cornerRadius(6)
                }
                
                // Sound Marquee
                MarqueeText(text: video.soundTitle)
                    .frame(maxWidth: 220)
                    .padding(.bottom, 24)
            }
            .padding(.leading, 14)
            
            Spacer()
            
            // Right Column: Vertical Action Buttons
            VStack(spacing: 18) {
                Spacer()
                
                // Profile Avatar + Follow '+' Button
                ZStack(alignment: .bottom) {
                    AsyncImage(url: URL(string: video.authorAvatarUrl)) { phase in
                        if let img = phase.image {
                            img.resizable().scaledToFill()
                        } else {
                            Circle().fill(Color.gray)
                        }
                    }
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 1.5)
                    )
                    
                    if !video.isFollowing {
                        Button(action: {
                            viewModel.toggleFollow(for: video.id)
                        }) {
                            ZStack {
                                Circle()
                                    .fill(TikTokTheme.red)
                                    .frame(width: 22, height: 22)
                                Image(systemName: "plus")
                                    .font(.system(size: 11, weight: .black))
                                    .foregroundColor(.white)
                            }
                        }
                        .offset(y: 10)
                        .transition(.scale)
                    }
                }
                .padding(.bottom, 8)
                
                // Like Button
                Button(action: {
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                        heartBounce = true
                    }
                    viewModel.toggleLike(for: video.id)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        heartBounce = false
                    }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 32))
                            .foregroundColor(video.isLiked ? TikTokTheme.red : .white)
                            .scaleEffect(heartBounce ? 1.3 : 1.0)
                            .shadow(color: Color.black.opacity(0.3), radius: 3)
                        
                        Text(TikTokTheme.formatCount(video.likeCount))
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                
                // Comments Button
                Button(action: {
                    TikTokTheme.haptic(.light)
                    viewModel.selectedVideoForComments = video
                    viewModel.showCommentsSheet = true
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "ellipsis.bubble.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 3)
                        
                        Text(TikTokTheme.formatCount(video.commentCount))
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                
                // Bookmark / Favorite Button
                Button(action: {
                    viewModel.toggleBookmark(for: video.id)
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "bookmark.fill")
                            .font(.system(size: 30))
                            .foregroundColor(video.isBookmarked ? TikTokTheme.yellow : .white)
                            .shadow(color: Color.black.opacity(0.3), radius: 3)
                        
                        Text(TikTokTheme.formatCount(video.bookmarkCount))
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                
                // Share Button
                Button(action: {
                    TikTokTheme.haptic(.light)
                    viewModel.selectedVideoForShare = video
                    viewModel.showShareSheet = true
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "arrowshape.turn.up.right.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 3)
                        
                        Text(TikTokTheme.formatCount(video.shareCount))
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                
                // Rotating Disc with floating notes
                RotatingDiscView(avatarUrl: video.authorAvatarUrl)
                    .padding(.bottom, 24)
            }
            .padding(.trailing, 10)
        }
    }
}
