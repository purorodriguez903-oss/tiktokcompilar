import SwiftUI
import Combine

enum AppLanguage: String, CaseIterable, Identifiable {
    case spanish = "es"
    case english = "en"
    case french = "fr"
    case portuguese = "pt"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .spanish: return "Español"
        case .english: return "English"
        case .french: return "Français"
        case .portuguese: return "Português"
        }
    }
    
    var flag: String {
        switch self {
        case .spanish: return "🇪🇸"
        case .english: return "🇺🇸"
        case .french: return "🇫🇷"
        case .portuguese: return "🇧🇷"
        }
    }
}

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @Published var currentLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: "selected_app_language")
        }
    }
    
    private init() {
        if let saved = UserDefaults.standard.string(forKey: "selected_app_language"),
           let lang = AppLanguage(rawValue: saved) {
            self.currentLanguage = lang
        } else {
            self.currentLanguage = .spanish
        }
    }
    
    func t(_ key: String) -> String {
        guard let langDict = translations[currentLanguage],
              let text = langDict[key] else {
            return translations[.spanish]?[key] ?? key
        }
        return text
    }
    
    private let translations: [AppLanguage: [String: String]] = [
        .spanish: [
            // Tabs
            "tab_home": "Inicio",
            "tab_friends": "Amigos",
            "tab_inbox": "Bandeja de entrada",
            "tab_profile": "Perfil",
            "tab_shop": "Tienda",
            
            // Feed
            "feed_following": "Siguiendo",
            "feed_foryou": "Para ti",
            "feed_live": "LIVE",
            "feed_search": "Buscar",
            "feed_comments": "comentarios",
            "feed_add_comment": "Añadir comentario...",
            "feed_share_to": "Compartir con",
            "feed_copy_link": "Copiar enlace",
            "feed_save_video": "Guardar vídeo",
            "feed_duet": "Dúo",
            "feed_stitch": "Pegar",
            "feed_not_interested": "No me interesa",
            "feed_report": "Denunciar",
            
            // Shop
            "shop_title": "TikTok Shop",
            "shop_search_placeholder": "Buscar productos, marcas y tiendas",
            "shop_flash_sale": "⚡ Ofertas Relámpago",
            "shop_ends_in": "Termina en",
            "shop_free_shipping": "Envío gratis",
            "shop_sold": "vendidos",
            "shop_categories": "Categorías",
            "shop_cat_all": "Para ti",
            "shop_cat_fashion": "Moda",
            "shop_cat_beauty": "Belleza",
            "shop_cat_tech": "Electrónica",
            "shop_cat_home": "Hogar",
            "shop_cat_shoes": "Calzado",
            "shop_live_shopping": "🔴 Directos de Compra",
            "shop_add_to_cart": "Añadir a la cesta",
            "shop_buy_now": "Comprar ahora",
            "shop_cart": "Cesta",
            "shop_cart_empty": "Tu cesta está vacía",
            "shop_checkout": "Tramitar pedido",
            "shop_total": "Total",
            "shop_reviews": "reseñas",
            "shop_orders": "Mis pedidos",
            "shop_coupons": "Cupones del 50%",
            
            // Friends
            "friends_title": "Amigos",
            "friends_connect": "Conecta con amigos",
            "friends_sync": "Sincronizar contactos",
            "friends_follow": "Seguir",
            "friends_suggested": "Cuentas sugeridas",
            
            // Inbox
            "inbox_title": "Bandeja de entrada",
            "inbox_activities": "Actividades",
            "inbox_messages": "Mensajes",
            "inbox_new_followers": "Nuevos seguidores",
            "inbox_likes": "Me gusta y comentarios",
            "inbox_system": "TikTok Notificaciones",
            "inbox_shop_updates": "Actualizaciones de pedidos",
            "inbox_type_message": "Escribe un mensaje...",
            
            // Profile
            "profile_following": "Siguiendo",
            "profile_followers": "Seguidores",
            "profile_likes": "Me gusta",
            "profile_edit": "Editar perfil",
            "profile_share": "Compartir perfil",
            "profile_add_bio": "Toca para añadir una descripción",
            "profile_tab_videos": "Vídeos",
            "profile_tab_private": "Privados",
            "profile_tab_saved": "Favoritos",
            "profile_tab_liked": "Me gusta",
            
            // Settings
            "settings_title": "Ajustes y privacidad",
            "settings_account": "Cuenta",
            "settings_manage_acc": "Administrar cuenta",
            "settings_privacy": "Privacidad",
            "settings_security": "Seguridad y permisos",
            "settings_content": "Contenido y pantalla",
            "settings_language": "Idioma de la aplicación",
            "settings_dark_mode": "Modo oscuro",
            "settings_cache": "Liberar espacio",
            "settings_cache_cleared": "¡Espacio en caché liberado!",
            "settings_shop_orders": "Pedidos de TikTok Shop",
            "settings_support": "Soporte",
            "settings_report_problem": "Informar de un problema",
            "settings_help_center": "Centro de ayuda",
            "settings_logout": "Cerrar sesión",
            "settings_version": "TikTok v34.2.0 (Build 2026)"
        ],
        .english: [
            // Tabs
            "tab_home": "Home",
            "tab_friends": "Friends",
            "tab_inbox": "Inbox",
            "tab_profile": "Profile",
            "tab_shop": "Shop",
            
            // Feed
            "feed_following": "Following",
            "feed_foryou": "For You",
            "feed_live": "LIVE",
            "feed_search": "Search",
            "feed_comments": "comments",
            "feed_add_comment": "Add comment...",
            "feed_share_to": "Share to",
            "feed_copy_link": "Copy link",
            "feed_save_video": "Save video",
            "feed_duet": "Duet",
            "feed_stitch": "Stitch",
            "feed_not_interested": "Not interested",
            "feed_report": "Report",
            
            // Shop
            "shop_title": "TikTok Shop",
            "shop_search_placeholder": "Search products, brands & shops",
            "shop_flash_sale": "⚡ Flash Deals",
            "shop_ends_in": "Ends in",
            "shop_free_shipping": "Free Shipping",
            "shop_sold": "sold",
            "shop_categories": "Categories",
            "shop_cat_all": "For You",
            "shop_cat_fashion": "Fashion",
            "shop_cat_beauty": "Beauty",
            "shop_cat_tech": "Electronics",
            "shop_cat_home": "Home",
            "shop_cat_shoes": "Shoes",
            "shop_live_shopping": "🔴 Live Shopping",
            "shop_add_to_cart": "Add to Cart",
            "shop_buy_now": "Buy Now",
            "shop_cart": "Cart",
            "shop_cart_empty": "Your cart is empty",
            "shop_checkout": "Checkout",
            "shop_total": "Total",
            "shop_reviews": "reviews",
            "shop_orders": "My Orders",
            "shop_coupons": "50% OFF Coupons",
            
            // Friends
            "friends_title": "Friends",
            "friends_connect": "Connect with friends",
            "friends_sync": "Sync Contacts",
            "friends_follow": "Follow",
            "friends_suggested": "Suggested accounts",
            
            // Inbox
            "inbox_title": "Inbox",
            "inbox_activities": "Activities",
            "inbox_messages": "Messages",
            "inbox_new_followers": "New followers",
            "inbox_likes": "Likes & comments",
            "inbox_system": "TikTok Notifications",
            "inbox_shop_updates": "Order updates",
            "inbox_type_message": "Send a message...",
            
            // Profile
            "profile_following": "Following",
            "profile_followers": "Followers",
            "profile_likes": "Likes",
            "profile_edit": "Edit profile",
            "profile_share": "Share profile",
            "profile_add_bio": "Tap to add bio",
            "profile_tab_videos": "Videos",
            "profile_tab_private": "Private",
            "profile_tab_saved": "Favorites",
            "profile_tab_liked": "Liked",
            
            // Settings
            "settings_title": "Settings and Privacy",
            "settings_account": "Account",
            "settings_manage_acc": "Manage account",
            "settings_privacy": "Privacy",
            "settings_security": "Security & permissions",
            "settings_content": "Content & Display",
            "settings_language": "App Language",
            "settings_dark_mode": "Dark Mode",
            "settings_cache": "Free up space",
            "settings_cache_cleared": "Cache cleared successfully!",
            "settings_shop_orders": "TikTok Shop Orders",
            "settings_support": "Support",
            "settings_report_problem": "Report a problem",
            "settings_help_center": "Help Center",
            "settings_logout": "Log Out",
            "settings_version": "TikTok v34.2.0 (Build 2026)"
        ],
        .french: [
            "tab_home": "Accueil",
            "tab_friends": "Amis",
            "tab_inbox": "Boîte de réception",
            "tab_profile": "Profil",
            "tab_shop": "Boutique",
            "feed_following": "Abonnements",
            "feed_foryou": "Pour toi",
            "feed_live": "LIVE",
            "feed_search": "Rechercher",
            "feed_comments": "commentaires",
            "feed_add_comment": "Ajouter un commentaire...",
            "feed_share_to": "Partager avec",
            "feed_copy_link": "Copier le lien",
            "feed_save_video": "Enregistrer la vidéo",
            "shop_title": "TikTok Shop",
            "shop_flash_sale": "⚡ Ventes Flash",
            "shop_free_shipping": "Livraison gratuite",
            "shop_add_to_cart": "Ajouter au panier",
            "shop_buy_now": "Acheter maintenant",
            "shop_cart": "Panier",
            "profile_following": "Abonnements",
            "profile_followers": "Abonnés",
            "profile_likes": "J'aime",
            "profile_edit": "Modifier le profil",
            "settings_title": "Paramètres et confidentialité",
            "settings_language": "Langue de l'application",
            "settings_cache": "Libérer de l'espace",
            "settings_logout": "Déconnexion"
        ],
        .portuguese: [
            "tab_home": "Início",
            "tab_friends": "Amigos",
            "tab_inbox": "Caixa de entrada",
            "tab_profile": "Perfil",
            "tab_shop": "Loja",
            "feed_following": "Seguindo",
            "feed_foryou": "Para Você",
            "feed_live": "AO VIVO",
            "feed_search": "Pesquisar",
            "feed_comments": "comentários",
            "feed_add_comment": "Adicionar comentário...",
            "feed_share_to": "Compartilhar com",
            "feed_copy_link": "Copiar link",
            "feed_save_video": "Salvar vídeo",
            "shop_title": "TikTok Shop",
            "shop_flash_sale": "⚡ Ofertas Relâmpago",
            "shop_free_shipping": "Frete grátis",
            "shop_add_to_cart": "Adicionar ao carrinho",
            "shop_buy_now": "Comprar agora",
            "shop_cart": "Carrinho",
            "profile_following": "Seguindo",
            "profile_followers": "Seguidores",
            "profile_likes": "Curtidas",
            "profile_edit": "Editar perfil",
            "settings_title": "Configurações e privacidade",
            "settings_language": "Idioma do aplicativo",
            "settings_cache": "Liberar espaço",
            "settings_logout": "Sair"
        ]
    ]
}
