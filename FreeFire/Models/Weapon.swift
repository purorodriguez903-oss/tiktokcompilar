import SwiftUI

enum WeaponCategory: String, CaseIterable {
    case assaultRifle = "Rifle de Asalto"
    case smg = "Subfusil (SMG)"
    case shotgun = "Escopeta"
    case sniper = "Francotirador"
    case utility = "Utilidad"
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

extension Weapon {
    static let classic2019Weapons: [Weapon] = [
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
            description: "El rifle de asalto clásico más potente de 2019. Causa un daño brutal pero requiere gran control de retroceso.",
            isEquipped: true,
            colorTheme: Color(red: 0.8, green: 0.4, blue: 0.1)
        ),
        Weapon(
            id: "w_mp40",
            name: "MP40",
            category: .smg,
            damage: 22,
            range: 35,
            rateOfFire: 95,
            accuracy: 54,
            reloadSpeed: 60,
            magazineSize: 30,
            iconSystemName: "bolt.fill",
            description: "El rey del combate a corta distancia en 2019. Su velocidad de disparo derrite a los enemigos en segundos.",
            isEquipped: false,
            colorTheme: Color(red: 0.9, green: 0.7, blue: 0.1)
        ),
        Weapon(
            id: "w_scar",
            name: "SCAR",
            category: .assaultRifle,
            damage: 30,
            range: 62,
            rateOfFire: 61,
            accuracy: 65,
            reloadSpeed: 52,
            magazineSize: 30,
            iconSystemName: "target",
            description: "El rifle más equilibrado y fácil de controlar de la era dorada de Bermuda. Excelente precisión a media distancia.",
            isEquipped: false,
            colorTheme: Color(red: 0.2, green: 0.6, blue: 0.3)
        ),
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
            iconSystemName: "circle.grid.3x3.fill",
            description: "La temida escopeta de 6 tiros de 2019. Capaz de noquear de un solo impacto a quemarropa.",
            isEquipped: false,
            colorTheme: Color(red: 0.8, green: 0.2, blue: 0.2)
        ),
        Weapon(
            id: "w_awm",
            name: "AWM",
            category: .sniper,
            damage: 150,
            range: 91,
            rateOfFire: 27,
            accuracy: 90,
            reloadSpeed: 34,
            magazineSize: 5,
            iconSystemName: "scope",
            description: "El francotirador de los airdrops legendario. Un disparo a la cabeza (300 de daño) elimina a cualquier rival instantáneamente.",
            isEquipped: false,
            colorTheme: Color(red: 0.3, green: 0.5, blue: 0.9)
        ),
        Weapon(
            id: "w_gloo",
            name: "Pared Gloo",
            category: .utility,
            damage: 0,
            range: 5,
            rateOfFire: 100,
            accuracy: 100,
            reloadSpeed: 100,
            magazineSize: 3,
            iconSystemName: "shield.fill",
            description: "Granada de hielo que despliega un escudo protector instantáneo contra balas en campo abierto.",
            isEquipped: false,
            colorTheme: Color(red: 0.2, green: 0.8, blue: 0.9)
        )
    ]
}

