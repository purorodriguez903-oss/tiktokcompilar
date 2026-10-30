import SwiftUI

struct FFCharacter: Identifiable, Equatable {
    let id: String
    let name: String
    let title: String
    let skillName: String
    let skillDescription: String
    let skillIcon: String
    let level: Int
    let bio: String
    let isSelected: Bool
    let color: Color
}

extension FFCharacter {
    static let classic2019Characters: [FFCharacter] = [
        FFCharacter(
            id: "char_hayato",
            name: "Hayato",
            title: "El Samurái Legendario",
            skillName: "Bushido",
            skillDescription: "Por cada 10% de disminución de la vida máxima, la penetración de armadura aumenta en un 10%.",
            skillIcon: "figure.walk",
            level: 6,
            bio: "Heredero de una legendaria familia de guerreros samurái. Porta la sangre ancestral que se desata cuando se encuentra al borde del abismo.",
            isSelected: true,
            color: Color(red: 0.8, green: 0.15, blue: 0.2)
        ),
        FFCharacter(
            id: "char_alok",
            name: "DJ Alok",
            title: "El Icono de la Música",
            skillName: "Ritmo Brutal (Drop the Beat)",
            skillDescription: "Crea un aura circular de 5 metros que aumenta la velocidad de movimiento un 15% y restaura 5 HP/seg por 10 segundos.",
            skillIcon: "music.note.list",
            level: 6,
            bio: "La leyenda brasileña lanzada a finales de 2019 que revolucionó por completo la jugabilidad y la meta de Free Fire en torneos.",
            isSelected: false,
            color: Color(red: 0.2, green: 0.8, blue: 0.9)
        ),
        FFCharacter(
            id: "char_kelly",
            name: "Kelly",
            title: "Velocista de Secundaria",
            skillName: "Carrera Veloz",
            skillDescription: "Aumenta la velocidad al esprintar en un 6%. Crucial para rotaciones rápidas y eludir la zona segura de Bermuda.",
            skillIcon: "figure.run",
            level: 6,
            bio: "Atleta destacada de pista y campo. Su agilidad legendaria fue pilar en todas las partidas competitivas de 2019.",
            isSelected: false,
            color: Color(red: 0.95, green: 0.75, blue: 0.1)
        ),
        FFCharacter(
            id: "char_kla",
            name: "Kla",
            title: "Luchador de Muay Thai",
            skillName: "Muay Thai",
            skillDescription: "El daño con los puños aumenta en un 400% (hasta 550 de daño en la cabeza).",
            skillIcon: "hand.raised.fill",
            level: 6,
            bio: "Un artista marcial supremo. El rey indiscutible de las peleas a puño limpio en el techo de Factory.",
            isSelected: false,
            color: Color(red: 0.9, green: 0.3, blue: 0.1)
        ),
        FFCharacter(
            id: "char_andrew",
            name: "Andrew",
            title: "Oficial de Policía",
            skillName: "Especialista en Armadura",
            skillDescription: "La pérdida de durabilidad del chaleco se reduce en un 12%. Resiste ráfagas prolongadas de fuego enemigo.",
            skillIcon: "shield.checkerboard",
            level: 6,
            bio: "Ex oficial de policía con una devoción inquebrantable a la justicia. Su chaleco resiste donde otros caen.",
            isSelected: false,
            color: Color(red: 0.2, green: 0.45, blue: 0.75)
        ),
        FFCharacter(
            id: "char_paloma",
            name: "Paloma",
            title: "Traficante de Armas",
            skillName: "Traficante de Armas",
            skillDescription: "180 municiones de fusil de asalto (AR) no ocupan espacio en la mochila.",
            skillIcon: "briefcase.fill",
            level: 6,
            bio: "La soberana del bajo mundo del tráfico de armas. Permite cargar cantidades masivas de balas y botiquines.",
            isSelected: false,
            color: Color(red: 0.7, green: 0.3, blue: 0.6)
        ),
        FFCharacter(
            id: "char_maxim",
            name: "Maxim",
            title: "Glotón Veloz",
            skillName: "Gula",
            skillDescription: "Reduce el tiempo necesario para consumir botiquines y comer hongos en un 12%.",
            skillIcon: "fork.knife",
            level: 6,
            bio: "Hermano de Misha y amante de los concursos de comida. Se cura en medio del tiroteo a una velocidad relámpago.",
            isSelected: false,
            color: Color(red: 0.3, green: 0.7, blue: 0.4)
        ),
        FFCharacter(
            id: "char_caroline",
            name: "Caroline",
            title: "Consentida del Instituto",
            skillName: "Agilidad",
            skillDescription: "Al sostener una escopeta (M1014/SPAS12), la velocidad de movimiento aumenta un 8%.",
            skillIcon: "hare.fill",
            level: 6,
            bio: "Hija mimada de un magnate y mejor amiga de Kelly. Experta en rusheo con escopeta a corta distancia.",
            isSelected: false,
            color: Color(red: 0.95, green: 0.5, blue: 0.7)
        ),
        FFCharacter(
            id: "char_laura",
            name: "Laura",
            title: "Tiradora de Élite",
            skillName: "Tiradora Afilada",
            skillDescription: "La precisión del arma aumenta en un 35% al apuntar a través de la mira telescópica.",
            skillIcon: "scope",
            level: 6,
            bio: "Agente especial entrenada desde la infancia. Con la mira puesta, sus disparos son quirúrgicos y letales.",
            isSelected: false,
            color: Color(red: 0.2, green: 0.65, blue: 0.65)
        ),
        FFCharacter(
            id: "char_rafael",
            name: "Rafael",
            title: "Asesino Silencioso",
            skillName: "Muerte Silenciosa",
            skillDescription: "Los disparos con cualquier arma no son mostrados en el minimapa de los enemigos durante 8 segundos.",
            skillIcon: "speaker.slash.fill",
            level: 6,
            bio: "Un sicario letal decidido a traer justicia a su manera sin dejar rastro de sus disparos.",
            isSelected: false,
            color: Color(red: 0.15, green: 0.2, blue: 0.25)
        ),
        FFCharacter(
            id: "char_adan",
            name: "Adán",
            title: "El Pionero de Bermuda",
            skillName: "Sin Habilidad (Veterano Puro)",
            skillDescription: "El personaje original con el que todo comenzó en 2019. Símbolo del estatus OG y la habilidad pura sin ayudas pasivas.",
            skillIcon: "person.fill",
            level: 6,
            bio: "El primer hombre en pisar la isla de Bermuda. No posee habilidades adicionales, pero representa la época dorada de Free Fire.",
            isSelected: false,
            color: Color(red: 0.85, green: 0.65, blue: 0.2)
        ),
        FFCharacter(
            id: "char_eva",
            name: "Eva",
            title: "La Primera Sobreviviente",
            skillName: "Sin Habilidad (Veterana Pura)",
            skillDescription: "La contraparte femenina original de Adán. Pura habilidad mecánica sin ventajas externas.",
            skillIcon: "person.crop.circle.fill",
            level: 6,
            bio: "La primera mujer de Bermuda. Icono clásico del lanzamiento del juego.",
            isSelected: false,
            color: Color(red: 0.85, green: 0.5, blue: 0.5)
        ),
        FFCharacter(
            id: "char_ford",
            name: "Ford",
            title: "Oficial Naval",
            skillName: "Voluntad de Hierro",
            skillDescription: "Reduce el daño recibido cuando se encuentra fuera de la zona segura en un 24%.",
            skillIcon: "shield.fill",
            level: 6,
            bio: "Un oficial de la marina que soportó el rigor del mar abierto. Permite sobrevivir y curarse dentro del gas tóxico.",
            isSelected: false,
            color: Color(red: 0.3, green: 0.4, blue: 0.5)
        )
    ]
}
