import SwiftUI

struct CharactersView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var characters: [FFCharacter] = FFCharacter.classic2019Characters
    @State private var selectedId: String = "char_adan"
    
    var activeCharacter: FFCharacter {
        characters.first { $0.id == selectedId } ?? characters[0]
    }
    
    var body: some View {
        ZStack {
            FreeFireTheme.backgroundDark
                .ignoresSafeArea()
            
            // Background military pattern
            VStack {
                HStack {
                    Image(systemName: "shield.lefthalf.filled")
                        .font(.system(size: 160))
                        .foregroundColor(Color.white.opacity(0.03))
                    Spacer()
                }
                Spacer()
            }
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Navigation Bar
                HStack(spacing: 16) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14, weight: .bold))
                            Text("VOLVER")
                                .font(.system(size: 14, weight: .heavy))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(6)
                    }
                    
                    Text("PERSONAJES CLÁSICOS 2019")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(FreeFireTheme.gold)
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        HStack(spacing: 4) {
                            Image(systemName: "bitcoinsign.circle.fill")
                                .foregroundColor(.yellow)
                            Text("35,420")
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
                            Text("1,250")
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
                        VStack(spacing: 10) {
                            ForEach(characters) { character in
                                Button(action: {
                                    selectedId = character.id
                                    SoundManager.shared.playButtonClick()
                                }) {
                                    HStack(spacing: 12) {
                                        ZStack {
                                            Circle()
                                                .fill(character.id == selectedId ? FreeFireTheme.gold : Color.gray.opacity(0.3))
                                                .frame(width: 44, height: 44)
                                            Image(systemName: character.skillIcon)
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(character.id == selectedId ? .black : .white)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(character.name)
                                                .font(.system(size: 15, weight: .black))
                                                .foregroundColor(character.id == selectedId ? FreeFireTheme.gold : .white)
                                            Text(character.title)
                                                .font(.system(size: 11, weight: .medium))
                                                .foregroundColor(.gray)
                                                .lineLimit(1)
                                        }
                                        
                                        Spacer()
                                        
                                        if character.isSelected {
                                            Text("EN USO")
                                                .font(.system(size: 9, weight: .black))
                                                .padding(.horizontal, 6)
                                                .padding(.vertical, 3)
                                                .background(FreeFireTheme.gold)
                                                .foregroundColor(.black)
                                                .cornerRadius(3)
                                        }
                                    }
                                    .padding(.horizontal, 12)
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
                        .padding(.vertical, 12)
                    }
                    .frame(width: 260)
                    
                    // Right detail panel
                    VStack(alignment: .leading, spacing: 14) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(activeCharacter.name)
                                    .font(.system(size: 32, weight: .black))
                                    .foregroundColor(.white)
                                Text(activeCharacter.title)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(FreeFireTheme.gold)
                            }
                            
                            Spacer()
                            
                            // 3D character badge preview
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(LinearGradient(colors: [FreeFireTheme.gold.opacity(0.3), Color.black], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 80, height: 80)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(FreeFireTheme.gold, lineWidth: 1)
                                    )
                                
                                Image(systemName: activeCharacter.skillIcon)
                                    .font(.system(size: 40))
                                    .foregroundColor(FreeFireTheme.gold)
                            }
                        }
                        
                        Divider().background(Color.white.opacity(0.15))
                        
                        // Skill box
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Image(systemName: "bolt.fill")
                                    .foregroundColor(FreeFireTheme.gold)
                                Text("HABILIDAD ESPECIAL:")
                                    .font(.system(size: 12, weight: .black))
                                    .foregroundColor(.gray)
                                Text(activeCharacter.skillName)
                                    .font(.system(size: 13, weight: .black))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("NIVEL \(activeCharacter.level) (MÁX)")
                                    .font(.system(size: 10, weight: .heavy))
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(FreeFireTheme.bloodRed)
                                    .foregroundColor(.white)
                                    .cornerRadius(3)
                            }
                            
                            Text(activeCharacter.skillDescription)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.white.opacity(0.85))
                                .padding(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.black.opacity(0.35))
                                .cornerRadius(6)
                        }
                        
                        // Biography
                        VStack(alignment: .leading, spacing: 4) {
                            Text("HISTORIA:")
                                .font(.system(size: 12, weight: .black))
                                .foregroundColor(.gray)
                            Text(activeCharacter.bio)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.white.opacity(0.75))
                        }
                        
                        Spacer()
                        
                        // Equip button
                        Button(action: {
                            for i in 0..<characters.count {
                                characters[i] = FFCharacter(
                                    id: characters[i].id,
                                    name: characters[i].name,
                                    title: characters[i].title,
                                    skillName: characters[i].skillName,
                                    skillDescription: characters[i].skillDescription,
                                    skillIcon: characters[i].skillIcon,
                                    level: characters[i].level,
                                    bio: characters[i].bio,
                                    isSelected: characters[i].id == selectedId,
                                    color: characters[i].color
                                )
                            }
                            SoundManager.shared.playButtonClick()
                        }) {
                            HStack {
                                Spacer()
                                Image(systemName: "checkmark.seal.fill")
                                Text(activeCharacter.isSelected ? "EQUIPADO" : "ELEGIR PERSONAJE")
                                    .font(.system(size: 16, weight: .black))
                                Spacer()
                            }
                            .foregroundColor(.black)
                            .padding(.vertical, 14)
                            .background(activeCharacter.isSelected ? Color.gray : FreeFireTheme.gold)
                            .cornerRadius(8)
                        }
                    }
                    .padding(16)
                    .background(Color.white.opacity(0.04))
                    .cornerRadius(8)
                }
                .padding(16)
            }
        }
    }
}

