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
            id: "char_adan",
            name: "Adán",
            title: "El Pionero de Bermuda",
            skillName: "Sin Habilidad (Veterano Puro)",
            skillDescription: "El personaje original con el que todo comenzó en 2019. Símbolo de habilidad pura sin ventajas pasivas.",
            skillIcon: "person.fill",
            level: 6,
            bio: "El primer hombre en pisar la isla de Bermuda. No posee habilidades adicionales, pero representa la época dorada de Free Fire.",
            isSelected: true,
            color: Color(red: 0.85, green: 0.65, blue: 0.2)
        ),
        FFCharacter(
            id: "char_kelly",
            name: "Kelly",
            title: "Velocista de Secundaria",
            skillName: "Carrera Veloz",
            skillDescription: "Aumenta la velocidad al esprintar en un 6%. Ideal para rotaciones rápidas y escapar de la zona segura.",
            skillIcon: "figure.run",
            level: 6,
            bio: "Una estudiante de secundaria y atleta de pista. Su velocidad la convirtió en uno de los personajes más utilizados en 2019.",
            isSelected: false,
            color: Color(red: 0.95, green: 0.75, blue: 0.1)
        ),
        FFCharacter(
            id: "char_andrew",
            name: "Andrew",
            title: "Oficial de Policía",
            skillName: "Especialista en Armadura",
            skillDescription: "La pérdida de durabilidad del chaleco se reduce en un 12%. Resiste más fuego enemigo en combate cuerpo a cuerpo.",
            skillIcon: "shield.checkerboard",
            level: 6,
            bio: "Un ex policía con un fuerte sentido de la justicia. Su chaleco dura significativamente más en tiroteos prolongados.",
            isSelected: false,
            color: Color(red: 0.2, green: 0.4, blue: 0.8)
        ),
        FFCharacter(
            id: "char_eva",
            name: "Eva",
            title: "La Primera Guerrera",
            skillName: "Sin Habilidad (Clásica)",
            skillDescription: "El personaje femenino clásico de 2019. Amada por la comunidad veterana por su diseño sobrio y limpio.",
            skillIcon: "person.fill",
            level: 6,
            bio: "Compañera inseparable de Adán en los primeros días del battle royale.",
            isSelected: false,
            color: Color(red: 0.8, green: 0.4, blue: 0.5)
        ),
        FFCharacter(
            id: "char_ford",
            name: "Ford",
            title: "Oficial de la Marina",
            skillName: "Voluntad de Hierro",
            skillDescription: "Reduce el daño recibido fuera de la zona segura en un 20%. Excelente para sobrevivir al gas tóxico.",
            skillIcon: "drop.triangle.fill",
            level: 6,
            bio: "Un marinero curtido por el mar que sabe resistir bajo condiciones extremas.",
            isSelected: false,
            color: Color(red: 0.3, green: 0.6, blue: 0.4)
        )
    ]
}

