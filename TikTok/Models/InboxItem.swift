import Foundation

enum InboxNotificationType {
    case follower
    case like
    case comment
    case system
    case shop
    case directMessage
}

struct InboxItem: Identifiable, Equatable {
    let id: String
    let type: InboxNotificationType
    let senderName: String
    let senderHandle: String
    let avatarUrl: String
    let message: String
    let timeAgo: String
    var isUnread: Bool
    let actionText: String?
}

extension InboxItem {
    static let sampleInbox: [InboxItem] = [
        InboxItem(
            id: "inbox_01",
            type: .shop,
            senderName: "TikTok Shop",
            senderHandle: "@tiktokshop",
            avatarUrl: "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=200",
            message: "¡Tu cupón de 50% de descuento en electrónica expira hoy! Aprovecha el envío gratis.",
            timeAgo: "10m",
            isUnread: true,
            actionText: "Ver ofertas"
        ),
        InboxItem(
            id: "inbox_02",
            type: .follower,
            senderName: "Camila Fernandez",
            senderHandle: "@camila_f",
            avatarUrl: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200",
            message: "empezó a seguirte.",
            timeAgo: "25m",
            isUnread: true,
            actionText: "Seguir también"
        ),
        InboxItem(
            id: "inbox_03",
            type: .like,
            senderName: "Alex Rivera",
            senderHandle: "@alexrivera",
            avatarUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200",
            message: "le ha gustado tu vídeo de TikTok Clone.",
            timeAgo: "1h",
            isUnread: false,
            actionText: nil
        ),
        InboxItem(
            id: "inbox_04",
            type: .system,
            senderName: "TikTok Oficial",
            senderHandle: "@tiktok",
            avatarUrl: "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=200",
            message: "Tu cuenta ha sido verificada con la insignia azul. ¡Bienvenido a la comunidad de creadores!",
            timeAgo: "3h",
            isUnread: false,
            actionText: "Ver perfil"
        ),
        InboxItem(
            id: "inbox_05",
            type: .directMessage,
            senderName: "Elena Dance",
            senderHandle: "@elenadance",
            avatarUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200",
            message: "Hola! ¿Hacemos un dúo con el nuevo trend viral hoy en la tarde?",
            timeAgo: "4h",
            isUnread: true,
            actionText: "Responder"
        )
    ]
}

