import Foundation

struct CommentItem: Identifiable, Equatable {
    let id: String
    let authorName: String
    let authorHandle: String
    let authorAvatarUrl: String
    let text: String
    let timeAgo: String
    var likeCount: Int
    var isLiked: Bool
    let isCreator: Bool
}

extension CommentItem {
    static let sampleComments: [CommentItem] = [
        CommentItem(
            id: "c1",
            authorName: "Sofia Martinez",
            authorHandle: "@sofiamartinez",
            authorAvatarUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200",
            text: "¡Esto quedó increíble! El diseño es idéntico al TikTok oficial 😱🔥",
            timeAgo: "2h",
            likeCount: 4320,
            isLiked: true,
            isCreator: false
        ),
        CommentItem(
            id: "c2",
            authorName: "Puro Rodriguez",
            authorHandle: "@purorodriguez",
            authorAvatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200",
            text: "Gracias a todos por el apoyo! Compilado directo en iOS con GitHub Actions 🚀",
            timeAgo: "1h",
            likeCount: 8900,
            isLiked: false,
            isCreator: true
        ),
        CommentItem(
            id: "c3",
            authorName: "Lucas Dev",
            authorHandle: "@lucasios",
            authorAvatarUrl: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200",
            text: "La fluidez de las animaciones y el menú de TikTok Shop están brutales 👏",
            timeAgo: "45m",
            likeCount: 1205,
            isLiked: false,
            isCreator: false
        ),
        CommentItem(
            id: "c4",
            authorName: "Mariana Gómez",
            authorHandle: "@marianag",
            authorAvatarUrl: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=200",
            text: "¿Ya funciona el carrito de compras y el cambio de idioma? Quedó perfecto!",
            timeAgo: "15m",
            likeCount: 340,
            isLiked: false,
            isCreator: false
        )
    ]
}
