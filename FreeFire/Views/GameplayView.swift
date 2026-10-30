import SwiftUI

struct GameplayView: View {
    let equippedWeapon: Weapon
    let selectedCharacter: FFCharacter
    let onExitToLobby: () -> Void
    @ObservedObject var userState = UserState.shared
    
    // Player State
    @State private var playerPos = CGPoint(x: 240, y: 320)
    @State private var playerFacingAngle: Double = 0.0
    @State private var playerHealth: Int = 200
    @State private var playerEP: Int = 150
    @State private var currentAmmo: Int = 30
    @State private var medkits: Int = 4
    @State private var glooWalls: Int = 3
    @State private var kills: Int = 0
    @State private var aliveCount: Int = 48
    @State private var totalDamage: Int = 0
    @State private var vestLevel: Int = 3
    @State private var helmetLevel: Int = 3
    
    // Combat & Controls State
    @State private var isAiming: Bool = false
    @State private var isCrouched: Bool = false
    @State private var isProne: Bool = false
    @State private var isSprinting: Bool = false
    @State private var isShooting: Bool = false
    @State private var muzzleFlash: Bool = false
    @State private var isUsingMedkit: Bool = false
    @State private var medkitProgress: CGFloat = 0.0
    @State private var activeWeaponSlot: Int = 0
    @State private var matchPhase: MatchPhase = .fighting
    @State private var safeZoneRadius: CGFloat = 110
    
    // Joystick Virtual
    @State private var joystickDrag: CGSize = .zero
    
    // Entities on Bermuda Map
    @State private var enemies: [EnemyBot] = [
        EnemyBot(name: "Bot_Peak_1", position: CGPoint(x: 360, y: 220), hp: 100, weaponName: "MP40"),
        EnemyBot(name: "Bot_ClockTower_2", position: CGPoint(x: 140, y: 190), hp: 100, weaponName: "SCAR"),
        EnemyBot(name: "Bot_Factory_3", position: CGPoint(x: 420, y: 380), hp: 100, weaponName: "M1014"),
        EnemyBot(name: "Bot_Pochinok_4", position: CGPoint(x: 180, y: 440), hp: 100, weaponName: "AK-47")
    ]
    @State private var placedGlooWalls: [GlooWallEntity] = []
    @State private var damageIndicators: [DamageIndicator] = []
    @State private var killFeedMessage: String? = "Partida iniciada en Bermuda - 50 Sobrevivientes"
    @State private var airdropLanded: Bool = true
    @State private var airdropPos = CGPoint(x: 320, y: 280)
    
    // 4 Weapon Slots (Primary, Secondary, Pistol, Melee)
    var weaponsLoadout: [Weapon] {
        [
            Weapon.classic2019Weapons[0], // AK47 (Primary)
            Weapon.classic2019Weapons[4], // MP40 (Secondary)
            Weapon.classic2019Weapons[10], // Desert Eagle (Pistol)
            Weapon.classic2019Weapons[13]  // Katana (Melee)
        ]
    }
    
    var currentWeapon: Weapon {
        if activeWeaponSlot < weaponsLoadout.count {
            return weaponsLoadout[activeWeaponSlot]
        }
        return equippedWeapon
    }
    
    var body: some View {
        ZStack {
            // MARK: - Bermuda Interactive Terrain
            bermudaTerrain
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { value in
                            movePlayerTowards(value.location)
                        }
                )
            
            // Scope Zoom Overlay
            if isAiming {
                scopeOverlayView
            }
            
            // MARK: - HUD Layout (Authentic 2019)
            VStack(spacing: 0) {
                topHUDBar
                
                Spacer()
                
                // Medkit Timer Bar if using
                if isUsingMedkit {
                    medkitUsingIndicator
                }
                
                bottomHUDControls
            }
            
            // Damage Red Flash
            if playerHealth < 100 {
                Rectangle()
                    .stroke(Color.red.opacity(Double(100 - playerHealth) / 100.0 * 0.4), lineWidth: 16)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
            }
            
            // Victory Screen (BOOYAH!)
            if matchPhase == .victory {
                BooyahVictoryView(
                    kills: kills,
                    damage: totalDamage,
                    onReturnToLobby: onExitToLobby
                )
                .transition(.opacity)
            }
        }
    }
    
    // MARK: - Bermuda Map Terrain
    private var bermudaTerrain: some View {
        ZStack {
            // Base Bermuda Field Grass
            Color(red: 0.16, green: 0.24, blue: 0.14).ignoresSafeArea()
            
            // Dirt crossroads / highways
            Path { p in
                // Horizontal highway
                p.move(to: CGPoint(x: 0, y: 320))
                p.addLine(to: CGPoint(x: 900, y: 320))
                // Vertical highway
                p.move(to: CGPoint(x: 300, y: 0))
                p.addLine(to: CGPoint(x: 300, y: 700))
                // Diagonal connecting road to Clock Tower
                p.move(to: CGPoint(x: 100, y: 150))
                p.addLine(to: CGPoint(x: 300, y: 320))
            }
            .stroke(Color(red: 0.32, green: 0.25, blue: 0.16), lineWidth: 36)
            
            // Classic Bermuda Landmarks (Towns & Buildings)
            Group {
                // Peak (Center Top Plateau)
                landmarkBuilding(name: "PEAK", pos: CGPoint(x: 340, y: 160), color: Color(red: 0.4, green: 0.35, blue: 0.25))
                // Clock Tower (Left)
                landmarkBuilding(name: "CLOCK TOWER", pos: CGPoint(x: 120, y: 220), color: Color(red: 0.35, green: 0.3, blue: 0.35))
                // Factory (Right)
                landmarkBuilding(name: "FACTORY", pos: CGPoint(x: 480, y: 360), color: Color(red: 0.25, green: 0.28, blue: 0.32))
                // Pochinok (Bottom Left)
                landmarkBuilding(name: "POCHINOK", pos: CGPoint(x: 180, y: 480), color: Color(red: 0.35, green: 0.28, blue: 0.2))
                // Bimasakti Strip (Center)
                landmarkBuilding(name: "BIMASAKTI", pos: CGPoint(x: 300, y: 320), color: Color(red: 0.3, green: 0.3, blue: 0.25))
            }
            
            // Airdrop Crate with Yellow Smoke
            if airdropLanded {
                ZStack {
                    // Yellow smoke beacon
                    Circle()
                        .fill(RadialGradient(colors: [Color.yellow.opacity(0.6), Color.clear], center: .center, startRadius: 4, endRadius: 35))
                        .frame(width: 70, height: 70)
                    
                    // Supply Drop Crate
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.red)
                        .frame(width: 28, height: 28)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3).stroke(Color.yellow, lineWidth: 2)
                        )
                        .overlay(
                            Text("DROP")
                                .font(.system(size: 6, weight: .black))
                                .foregroundColor(.white)
                        )
                }
                .position(airdropPos)
            }
            
            // Placed Gloo Walls
            ForEach(placedGlooWalls) { wall in
                ZStack {
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [FreeFireTheme.glooWallCyan, Color.blue.opacity(0.8)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 60, height: 16)
                        .shadow(color: FreeFireTheme.glooWallCyan.opacity(0.8), radius: 8)
                    
                    Text("GLOO")
                        .font(.system(size: 7, weight: .black))
                        .foregroundColor(.black)
                }
                .position(wall.position)
            }
            
            // Enemy Bots
            ForEach(enemies) { enemy in
                if enemy.hp > 0 {
                    ZStack {
                        // Bot red danger aura
                        Circle()
                            .fill(Color.red.opacity(0.2))
                            .frame(width: 36, height: 36)
                        
                        // Bot character
                        Circle()
                            .fill(Color.red)
                            .frame(width: 22, height: 22)
                            .overlay(
                                Image(systemName: "figure.stand")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                            )
                        
                        // Bot Health Bar & Name
                        VStack(spacing: 2) {
                            Text(enemy.name)
                                .font(.system(size: 7, weight: .bold))
                                .foregroundColor(.white)
                            
                            GeometryReader { g in
                                ZStack(alignment: .leading) {
                                    Rectangle().fill(Color.black).frame(width: 30, height: 3)
                                    Rectangle().fill(Color.red).frame(width: 30 * CGFloat(enemy.hp) / 100.0, height: 3)
                                }
                            }
                            .frame(width: 30, height: 3)
                        }
                        .offset(y: -20)
                    }
                    .position(enemy.position)
                } else {
                    // Loot Crate left on ground
                    Image(systemName: "archivebox.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.yellow)
                        .position(enemy.position)
                }
            }
            
            // Player Character with Equipped 2019 Skins
            ZStack {
                // Footprint aura
                Circle()
                    .fill(FreeFireTheme.gold.opacity(0.35))
                    .frame(width: 32, height: 32)
                
                // Player Model Icon
                ZStack {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 24, height: 24)
                    
                    // Head cosmetic (e.g. Sakura Oni Mask or Hip Hop Cap)
                    Image(systemName: userState.equippedHead.contains("sakura") ? "theatermasks.fill" : "person.fill")
                        .font(.system(size: 13))
                        .foregroundColor(userState.equippedTop.contains("sakura") ? .pink : .black)
                }
                
                // Gun Muzzle Flash on firing
                if muzzleFlash {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 20, height: 20)
                        .offset(x: 16)
                }
            }
            .position(playerPos)
            
            // Damage Numbers Overlay
            ForEach(damageIndicators) { dmg in
                HStack(spacing: 2) {
                    if dmg.isHeadshot {
                        Image(systemName: "skull.fill")
                            .font(.system(size: 13))
                            .foregroundColor(.red)
                    }
                    Text(dmg.text)
                        .font(.system(size: dmg.isHeadshot ? 20 : 15, weight: .black))
                        .foregroundColor(dmg.isHeadshot ? FreeFireTheme.headshotRed : .yellow)
                }
                .position(dmg.position)
                .offset(y: dmg.offsetY)
                .opacity(dmg.opacity)
            }
        }
    }
    
    private func landmarkBuilding(name: String, pos: CGPoint, color: Color) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(color)
                .frame(width: 75, height: 50)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.black.opacity(0.5), lineWidth: 1.5))
            
            VStack(spacing: 2) {
                Text(name)
                    .font(.system(size: 8, weight: .black))
                    .foregroundColor(.white)
                Image(systemName: "building.2.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .position(pos)
    }
    
    // MARK: - Top HUD Bar
    private var topHUDBar: some View {
        HStack(alignment: .top) {
            // Bermuda Minimap (Top Left)
            BermudaMinimapView(playerPos: playerPos, safeZoneRadius: safeZoneRadius)
                .padding(.leading, 14)
                .padding(.top, 10)
            
            Spacer()
            
            // Center: Kill Feed & Alive Count
            VStack(spacing: 4) {
                // Kill feed marquee
                if let msg = killFeedMessage {
                    Text(msg)
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(.yellow)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(Color.black.opacity(0.65))
                        .cornerRadius(4)
                }
                
                // Vivos / Asesinatos
                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "person.2.fill")
                            .foregroundColor(.white)
                        Text("VIVOS: \(aliveCount)")
                            .font(.system(size: 12, weight: .black))
                            .foregroundColor(.white)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "skull.fill")
                            .foregroundColor(.red)
                        Text("KILLS: \(kills)")
                            .font(.system(size: 12, weight: .black))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.5))
                .cornerRadius(4)
            }
            .padding(.top, 10)
            
            Spacer()
            
            // Top Right: 4 Weapon Slots + Exit Door Button (as seen in video)
            HStack(spacing: 8) {
                HStack(spacing: 6) {
                    ForEach(0..<weaponsLoadout.count, id: \.self) { idx in
                        let w = weaponsLoadout[idx]
                        Button(action: {
                            activeWeaponSlot = idx
                            FreeFireTheme.gunshotHaptic()
                        }) {
                            VStack(spacing: 2) {
                                Text(w.name)
                                    .font(.system(size: 8, weight: .black))
                                    .foregroundColor(activeWeaponSlot == idx ? .black : .white)
                                Image(systemName: w.iconSystemName)
                                    .font(.system(size: 11))
                                    .foregroundColor(activeWeaponSlot == idx ? .black : FreeFireTheme.gold)
                            }
                            .frame(width: 52, height: 38)
                            .background(activeWeaponSlot == idx ? FreeFireTheme.gold : Color.black.opacity(0.6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(activeWeaponSlot == idx ? Color.white : Color.clear, lineWidth: 1)
                            )
                            .cornerRadius(4)
                        }
                    }
                }
                
                // Exit Match Door Button (Exact match from video ff2019_18.jpg)
                Button(action: {
                    SoundManager.shared.playButtonClick()
                    onExitToLobby()
                }) {
                    Image(systemName: "door.left.hand.open")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.red.opacity(0.8))
                        .clipShape(Circle())
                }
            }
            .padding(.trailing, 14)
            .padding(.top, 10)
        }
    }
    
    // MARK: - Bottom HUD Controls
    private var bottomHUDControls: some View {
        HStack(alignment: .bottom) {
            // Left: Analog Joystick + Medkit + Backpack
            VStack(alignment: .leading, spacing: 14) {
                // Sprint lock button
                Button(action: {
                    isSprinting.toggle()
                    SoundManager.shared.playButtonClick()
                }) {
                    Image(systemName: "figure.run")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(isSprinting ? .black : .white)
                        .padding(8)
                        .background(isSprinting ? FreeFireTheme.gold : Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
                .padding(.leading, 30)
                
                // Virtual Analog Joystick
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.12))
                        .frame(width: 100, height: 100)
                        .overlay(Circle().stroke(Color.white.opacity(0.3), lineWidth: 1.5))
                    
                    Circle()
                        .fill(FreeFireTheme.gold)
                        .frame(width: 44, height: 44)
                        .offset(joystickDrag)
                        .gesture(
                            DragGesture()
                                .onChanged { val in
                                    let maxRadius: CGFloat = 35
                                    let dist = hypot(val.translation.width, val.translation.height)
                                    if dist > maxRadius {
                                        joystickDrag = CGSize(
                                            width: (val.translation.width / dist) * maxRadius,
                                            height: (val.translation.height / dist) * maxRadius
                                        )
                                    } else {
                                        joystickDrag = val.translation
                                    }
                                    
                                    // Move player
                                    let speed: CGFloat = isSprinting ? 5.0 : 3.0
                                    playerPos.x += (joystickDrag.width / maxRadius) * speed
                                    playerPos.y += (joystickDrag.height / maxRadius) * speed
                                }
                                .onEnded { _ in
                                    withAnimation(.easeOut(duration: 0.1)) {
                                        joystickDrag = .zero
                                    }
                                }
                        )
                }
                .padding(.leading, 20)
                .padding(.bottom, 16)
            }
            
            Spacer()
            
            // Center Bottom: HP Bar, EP Bar & Medkit
            VStack(spacing: 4) {
                HStack(spacing: 12) {
                    // Medkit Button
                    Button(action: {
                        useMedkit()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "cross.case.fill")
                                .foregroundColor(.green)
                            Text("x\(medkits)")
                                .font(.system(size: 12, weight: .black))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.black.opacity(0.65))
                        .cornerRadius(6)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.green, lineWidth: 1))
                    }
                    .disabled(isUsingMedkit || playerHealth >= 200 || medkits <= 0)
                    
                    // Gloo Wall Button
                    Button(action: {
                        deployGlooWall()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "shield.fill")
                                .foregroundColor(FreeFireTheme.glooWallCyan)
                            Text("x\(glooWalls)")
                                .font(.system(size: 12, weight: .black))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.black.opacity(0.65))
                        .cornerRadius(6)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(FreeFireTheme.glooWallCyan, lineWidth: 1))
                    }
                    .disabled(glooWalls <= 0)
                }
                
                // EP Bar (Yellow)
                HStack(spacing: 6) {
                    Text("EP")
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(.yellow)
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle().fill(Color.black.opacity(0.6)).frame(height: 6)
                            Rectangle().fill(Color.yellow).frame(width: geo.size.width * CGFloat(playerEP) / 200.0, height: 6)
                        }
                    }
                    .frame(width: 170, height: 6)
                    Text("\(playerEP)/200")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.white)
                }
                
                // HP Bar (Green)
                HStack(spacing: 6) {
                    Text("HP")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(FreeFireTheme.hpGreen)
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle().fill(Color.black.opacity(0.6)).frame(height: 10)
                            Rectangle().fill(FreeFireTheme.hpGreen).frame(width: geo.size.width * CGFloat(max(0, playerHealth)) / 200.0, height: 10)
                        }
                    }
                    .frame(width: 170, height: 10)
                    Text("\(playerHealth)/200")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 16)
            
            Spacer()
            
            // Right: Combat Actions (Fire, Scope, Jump, Crouch, Prone)
            HStack(alignment: .bottom, spacing: 14) {
                VStack(spacing: 10) {
                    // Scope Button
                    Button(action: {
                        isAiming.toggle()
                        FreeFireTheme.glooWallHaptic()
                    }) {
                        Image(systemName: "scope")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(isAiming ? .black : .white)
                            .padding(14)
                            .background(isAiming ? FreeFireTheme.gold : Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    
                    // Jump Button
                    Button(action: {
                        FreeFireTheme.glooWallHaptic()
                    }) {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                }
                
                VStack(spacing: 8) {
                    // Katana / Knife Slash Quick Button (Exact match from video ff2019_18.jpg)
                    Button(action: {
                        FreeFireTheme.gunshotHaptic()
                        damageIndicators.append(DamageIndicator(text: "150 (Katana)", isHeadshot: true, position: CGPoint(x: playerPos.x + 30, y: playerPos.y - 20)))
                    }) {
                        Image(systemName: "knife.fill")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.orange.opacity(0.8))
                            .clipShape(Circle())
                    }
                    
                    // Crouch Button
                    Button(action: {
                        isCrouched.toggle()
                        isProne = false
                        FreeFireTheme.glooWallHaptic()
                    }) {
                        Image(systemName: "figure.walk")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(isCrouched ? .black : .white)
                            .padding(10)
                            .background(isCrouched ? FreeFireTheme.gold : Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    
                    // Big Fire Button (Disparo)
                    Button(action: {
                        shootWeapon()
                    }) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color.yellow, FreeFireTheme.gold, Color.orange],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(width: 68, height: 68)
                                .shadow(color: FreeFireTheme.gold.opacity(0.6), radius: 8)
                            
                            Image(systemName: "flame.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .padding(.trailing, 20)
            .padding(.bottom, 16)
        }
    }
    
    // MARK: - Scope Overlay
    private var scopeOverlayView: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            
            // Scope Reticle
            Circle()
                .stroke(Color.red, lineWidth: 2)
                .frame(width: 140, height: 140)
            
            Circle()
                .fill(Color.red)
                .frame(width: 6, height: 6)
            
            Path { p in
                p.move(to: CGPoint(x: 0, y: 70))
                p.addLine(to: CGPoint(x: 140, y: 70))
                p.move(to: CGPoint(x: 70, y: 0))
                p.addLine(to: CGPoint(x: 70, y: 140))
            }
            .stroke(Color.red.opacity(0.6), lineWidth: 1)
            .frame(width: 140, height: 140)
        }
        .allowsHitTesting(false)
    }
    
    private var medkitUsingIndicator: some View {
        VStack(spacing: 4) {
            Text("USANDO BOTIQUÍN...")
                .font(.system(size: 11, weight: .black))
                .foregroundColor(.green)
            
            ProgressView(value: medkitProgress, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle(tint: .green))
                .frame(width: 140)
        }
        .padding(8)
        .background(Color.black.opacity(0.75))
        .cornerRadius(6)
        .padding(.bottom, 8)
    }
    
    // MARK: - Gameplay Logic
    private func movePlayerTowards(_ target: CGPoint) {
        withAnimation(.easeOut(duration: 0.3)) {
            playerPos = target
        }
    }
    
    private func shootWeapon() {
        FreeFireTheme.gunshotHaptic()
        muzzleFlash = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            muzzleFlash = false
        }
        
        // Find closest enemy bot
        if let idx = enemies.firstIndex(where: { $0.hp > 0 }) {
            let enemy = enemies[idx]
            
            // 2019 Headshot calculation (35% chance or when aiming)
            let isHeadshot = isAiming || Bool.random() && Bool.random()
            let damageAmount = isHeadshot ? Int.random(in: 120...180) : Int.random(in: 28...42)
            
            enemies[idx].hp = max(0, enemies[idx].hp - damageAmount)
            totalDamage += damageAmount
            
            // Spawn floating damage text
            let indicator = DamageIndicator(
                text: "\(damageAmount)",
                isHeadshot: isHeadshot,
                position: CGPoint(x: enemy.position.x, y: enemy.position.y - 20)
            )
            damageIndicators.append(indicator)
            
            if isHeadshot {
                FreeFireTheme.headshotHaptic()
            }
            
            // Animate floating damage
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                damageIndicators.removeAll { $0.id == indicator.id }
            }
            
            // Bot eliminated
            if enemies[idx].hp <= 0 {
                kills += 1
                aliveCount = max(1, aliveCount - 1)
                killFeedMessage = "VETERANO_2019 [\(currentWeapon.name)] 💀 \(enemy.name)"
                
                // Bot shoots back occasionally
                if enemies.allSatisfy({ $0.hp <= 0 }) {
                    // Trigger Booyah!
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        matchPhase = .victory
                        FreeFireTheme.booyahVictoryHaptic()
                    }
                }
            } else {
                // Enemy bot fires back at player!
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    if enemies[idx].hp > 0 && playerHealth > 0 {
                        let botDamage = Int.random(in: 15...25)
                        playerHealth = max(10, playerHealth - botDamage)
                        FreeFireTheme.gunshotHaptic()
                    }
                }
            }
        }
    }
    
    private func deployGlooWall() {
        guard glooWalls > 0 else { return }
        glooWalls -= 1
        FreeFireTheme.glooWallHaptic()
        
        let newWall = GlooWallEntity(position: CGPoint(x: playerPos.x + 40, y: playerPos.y))
        placedGlooWalls.append(newWall)
    }
    
    private func useMedkit() {
        guard medkits > 0, playerHealth < 200, !isUsingMedkit else { return }
        isUsingMedkit = true
        medkitProgress = 0.0
        SoundManager.shared.playButtonClick()
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            medkitProgress += 0.05
            if medkitProgress >= 1.0 {
                timer.invalidate()
                isUsingMedkit = false
                medkits -= 1
                playerHealth = min(200, playerHealth + 75)
                FreeFireTheme.booyahVictoryHaptic()
            }
        }
    }
}
