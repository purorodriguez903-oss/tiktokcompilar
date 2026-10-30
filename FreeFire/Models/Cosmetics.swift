import SwiftUI

enum CosmeticType: String, CaseIterable, Identifiable {
    case bundle = "CONJUNTOS"
    case head = "CABEZAS"
    case top = "PECHO"
    case pants = "PANTALONES"
    case shoes = "ZAPATOS"
    case pets = "MASCOTAS"
    
    var id: String { rawValue }
}

enum ItemRarity: String {
    case legendary = "LEGENDARIO"
    case epic = "ÉPICO"
    case rare = "RARO"
    
    var color: Color {
        switch self {
        case .legendary: return Color(red: 1.0, green: 0.8, blue: 0.0) // Gold
        case .epic: return Color(red: 0.75, green: 0.2, blue: 0.9)    // Purple
        case .rare: return Color(red: 0.2, green: 0.6, blue: 1.0)     // Blue
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
        // MARK: - Bundles (Conjuntos Legendarios)
        CosmeticItem(
            id: "bundle_sakura",
            name: "Pase Sakura (Temp. 1)",
            category: .bundle,
            rarity: .legendary,
            season: "Temporada 1 (2018-2019)",
            description: "El conjunto más legendario y exclusivo de la historia de Free Fire. Representa a los verdaderos veteranos con la mítica Máscara Oni de flores de cerezo.",
            iconName: "crown.fill",
            primaryColor: Color(red: 0.95, green: 0.45, blue: 0.6),
            secondaryColor: Color(red: 0.2, green: 0.1, blue: 0.15),
            priceGold: nil,
            priceDiamonds: 1200
        ),
        CosmeticItem(
            id: "bundle_hiphop",
            name: "Pase Hip Hop (Temp. 2)",
            category: .bundle,
            rarity: .legendary,
            season: "Temporada 2 (2019)",
            description: "El icónico traje callejero con gorra de visera plana, pañuelo urbano y chaqueta amarilla con detalles morados que marcó época.",
            iconName: "music.note",
            primaryColor: Color(red: 0.95, green: 0.8, blue: 0.1),
            secondaryColor: Color(red: 0.4, green: 0.15, blue: 0.6),
            priceGold: nil,
            priceDiamonds: 1200
        ),
        CosmeticItem(
            id: "bundle_criminal_red",
            name: "Criminal Rojo (Incubadora)",
            category: .bundle,
            rarity: .legendary,
            season: "Incubadora 2019",
            description: "El aspecto más temido en Bermuda. El overol rojo con la máscara demoníaca de payaso sonriente obtenido con Piedras Evolutivas.",
            iconName: "flame.fill",
            primaryColor: Color(red: 0.85, green: 0.1, blue: 0.15),
            secondaryColor: Color.black,
            priceGold: nil,
            priceDiamonds: 2000
        ),
        CosmeticItem(
            id: "bundle_dino_green",
            name: "Dino Verde Clásico",
            category: .bundle,
            rarity: .legendary,
            season: "Incubadora Dinos 2019",
            description: "El mítico mameluco enterizo de dinosaurio verde que todo jugador soñaba sacar en la primera Incubadora de Free Fire.",
            iconName: "pawprint.fill",
            primaryColor: Color(red: 0.25, green: 0.75, blue: 0.3),
            secondaryColor: Color(red: 0.9, green: 0.95, blue: 0.8),
            priceGold: nil,
            priceDiamonds: 1800
        ),
        
        // MARK: - Cabezas / Máscaras
        CosmeticItem(
            id: "sakura_mask",
            name: "Máscara Oni Sakura",
            category: .head,
            rarity: .legendary,
            season: "Pase Élite 1",
            description: "Máscara tradicional demoníaca japonesa blanca con cuernos carmesí y marcas tribales.",
            iconName: "theatermasks.fill",
            primaryColor: Color.white,
            secondaryColor: Color.red,
            priceGold: nil,
            priceDiamonds: 800
        ),
        CosmeticItem(
            id: "hiphop_cap",
            name: "Gorra Hip Hop Original",
            category: .head,
            rarity: .legendary,
            season: "Pase Élite 2",
            description: "Gorra invertida hacia atrás con visera recta plana amarilla.",
            iconName: "hat.widebrim.fill",
            primaryColor: Color.yellow,
            secondaryColor: Color.purple,
            priceGold: nil,
            priceDiamonds: 600
        ),
        CosmeticItem(
            id: "angelic_bandana",
            name: "Pañuelo Angelical",
            category: .head,
            rarity: .epic,
            season: "Evento Clásico 2019",
            description: "Pañuelo facial negro que cubre la mitad del rostro con bordado alado.",
            iconName: "face.smiling.fill",
            primaryColor: Color.black,
            secondaryColor: Color.cyan,
            priceGold: 25000,
            priceDiamonds: 400
        ),
        
        // MARK: - Pecho (Camisetas / Chamarras)
        CosmeticItem(
            id: "sakura_top",
            name: "Kimono Guerrero Sakura",
            category: .top,
            rarity: .legendary,
            season: "Pase Élite 1",
            description: "Chaqueta kimono estilizada con flores de cerezo bordadas a mano y hombreras doradas.",
            iconName: "tshirt.fill",
            primaryColor: Color(red: 0.9, green: 0.35, blue: 0.5),
            secondaryColor: Color.black,
            priceGold: nil,
            priceDiamonds: 700
        ),
        CosmeticItem(
            id: "hiphop_top",
            name: "Chaqueta Callejera Hip Hop",
            category: .top,
            rarity: .legendary,
            season: "Pase Élite 2",
            description: "Chaqueta bomber holgada amarilla con mangas púrpuras y cadenas de oro.",
            iconName: "tshirt.fill",
            primaryColor: Color.yellow,
            secondaryColor: Color.purple,
            priceGold: nil,
            priceDiamonds: 700
        ),
        CosmeticItem(
            id: "jacket_heroic_2019",
            name: "Chaqueta Heroico Temp. 2019",
            category: .top,
            rarity: .legendary,
            season: "Recompensa de Rango 2019",
            description: "La chamarra dorada y negra que solo los jugadores que alcanzaron el rango Heroico en clasificatoria portaban con orgullo.",
            iconName: "star.shield.fill",
            primaryColor: Color(red: 1.0, green: 0.75, blue: 0.0),
            secondaryColor: Color.black,
            priceGold: 50000,
            priceDiamonds: nil
        ),
        
        // MARK: - Pantalones
        CosmeticItem(
            id: "angelic_pants",
            name: "Pantalón Angelical Original",
            category: .pants,
            rarity: .legendary,
            season: "Evento Especial 2019",
            description: "El mítico pantalón azul oscuro con las alas blancas angelicales a los costados que se volvió el símbolo supremo de estatus.",
            iconName: "figure.walk",
            primaryColor: Color(red: 0.1, green: 0.2, blue: 0.45),
            secondaryColor: Color.white,
            priceGold: nil,
            priceDiamonds: 1500
        ),
        CosmeticItem(
            id: "sakura_pants",
            name: "Pantalón Samurai Sakura",
            category: .pants,
            rarity: .legendary,
            season: "Pase Élite 1",
            description: "Hakama tradicional japonesa con vendas en espinillas y cinturón de soga.",
            iconName: "figure.walk",
            primaryColor: Color(red: 0.15, green: 0.15, blue: 0.18),
            secondaryColor: Color.pink,
            priceGold: nil,
            priceDiamonds: 600
        ),
        CosmeticItem(
            id: "hiphop_pants",
            name: "Pantalón Baggy Hip Hop",
            category: .pants,
            rarity: .legendary,
            season: "Pase Élite 2",
            description: "Pantalón deportivo ancho y cómodo con bolsillos cargo y correas laterales.",
            iconName: "figure.walk",
            primaryColor: Color.purple,
            secondaryColor: Color.yellow,
            priceGold: nil,
            priceDiamonds: 600
        ),
        
        // MARK: - Zapatos
        CosmeticItem(
            id: "jordan_retro",
            name: "Tenis Clásicos Retro 2019",
            category: .shoes,
            rarity: .epic,
            season: "Tienda Clásica",
            description: "Zapatillas de bota alta rojas, blancas y negras de estilo urbano.",
            iconName: "shoeprints.fill",
            primaryColor: Color.red,
            secondaryColor: Color.white,
            priceGold: 15000,
            priceDiamonds: 300
        ),
        CosmeticItem(
            id: "classic_boots",
            name: "Botas Militares Bermuda",
            category: .shoes,
            rarity: .rare,
            season: "Inicial",
            description: "Botas tácticas de combate resistentes a todo tipo de terreno.",
            iconName: "shoeprints.fill",
            primaryColor: Color(red: 0.2, green: 0.18, blue: 0.14),
            secondaryColor: Color.black,
            priceGold: 5000,
            priceDiamonds: 100
        ),
        
        // MARK: - Mascotas (Pets)
        CosmeticItem(
            id: "pet_kitty",
            name: "Gatito Clásico",
            category: .pets,
            rarity: .epic,
            season: "OB13 (Primera Mascota)",
            description: "La primera mascota de la historia de Free Fire. Te acompaña fielmente y realiza piruetas y maullidos en el lobby.",
            iconName: "cat.fill",
            primaryColor: Color.orange,
            secondaryColor: Color.white,
            priceGold: 20000,
            priceDiamonds: 300
        ),
        CosmeticItem(
            id: "pet_mech_pup",
            name: "Perro Mecánico",
            category: .pets,
            rarity: .epic,
            season: "OB14 (2019)",
            description: "Cachorro cibernético de acero y circuitos con luces de neón azules que emite ladridos electrónicos.",
            iconName: "dog.fill",
            primaryColor: Color.cyan,
            secondaryColor: Color.gray,
            priceGold: 25000,
            priceDiamonds: 350
        ),
        CosmeticItem(
            id: "pet_shiba",
            name: "Shiba Inu",
            category: .pets,
            rarity: .legendary,
            season: "OB16 (2019)",
            description: "Habilidad: Marca la ubicación de hongos cercanos en el minimap cada cierto tiempo.",
            iconName: "pawprint.circle.fill",
            primaryColor: Color(red: 0.85, green: 0.55, blue: 0.2),
            secondaryColor: Color.white,
            priceGold: nil,
            priceDiamonds: 500
        ),
        CosmeticItem(
            id: "pet_night_panther",
            name: "Pantera Nocturna",
            category: .pets,
            rarity: .legendary,
            season: "OB15 (2019)",
            description: "Habilidad: Aumenta la capacidad de la mochila en 45 unidades para llevar más munición y botiquines.",
            iconName: "shield.righthalf.filled",
            primaryColor: Color.black,
            secondaryColor: Color.purple,
            priceGold: nil,
            priceDiamonds: 600
        )
    ]
}

