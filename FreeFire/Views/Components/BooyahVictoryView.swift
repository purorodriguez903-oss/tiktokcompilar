import SwiftUI

struct BooyahVictoryView: View {
    let kills: Int
    let damage: Int
    let onReturnToLobby: () -> Void
    
    @State private var scale: CGFloat = 0.4
    @State private var opacity: Double = 0.0
    @State private var flameOffset: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            // Dark vignette backdrop
            Color.black.opacity(0.8).ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Golden Fiery BOOYAH Banner (Classic 2019)
                ZStack {
                    // Flaming Glow
                    Text("BOOYAH!")
                        .font(.system(size: 64, weight: .black, design: .rounded))
                        .foregroundColor(Color.orange)
                        .blur(radius: 12)
                        .offset(y: flameOffset)
                    
                    Text("BOOYAH!")
                        .font(.system(size: 64, weight: .black, design: .rounded))
                        .foregroundColor(FreeFireTheme.booyahYellow)
                        .shadow(color: .red, radius: 4, x: 0, y: 3)
                }
                .scaleEffect(scale)
                .opacity(opacity)
                
                // Match Results Card
                VStack(spacing: 12) {
                    Text("¡VICTORIA EN BERMUDA #1!")
                        .font(.system(size: 14, weight: .black))
                        .foregroundColor(FreeFireTheme.gold)
                        .tracking(2)
                    
                    Divider().background(Color(white: 0.3))
                    
                    HStack(spacing: 36) {
                        VStack(spacing: 4) {
                            Text("\(kills)")
                                .font(.system(size: 26, weight: .black))
                                .foregroundColor(.white)
                            Text("KILLS")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.gray)
                        }
                        
                        VStack(spacing: 4) {
                            Text("\(damage)")
                                .font(.system(size: 26, weight: .black))
                                .foregroundColor(.white)
                            Text("DAÑO")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.gray)
                        }
                        
                        VStack(spacing: 4) {
                            Text("+48")
                                .font(.system(size: 26, weight: .black))
                                .foregroundColor(.green)
                            Text("RANGO")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(.yellow)
                        Text("+350 Oro ganados")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 4)
                }
                .padding(20)
                .background(FreeFireTheme.panelBg)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(FreeFireTheme.cardBorder, lineWidth: 2)
                )
                .cornerRadius(10)
                
                // Return to Lobby Button
                Button(action: {
                    FreeFireTheme.booyahVictoryHaptic()
                    onReturnToLobby()
                }) {
                    Text("REGRESAR AL LOBBY")
                        .font(.system(size: 15, weight: .black))
                        .foregroundColor(.black)
                        .frame(width: 260, height: 48)
                        .background(FreeFireTheme.gold)
                        .cornerRadius(6)
                        .shadow(color: .orange.opacity(0.5), radius: 8)
                }
            }
        }
        .onAppear {
            FreeFireTheme.booyahVictoryHaptic()
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                scale = 1.0
                opacity = 1.0
            }
            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                flameOffset = -4
            }
        }
    }
}
