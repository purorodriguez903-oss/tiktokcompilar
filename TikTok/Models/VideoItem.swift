import Foundation
import SwiftUI

struct VideoItem: Identifiable, Equatable {
    let id: String
    let authorName: String
    let authorHandle: String
    let authorAvatarUrl: String
    let isVerified: Bool
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
    let bgGradient: [Color]
    
    static func == (lhs: VideoItem, rhs: VideoItem) -> Bool {
        lhs.id == rhs.id && lhs.isLiked == rhs.isLiked && lhs.isBookmarked == rhs.isBookmarked && lhs.isFollowing == rhs.isFollowing
    }
}

extension VideoItem {
    static let sampleFeed: [VideoItem] = [
        VideoItem(
            id: "vid_01",
            authorName: "Puro Rodriguez",
            authorHandle: "@purorodriguez",
            authorAvatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300",
            isVerified: true,
            videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
            description: "¡Probando el nuevo TikTok clon para iOS compilado directo desde GitHub Actions! 🚀🔥 ¿Qué opinan del diseño?",
            tags: ["#fyp", "#parati", "#tiktok", "#ios", "#developer", "#viral"],
            soundTitle: "Puro Rodriguez • Sonido Original - Hit 2026",
            soundAuthor: "Puro Rodriguez",
            likeCount: 842100,
            commentCount: 14200,
            bookmarkCount: 45600,
            shareCount: 19800,
            isLiked: false,
            isBookmarked: false,
            isFollowing: false,
            bgGradient: [Color(red: 0.1, green: 0.2, blue: 0.4), Color(red: 0.05, green: 0.05, blue: 0.1)]
        ),
        VideoItem(
            id: "vid_02",
            authorName: "Elena Dance",
            authorHandle: "@elenadance",
            authorAvatarUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300",
            isVerified: true,
            videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
            description: "Nuevo trend viral de la semana! 💃✨ Intenten seguir la coreografía en los comentarios #dancechallenge",
            tags: ["#dance", "#trend", "#viral", "#foryou", "#parati"],
            soundTitle: "Elena Dance • Trending Beat Latin Remix",
            soundAuthor: "Elena Dance",
            likeCount: 1420000,
            commentCount: 38900,
            bookmarkCount: 92400,
            shareCount: 48200,
            isLiked: true,
            isBookmarked: false,
            isFollowing: true,
            bgGradient: [Color(red: 0.4, green: 0.1, blue: 0.3), Color(red: 0.1, green: 0.05, blue: 0.15)]
        ),
        VideoItem(
            id: "vid_03",
            authorName: "TikTok Shop Oficial",
            authorHandle: "@tiktokshop_es",
            authorAvatarUrl: "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=300",
            isVerified: true,
            videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
            description: "¡Los mejores gadgets virales que puedes conseguir hoy en TikTok Shop con 50% de descuento y envío gratis! 🛍️📦 Toca la cesta amarilla abajo.",
            tags: ["#tiktokshop", "#ofertas", "#haul", "#gadgets", "#descuentos"],
            soundTitle: "TikTok Shop Deals • Audio Promocional",
            soundAuthor: "TikTok Shop",
            likeCount: 523000,
            commentCount: 9840,
            bookmarkCount: 88100,
            shareCount: 31200,
            isLiked: false,
            isBookmarked: true,
            isFollowing: false,
            bgGradient: [Color(red: 0.15, green: 0.3, blue: 0.25), Color(red: 0.05, green: 0.1, blue: 0.1)]
        ),
        VideoItem(
            id: "vid_04",
            authorName: "Chef Carlos Cocina",
            authorHandle: "@carloscooking",
            authorAvatarUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300",
            isVerified: false,
            videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
            description: "Receta rápida de pasta en 10 minutos que se hizo viral en Italia 🍝 ¿La probarías?",
            tags: ["#receta", "#comida", "#foodie", "#viral", "#chef"],
            soundTitle: "Sonido de Cocina Relajante • ASMR",
            soundAuthor: "Carlos Cooking",
            likeCount: 312500,
            commentCount: 4210,
            bookmarkCount: 65400,
            shareCount: 15300,
            isLiked: false,
            isBookmarked: false,
            isFollowing: false,
            bgGradient: [Color(red: 0.35, green: 0.2, blue: 0.1), Color(red: 0.1, green: 0.08, blue: 0.05)]
        )
    ]
}
