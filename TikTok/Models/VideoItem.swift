import Foundation
import SwiftUI

enum PostMediaType {
    case video
    case photoCarousel([String])
}

struct VideoItem: Identifiable, Equatable {
    let id: String
    let authorName: String
    let authorHandle: String
    let authorAvatarUrl: String
    let isVerified: Bool
    let mediaType: PostMediaType
    let videoUrl: String
    let description: String
    let tags: [String]
    let soundTitle: String
    let soundAuthor: String
    var likeCount: Int
    var commentCount: Int
    var bookmarkCount: Int
    var shareCount: Int
    var isLiked: Bool
    var isBookmarked: Bool
    var isFollowing: Bool
    let searchQuery: String?
    let bgGradient: [Color]
    
    static func == (lhs: VideoItem, rhs: VideoItem) -> Bool {
        lhs.id == rhs.id && lhs.isLiked == rhs.isLiked && lhs.isBookmarked == rhs.isBookmarked && lhs.isFollowing == rhs.isFollowing
    }
}

extension VideoItem {
    static let sampleFeed: [VideoItem] = [
        VideoItem(
            id: "vid_rigo",
            authorName: "Rigo off ⚡",
            authorHandle: "Rigo off",
            authorAvatarUrl: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200",
            isVerified: false,
            mediaType: .photoCarousel([
                "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800",
                "https://images.unsplash.com/photo-1511512578047-dfb367046420?w=800"
            ]),
            videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
            description: "Ya no sé nada de ellos 🥺🥹💔 #viralvideo #oldfriends #ffveterano",
            tags: ["#viralvideo", "#oldfriends", "#ffveterano"],
            soundTitle: "original sound - starsov...",
            soundAuthor: "starsov",
            likeCount: 4835,
            commentCount: 140,
            bookmarkCount: 411,
            shareCount: 299,
            isLiked: false,
            isBookmarked: false,
            isFollowing: false,
            searchQuery: "brincos dieras dallas",
            bgGradient: [Color(red: 0.1, green: 0.12, blue: 0.2), Color(red: 0.05, green: 0.05, blue: 0.1)]
        ),
        VideoItem(
            id: "vid_laura",
            authorName: "Laura 🍒❤️",
            authorHandle: "Laura 🍒❤️",
            authorAvatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200",
            isVerified: false,
            mediaType: .video,
            videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
            description: "Jajaja @Brincos Dieras 🤤 #brincosdieras #dallas",
            tags: ["#brincosdieras", "#dallas"],
            soundTitle: "Brincos Dieras en vivo • Show 2026",
            soundAuthor: "Brincos Dieras",
            likeCount: 1185,
            commentCount: 21,
            bookmarkCount: 105,
            shareCount: 196,
            isLiked: true,
            isBookmarked: false,
            isFollowing: false,
            searchQuery: "brincos dieras dallas",
            bgGradient: [Color(red: 0.15, green: 0.05, blue: 0.2), Color(red: 0.05, green: 0.02, blue: 0.08)]
        ),
        VideoItem(
            id: "vid_ellyanna",
            authorName: "Ellyanna 🎀",
            authorHandle: "Ellyanna 🎀",
            authorAvatarUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200",
            isVerified: false,
            mediaType: .photoCarousel([
                "https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=800",
                "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=800"
            ]),
            videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
            description: "#fyp",
            tags: ["#fyp"],
            soundTitle: "Contains: God's Plan - Drake",
            soundAuthor: "Drake",
            likeCount: 80,
            commentCount: 5,
            bookmarkCount: 3,
            shareCount: 12,
            isLiked: false,
            isBookmarked: false,
            isFollowing: false,
            searchQuery: "gods plan lyrics",
            bgGradient: [Color(white: 0.18), Color(white: 0.08)]
        ),
        VideoItem(
            id: "vid_alexrod",
            authorName: "atx_alexrod1",
            authorHandle: "atx_alexrod1",
            authorAvatarUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200",
            isVerified: false,
            mediaType: .video,
            videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
            description: "Aunque no soy de feria! 🔥 #austin #tiktok",
            tags: ["#austin", "#tiktok"],
            soundTitle: "original sound - atx_alexrod1",
            soundAuthor: "atx_alexrod1",
            likeCount: 151100,
            commentCount: 890,
            bookmarkCount: 2300,
            shareCount: 1450,
            isLiked: true,
            isBookmarked: true,
            isFollowing: true,
            searchQuery: nil,
            bgGradient: [Color(red: 0.2, green: 0.1, blue: 0.15), Color(red: 0.08, green: 0.04, blue: 0.06)]
        )
    ]
}
