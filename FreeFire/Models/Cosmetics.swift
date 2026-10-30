import SwiftUI

enum CosmeticType: String, CaseIterable, Identifiable {
    case bundle = "CONJUNTOS"
    case head = "CABEZAS"
    case mask = "MÁSCARAS"
    case top = "PECHO"
    case pants = "PANTALONES"
    case shoes = "ZAPATOS"
    case pets = "MASCOTAS"
    case emote = "EMOTES"
    
    var id: String { rawValue }
}

enum ItemRarity: String {
    case legendary = "MÍTICO / LEGENDARIO"
    case epic = "ÉPICO"
    case rare = "RARO"
    
    var color: Color {
        switch self {
        case .legendary: return Color(red: 1.0, green: 0.75, blue: 0.0) // Gold / Yellow
        case .epic: return Color(red: 0.8, green: 0.25, blue: 0.95)   // Purple
        case .rare: return Color(red: 0.2, green: 0.65, blue: 1.0)     // Blue
        }
    }
}

struct CosmeticItem: Identifiable, Equatable {
    let id: String
    let name: String
    let category: CosmeticType
    let rarity: ItemRarity
    let season: String
    let description: String
    let iconName: String
    let primaryColor: Color
    let secondaryColor: Color
    let priceGold: Int?
    let priceDiamonds: Int?
}

extension CosmeticItem {
    static let classic2019Cosmetics: [CosmeticItem] = [
        // MARK: - Sets from User's Video
        CosmeticItem(
            id: "bundle_cyber_bone",
            name: "Cazador de Huesos Booyah",
            category: .bundle,
            rarity: .legendary,
            season: "Booyah Day Especial",
            description: "El conjunto blindado cibernético con costillas esqueléticas doradas brillantes y peinado con fuego amarillo que portas en tu cuenta.",
            iconName: "flame.fill",
            primaryColor: Color(red: 1.0, green: 0.85, blue: 0.0),
            secondaryColor: Color.black,
            priceGold: nil,
            priceDiamonds: 1200
        ),
        CosmeticItem(
            id: "bundle_don_muerte",
            name: "Conjunto Velador de Don Muerte",
            category: .bundle,
            rarity: .legendary,
            season: "Ruleta de Tokens",
            description: "Aspecto espectral con llamas de fuego verde, sombrero de charro calavera y gabardina de forajido de ultra tumba.",
            iconName: "crown.fill",
            primaryColor: Color(red: 0.2, green: 0.9, blue: 0.5),
            secondaryColor: Color.black,
            priceGold: nil,
            priceDiamonds: 1500
        ),
        CosmeticItem(
            id: "bundle_sakura",
            name: "Pase Sakura (Temp. 1)",
            category: .bundle,
            rarity: .legendary,
            season: "Temporada 1",
            description: "El primer pase de la historia de Free Fire con la máscara tradicional Oni de flores de cerezo.",
            iconName: "crown.fill",
            primaryColor: Color.pink,
            secondaryColor: Color.black,
            priceGold: nil,
            priceDiamonds: 1200
        ),
        CosmeticItem(
            id: "bundle_hiphop",
            name: "Pase Hip Hop (Temp. 2)",
            category: .bundle,
            rarity: .legendary,
            season: "Temporada 2",
            description: "Chaqueta amarilla, gorra de visera plana y pañuelo urbano de la época dorada.",
            iconName: "music.note",
            primaryColor: Color.yellow,
            secondaryColor: Color.purple,
            priceGold: nil,
            priceDiamonds: 1200
        ),
        
        // MARK: - Cabezas / Máscaras
        CosmeticItem(
            id: "cyber_bone_head",
            name: "Peinado Espinas de Fuego",
            category: .head,
            rarity: .legendary,
            season: "Booyah Day",
            description: "Cabello puntiagudo erizado con aura de fuego ardiente y gafas luminosas amarillas.",
            iconName: "comb.fill",
            primaryColor: Color.yellow,
            secondaryColor: Color.orange,
            priceGold: nil,
            priceDiamonds: 600
        ),
        CosmeticItem(
            id: "don_muerte_mask",
            name: "Calavera Don Muerte",
            category: .mask,
            rarity: .legendary,
            season: "Ruleta de Tokens",
            description: "Cráneo mexicano con flamas ectoplásmicas verdes en ojos y boca.",
            iconName: "theatermasks.fill",
            primaryColor: Color.green,
            secondaryColor: Color.black,
            priceGold: nil,
            priceDiamonds: 800
        ),
        CosmeticItem(
            id: "angelic_bandana",
            name: "Pañuelo Angelical",
            category: .mask,
            rarity: .epic,
            season: "Clásico",
            description: "Pañuelo negro que cubre el rostro con bordados alados celestes.",
            iconName: "face.smiling.fill",
            primaryColor: Color.black,
            secondaryColor: Color.cyan,
            priceGold: 25000,
            priceDiamonds: 400
        ),
        
        // MARK: - Pecho
        CosmeticItem(
            id: "cyber_bone_jacket",
            name: "Chaqueta Cyber Costillas",
            category: .top,
            rarity: .legendary,
            season: "Booyah Day",
            description: "Armadura ligera con relieves de costillas óseas doradas que brillan en la oscuridad.",
            iconName: "tshirt.fill",
            primaryColor: Color(red: 1.0, green: 0.8, blue: 0.0),
            secondaryColor: Color.black,
            priceGold: nil,
            priceDiamonds: 700
        ),
        
        // MARK: - Pantalones
        CosmeticItem(
            id: "cyber_bone_pants",
            name: "Pantalón Blindado Cyber",
            category: .pants,
            rarity: .legendary,
            season: "Booyah Day",
            description: "Pantalón de combate negro con rodilleras reforzadas y franjas amarillas de neón.",
            iconName: "figure.walk",
            primaryColor: Color.black,
            secondaryColor: Color.yellow,
            priceGold: nil,
            priceDiamonds: 600
        ),
        CosmeticItem(
            id: "angelic_pants",
            name: "Pantalón Angelical Original",
            category: .pants,
            rarity: .legendary,
            season: "Especial",
            description: "El mítico pantalón azul con alas blancas.",
            iconName: "figure.walk",
            primaryColor: Color(red: 0.1, green: 0.25, blue: 0.55),
            secondaryColor: Color.white,
            priceGold: nil,
            priceDiamonds: 1500
        ),
        
        // MARK: - Zapatos
        CosmeticItem(
            id: "cyber_bone_shoes",
            name: "Tenis Cyber Booyah",
            category: .shoes,
            rarity: .legendary,
            season: "Booyah Day",
            description: "Calzado deportivo aerodinámico blanco, negro y amarillo con suela luminosa.",
            iconName: "shoeprints.fill",
            primaryColor: Color.white,
            secondaryColor: Color.yellow,
            priceGold: 15000,
            priceDiamonds: 300
        ),
        
        // MARK: - Mascotas
        CosmeticItem(
            id: "pet_waggor",
            name: "Sr. Waggor (Pingüino)",
            category: .pets,
            rarity: .legendary,
            season: "Mascota Oficial",
            description: "Habilidad: Produce Paredes Gloo automáticamente cada 100 segundos cuando tienes menos de 2 paredes.",
            iconName: "shield.checkered",
            primaryColor: Color.red,
            secondaryColor: Color.black,
            priceGold: nil,
            priceDiamonds: 500
        ),
        CosmeticItem(
            id: "pet_shiba",
            name: "Shiba Inu",
            category: .pets,
            rarity: .epic,
            season: "OB16",
            description: "Habilidad: Marca hongos en el minimapa.",
            iconName: "pawprint.circle.fill",
            primaryColor: Color.orange,
            secondaryColor: Color.white,
            priceGold: nil,
            priceDiamonds: 400
        ),
        
        // MARK: - Emotes (From User's Video)
        CosmeticItem(
            id: "emote_dance_battle",
            name: "Batalla de Baile",
            category: .emote,
            rarity: .legendary,
            season: "Exclusivo",
            description: "El icónico baile acrobático de breakdance y piruetas en el aire con destellos de luz que tienes equipado.",
            iconName: "figure.dance",
            primaryColor: Color.yellow,
            secondaryColor: Color.orange,
            priceGold: nil,
            priceDiamonds: 500
        ),
        CosmeticItem(
            id: "emote_booyah",
            name: "¡BOOYAH!",
            category: .emote,
            rarity: .epic,
            season: "Clásico",
            description: "Celebra levantando los brazos hacia el cielo mientras aparece el emblema BOOYAH.",
            iconName: "hands.sparkles.fill",
            primaryColor: Color.yellow,
            secondaryColor: Color.red,
            priceGold: nil,
            priceDiamonds: 350
        )
    ]
}
