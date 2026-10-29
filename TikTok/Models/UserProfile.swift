import Foundation

struct UserVideoThumbnail: Identifiable, Equatable {
    let id: String
    let viewCount: String
    let isPinned: Bool
    let coverColorHex: String
    let caption: String
}

struct UserProfile: Equatable {
    var name: String
    var handle: String
    var avatarUrl: String
    var bio: String
    var followingCount: Int
    var followersCount: Int
    var likesCount: Int
    var isVerified: Bool
    var instagramHandle: String
    var youtubeHandle: String
    var showcaseUrl: String
    var videos: [UserVideoThumbnail]
    var likedVideos: [UserVideoThumbnail]
    var savedVideos: [UserVideoThumbnail]
    var privateVideos: [UserVideoThumbnail]
}

extension UserProfile {
    static let currentUser = UserProfile(
        name: "Puro Rodriguez",
        handle: "@purorodriguez",
        avatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400",
        bio: "⚡ Creador de contenido | Swift & iOS Developer\n📱 TikTok Clone para iOS compilado en GitHub Actions\n📍 Madrid / Los Angeles\n✨ Sigue mis proyectos en GitHub",
        followingCount: 148,
        followersCount: 128500,
        likesCount: 2450000,
        isVerified: true,
        instagramHandle: "purorodriguez_dev",
        youtubeHandle: "Puro Rodriguez Tech",
        showcaseUrl: "github.com/purorodriguez903-oss",
        videos: [
            UserVideoThumbnail(id: "pv1", viewCount: "1.2M", isPinned: true, coverColorHex: "#3A1C71", caption: "Presentando TikTok iOS Clon"),
            UserVideoThumbnail(id: "pv2", viewCount: "840K", isPinned: true, coverColorHex: "#D76D77", caption: "Cómo compilar IPAs con GitHub"),
            UserVideoThumbnail(id: "pv3", viewCount: "520K", isPinned: true, coverColorHex: "#FFAF7B", caption: "Tutorial de Swift y SwiftUI"),
            UserVideoThumbnail(id: "pv4", viewCount: "290K", isPinned: false, coverColorHex: "#11998E", caption: "Probando TikTok Shop"),
            UserVideoThumbnail(id: "pv5", viewCount: "185K", isPinned: false, coverColorHex: "#38EF7D", caption: "Setup de desarrollo 2026"),
            UserVideoThumbnail(id: "pv6", viewCount: "94K", isPinned: false, coverColorHex: "#EA384D", caption: "Un día en la vida de un dev")
        ],
        likedVideos: [
            UserVideoThumbnail(id: "lv1", viewCount: "3.4M", isPinned: false, coverColorHex: "#2C3E50", caption: "Dance trend"),
            UserVideoThumbnail(id: "lv2", viewCount: "950K", isPinned: false, coverColorHex: "#4CA1AF", caption: "Cooking ASMR"),
            UserVideoThumbnail(id: "lv3", viewCount: "1.1M", isPinned: false, coverColorHex: "#C33764", caption: "Travel vlog")
        ],
        savedVideos: [
            UserVideoThumbnail(id: "sv1", viewCount: "2.1M", isPinned: false, coverColorHex: "#1D2671", caption: "Coding tricks"),
            UserVideoThumbnail(id: "sv2", viewCount: "670K", isPinned: false, coverColorHex: "#C33764", caption: "Gadgets viral")
        ],
        privateVideos: [
            UserVideoThumbnail(id: "pr1", viewCount: "0", isPinned: false, coverColorHex: "#232526", caption: "Borrador de prueba")
        ]
    )
}
