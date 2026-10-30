import SwiftUI

struct LobbyView: View {
    @ObservedObject var userState = UserState.shared
    
    // Navigation Sheets
    @State private var showStore = false
    @State private var showVault = false
    @State private var showLuckRoyale = false
    @State private var showArmory = false
    @State private var showCharacters = false
    @State private var showPets = false
    @State private var showSettings = false
    @State private var showElitePass = false
    @State private var showEmoteWheel = false
    @State private var activeEmoteText: String? = nil
    
    // Matchmaking & Game State
    @State private var isStartingMatch = false
    @State private var matchTimer = 3
    @State private var isInGame = false
    @State private var matchMode = "BERMUDA - CLÁSICO"
    @State private var teamType = "SOLO"
    
    @State private var equippedWeapon: Weapon = Weapon.classic2019Weapons[0]
    
    var currentCharacter: FFCharacter {
        FFCharacter.classic2019Characters.first { $0.id == userState.equippedCharacterId } ?? FFCharacter.classic2019Characters[0]
    }
    
    var body: some View {
        ZStack {
            if isInGame {
                GameplayView(
                    equippedWeapon: equippedWeapon,
                    selectedCharacter: currentCharacter,
                    onExitToLobby: {
                        isInGame = false
                        isStartingMatch = false
                    }
                )
                .transition(.opacity)
            } else {
                lobbyContent
            }
        }
        .fullScreenCover(isPresented: $showStore) {
            StoreView()
        }
        .fullScreenCover(isPresented: $showVault) {
            VaultView()
        }
        .fullScreenCover(isPresented: $showLuckRoyale) {
            LuckRoyaleView()
        }
        .fullScreenCover(isPresented: $showArmory) {
            ArmoryView(selectedWeapon: $equippedWeapon)
        }
        .fullScreenCover(isPresented: $showCharacters) {
            CharactersView()
        }
        .fullScreenCover(isPresented: $showPets) {
            PetsView()
        }
        .fullScreenCover(isPresented: $showSettings) {
            Settings2019View()
        }
    }
    
    // MARK: - Main Lobby Content
    private var lobbyContent: some View {
        ZStack {
            // Classic 2019 Hangar / Bermuda Outpost Backdrop
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.14, green: 0.17, blue: 0.22),
                        Color(red: 0.08, green: 0.1, blue: 0.14),
                        Color(red: 0.03, green: 0.04, blue: 0.06)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                // Yellow Spotlight Glow (Authentic 2019 Hangar lighting)
                RadialGradient(
                    gradient: Gradient(colors: [FreeFireTheme.gold.opacity(0.18), Color.clear]),
                    center: .center,
                    startRadius: 40,
                    endRadius: 400
                )
                .ignoresSafeArea()
                
                // Floor Shadow
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(LinearGradient(colors: [Color.black.opacity(0.65), Color.black], startPoint: .top, endPoint: .bottom))
                        .frame(height: 150)
                }
                .ignoresSafeArea()
            }
            
            // Center: 3D Character Model with Equipped 2019 Cosmetics & Weapon
            VStack {
                Spacer()
                
                ZStack {
                    // Golden Pedestal Reflection
                    Ellipse()
                        .fill(RadialGradient(colors: [FreeFireTheme.gold.opacity(0.4), Color.clear], center: .center, startRadius: 10, endRadius: 160))
                        .frame(width: 300, height: 45)
                        .offset(y: 120)
                    
                    // Emote Speech Banner above player
                    if let emote = activeEmoteText {
                        Text(emote)
                            .font(.system(size: 13, weight: .black))
                            .foregroundColor(.black)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 6)
                            .background(FreeFireTheme.gold)
                            .cornerRadius(8)
                            .offset(y: -140)
                            .transition(.scale)
                    }
                    
                    // Character Visual Stance with Equipped Clothing
                    HStack(alignment: .bottom, spacing: 20) {
                        // Character Body
                        VStack(spacing: 2) {
                            // Head / Mask (e.g. Sakura Oni Mask or Hip Hop Cap)
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.92, green: 0.75, blue: 0.6))
                                    .frame(width: 36, height: 36)
                                
                                Image(systemName: userState.equippedHead.contains("sakura") ? "theatermasks.fill" : userState.equippedHead.contains("hiphop") ? "hat.widebrim.fill" : "person.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(userState.equippedHead.contains("sakura") ? .white : .yellow)
                            }
                            
                            // Top / Torso (e.g. Sakura Kimono or Hip Hop Jacket)
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(
                                        userState.equippedTop.contains("sakura") ? Color(red: 0.85, green: 0.35, blue: 0.5) :
                                        userState.equippedTop.contains("hiphop") ? Color.yellow :
                                        userState.equippedTop.contains("criminal") ? Color.red : Color(red: 0.3, green: 0.4, blue: 0.3)
                                    )
                                    .frame(width: 58, height: 65)
                                    .overlay(
                                        Image(systemName: "shield.fill")
                                            .font(.system(size: 24))
                                            .foregroundColor(.white.opacity(0.4))
                                    )
                                
                                // Equipped Weapon held in hands
                                Image(systemName: equippedWeapon.iconSystemName)
                                    .font(.system(size: 24))
                                    .foregroundColor(FreeFireTheme.gold)
                                    .shadow(color: FreeFireTheme.gold.opacity(0.8), radius: 6)
                                    .offset(x: 20, y: -6)
                            }
                            
                            // Pants (e.g. Angelic Pants or Samurai Pants)
                            HStack(spacing: 4) {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(userState.equippedPants.contains("angelic") ? Color(red: 0.1, green: 0.25, blue: 0.55) : Color(white: 0.18))
                                    .frame(width: 22, height: 50)
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(userState.equippedPants.contains("angelic") ? Color(red: 0.1, green: 0.25, blue: 0.55) : Color(white: 0.18))
                                    .frame(width: 22, height: 50)
                            }
                            
                            // Shoes
                            HStack(spacing: 8) {
                                RoundedRectangle(cornerRadius: 2).fill(Color.red).frame(width: 20, height: 8)
                                RoundedRectangle(cornerRadius: 2).fill(Color.red).frame(width: 20, height: 8)
                            }
                        }
                        
                        // Equipped Pet standing alongside!
                        VStack(spacing: 2) {
                            ZStack {
                                Circle()
                                    .fill(Color.black.opacity(0.5))
                                    .frame(width: 36, height: 36)
                                Image(systemName: userState.equippedPetId.contains("shiba") ? "pawprint.circle.fill" : userState.equippedPetId.contains("kitty") ? "cat.fill" : "dog.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.orange)
                            }
                            Text(userState.equippedPetId.replacingOccurrences(of: "pet_", with: "").uppercased())
                                .font(.system(size: 8, weight: .black))
                                .foregroundColor(.white)
                        }
                        .offset(y: -10)
                    }
                    
                    // Character Title Tag
                    Text("\(currentCharacter.name.uppercased()) • \(currentCharacter.skillName.uppercased())")
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.black.opacity(0.8))
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(FreeFireTheme.gold, lineWidth: 1))
                        .cornerRadius(4)
                        .offset(y: 115)
                }
                
                Spacer().frame(height: 50)
            }
            
            // MARK: - UI Overlay
            VStack(spacing: 0) {
                topNavigationBar
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    leftMenuButtons
                    
                    // Emote Action Button in Bottom Center
                    Button(action: {
                        showEmoteWheel.toggle()
                        SoundManager.shared.playButtonClick()
                    }) {
                        VStack(spacing: 2) {
                            Image(systemName: "face.smiling.fill")
                                .font(.system(size: 18))
                            Text("EMOTE")
                                .font(.system(size: 9, weight: .black))
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(FreeFireTheme.gold)
                        .clipShape(Capsule())
                    }
                    .padding(.bottom, 16)
                    
                    Spacer()
                    
                    rightMatchControls
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 14)
            }
            
            // Emote Wheel Popup
            if showEmoteWheel {
                emoteWheelOverlay
            }
            
            // Matchmaking Loading Overlay
            if isStartingMatch {
                matchmakingOverlay
            }
        }
    }
    
    // MARK: - Top Nav Bar
    private var topNavigationBar: some View {
        HStack(spacing: 12) {
            // Player Profile Tag (Heroico 2019)
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(FreeFireTheme.gold)
                        .frame(width: 44, height: 44)
                    Image(systemName: "crown.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.black)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text(userState.playerName)
                            .font(.system(size: 14, weight: .black))
                            .foregroundColor(.white)
                        Text("LV.\(userState.playerLevel)")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(FreeFireTheme.gold)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 1)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(3)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 9))
                            .foregroundColor(.yellow)
                        Text("\(userState.rankName) - \(userState.rankScore) PTS")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.yellow)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.black.opacity(0.55))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(FreeFireTheme.gold.opacity(0.5), lineWidth: 1))
            
            Spacer()
            
            // Currency Indicators
            HStack(spacing: 10) {
                // Gold
                Button(action: { showStore = true }) {
                    HStack(spacing: 4) {
                        Image(systemName: "bitcoinsign.circle.fill").foregroundColor(.yellow)
                        Text("\(userState.gold)").font(.system(size: 13, weight: .heavy)).foregroundColor(.white)
                        Image(systemName: "plus.circle.fill").font(.system(size: 11)).foregroundColor(FreeFireTheme.gold)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(6)
                }
                
                // Diamonds
                Button(action: { showStore = true }) {
                    HStack(spacing: 4) {
                        Image(systemName: "diamond.fill").foregroundColor(.cyan)
                        Text("\(userState.diamonds)").font(.system(size: 13, weight: .heavy)).foregroundColor(.white)
                        Image(systemName: "plus.circle.fill").font(.system(size: 11)).foregroundColor(FreeFireTheme.gold)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(6)
                }
            }
            
            // Settings Button
            Button(action: {
                showSettings = true
                SoundManager.shared.playButtonClick()
            }) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 10)
    }
    
    // MARK: - Left Menu Buttons
    private var leftMenuButtons: some View {
        VStack(alignment: .leading, spacing: 8) {
            menuButton(title: "TIENDA", icon: "cart.fill", color: .yellow) {
                showStore = true
            }
            menuButton(title: "LUCK ROYALE", icon: "crown.fill", color: FreeFireTheme.gold) {
                showLuckRoyale = true
            }
            menuButton(title: "BÓVEDA", icon: "archivebox.fill", color: .orange) {
                showVault = true
            }
            menuButton(title: "ARMERÍA", icon: "cross.vial.fill", color: .cyan) {
                showArmory = true
            }
            menuButton(title: "PERSONAJES", icon: "person.3.fill", color: .pink) {
                showCharacters = true
            }
            menuButton(title: "MASCOTAS", icon: "pawprint.fill", color: .green) {
                showPets = true
            }
            menuButton(title: "PASE ÉLITE", icon: "flame.fill", color: FreeFireTheme.bloodRed) {
                showVault = true
            }
        }
    }
    
    private func menuButton(title: String, icon: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
            SoundManager.shared.playButtonClick()
        }) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .black))
                    .foregroundColor(color)
                    .frame(width: 18)
                
                Text(title)
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .frame(width: 130)
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .background(Color.black.opacity(0.7))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(color.opacity(0.6), lineWidth: 1)
            )
            .cornerRadius(6)
        }
    }
    
    // MARK: - Right Match Controls
    private var rightMatchControls: some View {
        VStack(alignment: .trailing, spacing: 8) {
            // Mode Select
            VStack(alignment: .trailing, spacing: 2) {
                Text("MODO SELECCIONADO")
                    .font(.system(size: 8, weight: .black))
                    .foregroundColor(.gray)
                
                HStack(spacing: 6) {
                    Image(systemName: "map.fill")
                        .font(.system(size: 12))
                        .foregroundColor(FreeFireTheme.gold)
                    Text(matchMode)
                        .font(.system(size: 13, weight: .black))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.black.opacity(0.65))
                .cornerRadius(6)
            }
            
            // Solo / Duo / Squad selector
            HStack(spacing: 4) {
                ForEach(["SOLO", "DÚO", "ESCUADRA"], id: \.self) { type in
                    Button(action: {
                        teamType = type
                        SoundManager.shared.playButtonClick()
                    }) {
                        Text(type)
                            .font(.system(size: 10, weight: .heavy))
                            .foregroundColor(teamType == type ? .black : .white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(teamType == type ? FreeFireTheme.gold : Color.black.opacity(0.6))
                            .cornerRadius(4)
                    }
                }
            }
            
            // Big INICIAR Button
            Button(action: {
                startMatchmaking()
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "play.fill")
                        .font(.system(size: 18, weight: .black))
                    Text("INICIAR")
                        .font(.system(size: 22, weight: .black))
                }
                .foregroundColor(.black)
                .frame(width: 190, height: 52)
                .background(
                    LinearGradient(
                        colors: [Color(red: 1.0, green: 0.85, blue: 0.0), FreeFireTheme.gold, Color(red: 0.9, green: 0.55, blue: 0.0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(8)
                .shadow(color: FreeFireTheme.gold.opacity(0.6), radius: 10, y: 3)
            }
        }
    }
    
    // MARK: - Emote Wheel
    private var emoteWheelOverlay: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            
            VStack(spacing: 14) {
                Text("EMOTES CLÁSICOS 2019")
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(FreeFireTheme.gold)
                
                HStack(spacing: 14) {
                    emoteButton(name: "Risa", icon: "face.smiling.inverse")
                    emoteButton(name: "Aplauso", icon: "hands.clap.fill")
                    emoteButton(name: "Provocación", icon: "hand.raised.slash.fill")
                    emoteButton(name: "Saludo", icon: "hand.wave.fill")
                    emoteButton(name: "Trono", icon: "crown.fill")
                }
                
                Button("CERRAR") {
                    showEmoteWheel = false
                }
                .font(.system(size: 12, weight: .black))
                .foregroundColor(.white)
                .padding(.top, 6)
            }
            .padding(20)
            .background(Color(white: 0.12))
            .cornerRadius(12)
        }
    }
    
    private func emoteButton(name: String, icon: String) -> some View {
        Button(action: {
            activeEmoteText = "Emote: \(name)!"
            showEmoteWheel = false
            FreeFireTheme.booyahVictoryHaptic()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                activeEmoteText = nil
            }
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(FreeFireTheme.gold)
                Text(name)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(width: 65, height: 65)
            .background(Color.black.opacity(0.5))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(FreeFireTheme.gold.opacity(0.5), lineWidth: 1))
        }
    }
    
    // MARK: - Matchmaking Overlay
    private var matchmakingOverlay: some View {
        ZStack {
            Color.black.opacity(0.85).ignoresSafeArea()
            
            VStack(spacing: 16) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: FreeFireTheme.gold))
                    .scaleEffect(1.8)
                
                Text("EMPAREJANDO EN BERMUDA...")
                    .font(.system(size: 18, weight: .black))
                    .foregroundColor(FreeFireTheme.gold)
                
                Text("Bermuda Clásica • 50 Jugadores")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
                
                Text("00:0\(matchTimer)")
                    .font(.system(size: 26, weight: .heavy, design: .monospaced))
                    .foregroundColor(.white)
                
                Button("CANCELAR") {
                    isStartingMatch = false
                }
                .font(.system(size: 12, weight: .heavy))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.2))
                .cornerRadius(6)
            }
        }
    }
    
    private func startMatchmaking() {
        SoundManager.shared.playButtonClick()
        isStartingMatch = true
        matchTimer = 3
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if matchTimer > 1 {
                matchTimer -= 1
            } else {
                timer.invalidate()
                isStartingMatch = false
                isInGame = true
            }
        }
    }
}
