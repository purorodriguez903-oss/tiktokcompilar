import SwiftUI

struct GameplayView: View {
    let equippedWeapon: Weapon
    let selectedCharacter: FFCharacter
    let onExitToLobby: () -> Void
    
    // Player State
    @State private var playerPos = CGPoint(x: 200, y: 300)
    @State private var playerHealth: Int = 200
    @State private var playerEP: Int = 120
    @State private var currentAmmo: Int = 30
    @State private var medkits: Int = 3
    @State private var glooWalls: Int = 3
    @State private var kills: Int = 0
    @State private var aliveCount: Int = 18
    @State private var totalDamage: Int = 0
    
    // Combat / Movement Flags
    @State private var isAiming: Bool = false
    @State private var isCrouched: Bool = false
    @State private var isShooting: Bool = false
    @State private var muzzleFlash: Bool = false
    @State private var activeWeaponIndex: Int = 0
    @State private var matchPhase: MatchPhase = .fighting
    @State private var safeZoneRadius: CGFloat = 80
    
    // Entities on Bermuda
    @State private var enemies: [EnemyBot] = [
        EnemyBot(name: "Bot_Veterano_1", position: CGPoint(x: 280, y: 220), hp: 100, weaponName: "MP40"),
        EnemyBot(name: "Bot_Campero_2", position: CGPoint(x: 120, y: 180), hp: 100, weaponName: "SCAR"),
        EnemyBot(name: "Bot_Rusher_3", position: CGPoint(x: 320, y: 380), hp: 100, weaponName: "M1014")
    ]
    @State private var placedGlooWalls: [GlooWallEntity] = []
    @State private var damageIndicators: [DamageIndicator] = []
    @State private var killFeedMessage: String? = nil
    
    let weaponsInLoadout: [Weapon] = [
        Weapon.classic2019Weapons[0], // AK47
        Weapon.classic2019Weapons[1], // MP40
        Weapon.classic2019Weapons[3]  // M1014
    ]
    
    var currentWeapon: Weapon {
        weaponsInLoadout[safe: activeWeaponIndex] ?? equippedWeapon
    }
    
    var body: some View {
        ZStack {
            // Bermuda Terrain Canvas (Classic 2019 grass and dirt roads)
            ZStack {
                // Grass field
                Color(red: 0.18, green: 0.28, blue: 0.16).ignoresSafeArea()
                
                // Bermuda Dirt roads / landmarks
                Path { p in
                    p.move(to: CGPoint(x: 0, y: 300))
                    p.addLine(to: CGPoint(x: 800, y: 300))
                    p.move(to: CGPoint(x: 400, y: 0))
                    p.addLine(to: CGPoint(x: 400, y: 600))
                }
                .stroke(Color(red: 0.35, green: 0.28, blue: 0.18), lineWidth: 40)
                
                // Military Crates / Obstacles
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(red: 0.45, green: 0.35, blue: 0.2))
                    .frame(width: 44, height: 44)
                    .position(x: 260, y: 260)
                    .overlay(
                        Text("CRATE")
                            .font(.system(size: 8, weight: .bold))
                            .foregroundColor(.black.opacity(0.6))
                            .position(x: 260, y: 260)
                    )
                
                // Placed Gloo Walls (Classic Ice Shield)
                ForEach(placedGlooWalls) { wall in
                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            LinearGradient(
                                colors: [FreeFireTheme.glooWallCyan, Color.blue.opacity(0.8)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 54, height: 16)
                        .position(wall.position)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.white, lineWidth: 1.5)
                                .frame(width: 54, height: 16)
                                .position(wall.position)
                        )
                }
                
                // Enemy Bots
                ForEach(enemies.filter { $0.isAlive }) { enemy in
                    ZStack {
                        Circle()
                            .fill(FreeFireTheme.damageRed)
                            .frame(width: 28, height: 28)
                            .overlay(
                                Circle().stroke(Color.black, lineWidth: 2)
                            )
                        
                        Text("LV.4")
                            .font(.system(size: 8, weight: .black))
                            .foregroundColor(.white)
                    }
                    .position(enemy.position)
                }
                
                // Player Character (Adán / Kelly)
                ZStack {
                    if isAiming {
                        Circle()
                            .stroke(Color.red, lineWidth: 1.5)
                            .frame(width: 40, height: 40)
                    }
                    
                    Circle()
                        .fill(FreeFireTheme.gold)
                        .frame(width: 32, height: 32)
                        .overlay(
                            Circle().stroke(Color.black, lineWidth: 2)
                        )
                    
                    // Facing indicator / Gun
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 4, height: 14)
                        .offset(y: -18)
                    
                    // Muzzle flash
                    if muzzleFlash {
                        Image(systemName: "sparkle")
                            .font(.system(size: 16))
                            .foregroundColor(.yellow)
                            .offset(y: -28)
                    }
                }
                .position(playerPos)
                
                // Floating Damage Numbers (Classic Yellow Body / Red Headshot)
                ForEach(damageIndicators) { dmg in
                    HStack(spacing: 2) {
                        if dmg.isHeadshot {
                            Image(systemName: "star.fill")
                                .font(.system(size: 11))
                                .foregroundColor(.red)
                        }
                        Text(dmg.text)
                            .font(.system(size: dmg.isHeadshot ? 18 : 14, weight: .black))
                            .foregroundColor(dmg.isHeadshot ? FreeFireTheme.headshotRed : .yellow)
                    }
                    .position(dmg.position)
                    .offset(y: dmg.offsetY)
                    .opacity(dmg.opacity)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture { loc in
                movePlayer(to: loc)
            }
            
            // HUD Overlay (Authentic 2019 Layout)
            VStack {
                // Top HUD Bar: Minimap | Vivos/Kills | Loadout selector
                HStack(alignment: .top) {
                    // Minimap (Top Left)
                    BermudaMinimapView(playerPos: playerPos, safeZoneRadius: safeZoneRadius)
                        .padding(.leading, 12)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    // Center Match Counter
                    VStack(spacing: 2) {
                        HStack(spacing: 14) {
                            HStack(spacing: 4) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(.white)
                                Text("VIVOS: \(aliveCount)")
                                    .font(.system(size: 12, weight: .black))
                                    .foregroundColor(.white)
                            }
                            
                            HStack(spacing: 4) {
                                Image(systemName: "scope")
                                    .font(.system(size: 12))
                                    .foregroundColor(.red)
                                Text("KILLS: \(kills)")
                                    .font(.system(size: 12, weight: .black))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(Color.black.opacity(0.65))
                        .cornerRadius(6)
                        
                        if let killMsg = killFeedMessage {
                            Text(killMsg)
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(FreeFireTheme.gold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(4)
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // Weapon Switcher Strip (Top Right)
                    HStack(spacing: 6) {
                        ForEach(0..<weaponsInLoadout.count, id: \.self) { idx in
                            let wp = weaponsInLoadout[idx]
                            Button(action: {
                                FreeFireTheme.gunshotHaptic()
                                activeWeaponIndex = idx
                            }) {
                                VStack(spacing: 2) {
                                    Text(wp.name)
                                        .font(.system(size: 10, weight: .black))
                                        .foregroundColor(activeWeaponIndex == idx ? .black : .white)
                                    Image(systemName: wp.iconSystemName)
                                        .font(.system(size: 12))
                                        .foregroundColor(activeWeaponIndex == idx ? .black : FreeFireTheme.gold)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                                .background(activeWeaponIndex == idx ? FreeFireTheme.gold : Color.black.opacity(0.6))
                                .cornerRadius(6)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                )
                            }
                        }
                    }
                    .padding(.trailing, 12)
                    .padding(.top, 10)
                }
                
                Spacer()
                
                // Bottom HUD: Movement, Health/EP bar, Shoot & Action buttons
                HStack(alignment: .bottom) {
                    // Left: Virtual Joystick Pad simulation
                    VStack(alignment: .leading, spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.4))
                                .frame(width: 90, height: 90)
                                .overlay(
                                    Circle().stroke(Color.white.opacity(0.2), lineWidth: 2)
                                )
                            
                            Circle()
                                .fill(Color.white.opacity(0.7))
                                .frame(width: 36, height: 36)
                        }
                        
                        Text("TOCA EL MAPA PARA CAMINAR")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.leading, 16)
                    
                    Spacer()
                    
                    // Center: Health Bar (HP: 200/200) & EP Bar
                    VStack(spacing: 4) {
                        // EP Bar (Yellow)
                        HStack(spacing: 6) {
                            Text("EP \(playerEP)/200")
                                .font(.system(size: 9, weight: .heavy))
                                .foregroundColor(FreeFireTheme.epYellow)
                            
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.black.opacity(0.6))
                                    .frame(width: 140, height: 5)
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(FreeFireTheme.epYellow)
                                    .frame(width: CGFloat(playerEP) * 0.7, height: 5)
                            }
                        }
                        
                        // HP Bar (Green)
                        HStack(spacing: 6) {
                            Text("HP \(playerHealth)/200")
                                .font(.system(size: 11, weight: .black))
                                .foregroundColor(FreeFireTheme.hpGreen)
                            
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.black.opacity(0.6))
                                    .frame(width: 170, height: 10)
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(FreeFireTheme.hpGreen)
                                    .frame(width: CGFloat(playerHealth) * 0.85, height: 10)
                            }
                        }
                        
                        // Medkit & Gloo Wall shortcuts
                        HStack(spacing: 12) {
                            // Medkit
                            Button(action: useMedkit) {
                                HStack(spacing: 4) {
                                    Image(systemName: "cross.case.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(.green)
                                    Text("\(medkits)")
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(6)
                            }
                            
                            // Gloo Wall
                            Button(action: deployGlooWall) {
                                HStack(spacing: 4) {
                                    Image(systemName: "shield.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(FreeFireTheme.glooWallCyan)
                                    Text("\(glooWalls)")
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(6)
                            }
                        }
                        .padding(.top, 2)
                    }
                    
                    Spacer()
                    
                    // Right: Classic Shoot Button, Scope, Jump, Crouch
                    VStack(alignment: .trailing, spacing: 10) {
                        HStack(spacing: 14) {
                            // Scope
                            Button(action: {
                                isAiming.toggle()
                                FreeFireTheme.glooWallHaptic()
                            }) {
                                Circle()
                                    .fill(isAiming ? Color.red.opacity(0.8) : Color.black.opacity(0.6))
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        Image(systemName: "scope")
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                    )
                            }
                            
                            // Big Fire / Shoot Button (Classic Free Fire bullet button)
                            Button(action: shootWeapon) {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.85, green: 0.25, blue: 0.15))
                                        .frame(width: 68, height: 68)
                                        .overlay(
                                            Circle().stroke(Color.white.opacity(0.6), lineWidth: 2)
                                        )
                                    
                                    Image(systemName: "flame.fill")
                                        .font(.system(size: 28))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        
                        // Jump / Crouch Row
                        HStack(spacing: 12) {
                            Button(action: {
                                FreeFireTheme.glooWallHaptic()
                            }) {
                                Circle()
                                    .fill(Color.black.opacity(0.6))
                                    .frame(width: 38, height: 38)
                                    .overlay(
                                        Image(systemName: "arrow.up")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.white)
                                    )
                            }
                            
                            Button(action: {
                                isCrouched.toggle()
                                FreeFireTheme.glooWallHaptic()
                            }) {
                                Circle()
                                    .fill(isCrouched ? FreeFireTheme.gold : Color.black.opacity(0.6))
                                    .frame(width: 38, height: 38)
                                    .overlay(
                                        Image(systemName: "figure.walk")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(isCrouched ? .black : .white)
                                    )
                            }
                        }
                    }
                    .padding(.trailing, 16)
                }
                .padding(.bottom, 14)
            }
            
            // BOOYAH! Victory Screen
            if matchPhase == .victory {
                BooyahVictoryView(
                    kills: kills,
                    damage: totalDamage,
                    onReturnToLobby: onExitToLobby
                )
            }
        }
        .navigationBarHidden(true)
    }
    
    private func movePlayer(to location: CGPoint) {
        withAnimation(.easeOut(duration: 0.2)) {
            playerPos = location
        }
    }
    
    private func shootWeapon() {
        guard currentAmmo > 0 else {
            currentAmmo = currentWeapon.magazineSize
            return
        }
        
        currentAmmo -= 1
        muzzleFlash = true
        FreeFireTheme.gunshotHaptic()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            muzzleFlash = false
        }
        
        // Find nearest bot to damage
        if let targetIndex = enemies.firstIndex(where: { $0.isAlive }) {
            let isHead = Bool.random()
            let dmg = isHead ? 150 : currentWeapon.damage
            
            enemies[targetIndex].hp -= dmg
            totalDamage += dmg
            
            let pos = enemies[targetIndex].position
            var ind = DamageIndicator(
                text: isHead ? "¡HEADSHOT! -\(dmg)" : "-\(dmg)",
                isHeadshot: isHead,
                position: pos
            )
            damageIndicators.append(ind)
            
            if isHead {
                FreeFireTheme.headshotHaptic()
            }
            
            // Animate indicator
            let indId = ind.id
            withAnimation(.easeOut(duration: 0.6)) {
                if let idx = damageIndicators.firstIndex(where: { $0.id == indId }) {
                    damageIndicators[idx].offsetY = -35
                    damageIndicators[idx].opacity = 0
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                damageIndicators.removeAll(where: { $0.id == indId })
            }
            
            // Check if killed
            if enemies[targetIndex].hp <= 0 {
                enemies[targetIndex].isAlive = false
                kills += 1
                aliveCount = max(1, aliveCount - 1)
                killFeedMessage = "AlexRod ︻╦デ═一 \(enemies[targetIndex].name)"
                
                // If all bots dead -> BOOYAH!
                if enemies.allSatisfy({ !$0.isAlive }) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation { matchPhase = .victory }
                    }
                }
            }
        }
    }
    
    private func deployGlooWall() {
        guard glooWalls > 0 else { return }
        glooWalls -= 1
        FreeFireTheme.glooWallHaptic()
        let wallPos = CGPoint(x: playerPos.x, y: playerPos.y - 35)
        placedGlooWalls.append(GlooWallEntity(position: wallPos, rotation: 0))
    }
    
    private func useMedkit() {
        guard medkits > 0, playerHealth < 200 else { return }
        medkits -= 1
        FreeFireTheme.booyahVictoryHaptic()
        playerHealth = min(200, playerHealth + 75)
    }
}
