import SwiftUI

struct LuckRoyaleView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userState = UserState.shared
    
    enum RoyaleType: String, CaseIterable, Identifiable {
        case diamond = "DIAMANTE ROYALE"
        case gold = "ORO ROYALE"
        case weapon = "ARMA ROYALE"
        case incubator = "INCUBADORA"
        
        var id: String { rawValue }
    }
    
    @State private var activeRoyale: RoyaleType = .weapon
    @State private var isSpinning: Bool = false
    @State private var spinRotation: Double = 0.0
    @State private var wonPrizeName: String? = nil
    
    var body: some View {
        ZStack {
            FreeFireTheme.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header
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
                        Image(systemName: "crown.fill")
                            .foregroundColor(FreeFireTheme.gold)
                        Text("LUCK ROYALE 2019")
                            .font(.system(size: 18, weight: .black))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 14) {
                        HStack(spacing: 6) {
                            Image(systemName: "bitcoinsign.circle.fill")
                                .foregroundColor(.yellow)
                            Text("\(userState.gold)")
                                .font(.system(size: 13, weight: .black))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(6)
                        
                        HStack(spacing: 6) {
                            Image(systemName: "diamond.fill")
                                .foregroundColor(.cyan)
                            Text("\(userState.diamonds)")
                                .font(.system(size: 13, weight: .black))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(6)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(FreeFireTheme.secondaryDark)
                
                // Body Content
                HStack(spacing: 0) {
                    // Left Tabs
                    VStack(spacing: 8) {
                        ForEach(RoyaleType.allCases) { type in
                            Button(action: {
                                activeRoyale = type
                                SoundManager.shared.playButtonClick()
                            }) {
                                HStack {
                                    Text(type.rawValue)
                                        .font(.system(size: 12, weight: .black))
                                        .foregroundColor(activeRoyale == type ? .black : .white)
                                    Spacer()
                                    if activeRoyale == type {
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 12)
                                .background(activeRoyale == type ? FreeFireTheme.gold : Color.black.opacity(0.4))
                                .cornerRadius(6)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: 180)
                    .padding(14)
                    
                    Divider().background(Color.white.opacity(0.12))
                    
                    // Center Grand Prize Showcase
                    VStack(spacing: 16) {
                        grandPrizeBanner
                        
                        // Roulette Wheel
                        ZStack {
                            Circle()
                                .stroke(FreeFireTheme.gold, lineWidth: 6)
                                .frame(width: 170, height: 170)
                                .background(
                                    Circle()
                                        .fill(LinearGradient(colors: [Color.purple.opacity(0.4), Color.black], startPoint: .top, endPoint: .bottom))
                                )
                                .rotationEffect(.degrees(spinRotation))
                            
                            VStack(spacing: 4) {
                                Image(systemName: activeRoyale == .weapon ? "flame.fill" : activeRoyale == .incubator ? "pawprint.fill" : "crown.fill")
                                    .font(.system(size: 54))
                                    .foregroundColor(FreeFireTheme.gold)
                                    .rotationEffect(.degrees(-spinRotation))
                                
                                Text(isSpinning ? "GIRANDO..." : "RULETA")
                                    .font(.system(size: 11, weight: .black))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                        
                        // Spin Buttons
                        HStack(spacing: 20) {
                            // 1 Spin
                            Button(action: {
                                performSpin(count: 1)
                            }) {
                                VStack(spacing: 4) {
                                    Text("1 GIRO")
                                        .font(.system(size: 14, weight: .black))
                                    HStack(spacing: 4) {
                                        if activeRoyale == .gold {
                                            Image(systemName: "bitcoinsign.circle.fill").foregroundColor(.yellow)
                                            Text("300").font(.system(size: 12, weight: .heavy))
                                        } else {
                                            Image(systemName: "diamond.fill").foregroundColor(.cyan)
                                            Text("60").font(.system(size: 12, weight: .heavy))
                                        }
                                    }
                                }
                                .foregroundColor(.black)
                                .frame(width: 140, height: 50)
                                .background(FreeFireTheme.gold)
                                .cornerRadius(8)
                            }
                            .disabled(isSpinning)
                            
                            // 10+1 Spins
                            Button(action: {
                                performSpin(count: 10)
                            }) {
                                VStack(spacing: 4) {
                                    Text("10+1 GIROS")
                                        .font(.system(size: 14, weight: .black))
                                    HStack(spacing: 4) {
                                        if activeRoyale == .gold {
                                            Image(systemName: "bitcoinsign.circle.fill").foregroundColor(.yellow)
                                            Text("3,000").font(.system(size: 12, weight: .heavy))
                                        } else {
                                            Image(systemName: "diamond.fill").foregroundColor(.cyan)
                                            Text("600").font(.system(size: 12, weight: .heavy))
                                        }
                                    }
                                }
                                .foregroundColor(.black)
                                .frame(width: 140, height: 50)
                                .background(
                                    LinearGradient(colors: [Color.yellow, FreeFireTheme.gold, Color.orange], startPoint: .top, endPoint: .bottom)
                                )
                                .cornerRadius(8)
                            }
                            .disabled(isSpinning)
                        }
                        .padding(.bottom, 16)
                    }
                    .padding(16)
                }
            }
            
            // Win Modal
            if let prize = wonPrizeName {
                ZStack {
                    Color.black.opacity(0.85).ignoresSafeArea()
                    
                    VStack(spacing: 16) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 60))
                            .foregroundColor(FreeFireTheme.gold)
                        
                        Text("¡PREMIO OBTENIDO!")
                            .font(.system(size: 24, weight: .black))
                            .foregroundColor(FreeFireTheme.gold)
                        
                        Text(prize)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                        
                        Button("RECLAMAR") {
                            wonPrizeName = nil
                        }
                        .font(.system(size: 14, weight: .black))
                        .foregroundColor(.black)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 10)
                        .background(FreeFireTheme.gold)
                        .cornerRadius(6)
                    }
                    .padding(28)
                    .background(Color(white: 0.12))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(FreeFireTheme.gold, lineWidth: 2))
                }
            }
        }
    }
    
    private var grandPrizeBanner: some View {
        VStack(spacing: 4) {
            switch activeRoyale {
            case .weapon:
                Text("GRAN PREMIO: AK-47 DRAGÓN LLAMEANTE")
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(FreeFireTheme.gold)
                Text("+1 Daño  |  +2 Velocidad de Disparo  |  -1 Cargador")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
            case .diamond:
                Text("GRAN PREMIO: CONJUNTO GUERRERO SAKURA")
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(.pink)
                Text("Aspecto Legendario de la Temporada 1")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
            case .gold:
                Text("GRAN PREMIO: PAÑUELO ANGELICAL & CHAQUETA HEROICO")
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(.yellow)
                Text("Tiradas accesibles con Monedas de Oro")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
            case .incubator:
                Text("INCUBADORA CLÁSICA: ESCUADRÓN CRIMINAL & DINOS")
                    .font(.system(size: 16, weight: .black))
                    .foregroundColor(.red)
                Text("Usa 3 Pergaminos y 7 Piedras Evolutivas")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(.vertical, 8)
    }
    
    private func performSpin(count: Int) {
        let costGold = count == 1 ? 300 : 3000
        let costDia = count == 1 ? 60 : 600
        
        if activeRoyale == .gold {
            guard userState.gold >= costGold else { return }
            userState.gold -= costGold
        } else {
            guard userState.diamonds >= costDia else { return }
            userState.diamonds -= costDia
        }
        
        isSpinning = true
        SoundManager.shared.playButtonClick()
        
        withAnimation(.easeOut(duration: 2.0)) {
            spinRotation += 1440 + Double.random(in: 45...360)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isSpinning = false
            FreeFireTheme.booyahVictoryHaptic()
            
            if activeRoyale == .weapon {
                wonPrizeName = "¡Felicidades! Has conseguido el aspecto legendario: AK-47 Dragón Llameante."
                userState.ownedWeaponSkins.insert("skin_ak_flaming_dragon")
            } else if activeRoyale == .incubator {
                wonPrizeName = "¡Piedra Evolutiva y Pergamino de Criminal Rojo obtenidos!"
                userState.evolutionStones += 1
            } else if activeRoyale == .diamond {
                wonPrizeName = "¡Cubo Mágico y Fragmentos Sakura obtenidos!"
                userState.magicCubes += 1
            } else {
                wonPrizeName = "¡Chaqueta Militar de Bermuda y 500 Oro extra!"
            }
        }
    }
}
