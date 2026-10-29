import SwiftUI

struct FeedOverlayView: View {
    let video: VideoItem
    @ObservedObject var viewModel: FeedViewModel
    @State private var heartBounce: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack(alignment: .bottom, spacing: 0) {
                // Left Column: User info, caption, audio
                VStack(alignment: .leading, spacing: 8) {
                    // Author & Photo Badge (Frame 002)
                    HStack(spacing: 6) {
                        Text(video.authorName)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                        
                        if case .photoCarousel = video.mediaType {
                            HStack(spacing: 3) {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 9))
                                Text("Photo")
                                    .font(.system(size: 10, weight: .bold))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.white.opacity(0.25))
                            .cornerRadius(4)
                        }
                    }
                    
                    // Caption
                    Text(video.description)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    
                    // See translation
                    Button(action: {}) {
                        Text("See translation")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color(white: 0.75))
                    }
                    
                    // Sound Title Ticker
                    HStack(spacing: 6) {
                        Image(systemName: "music.note")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(video.soundTitle)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.white)
                            .lineLimit(1)
                    }
                    
                    // Like Popover Bubble "76 ❤️ 2" (Frame 002)
                    HStack(spacing: 6) {
                        Text("76")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                        Image(systemName: "heart.fill")
                            .font(.system(size: 11))
                            .foregroundColor(.white)
                        Text("2")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(TikTokTheme.red)
                    .cornerRadius(12)
                    .padding(.top, 2)
                }
                .padding(.leading, 14)
                
                Spacer()
                
                // Right Column: Vertical Action Buttons
                VStack(spacing: 16) {
                    // Profile Avatar + Follow '+'
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
                        .overlay(Circle().stroke(Color.white, lineWidth: 1.5))
                        
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
                        }
                    }
                    .padding(.bottom, 6)
                    
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
                        VStack(spacing: 3) {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 32))
                                .foregroundColor(video.isLiked ? TikTokTheme.red : .white)
                                .scaleEffect(heartBounce ? 1.3 : 1.0)
                            Text(TikTokTheme.formatCount(video.likeCount))
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                    
                    // Comment Button (Speech bubble with '...')
                    Button(action: {
                        TikTokTheme.haptic(.light)
                        viewModel.selectedVideoForComments = video
                        viewModel.showCommentsSheet = true
                    }) {
                        VStack(spacing: 3) {
                            ZStack {
                                Image(systemName: "bubble.right.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                HStack(spacing: 2) {
                                    Circle().fill(Color.black).frame(width: 3, height: 3)
                                    Circle().fill(Color.black).frame(width: 3, height: 3)
                                    Circle().fill(Color.black).frame(width: 3, height: 3)
                                }
                                .offset(x: -2)
                            }
                            Text(TikTokTheme.formatCount(video.commentCount))
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                    
                    // Bookmark / Favorite Button
                    Button(action: {
                        viewModel.toggleBookmark(for: video.id)
                    }) {
                        VStack(spacing: 3) {
                            Image(systemName: "bookmark.fill")
                                .font(.system(size: 30))
                                .foregroundColor(video.isBookmarked ? TikTokTheme.yellow : .white)
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
                        VStack(spacing: 3) {
                            Image(systemName: "arrowshape.turn.up.right.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                            Text(TikTokTheme.formatCount(video.shareCount))
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                    
                    // Rotating Vinyl Disc
                    RotatingDiscView(avatarUrl: video.authorAvatarUrl)
                }
                .padding(.trailing, 10)
            }
            .padding(.bottom, 10)
            
            // Search Suggestion Pill above tab bar (Frame 004)
            if let query = video.searchQuery {
                HStack(spacing: 6) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.gray)
                    Text("Search • \(query)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.black.opacity(0.55))
                .cornerRadius(6)
                .padding(.horizontal, 14)
                .padding(.bottom, 6)
            }
        }
    }
}
