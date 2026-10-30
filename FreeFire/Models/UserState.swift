import SwiftUI
import Combine

class UserState: ObservableObject {
    static let shared = UserState()
    
    // Player Profile (Exact match from user's video)
    @Published var playerName: String = "000ECRT"
    @Published var playerLevel: Int = 57
    @Published var rankScore: Int = 539 // Estrellas Heroico en DE-Clasificatoria
    @Published var rankName: String = "HEROICO"
    @Published var guildName: String = "0xModz"
    @Published var region: String = "NORTE AMÉRICA"
    @Published var loginState: String = "Google • Rafa"
    
    // Currencies (Exact match from user's video)
    @Published var gold: Int = 18060
    @Published var diamonds: Int = 94
    @Published var booyahPassLevel: Int = 20
    @Published var magicCubes: Int = 3
    @Published var evolutionStones: Int = 7
    @Published var tokensDonMuerte: Int = 3
    
    // Equipped Cosmetics (Exact match from user's video)
    @Published var equippedHead: String = "cyber_bone_head" // Máscara y cabello puntiagudo amarillo
    @Published var equippedTop: String = "cyber_bone_jacket" // Chaqueta cibernética hueso con costillas doradas
    @Published var equippedPants: String = "cyber_bone_pants" // Pantalón blindado negro y amarillo
    @Published var equippedShoes: String = "cyber_bone_shoes" // Tenis futuristas amarillos y blancos
    @Published var equippedBundle: String = "bundle_cyber_bone" // Conjunto Cazador de Huesos Booyah
    
    // Equipped Weapon & Pet (Exact match from user's video)
    @Published var equippedWeaponId: String = "w_katana" // Katana en mano
    @Published var equippedWeaponSkinId: String = "skin_katana_blood"
    @Published var equippedPetId: String = "pet_waggor" // Pingüino Sr. Waggor con chaqueta roja
    
    // Active Emote
    @Published var activeEmote: String = "Batalla de baile"
    
    // Equipped Emotes for 8-slot wheel (Exact match from video)
    @Published var wheelEmotes: [String] = [
        "Batalla de baile",
        "BOOYAH!",
        "Aplauso",
        "Pose de Alas",
        "Provocación",
        "Corazón",
        "Risa",
        "El Trono"
    ]
    
    // Settings (Exact match from video)
    @Published var crosshairType: String = "Clásico"
    @Published var damageIndicatorType: String = "Clásico"
    @Published var hitEffectType: String = "Oscuro"
    @Published var impactMarkersType: String = "Clásico"
    @Published var messageSuggestions: Bool = false
    @Published var teammateNickname: Bool = false
    @Published var enemyOutline: Bool = false
    
    // Inventory
    @Published var ownedCosmetics: Set<String> = [
        "bundle_cyber_bone", "cyber_bone_head", "cyber_bone_jacket", "cyber_bone_pants", "cyber_bone_shoes",
        "bundle_don_muerte", "don_muerte_mask", "don_muerte_jacket",
        "bundle_sakura", "bundle_hiphop", "bundle_criminal_red", "bundle_dino_green",
        "jacket_heroic_2019", "angelic_pants", "angelic_bandana", "jordan_retro"
    ]
    
    @Published var ownedPets: Set<String> = [
        "pet_waggor", "pet_shiba", "pet_kitty", "pet_mech_pup", "pet_night_panther"
    ]
    
    private init() {}
    
    func equipCosmetic(id: String, category: String) {
        switch category {
        case "bundle":
            equippedBundle = id
            if id == "bundle_cyber_bone" {
                equippedHead = "cyber_bone_head"
                equippedTop = "cyber_bone_jacket"
                equippedPants = "cyber_bone_pants"
                equippedShoes = "cyber_bone_shoes"
            }
        case "head":
            equippedHead = id
            equippedBundle = ""
        case "top":
            equippedTop = id
            equippedBundle = ""
        case "pants":
            equippedPants = id
            equippedBundle = ""
        case "shoes":
            equippedShoes = id
        default:
            break
        }
        SoundManager.shared.playButtonClick()
    }
}
