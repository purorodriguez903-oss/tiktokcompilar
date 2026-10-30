import SwiftUI

struct PetsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userState = UserState.shared
    
    struct PetModel: Identifiable {
        let id: String
        let name: String
        let skillName: String
        let skillDescription: String
        let iconName: String
        let color: Color
        let bio: String
    }
    
    let petsList: [PetModel] = [
        PetModel(
            id: "pet_shiba",
            name: "Shiba Inu",
            skillName: "Sentido del Hongo",
            skillDescription: "Marca en el minimapa la posición de los hongos circundantes cada 120 segundos.",
            iconName: "pawprint.circle.fill",
            color: Color(red: 0.85, green: 0.55, blue: 0.2),
            bio: "Un leal perro japonés de pelaje cobrizo. Su agudo olfato ayuda a localizar recursos vitales en Bermuda."
        ),
        PetModel(
            id: "pet_kitty",
            name: "Gatito Clásico",
            skillName: "Compañero Fiel (Sin habilidad)",
            skillDescription: "La primera mascota lanzada en Free Fire. No otorga ventajas pasivas pero realiza piruetas y ronroneos en el lobby.",
            iconName: "cat.fill",
            color: Color.orange,
            bio: "El gato que inició la era de las mascotas en Free Fire. Símbolo de ternura y estatus clásico."
        ),
        PetModel(
            id: "pet_mech_pup",
            name: "Perro Mecánico",
            skillName: "Compañero Cibernético",
            skillDescription: "Estructura blindada de titanio con ladridos electrónicos.",
            iconName: "dog.fill",
            color: Color.cyan,
            bio: "Creado en el laboratorio de alta tecnología de Mars Electric en Bermuda."
        ),
        PetModel(
            id: "pet_night_panther",
            name: "Pantera Nocturna",
            skillName: "Entrenamiento con Pesas",
            skillDescription: "Aumenta el espacio total de la mochila en 45 unidades.",
            iconName: "shield.righthalf.filled",
            color: Color.purple,
            bio: "Una fiera biomecánica sigilosa que amplía la capacidad de carga en tiroteos prolongados."
        )
    ]
    
    @State private var selectedPetId: String = "pet_shiba"
    
    var activePet: PetModel {
        petsList.first { $0.id == selectedPetId } ?? petsList[0]
    }
    
    var body: some View {
        ZStack {
            FreeFireTheme.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack(spacing: 16) {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14, weight: .bold))
                            Text("SALIR")
                                .font(.system(size: 14, weight: .black))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(6)
                    }
                    
                    HStack(spacing: 6) {
                        Image(systemName: "pawprint.fill")
                            .foregroundColor(FreeFireTheme.gold)
                        Text("MASCOTAS CLÁSICAS 2019")
                            .font(.system(size: 18, weight: .black))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(FreeFireTheme.secondaryDark)
                
                // Body
                HStack(spacing: 16) {
                    // Left: Pets list
                    VStack(spacing: 10) {
                        ForEach(petsList) { pet in
                            Button(action: {
                                selectedPetId = pet.id
                                SoundManager.shared.playButtonClick()
                            }) {
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(pet.id == selectedPetId ? FreeFireTheme.gold : Color.gray.opacity(0.3))
                                            .frame(width: 44, height: 44)
                                        Image(systemName: pet.iconName)
                                            .font(.system(size: 22))
                                            .foregroundColor(pet.id == selectedPetId ? .black : .white)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(pet.name)
                                            .font(.system(size: 14, weight: .black))
                                            .foregroundColor(pet.id == selectedPetId ? FreeFireTheme.gold : .white)
                                        Text(pet.skillName)
                                            .font(.system(size: 10))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    if userState.equippedPetId == pet.id {
                                        Text("EN USO")
                                            .font(.system(size: 9, weight: .black))
                                            .padding(.horizontal, 6)
                                            .padding(.vertical, 3)
                                            .background(FreeFireTheme.gold)
                                            .foregroundColor(.black)
                                            .cornerRadius(3)
                                    }
                                }
                                .padding(10)
                                .background(pet.id == selectedPetId ? Color.white.opacity(0.12) : Color.black.opacity(0.35))
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(pet.id == selectedPetId ? FreeFireTheme.gold : Color.clear, lineWidth: 1.5))
                            }
                        }
                        Spacer()
                    }
                    .frame(width: 250)
                    .padding(14)
                    
                    Divider().background(Color.white.opacity(0.12))
                    
                    // Right: Pet showcase
                    VStack(alignment: .leading, spacing: 14) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(activePet.name)
                                    .font(.system(size: 26, weight: .black))
                                    .foregroundColor(.white)
                                Text("NIVEL 7 (MÁXIMO)")
                                    .font(.system(size: 12, weight: .heavy))
                                    .foregroundColor(FreeFireTheme.gold)
                            }
                            Spacer()
                            Image(systemName: activePet.iconName)
                                .font(.system(size: 60))
                                .foregroundColor(activePet.color)
                        }
                        
                        Divider().background(Color.white.opacity(0.15))
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("HABILIDAD:")
                                .font(.system(size: 12, weight: .black))
                                .foregroundColor(.gray)
                            Text(activePet.skillName)
                                .font(.system(size: 14, weight: .black))
                                .foregroundColor(FreeFireTheme.gold)
                            Text(activePet.skillDescription)
                                .font(.system(size: 12))
                                .foregroundColor(.white.opacity(0.85))
                                .padding(10)
                                .background(Color.black.opacity(0.4))
                                .cornerRadius(6)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("HISTORIA:")
                                .font(.system(size: 12, weight: .black))
                                .foregroundColor(.gray)
                            Text(activePet.bio)
                                .font(.system(size: 12))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            userState.equippedPetId = activePet.id
                            SoundManager.shared.playButtonClick()
                            FreeFireTheme.glooWallHaptic()
                        }) {
                            Text(userState.equippedPetId == activePet.id ? "EQUIPADO" : "ELEGIR MASCOTA")
                                .font(.system(size: 14, weight: .black))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(userState.equippedPetId == activePet.id ? Color.gray : FreeFireTheme.gold)
                                .cornerRadius(8)
                        }
                    }
                    .padding(20)
                }
            }
        }
    }
}
