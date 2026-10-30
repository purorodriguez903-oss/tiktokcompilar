import SwiftUI

struct LobbyView: View {
    @ObservedObject var userState = UserState.shared
    
    // Navigation Sheets
    @State private var showStore = false
    @State private var showInventory = false
    @State private var showLuckRoyale = false
    @State private var showArmory = false
    @State private var showSettings = false
    @State private var showEmoteWheel = false
    
    // Emote Animation in Lobby
    @State private var isDancing: Bool = false
    @State private var characterRotation: Double = 0.0
    @State private var activeEmoteBanner: String? = nil
    
    // Matchmaking State
    @State private var isStartingMatch: Bool = false
    @State private var matchTimer: Int = 3
    @State private var isInGame: Bool = false
    @State private var matchMode: String = "DE-CLASIFICATORIA"
    
    var body: some View {
        ZStack {
            if isInGame {
                GameplayView(
                    equippedWeapon: Weapon.classic2019Weapons[0],
                    selectedCharacter: FFCharacter.classic2019Characters[0],
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
        .fullScreenCover(isPresented: $showInventory) {
            VaultView()
        }
        .fullScreenCover(isPresented: $showLuckRoyale) {
            LuckRoyaleView()
        }
        .fullScreenCover(isPresented: $showArmory) {
            ArmoryView(selectedWeapon: .constant(Weapon.classic2019Weapons[0]))
        }
        .fullScreenCover(isPresented: $showSettings) {
            Settings2019View()
        }
    }
    
    // MARK: - Lobby Main Content
    private var lobbyContent: some View {
        ZStack {
            // Naruto Collab Konoha Landscape Backdrop (Exact match from user video ff2019_13.jpg)
            ZStack {
                // Sky & Distant Mountain Gradient
                LinearGradient(
                    colors: [
                        Color(red: 0.55, green: 0.65, blue: 0.75),
                        Color(red: 0.7, green: 0.6, blue: 0.55),
                        Color(red: 0.35, green: 0.3, blue: 0.25)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                // Hokage Monument Rock Carvings Silhouette
                HStack(spacing: 8) {
                    Spacer()
                    Image(systemName: "person.crop.artframe")
                        .font(.system(size: 80))
                        .foregroundColor(Color(red: 0.45, green: 0.38, blue: 0.3).opacity(0.35))
                    Image(systemName: "person.crop.artframe")
                        .font(.system(size: 95))
                        .foregroundColor(Color(red: 0.45, green: 0.38, blue: 0.3).opacity(0.4))
                    Image(systemName: "person.crop.artframe")
                        .font(.system(size: 90))
                        .foregroundColor(Color(red: 0.45, green: 0.38, blue: 0.3).opacity(0.35))
                    Spacer()
                }
                .offset(y: -50)
                
                // Japanese Pagoda / Ninja Rooftops
                HStack {
                    VStack {
                        Spacer()
                        Image(systemName: "tent.fill")
                            .font(.system(size: 130))
                            .foregroundColor(Color(red: 0.18, green: 0.28, blue: 0.28))
                            .offset(x: -80, y: 30)
                    }
                    Spacer()
                    VStack {
                        Spacer()
                        Image(systemName: "tent.fill")
                            .font(.system(size: 150))
                            .foregroundColor(Color(red: 0.18, green: 0.28, blue: 0.28))
                            .offset(x: 80, y: 20)
                    }
                }
                .ignoresSafeArea()
                
                // Modern Stone Arena Ground Platform with Orange Tribal Seal
                VStack {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 0.5, green: 0.48, blue: 0.45), Color(red: 0.2, green: 0.2, blue: 0.2)], startPoint: .top, endPoint: .bottom))
                            .frame(height: 140)
                        
                        // Konoha / Uzumaki Orange Spiral Seal on ground
                        Circle()
                            .stroke(Color.orange.opacity(0.7), lineWidth: 4)
                            .frame(width: 170, height: 60)
                            .scaleEffect(x: 1.5, y: 0.4)
                    }
                }
                .ignoresSafeArea()
            }
            
            // Center Character Model & Pet (Exact match to user's video: Cazador de Huesos + Katana + Sr. Waggor)
            VStack {
                Spacer()
                
                ZStack {
                    // Active Emote Speech Bubble
                    if let banner = activeEmoteBanner {
                        Text(banner)
                            .font(.system(size: 12, weight: .black))
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 5)
                            .background(FreeFireTheme.gold)
                            .cornerRadius(6)
                            .offset(y: -145)
                            .transition(.scale)
                    }
                    
                    HStack(alignment: .bottom, spacing: 18) {
                        // Character: Cyber Bone Set (Cazador de Huesos Booyah)
                        VStack(spacing: 0) {
                            // Spiky Yellow Fiery Hair & Gold Glasses
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.95, green: 0.8, blue: 0.2))
                                    .frame(width: 32, height: 32)
                                    .shadow(color: .yellow, radius: 10)
                                
                                Image(systemName: "flame.fill")
                                    .font(.system(size: 26))
                                    .foregroundColor(.yellow)
                                    .offset(y: -10)
                                
                                // Gold Visor
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.yellow)
                                    .frame(width: 20, height: 5)
                                    .offset(y: -2)
                            }
                            
                            // Torso: Cyber Bone Jacket with Golden Skeleton Ribs
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.black)
                                    .frame(width: 60, height: 68)
                                    .overlay(
                                        // Golden skeleton rib cage relief
                                        VStack(spacing: 3) {
                                            ForEach(0..<4) { _ in
                                                HStack(spacing: 4) {
                                                    RoundedRectangle(cornerRadius: 1).fill(Color.yellow).frame(width: 18, height: 4)
                                                    RoundedRectangle(cornerRadius: 1).fill(Color.yellow).frame(width: 18, height: 4)
                                                }
                                            }
                                        }
                                    )
                                
                                // Equipped Katana blade held at side
                                Image(systemName: "waveform.path")
                                    .font(.system(size: 32))
                                    .foregroundColor(.red)
                                    .rotationEffect(.degrees(45))
                                    .offset(x: 32, y: 10)
                            }
                            
                            // Legs: Black Cyber Armoured Pants with Yellow Neon Stripes
                            HStack(spacing: 4) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 3).fill(Color(white: 0.12)).frame(width: 22, height: 56)
                                    Rectangle().fill(Color.yellow).frame(width: 3, height: 40).offset(x: -6)
                                }
                                ZStack {
                                    RoundedRectangle(cornerRadius: 3).fill(Color(white: 0.12)).frame(width: 22, height: 56)
                                    Rectangle().fill(Color.yellow).frame(width: 3, height: 40).offset(x: 6)
                                }
                            }
                            
                            // Shoes: White & Yellow Sneaker Boots
                            HStack(spacing: 8) {
                                RoundedRectangle(cornerRadius: 2).fill(Color.white).frame(width: 22, height: 9)
                                RoundedRectangle(cornerRadius: 2).fill(Color.white).frame(width: 22, height: 9)
                            }
                        }
                        .rotationEffect(.degrees(isDancing ? characterRotation : 0))
                        
                        // Pet: Sr. Waggor (Penguin with Red Bomber Jacket & Sunglasses)
                        VStack(spacing: 2) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.15, green: 0.15, blue: 0.2))
                                    .frame(width: 36, height: 42)
                                
                                // Red Jacket
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.red)
                                    .frame(width: 28, height: 24)
                                    .offset(y: 4)
                                
                                // Sunglasses & Beak
                                VStack(spacing: 1) {
                                    Capsule().fill(Color.black).frame(width: 18, height: 5)
                                    Triangle().fill(Color.orange).frame(width: 8, height: 6)
                                }
                                .offset(y: -8)
                            }
                            
                            Text("SR. WAGGOR")
                                .font(.system(size: 8, weight: .black))
                                .foregroundColor(.white)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 1)
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(3)
                        }
                        .offset(y: -10)
                    }
                }
                
                Spacer().frame(height: 52)
            }
            
            // MARK: - UI Overlays (Exact match from video)
            VStack(spacing: 0) {
                topNavigationBar
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    leftSidebarButtons
                    
                    // Emote Trigger Button in Center Bottom
                    Button(action: {
                        showEmoteWheel.toggle()
                        SoundManager.shared.playButtonClick()
                    }) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(colors: [Color.yellow, FreeFireTheme.gold], startPoint: .top, endPoint: .bottom))
                                .frame(width: 48, height: 48)
                                .shadow(color: FreeFireTheme.gold.opacity(0.6), radius: 6)
                            
                            Image(systemName: "face.smiling.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.bottom, 14)
                    
                    Spacer()
                    
                    rightMatchControls
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                
                bottomTabBar
            }
            
            // 8-Slot Emote Wheel Modal (Exact match to video ff2019_12.jpg)
            if showEmoteWheel {
                eightSlotEmoteWheel
            }
            
            // Matchmaking Overlay
            if isStartingMatch {
                matchmakingOverlay
            }
        }
    }
    
    // MARK: - Top Navigation Bar (Exact match to video)
    private var topNavigationBar: some View {
        HStack(spacing: 10) {
            // Profile Badge: "000ECRT" Lv.57 + Heroico 539 + Soccer Ball Icon
            HStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(red: 0.1, green: 0.2, blue: 0.45))
                        .frame(width: 38, height: 38)
                    Image(systemName: "soccerball")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    VStack {
                        Spacer()
                        Text("57")
                            .font(.system(size: 8, weight: .black))
                            .foregroundColor(.white)
                            .padding(.horizontal, 3)
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(2)
                    }
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text(userState.playerName)
                            .font(.system(size: 13, weight: .black))
                            .foregroundColor(.white)
                        Image(systemName: "shield.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.red)
                    }
                    
                    Text("\(userState.rankName) • \(userState.rankScore) ⭐")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(FreeFireTheme.gold)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.black.opacity(0.55))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white.opacity(0.15), lineWidth: 1))
            
            // Gold (18,060)
            HStack(spacing: 4) {
                Image(systemName: "bitcoinsign.circle.fill").foregroundColor(.yellow)
                Text("\(userState.gold)").font(.system(size: 12, weight: .black)).foregroundColor(.white)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(Color.black.opacity(0.55))
            .cornerRadius(6)
            
            // Diamonds (94+)
            HStack(spacing: 4) {
                Image(systemName: "diamond.fill").foregroundColor(.cyan)
                Text("\(userState.diamonds)+").font(.system(size: 12, weight: .black)).foregroundColor(.white)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(Color.black.opacity(0.55))
            .cornerRadius(6)
            
            Spacer()
            
            // Top Right: FREE FIRE logo + Mail + Friends + Settings + Wifi (17ms)
            HStack(spacing: 8) {
                HStack(spacing: 2) {
                    Image(systemName: "wifi")
                        .font(.system(size: 10))
                        .foregroundColor(.green)
                    Text("17ms")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.green)
                }
                
                Button(action: { showSettings = true }) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
    
    // MARK: - Left Sidebar Buttons (Exact match from video)
    private var leftSidebarButtons: some View {
        VStack(alignment: .leading, spacing: 6) {
            sideButton(title: "TIENDA", icon: "cart.fill", badge: nil) {
                showStore = true
            }
            sideButton(title: "LUCK ROYALE", icon: "crown.fill", badge: "NUEVO") {
                showLuckRoyale = true
            }
            sideButton(title: "PASE BOOYAH", icon: "flame.fill", badge: "NVL.20") {
                showInventory = true
            }
            sideButton(title: "MISIONES", icon: "list.clipboard.fill", badge: nil) {
                SoundManager.shared.playButtonClick()
            }
            sideButton(title: "EVENTOS", icon: "gift.fill", badge: nil) {
                SoundManager.shared.playButtonClick()
            }
        }
    }
    
    private func sideButton(title: String, icon: String, badge: String?, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
            SoundManager.shared.playButtonClick()
        }) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                    .foregroundColor(FreeFireTheme.gold)
                    .frame(width: 16)
                
                Text(title)
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(.white)
                
                Spacer()
                
                if let b = badge {
                    Text(b)
                        .font(.system(size: 7, weight: .black))
                        .padding(.horizontal, 4)
                        .padding(.vertical, 1)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                }
            }
            .frame(width: 120)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color.black.opacity(0.65))
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.white.opacity(0.12), lineWidth: 1))
            .cornerRadius(5)
        }
    }
    
    // MARK: - Bottom Tab Bar (INVENTARIO, ARMAS, PRESET, ESPECIAL)
    private var bottomTabBar: some View {
        HStack(spacing: 20) {
            bottomTabButton(title: "INVENTARIO", icon: "archivebox.fill") {
                showInventory = true
            }
            bottomTabButton(title: "ARMAS", icon: "cross.vial.fill") {
                showArmory = true
            }
            bottomTabButton(title: "PRESET", icon: "person.crop.circle.badge.checkmark") {
                showInventory = true
            }
            bottomTabButton(title: "ESPECIAL", icon: "star.fill") {
                showLuckRoyale = true
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
        .background(Color.black.opacity(0.75))
    }
    
    private func bottomTabButton(title: String, icon: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
            SoundManager.shared.playButtonClick()
        }) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                    .foregroundColor(FreeFireTheme.gold)
                Text(title)
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Color.white.opacity(0.08))
            .cornerRadius(4)
        }
    }
    
    // MARK: - Right Match Controls (Exact match to video: DE-CLASIFICATORIA + INICIAR)
    private var rightMatchControls: some View {
        VStack(alignment: .trailing, spacing: 6) {
            // Mode Select Button
            Button(action: {
                matchMode = matchMode == "DE-CLASIFICATORIA" ? "ENTRENAMIENTO" : "DE-CLASIFICATORIA"
                SoundManager.shared.playButtonClick()
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "flame.fill").foregroundColor(.orange)
                    Text(matchMode)
                        .font(.system(size: 13, weight: .black))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(Color.black.opacity(0.7))
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(FreeFireTheme.gold.opacity(0.7), lineWidth: 1))
                .cornerRadius(6)
            }
            
            // Big Yellow INICIAR Button
            Button(action: {
                startMatchmaking()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "play.fill")
                        .font(.system(size: 18, weight: .black))
                    Text("INICIAR")
                        .font(.system(size: 22, weight: .black))
                }
                .foregroundColor(.black)
                .frame(width: 170, height: 48)
                .background(
                    LinearGradient(
                        colors: [Color.yellow, FreeFireTheme.gold, Color.orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(6)
                .shadow(color: FreeFireTheme.gold.opacity(0.6), radius: 8)
            }
        }
    }
    
    // MARK: - 8-Slot Circular Emote Wheel (Exact match to video ff2019_12.jpg)
    private var eightSlotEmoteWheel: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            
            VStack(spacing: 12) {
                Text("RUEDA DE EMOTES")
                    .font(.system(size: 15, weight: .black))
                    .foregroundColor(FreeFireTheme.gold)
                
                // Circular layout of 8 emotes
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 1.5)
                        .frame(width: 220, height: 220)
                    
                    ForEach(0..<userState.wheelEmotes.count, id: \.self) { idx in
                        let angle = Double(idx) * (360.0 / Double(userState.wheelEmotes.count))
                        let radians = angle * .pi / 180.0
                        let x = 85.0 * cos(radians)
                        let y = 85.0 * sin(radians)
                        
                        Button(action: {
                            triggerEmote(userState.wheelEmotes[idx])
                        }) {
                            VStack(spacing: 2) {
                                Image(systemName: idx == 0 ? "figure.dance" : idx == 1 ? "crown.fill" : "hands.clap.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(FreeFireTheme.gold)
                                Text(userState.wheelEmotes[idx])
                                    .font(.system(size: 7, weight: .bold))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                            }
                            .frame(width: 52, height: 52)
                            .background(Color.black.opacity(0.85))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(FreeFireTheme.gold.opacity(0.6), lineWidth: 1))
                        }
                        .offset(x: x, y: y)
                    }
                }
                .frame(width: 240, height: 240)
                
                Button("CERRAR") {
                    showEmoteWheel = false
                }
                .font(.system(size: 12, weight: .black))
                .foregroundColor(.white)
                .padding(.top, 4)
            }
            .padding(18)
            .background(Color(white: 0.12))
            .cornerRadius(12)
        }
    }
    
    private func triggerEmote(_ name: String) {
        showEmoteWheel = false
        activeEmoteBanner = "Emote: \(name)!"
        FreeFireTheme.booyahVictoryHaptic()
        
        // Trigger breakdance animation
        isDancing = true
        withAnimation(.easeInOut(duration: 0.5).repeatCount(4, autoreverses: true)) {
            characterRotation = 25.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            isDancing = false
            characterRotation = 0.0
            activeEmoteBanner = nil
        }
    }
    
    // MARK: - Matchmaking Overlay
    private var matchmakingOverlay: some View {
        ZStack {
            Color.black.opacity(0.85).ignoresSafeArea()
            
            VStack(spacing: 14) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: FreeFireTheme.gold))
                    .scaleEffect(1.8)
                
                Text("BUSCANDO PARTIDA EN DE-CLASIFICATORIA...")
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(FreeFireTheme.gold)
                
                Text("00:0\(matchTimer)")
                    .font(.system(size: 26, weight: .heavy, design: .monospaced))
                    .foregroundColor(.white)
                
                Button("CANCELAR") {
                    isStartingMatch = false
                }
                .font(.system(size: 11, weight: .heavy))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 6)
                .background(Color.white.opacity(0.2))
                .cornerRadius(4)
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

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}
