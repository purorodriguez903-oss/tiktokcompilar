import SwiftUI
import Combine

class UserState: ObservableObject {
    static let shared = UserState()
    
    // Player Profile (Authentic 2019 Veteran)
    @Published var playerName: String = "VETERANO_2019"
    @Published var playerLevel: Int = 55
    @Published var rankScore: Int = 3250 // Heroico threshold in 2019
    @Published var rankName: String = "HEROICO"
    @Published var guildName: String = "LOS_VETERANOS"
    
    // Currencies
    @Published var gold: Int = 84520
    @Published var diamonds: Int = 2450
    @Published var magicCubes: Int = 2
    @Published var evolutionStones: Int = 5
    @Published var blueprints: Int = 3
    
    // Equipped Cosmetics
    @Published var equippedHead: String = "sakura_mask" // Máscara Oni Sakura
    @Published var equippedTop: String = "sakura_top"   // Chaqueta Kimono Sakura
    @Published var equippedPants: String = "sakura_pants" // Pantalón Sakura
    @Published var equippedShoes: String = "jordan_retro" // Tenis clásicos
    @Published var equippedBundle: String = "bundle_sakura" // Pase Sakura Season 1
    
    // Equipped Weapon & Skin
    @Published var equippedWeaponId: String = "weapon_ak47"
    @Published var equippedWeaponSkinId: String = "skin_ak_flaming_dragon" // AK Dragón Llameante
    
    // Equipped Character & Pet
    @Published var equippedCharacterId: String = "char_hayato"
    @Published var equippedPetId: String = "pet_shiba"
    
    // Inventory of owned items
    @Published var ownedCosmetics: Set<String> = [
        "bundle_sakura", "sakura_mask", "sakura_top", "sakura_pants",
        "bundle_hiphop", "hiphop_cap", "hiphop_top", "hiphop_pants",
        "bundle_criminal_red", "bundle_dino_green",
        "jacket_heroic_2019", "angelic_pants", "angelic_bandana",
        "jordan_retro", "classic_boots"
    ]
    
    @Published var ownedWeaponSkins: Set<String> = [
        "skin_ak_flaming_dragon", "skin_mp40_mechanical", "skin_scar_cupid",
        "skin_m1014_cat_eye", "skin_awm_cheetah", "skin_pan_gold", "skin_katana_blood"
    ]
    
    @Published var ownedCharacters: Set<String> = [
        "char_adan", "char_eva", "char_kelly", "char_andrew", "char_kla",
        "char_hayato", "char_paloma", "char_maxim", "char_caroline",
        "char_laura", "char_rafael", "char_alok"
    ]
    
    @Published var ownedPets: Set<String> = [
        "pet_kitty", "pet_mech_pup", "pet_shiba", "pet_night_panther"
    ]
    
    private init() {}
    
    func equipCosmetic(id: String, category: String) {
        switch category {
        case "bundle":
            equippedBundle = id
            if id == "bundle_sakura" {
                equippedHead = "sakura_mask"
                equippedTop = "sakura_top"
                equippedPants = "sakura_pants"
            } else if id == "bundle_hiphop" {
                equippedHead = "hiphop_cap"
                equippedTop = "hiphop_top"
                equippedPants = "hiphop_pants"
            } else if id == "bundle_criminal_red" {
                equippedHead = "criminal_mask"
                equippedTop = "criminal_suit"
                equippedPants = "criminal_pants"
            } else if id == "bundle_dino_green" {
                equippedHead = "dino_hood"
                equippedTop = "dino_suit"
                equippedPants = "dino_legs"
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
    
    func buyWithGold(cost: Int, itemId: String, category: String) -> Bool {
        guard gold >= cost else { return false }
        gold -= cost
        ownedCosmetics.insert(itemId)
        equipCosmetic(id: itemId, category: category)
        FreeFireTheme.booyahVictoryHaptic()
        return true
    }
    
    func buyWithDiamonds(cost: Int, itemId: String, category: String) -> Bool {
        guard diamonds >= cost else { return false }
        diamonds -= cost
        ownedCosmetics.insert(itemId)
        equipCosmetic(id: itemId, category: category)
        FreeFireTheme.booyahVictoryHaptic()
        return true
    }
}
