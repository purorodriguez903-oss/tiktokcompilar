import SwiftUI

enum WeaponCategory: String, CaseIterable, Identifiable {
    case assaultRifle = "Rifles de Asalto"
    case smg = "Subfusiles (SMG)"
    case shotgun = "Escopetas"
    case sniper = "Francotiradores"
    case pistol = "Pistolas"
    case melee = "Cuerpo a Cuerpo"
    case utility = "Pared Gloo / Granadas"
    
    var id: String { rawValue }
}

struct WeaponSkin: Identifiable, Equatable {
    let id: String
    let name: String
    let weaponId: String
    let rarity: ItemRarity
    let damageBonus: Int       // e.g. +1, +2
    let rateOfFireBonus: Int   // e.g. +2
    let rangeBonus: Int        // e.g. +1, -1
    let reloadBonus: Int       // e.g. -1
    let magazineBonus: Int     // e.g. -1
    let color: Color
    let secondaryColor: Color
    let description: String
}

struct Weapon: Identifiable, Equatable {
    let id: String
    let name: String
    let category: WeaponCategory
    let damage: Int       // 0 - 100
    let range: Int        // 0 - 100
    let rateOfFire: Int   // 0 - 100
    let accuracy: Int     // 0 - 100
    let reloadSpeed: Int  // 0 - 100
    let magazineSize: Int
    let iconSystemName: String
    let description: String
    let isEquipped: Bool
    let colorTheme: Color
}

extension WeaponSkin {
    static let classic2019Skins: [WeaponSkin] = [
        WeaponSkin(
            id: "skin_ak_flaming_dragon",
            name: "AK-47 Dragón Llameante",
            weaponId: "w_ak47",
            rarity: .legendary,
            damageBonus: 1,
            rateOfFireBonus: 2,
            rangeBonus: 0,
            reloadBonus: 0,
            magazineBonus: -1,
            color: Color(red: 1.0, green: 0.25, blue: 0.0),
            secondaryColor: Color(red: 1.0, green: 0.8, blue: 0.0),
            description: "La skin de AK-47 más codiciada de 2019 en Arma Royale. Envuelve el arma en llamas vivientes rojas y doradas."
        ),
        WeaponSkin(
            id: "skin_mp40_mechanical",
            name: "MP40 Mecánica (Machine Girl)",
            weaponId: "w_mp40",
            rarity: .legendary,
            damageBonus: 2,
            rateOfFireBonus: 0,
            rangeBonus: 1,
            reloadBonus: -1,
            magazineBonus: 0,
            color: Color(red: 0.2, green: 0.6, blue: 0.9),
            secondaryColor: Color(red: 0.8, green: 0.3, blue: 0.7),
            description: "La legendaria MP40 con doble daño que dominaba los duelos a corta distancia en 2019."
        ),
        WeaponSkin(
            id: "skin_scar_cupid",
            name: "SCAR Cupido (Valentine)",
            weaponId: "w_scar",
            rarity: .legendary,
            damageBonus: 1,
            rateOfFireBonus: 2,
            rangeBonus: -1,
            reloadBonus: 0,
            magazineBonus: 0,
            color: Color(red: 0.95, green: 0.3, blue: 0.55),
            secondaryColor: Color.white,
            description: "Lanzada en San Valentín 2019. Su impresionante cadencia de tiro la convirtió en una de las armas favoritas de los pro-players."
        ),
        WeaponSkin(
            id: "skin_m1014_cat_eye",
            name: "M1014 Ojo de Gato",
            weaponId: "w_m1014",
            rarity: .epic,
            damageBonus: 1,
            rateOfFireBonus: 0,
            rangeBonus: 1,
            reloadBonus: -1,
            magazineBonus: 0,
            color: Color(red: 0.9, green: 0.8, blue: 0.1),
            secondaryColor: Color.black,
            description: "Aspecto felino con ojos brillantes en la recámara. Aumenta el alcance para one-taps demoledores."
        ),
        WeaponSkin(
            id: "skin_awm_cheetah",
            name: "AWM Guepardo",
            weaponId: "w_awm",
            rarity: .epic,
            damageBonus: 2,
            rateOfFireBonus: 0,
            rangeBonus: 0,
            reloadBonus: -1,
            magazineBonus: 0,
            color: Color(red: 0.95, green: 0.7, blue: 0.2),
            secondaryColor: Color.black,
            description: "Patrón de leopardo que otorga daño colosal de 330 en pecho y 1100 en cabeza."
        ),
        WeaponSkin(
            id: "skin_pan_gold",
            name: "Sartén de Oro 2019",
            weaponId: "w_pan",
            rarity: .legendary,
            damageBonus: 0,
            rateOfFireBonus: 0,
            rangeBonus: 0,
            reloadBonus: 0,
            magazineBonus: 0,
            color: Color(red: 1.0, green: 0.84, blue: 0.0),
            secondaryColor: Color.black,
            description: "Sartén de oro puro que desvía balas por la espalda con su tintineo característico metálico."
        ),
        WeaponSkin(
            id: "skin_katana_blood",
            name: "Katana Luna Sangrienta",
            weaponId: "w_katana",
            rarity: .legendary,
            damageBonus: 1,
            rateOfFireBonus: 0,
            rangeBonus: 0,
            reloadBonus: 0,
            magazineBonus: 0,
            color: Color(red: 0.8, green: 0.1, blue: 0.15),
            secondaryColor: Color.white,
            description: "La legendaria espada japonesa con estela de cortes rojos introducida junto a Hayato en 2019."
        )
    ]
}

extension Weapon {
    static let classic2019Weapons: [Weapon] = [
        // Rifles de Asalto
        Weapon(
            id: "w_ak47",
            name: "AK-47",
            category: .assaultRifle,
            damage: 38,
            range: 72,
            rateOfFire: 56,
            accuracy: 41,
            reloadSpeed: 45,
            magazineSize: 30,
            iconSystemName: "cross.fill",
            description: "El fusil de asalto más potente y representativo de 2019. Daño destructivo a costa de un fuerte retroceso.",
            isEquipped: true,
            colorTheme: Color(red: 0.8, green: 0.4, blue: 0.1)
        ),
        Weapon(
            id: "w_scar",
            name: "SCAR",
            category: .assaultRifle,
            damage: 32,
            range: 68,
            rateOfFire: 62,
            accuracy: 50,
            reloadSpeed: 52,
            magazineSize: 30,
            iconSystemName: "triangle.fill",
            description: "El rifle más estable y amigable para disparar a media y larga distancia en Bermuda.",
            isEquipped: false,
            colorTheme: Color(red: 0.3, green: 0.6, blue: 0.8)
        ),
        Weapon(
            id: "w_m4a1",
            name: "M4A1",
            category: .assaultRifle,
            damage: 29,
            range: 77,
            rateOfFire: 57,
            accuracy: 55,
            reloadSpeed: 48,
            magazineSize: 30,
            iconSystemName: "shield.checkered",
            description: "Rifle de asalto equilibrado con el mayor alcance base de su categoría.",
            isEquipped: false,
            colorTheme: Color(red: 0.4, green: 0.5, blue: 0.4)
        ),
        Weapon(
            id: "w_groza",
            name: "GROZA (Drop)",
            category: .assaultRifle,
            damage: 35,
            range: 77,
            rateOfFire: 58,
            accuracy: 52,
            reloadSpeed: 50,
            magazineSize: 30,
            iconSystemName: "crown.fill",
            description: "Exclusivo de los airdrops (cajas amarillas). Combina el daño del AK-47 con la estabilidad de la SCAR.",
            isEquipped: false,
            colorTheme: Color(red: 0.9, green: 0.2, blue: 0.3)
        ),
        
        // Subfusiles
        Weapon(
            id: "w_mp40",
            name: "MP40",
            category: .smg,
            damage: 22,
            range: 35,
            rateOfFire: 95,
            accuracy: 25,
            reloadSpeed: 60,
            magazineSize: 32,
            iconSystemName: "bolt.fill",
            description: "La reina indiscutible del combate a corta distancia. Dispara ráfagas a una velocidad demoledora.",
            isEquipped: false,
            colorTheme: Color(red: 0.9, green: 0.7, blue: 0.1)
        ),
        Weapon(
            id: "w_ump",
            name: "UMP",
            category: .smg,
            damage: 25,
            range: 42,
            rateOfFire: 75,
            accuracy: 42,
            reloadSpeed: 62,
            magazineSize: 30,
            iconSystemName: "circle.grid.cross.fill",
            description: "Subfusil muy versátil con buen daño y bajo retroceso ideal para principiantes y veteranos.",
            isEquipped: false,
            colorTheme: Color(red: 0.5, green: 0.5, blue: 0.7)
        ),
        
        // Escopetas
        Weapon(
            id: "w_m1014",
            name: "M1014",
            category: .shotgun,
            damage: 94,
            range: 15,
            rateOfFire: 38,
            accuracy: 20,
            reloadSpeed: 30,
            magazineSize: 6,
            iconSystemName: "flame.fill",
            description: "La escopeta semiautomática clásica del 2019. Letal a quemarropa con capacidad de eliminar de un disparo.",
            isEquipped: false,
            colorTheme: Color(red: 0.9, green: 0.2, blue: 0.2)
        ),
        Weapon(
            id: "w_spas12",
            name: "SPAS12",
            category: .shotgun,
            damage: 97,
            range: 18,
            rateOfFire: 42,
            accuracy: 22,
            reloadSpeed: 34,
            magazineSize: 5,
            iconSystemName: "shield.slash.fill",
            description: "Escopeta de corredera pesada con impacto letal a corta distancia.",
            isEquipped: false,
            colorTheme: Color(red: 0.6, green: 0.3, blue: 0.3)
        ),
        
        // Francotiradores
        Weapon(
            id: "w_awm",
            name: "AWM (Drop)",
            category: .sniper,
            damage: 90,
            range: 95,
            rateOfFire: 27,
            accuracy: 90,
            reloadSpeed: 35,
            magazineSize: 5,
            iconSystemName: "scope",
            description: "El rifle de francotirador definitivo obtenido solo en airdrops. Capaz de noquear de un tiro certero a la cabeza.",
            isEquipped: false,
            colorTheme: Color(red: 0.2, green: 0.7, blue: 0.9)
        ),
        Weapon(
            id: "w_kar98k",
            name: "Kar98k",
            category: .sniper,
            damage: 85,
            range: 88,
            rateOfFire: 30,
            accuracy: 85,
            reloadSpeed: 38,
            magazineSize: 5,
            iconSystemName: "target",
            description: "Francotirador clásico de cerrojo disponible en el suelo de Bermuda con mira 8x preinstalada.",
            isEquipped: false,
            colorTheme: Color(red: 0.7, green: 0.6, blue: 0.4)
        ),
        
        // Pistolas
        Weapon(
            id: "w_deagle",
            name: "Desert Eagle",
            category: .pistol,
            damage: 90,
            range: 38,
            rateOfFire: 33,
            accuracy: 45,
            reloadSpeed: 69,
            magazineSize: 7,
            iconSystemName: "target",
            description: "La pistola de mayor calibre de Free Fire. Famosa por los legendarios 'tiros fantasma' a la cabeza.",
            isEquipped: false,
            colorTheme: Color(red: 0.7, green: 0.7, blue: 0.7)
        ),
        Weapon(
            id: "w_g18",
            name: "G18",
            category: .pistol,
            damage: 20,
            range: 20,
            rateOfFire: 64,
            accuracy: 40,
            reloadSpeed: 55,
            magazineSize: 15,
            iconSystemName: "burst.fill",
            description: "Pistola automática de tiro rápido ideal para los primeros segundos tras caer del avión.",
            isEquipped: false,
            colorTheme: Color(red: 0.4, green: 0.4, blue: 0.4)
        ),
        
        // Melee
        Weapon(
            id: "w_pan",
            name: "Sartén",
            category: .melee,
            damage: 62,
            range: 5,
            rateOfFire: 35,
            accuracy: 10,
            reloadSpeed: 0,
            magazineSize: 0,
            iconSystemName: "frying.pan.fill",
            description: "El mítico sartén que desvía balas como un escudo trasero antibalas en Bermuda.",
            isEquipped: false,
            colorTheme: Color(red: 1.0, green: 0.8, blue: 0.2)
        ),
        Weapon(
            id: "w_katana",
            name: "Katana",
            category: .melee,
            damage: 66,
            range: 6,
            rateOfFire: 32,
            accuracy: 10,
            reloadSpeed: 0,
            magazineSize: 0,
            iconSystemName: "waveform.path",
            description: "Espada samurái tradicional introducida en 2019 con elegantes cortes y sonido metálico cortante.",
            isEquipped: false,
            colorTheme: Color(red: 0.8, green: 0.2, blue: 0.2)
        ),
        
        // Utilidad
        Weapon(
            id: "w_gloo_wall",
            name: "Pared Gloo",
            category: .utility,
            damage: 0,
            range: 10,
            rateOfFire: 100,
            accuracy: 100,
            reloadSpeed: 100,
            magazineSize: 3,
            iconSystemName: "shield.fill",
            description: "Crea un muro de hielo instantáneo que absorbe el fuego enemigo. El elemento táctico insignia de Free Fire.",
            isEquipped: false,
            colorTheme: Color(red: 0.35, green: 0.85, blue: 1.0)
        )
    ]
}
