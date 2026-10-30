import SwiftUI

struct CharactersView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userState = UserState.shared
    @State private var characters: [FFCharacter] = FFCharacter.classic2019Characters
    @State private var selectedId: String = "char_hayato"
    
    var activeCharacter: FFCharacter {
        characters.first { $0.id == selectedId } ?? characters[0]
    }
    
    var body: some View {
        ZStack {
            FreeFireTheme.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Navigation Bar
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
                    
                    Text("PERSONAJES Y HABILIDADES 2019")
                        .font(.system(size: 18, weight: .black))
                        .foregroundColor(FreeFireTheme.gold)
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        HStack(spacing: 4) {
                            Image(systemName: "bitcoinsign.circle.fill")
                                .foregroundColor(.yellow)
                            Text("\(userState.gold)")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(4)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "diamond.fill")
                                .foregroundColor(.cyan)
                            Text("\(userState.diamonds)")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(4)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(FreeFireTheme.secondaryDark)
                
                // Main Content
                HStack(spacing: 16) {
                    // Left list of characters
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 8) {
                            ForEach(characters) { character in
                                Button(action: {
                                    selectedId = character.id
                                    SoundManager.shared.playButtonClick()
                                }) {
                                    HStack(spacing: 12) {
                                        ZStack {
                                            Circle()
                                                .fill(character.id == selectedId ? FreeFireTheme.gold : Color.gray.opacity(0.3))
                                                .frame(width: 40, height: 40)
                                            Image(systemName: character.skillIcon)
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundColor(character.id == selectedId ? .black : .white)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(character.name)
                                                .font(.system(size: 14, weight: .black))
                                                .foregroundColor(character.id == selectedId ? FreeFireTheme.gold : .white)
                                            Text(character.title)
                                                .font(.system(size: 10))
                                                .foregroundColor(.gray)
                                                .lineLimit(1)
                                        }
                                        
                                        Spacer()
                                        
                                        if userState.equippedCharacterId == character.id {
                                            Text("EN USO")
                                                .font(.system(size: 8, weight: .black))
                                                .padding(.horizontal, 6)
                                                .padding(.vertical, 3)
                                                .background(FreeFireTheme.gold)
                                                .foregroundColor(.black)
                                                .cornerRadius(3)
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 8)
                                    .background(character.id == selectedId ? Color.white.opacity(0.12) : Color.black.opacity(0.3))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(character.id == selectedId ? FreeFireTheme.gold : Color.clear, lineWidth: 1.5)
                                    )
                                    .cornerRadius(6)
                                }
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    .frame(width: 250)
                    
                    // Right detail panel
                    VStack(alignment: .leading, spacing: 14) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(activeCharacter.name)
                                    .font(.system(size: 28, weight: .black))
                                    .foregroundColor(.white)
                                Text(activeCharacter.title)
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(FreeFireTheme.gold)
                            }
                            
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(LinearGradient(colors: [activeCharacter.color.opacity(0.4), Color.black], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 70, height: 70)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(activeCharacter.color, lineWidth: 1.5))
                                
                                Image(systemName: activeCharacter.skillIcon)
                                    .font(.system(size: 34))
                                    .foregroundColor(activeCharacter.color)
                            }
                        }
                        
                        Divider().background(Color.white.opacity(0.15))
                        
                        // Skill box
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Image(systemName: "bolt.fill")
                                    .foregroundColor(FreeFireTheme.gold)
                                Text("HABILIDAD:")
                                    .font(.system(size: 11, weight: .black))
                                    .foregroundColor(.gray)
                                Text(activeCharacter.skillName)
                                    .font(.system(size: 13, weight: .black))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("NIVEL 6 (MÁX)")
                                    .font(.system(size: 9, weight: .heavy))
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(FreeFireTheme.bloodRed)
                                    .foregroundColor(.white)
                                    .cornerRadius(3)
                            }
                            
                            Text(activeCharacter.skillDescription)
                                .font(.system(size: 12))
                                .foregroundColor(.white.opacity(0.9))
                                .padding(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.black.opacity(0.35))
                                .cornerRadius(6)
                        }
                        
                        // Skill combination slots (2019 feature)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("RANURAS DE HABILIDADES ADICIONALES:")
                                .font(.system(size: 10, weight: .black))
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 12) {
                                skillSlotBadge(title: "Kelly", icon: "figure.run", desc: "+6% Sprint")
                                skillSlotBadge(title: "Andrew", icon: "shield.checkerboard", desc: "Durabilidad Chaleco")
                                skillSlotBadge(title: "Kla", icon: "hand.raised.fill", desc: "+400% Puño")
                            }
                        }
                        
                        Spacer()
                        
                        // Equip button
                        Button(action: {
                            userState.equippedCharacterId = activeCharacter.id
                            SoundManager.shared.playButtonClick()
                            FreeFireTheme.booyahVictoryHaptic()
                        }) {
                            Text(userState.equippedCharacterId == activeCharacter.id ? "EQUIPADO" : "ELEGIR PERSONAJE")
                                .font(.system(size: 14, weight: .black))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(userState.equippedCharacterId == activeCharacter.id ? Color.gray : FreeFireTheme.gold)
                                .cornerRadius(8)
                        }
                    }
                    .padding(16)
                    .background(Color.white.opacity(0.04))
                    .cornerRadius(8)
                }
                .padding(14)
            }
        }
    }
    
    private func skillSlotBadge(title: String, icon: String, desc: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(FreeFireTheme.gold)
            VStack(alignment: .leading, spacing: 1) {
                Text(title)
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(.white)
                Text(desc)
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(Color.black.opacity(0.5))
        .cornerRadius(6)
        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white.opacity(0.1), lineWidth: 1))
    }
}
