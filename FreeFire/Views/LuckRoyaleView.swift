import SwiftUI

struct LuckRoyaleView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userState = UserState.shared
    
    enum RoyaleTab: String, CaseIterable, Identifiable {
        case donMuerte = "REGRESO DE DON MUERTE"
        case g36 = "G36 LA VENGANZA DE LA NOVIA"
        case ghost = "FLOTANDO COMO FANTASMA"
        case incubator = "INCUBADORA PESADILLAS"
        case xm8 = "XM8 CALABAZA ARDIENTE"
        
        var id: String { rawValue }
    }
    
    @State private var activeTab: RoyaleTab = .donMuerte
    @State private var isSpinning: Bool = false
    @State private var rouletteRotation: Double = 0.0
    @State private var showPrizeClaim: Bool = false
    @State private var prizeClaimMessage: String = ""
    
    var body: some View {
        ZStack {
            FreeFireTheme.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header Bar (Exact match to video ff2019_14.jpg)
                HStack(spacing: 12) {
                    // Profile Badge
                    HStack(spacing: 6) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4).fill(Color.blue).frame(width: 30, height: 30)
                            Image(systemName: "soccerball").font(.system(size: 14)).foregroundColor(.white)
                        }
                        VStack(alignment: .leading, spacing: 1) {
                            Text(userState.playerName).font(.system(size: 11, weight: .black)).foregroundColor(.white)
                            Text("57").font(.system(size: 8, weight: .bold)).foregroundColor(FreeFireTheme.gold)
                        }
                    }
                    .padding(4)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(6)
                    
                    // Gold (18,060)
                    HStack(spacing: 4) {
                        Image(systemName: "bitcoinsign.circle.fill").foregroundColor(.yellow)
                        Text("\(userState.gold)").font(.system(size: 11, weight: .black)).foregroundColor(.white)
                    }
                    .padding(4)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(6)
                    
                    // Diamonds (94+)
                    HStack(spacing: 4) {
                        Image(systemName: "diamond.fill").foregroundColor(.cyan)
                        Text("\(userState.diamonds)+").font(.system(size: 11, weight: .black)).foregroundColor(.white)
                    }
                    .padding(4)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(6)
                    
                    Spacer()
                    
                    // Token count & LUCK ROYALE Title
                    HStack(spacing: 6) {
                        Image(systemName: "circle.hexagongrid.fill").foregroundColor(.purple)
                        Text("\(userState.tokensDonMuerte)").font(.system(size: 12, weight: .black)).foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(4)
                    
                    Text("LUCK ROYALE")
                        .font(.system(size: 15, weight: .black))
                        .foregroundColor(.white)
                    
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                            .padding(6)
                            .background(Color.white.opacity(0.15))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(FreeFireTheme.secondaryDark)
                
                // Main Content
                HStack(spacing: 0) {
                    // Left Royale Banners List (Exact match to video)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 8) {
                            ForEach(RoyaleTab.allCases) { tab in
                                Button(action: {
                                    activeTab = tab
                                    SoundManager.shared.playButtonClick()
                                }) {
                                    HStack {
                                        Text(tab.rawValue)
                                            .font(.system(size: 9, weight: .black))
                                            .foregroundColor(activeTab == tab ? .black : .white)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    .frame(height: 48)
                                    .padding(.horizontal, 10)
                                    .background(activeTab == tab ? FreeFireTheme.gold : Color.black.opacity(0.5))
                                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(activeTab == tab ? Color.white : Color.clear, lineWidth: 1.5))
                                    .cornerRadius(6)
                                }
                            }
                        }
                        .padding(8)
                    }
                    .frame(width: 150)
                    
                    Divider().background(Color.white.opacity(0.1))
                    
                    // Center: "Ruleta de Tokens - Don Muerte" (Exact match to video ff2019_14.jpg)
                    VStack(spacing: 10) {
                        // Title Banner
                        HStack {
                            Text("Ruleta de Tokens")
                                .font(.system(size: 24, weight: .black, design: .rounded))
                                .foregroundColor(Color(red: 0.2, green: 0.9, blue: 0.6))
                                .shadow(color: .green, radius: 4)
                            
                            Text("Regreso de Don Muerte")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.green.opacity(0.4))
                                .cornerRadius(3)
                            
                            Spacer()
                            
                            // Intercambio Button
                            Button("Intercambio") {
                                userState.tokensDonMuerte += 5
                                FreeFireTheme.booyahVictoryHaptic()
                            }
                            .font(.system(size: 10, weight: .black))
                            .foregroundColor(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(FreeFireTheme.gold)
                            .cornerRadius(4)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 6)
                        
                        // Center Roulette Web & Prizes
                        HStack(spacing: 16) {
                            // Circular Web with 8 Hexagonal Token Sockets
                            ZStack {
                                // Green Spectral Web Glow
                                Circle()
                                    .fill(RadialGradient(colors: [Color.green.opacity(0.4), Color.clear], center: .center, startRadius: 10, endRadius: 110))
                                    .frame(width: 220, height: 220)
                                
                                Circle()
                                    .stroke(Color.green.opacity(0.5), lineWidth: 2)
                                    .frame(width: 180, height: 180)
                                    .rotationEffect(.degrees(rouletteRotation))
                                
                                // Center Hexagon: Don Muerte Grand Prize
                                ZStack {
                                    Circle().fill(Color.black).frame(width: 60, height: 60)
                                    Circle().stroke(Color.yellow, lineWidth: 2).frame(width: 60, height: 60)
                                    Image(systemName: "crown.fill").font(.system(size: 24)).foregroundColor(.yellow)
                                }
                                
                                // 8 Outer Hexagons
                                ForEach(0..<8) { i in
                                    let angle = Double(i) * (360.0 / 8.0)
                                    let radians = angle * .pi / 180.0
                                    let x = 70.0 * cos(radians)
                                    let y = 70.0 * sin(radians)
                                    
                                    ZStack {
                                        Circle().fill(Color(white: 0.15)).frame(width: 28, height: 28)
                                        Circle().stroke(Color.green, lineWidth: 1).frame(width: 28, height: 28)
                                        Image(systemName: "bitcoinsign.circle.fill").font(.system(size: 14)).foregroundColor(.yellow)
                                    }
                                    .offset(x: x, y: y)
                                    .rotationEffect(.degrees(rouletteRotation))
                                }
                            }
                            .frame(width: 220, height: 220)
                            
                            // Don Muerte 3D Character Preview with Green Spectral Flames
                            VStack(alignment: .leading, spacing: 4) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(LinearGradient(colors: [Color.green.opacity(0.3), Color.black], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 130, height: 150)
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.green, lineWidth: 1.5))
                                    
                                    VStack(spacing: 4) {
                                        Image(systemName: "skull.fill")
                                            .font(.system(size: 50))
                                            .foregroundColor(Color(red: 0.3, green: 0.95, blue: 0.5))
                                            .shadow(color: .green, radius: 8)
                                        
                                        Text("DON MUERTE")
                                            .font(.system(size: 11, weight: .black))
                                            .foregroundColor(.white)
                                    }
                                }
                                
                                Text("Conjunto Velador de Don Muerte")
                                    .font(.system(size: 10, weight: .black))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                
                                Text("Efecto de derribo y aura de fuego verde.")
                                    .font(.system(size: 8))
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }
                        }
                        
                        Spacer()
                        
                        // Spin Buttons (Exact match to video: 1 GIRO 15 Dia | 10 GIROS 125 Dia)
                        HStack(spacing: 20) {
                            // 1 Giro
                            Button(action: {
                                performSpin(count: 1)
                            }) {
                                VStack(spacing: 2) {
                                    Text("1 GIRO")
                                        .font(.system(size: 13, weight: .black))
                                        .foregroundColor(.white)
                                    HStack(spacing: 4) {
                                        Image(systemName: "diamond.fill").foregroundColor(.cyan).font(.system(size: 10))
                                        Text("15").font(.system(size: 12, weight: .black)).foregroundColor(.white)
                                    }
                                }
                                .frame(width: 140, height: 46)
                                .background(LinearGradient(colors: [Color.cyan, Color.blue], startPoint: .top, endPoint: .bottom))
                                .cornerRadius(6)
                            }
                            .disabled(isSpinning)
                            
                            // 10 Giros
                            Button(action: {
                                performSpin(count: 10)
                            }) {
                                VStack(spacing: 2) {
                                    Text("10 GIROS")
                                        .font(.system(size: 13, weight: .black))
                                        .foregroundColor(.black)
                                    HStack(spacing: 4) {
                                        Image(systemName: "diamond.fill").foregroundColor(.black).font(.system(size: 10))
                                        Text("125").font(.system(size: 12, weight: .black)).foregroundColor(.black)
                                    }
                                }
                                .frame(width: 140, height: 46)
                                .background(LinearGradient(colors: [Color.yellow, FreeFireTheme.gold, Color.orange], startPoint: .top, endPoint: .bottom))
                                .cornerRadius(6)
                            }
                            .disabled(isSpinning)
                        }
                        .padding(.bottom, 12)
                    }
                }
            }
            
            // Win Modal
            if showPrizeClaim {
                ZStack {
                    Color.black.opacity(0.8).ignoresSafeArea()
                    VStack(spacing: 12) {
                        Image(systemName: "sparkles").font(.system(size: 45)).foregroundColor(.green)
                        Text("¡FELICITACIONES!")
                            .font(.system(size: 18, weight: .black))
                            .foregroundColor(.green)
                        Text(prizeClaimMessage)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                        Button("CONTINUAR") {
                            showPrizeClaim = false
                        }
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(FreeFireTheme.gold)
                        .cornerRadius(6)
                    }
                    .padding(20)
                    .background(Color(white: 0.14))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
                }
            }
        }
    }
    
    private func performSpin(count: Int) {
        let cost = count == 1 ? 15 : 125
        guard userState.diamonds >= cost else { return }
        userState.diamonds -= cost
        isSpinning = true
        SoundManager.shared.playButtonClick()
        
        withAnimation(.easeOut(duration: 2.0)) {
            rouletteRotation += 1440 + Double.random(in: 45...360)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isSpinning = false
            userState.tokensDonMuerte += count * 2
            prizeClaimMessage = "¡Has ganado \(count * 2) Tokens Don Muerte y el aspecto Velador de Don Muerte!"
            userState.ownedCosmetics.insert("bundle_don_muerte")
            showPrizeClaim = true
            FreeFireTheme.booyahVictoryHaptic()
        }
    }
}
