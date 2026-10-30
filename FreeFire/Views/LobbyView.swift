import SwiftUI

struct LobbyView: View {
    @State private var showArmory = false
    @State private var showCharacters = false
    @State private var showSettings = false
    @State private var isStartingMatch = false
    @State private var matchTimer = 3
    @State private var isInGame = false
    @State private var matchMode = "CLÁSICO - BERMUDA"
    @State private var teamType = "SOLO"
    @State private var selectedCharacterName = "Adán"
    @State private var equippedWeapon: Weapon = Weapon.classic2019Weapons[0]
    @State private var selectedCharacter: FFCharacter = FFCharacter.classic2019Characters[0]
    
    var body: some View {
        ZStack {
            if isInGame {
                GameplayView(
                    equippedWeapon: equippedWeapon,
                    selectedCharacter: selectedCharacter,
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
        .fullScreenCover(isPresented: $showArmory) {
            ArmoryView(selectedWeapon: $equippedWeapon)
        }
        .fullScreenCover(isPresented: $showCharacters) {
            CharactersView()
        }
        .fullScreenCover(isPresented: $showSettings) {
            Settings2019View()
        }
    }
    
    // MARK: - Main Lobby Content
    private var lobbyContent: some View {
        ZStack {
            // Background: classic 2019 hangar / Bermuda outpost
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.12, green: 0.14, blue: 0.18),
                        Color(red: 0.08, green: 0.09, blue: 0.12),
                        Color(red: 0.04, green: 0.05, blue: 0.07)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                // Classic military spotlight beam
                RadialGradient(
                    gradient: Gradient(colors: [Color.yellow.opacity(0.12), Color.clear]),
                    center: .center,
                    startRadius: 50,
                    endRadius: 360
                )
                .ignoresSafeArea()
                
                // Floor shadow & hangar grid
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(LinearGradient(colors: [Color.black.opacity(0.6), Color.black], startPoint: .top, endPoint: .bottom))
                        .frame(height: 140)
                }
                .ignoresSafeArea()
            }
            
            // Center: Character 3D representation
            VStack {
                Spacer()
                
                ZStack {
                    // Pedestal glow
                    Ellipse()
                        .fill(RadialGradient(colors: [FreeFireTheme.gold.opacity(0.35), Color.clear], center: .center, startRadius: 10, endRadius: 140))
                        .frame(width: 280, height: 40)
                        .offset(y: 110)
                    
                    // 2019 Character silhouette & gear
                    VStack(spacing: 0) {
                        Image(systemName: "figure.stand")
                            .font(.system(size: 160))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color(red: 0.95, green: 0.75, blue: 0.4), Color(red: 0.45, green: 0.35, blue: 0.25)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .shadow(color: FreeFireTheme.gold.opacity(0.5), radius: 16)
                            .overlay(
                                // Gun held across chest
                                Image(systemName: "shield.fill")
                                    .font(.system(size: 26))
                                    .foregroundColor(.white.opacity(0.4))
                                    .offset(y: -10)
                            )
                        
                        Text(selectedCharacterName.uppercased())
                            .font(.system(size: 14, weight: .black))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(Color.black.opacity(0.75))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(FreeFireTheme.gold, lineWidth: 1)
                            )
                            .cornerRadius(4)
                            .offset(y: -10)
                    }
                }
                
                Spacer().frame(height: 50)
            }
            
            // UI Overlay
            VStack(spacing: 0) {
                topNavigationBar
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    leftMenuButtons
                    Spacer()
                    rightMatchControls
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
            
            // Matchmaking overlay
            if isStartingMatch {
                matchmakingOverlay
            }
        }
    }
    
    // MARK: - Top Nav Bar
    private var topNavigationBar: some View {
        HStack(spacing: 14) {
            // Player Profile Tag
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(FreeFireTheme.gold)
                        .frame(width: 44, height: 44)
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.black)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text("VETERANO_2019")
                            .font(.system(size: 14, weight: .black))
                            .foregroundColor(.white)
                        Text("LV.45")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(FreeFireTheme.gold)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(3)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.cyan)
                        Text("DIAMANTE I - 2450 PTS")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.cyan)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.black.opacity(0.4))
            .cornerRadius(8)
            
            Spacer()
            
            // Currency
            HStack(spacing: 12) {
                HStack(spacing: 6) {
                    Image(systemName: "bitcoinsign.circle.fill")
                        .foregroundColor(.yellow)
                    Text("35,420")
                        .font(.system(size: 13, weight: .heavy))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.black.opacity(0.5))
                .cornerRadius(6)
                
                HStack(spacing: 6) {
                    Image(systemName: "diamond.fill")
                        .foregroundColor(.cyan)
                    Text("1,250")
                        .font(.system(size: 13, weight: .heavy))
                        .foregroundColor(.white)
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.black)
                            .padding(4)
                            .background(FreeFireTheme.gold)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.black.opacity(0.5))
                .cornerRadius(6)
            }
            
            // Settings Button
            Button(action: {
                showSettings = true
                SoundManager.shared.playButtonClick()
            }) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.black.opacity(0.5))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }
    
    // MARK: - Left Menu Buttons
    private var leftMenuButtons: some View {
        VStack(alignment: .leading, spacing: 10) {
            menuButton(title: "ARMERÍA", icon: "cross.vial.fill", color: .yellow) {
                showArmory = true
            }
            
            menuButton(title: "PERSONAJES", icon: "person.3.fill", color: .cyan) {
                showCharacters = true
            }
            
            menuButton(title: "BÓVEDA", icon: "archivebox.fill", color: .orange) {
                SoundManager.shared.playButtonClick()
            }
            
            menuButton(title: "LUCK ROYALE", icon: "crown.fill", color: FreeFireTheme.gold) {
                SoundManager.shared.playButtonClick()
            }
            
            menuButton(title: "PASE ÉLITE", icon: "flame.fill", color: FreeFireTheme.bloodRed) {
                SoundManager.shared.playButtonClick()
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
                    .font(.system(size: 14, weight: .black))
                    .foregroundColor(color)
                    .frame(width: 20)
                
                Text(title)
                    .font(.system(size: 12, weight: .black))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .frame(width: 135)
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(Color.black.opacity(0.65))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(color.opacity(0.6), lineWidth: 1)
            )
            .cornerRadius(6)
        }
    }
    
    // MARK: - Right Match Controls
    private var rightMatchControls: some View {
        VStack(alignment: .trailing, spacing: 10) {
            // Mode Select
            VStack(alignment: .trailing, spacing: 4) {
                Text("MODO SELECCIONADO")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(.gray)
                
                HStack(spacing: 8) {
                    Image(systemName: "map.fill")
                        .foregroundColor(FreeFireTheme.gold)
                    Text(matchMode)
                        .font(.system(size: 14, weight: .black))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.black.opacity(0.6))
                .cornerRadius(6)
            }
            
            // Solo / Duo / Squad selector
            HStack(spacing: 6) {
                ForEach(["SOLO", "DÚO", "ESCUADRA"], id: \.self) { type in
                    Button(action: {
                        teamType = type
                        SoundManager.shared.playButtonClick()
                    }) {
                        Text(type)
                            .font(.system(size: 11, weight: .heavy))
                            .foregroundColor(teamType == type ? .black : .white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(teamType == type ? FreeFireTheme.gold : Color.black.opacity(0.6))
                            .cornerRadius(4)
                    }
                }
            }
            
            // Big INICIAR (START) Button
            Button(action: {
                startMatchmaking()
            }) {
                HStack(spacing: 12) {
                    Image(systemName: "play.fill")
                        .font(.system(size: 20, weight: .black))
                    Text("INICIAR")
                        .font(.system(size: 24, weight: .black))
                }
                .foregroundColor(.black)
                .frame(width: 200, height: 56)
                .background(
                    LinearGradient(
                        colors: [Color(red: 1.0, green: 0.85, blue: 0.0), FreeFireTheme.gold, Color(red: 0.9, green: 0.55, blue: 0.0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(10)
                .shadow(color: FreeFireTheme.gold.opacity(0.6), radius: 12, y: 4)
            }
        }
    }
    
    // MARK: - Matchmaking Overlay
    private var matchmakingOverlay: some View {
        ZStack {
            Color.black.opacity(0.85)
                .ignoresSafeArea()
            
            VStack(spacing: 18) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: FreeFireTheme.gold))
                    .scaleEffect(2.0)
                
                Text("BUSCANDO PARTIDA...")
                    .font(.system(size: 20, weight: .black))
                    .foregroundColor(FreeFireTheme.gold)
                
                Text("Bermuda 2019 - 50 Jugadores")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
                
                Text("00:0\(matchTimer)")
                    .font(.system(size: 28, weight: .heavy, design: .monospaced))
                    .foregroundColor(.white)
                
                Button(action: {
                    isStartingMatch = false
                }) {
                    Text("CANCELAR")
                        .font(.system(size: 13, weight: .heavy))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(6)
                }
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

