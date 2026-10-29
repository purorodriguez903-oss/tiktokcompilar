import SwiftUI
import Combine

class FeedViewModel: ObservableObject {
    @Published var feedType: FeedType = .forYou
    @Published var forYouVideos: [VideoItem] = VideoItem.sampleFeed
    @Published var followingVideos: [VideoItem] = Array(VideoItem.sampleFeed.reversed())
    @Published var currentVideoIndex: Int = 0
    @Published var selectedVideoForComments: VideoItem? = nil
    @Published var selectedVideoForShare: VideoItem? = nil
    @Published var showCommentsSheet: Bool = false
    @Published var showShareSheet: Bool = false
    
    // Comments storage per video
    @Published var comments: [String: [CommentItem]] = [:]
    
    enum FeedType {
        case following
        case forYou
    }
    
    var currentVideos: [VideoItem] {
        get {
            switch feedType {
            case .forYou: return forYouVideos
            case .following: return followingVideos
            }
        }
        set {
            switch feedType {
            case .forYou: forYouVideos = newValue
            case .following: followingVideos = newValue
            }
        }
    }
    
    init() {
        // Initialize default comments for each video
        for video in VideoItem.sampleFeed {
            comments[video.id] = CommentItem.sampleComments
        }
    }
    
    func toggleLike(for videoId: String) {
        TikTokTheme.haptic(.medium)
        if feedType == .forYou {
            if let idx = forYouVideos.firstIndex(where: { $0.id == videoId }) {
                forYouVideos[idx].isLiked.toggle()
                forYouVideos[idx].likeCount += forYouVideos[idx].isLiked ? 1 : -1
            }
        } else {
            if let idx = followingVideos.firstIndex(where: { $0.id == videoId }) {
                followingVideos[idx].isLiked.toggle()
                followingVideos[idx].likeCount += followingVideos[idx].isLiked ? 1 : -1
            }
        }
    }
    
    func toggleBookmark(for videoId: String) {
        TikTokTheme.haptic(.light)
        if feedType == .forYou {
            if let idx = forYouVideos.firstIndex(where: { $0.id == videoId }) {
                forYouVideos[idx].isBookmarked.toggle()
                forYouVideos[idx].bookmarkCount += forYouVideos[idx].isBookmarked ? 1 : -1
            }
        } else {
            if let idx = followingVideos.firstIndex(where: { $0.id == videoId }) {
                followingVideos[idx].isBookmarked.toggle()
                followingVideos[idx].bookmarkCount += followingVideos[idx].isBookmarked ? 1 : -1
            }
        }
    }
    
    func toggleFollow(for videoId: String) {
        TikTokTheme.hapticNotification(.success)
        if feedType == .forYou {
            if let idx = forYouVideos.firstIndex(where: { $0.id == videoId }) {
                forYouVideos[idx].isFollowing.toggle()
            }
        } else {
            if let idx = followingVideos.firstIndex(where: { $0.id == videoId }) {
                followingVideos[idx].isFollowing.toggle()
            }
        }
    }
    
    func addComment(videoId: String, text: String) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        TikTokTheme.haptic(.medium)
        
        let newComment = CommentItem(
            id: UUID().uuidString,
            authorName: "Puro Rodriguez",
            authorHandle: "@purorodriguez",
            authorAvatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200",
            text: text,
            timeAgo: "Ahora",
            likeCount: 0,
            isLiked: false,
            isCreator: true
        )
        
        var list = comments[videoId] ?? []
        list.insert(newComment, at: 0)
        comments[videoId] = list
        
        // Update video comment count
        if let idx = forYouVideos.firstIndex(where: { $0.id == videoId }) {
            forYouVideos[idx].commentCount += 1
        }
        if let idx = followingVideos.firstIndex(where: { $0.id == videoId }) {
            followingVideos[idx].commentCount += 1
        }
    }
    
    func toggleCommentLike(videoId: String, commentId: String) {
        TikTokTheme.haptic(.light)
        guard var list = comments[videoId],
              let idx = list.firstIndex(where: { $0.id == commentId }) else { return }
        list[idx].isLiked.toggle()
        list[idx].likeCount += list[idx].isLiked ? 1 : -1
        comments[videoId] = list
    }
}
