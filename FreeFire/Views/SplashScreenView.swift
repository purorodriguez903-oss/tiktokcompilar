import SwiftUI

struct SplashScreenView: View {
    @Binding var isGameLoaded: Bool
    @ObservedObject var userState = UserState.shared
    
    @State private var rasenganRotation: Double = 0.0
    @State private var auraPulse: CGFloat = 1.0
    @State private var showCloseSessionModal: Bool = false
    @State private var isLoadingLobby: Bool = false
    @State private var chakraParticles: Bool = false
    
    var body: some View {
        ZStack {
            // Background: Naruto Kurama Mode Fiery Amber Backdrop
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.95, green: 0.55, blue: 0.0),
                        Color(red: 0.8, green: 0.35, blue: 0.0),
                        Color(red: 0.4, green: 0.12, blue: 0.02)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Fiery Chakra Radiance
                RadialGradient(
                    colors: [
                        Color(red: 1.0, green: 0.9, blue: 0.3).opacity(0.8),
                        Color(red: 1.0, green: 0.5, blue: 0.0).opacity(0.4),
                        Color.clear
                    ],
                    center: .center,
                    startRadius: 40,
                    endRadius: 360
                )
                .ignoresSafeArea()
                .scaleEffect(auraPulse)
            }
            
            // Naruto Kurama Face Silhouette & Rasengan Spiral (Exact match to video)
            ZStack {
                // Naruto Headband Band & Whiskers Markings
                VStack(spacing: 6) {
                    // Konoha Leaf Metal Plate
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(LinearGradient(colors: [Color.gray, Color.white, Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 90, height: 32)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.black, lineWidth: 1.5))
                        
                        // Konoha Leaf Symbol
                        Image(systemName: "leaf.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                    .offset(y: -50)
                    
                    // Golden Glowing Eyes (Sage / Kurama Mode)
                    HStack(spacing: 38) {
                        Circle().fill(Color.orange).frame(width: 14, height: 14)
                            .overlay(Circle().fill(Color.yellow).frame(width: 8, height: 8))
                            .shadow(color: .yellow, radius: 8)
                        Circle().fill(Color.orange).frame(width: 14, height: 14)
                            .overlay(Circle().fill(Color.yellow).frame(width: 8, height: 8))
                            .shadow(color: .yellow, radius: 8)
                    }
                    .offset(y: -35)
                }
                
                // Rotating Rasengan Chakra Rings
                ZStack {
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [Color.white, Color.cyan.opacity(0.8), Color.yellow.opacity(0.8), Color.white],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 5
                        )
                        .frame(width: 240, height: 240)
                        .rotationEffect(.degrees(rasenganRotation))
                    
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [Color.yellow, Color.orange, Color.white],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 3
                        )
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(-rasenganRotation * 1.5))
                    
                    // Core Energy Flare
                    Circle()
                        .fill(RadialGradient(colors: [Color.white, Color.yellow.opacity(0.6), Color.clear], center: .center, startRadius: 10, endRadius: 70))
                        .frame(width: 130, height: 130)
                }
            }
            
            // UI Overlay (Exact layout from user's video)
            VStack {
                // Top Bar: Version 1.132.15 (Left) | FREE FIRE Logo (Right)
                HStack(alignment: .top) {
                    Text("1.132.15")
                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                        .foregroundColor(.white.opacity(0.85))
                        .padding(.leading, 24)
                        .padding(.top, 14)
                    
                    Spacer()
                    
                    // Official Free Fire Modern Logo
                    HStack(spacing: 4) {
                        Text("FREE FIRE")
                            .font(.system(size: 26, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.8), radius: 4)
                        
                        Image(systemName: "flame.fill")
                            .font(.system(size: 20))
                            .foregroundColor(FreeFireTheme.gold)
                    }
                    .padding(.trailing, 24)
                    .padding(.top, 14)
                }
                
                Spacer()
                
                // Center / Bottom Touch to Start Banner
                Button(action: {
                    SoundManager.shared.playButtonClick()
                    FreeFireTheme.booyahVictoryHaptic()
                    isLoadingLobby = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            isGameLoaded = true
                        }
                    }
                }) {
                    VStack(spacing: 8) {
                        if isLoadingLobby {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.5)
                        } else {
                            Text("TOCA LA PANTALLA PARA INICIAR")
                                .font(.system(size: 16, weight: .black))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 4)
                            
                            Text("Conectado como: \(userState.loginState)")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.yellow)
                        }
                    }
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                }
                
                Spacer()
                
                // Bottom Bar: Google CERRAR SESIÓN button (Bottom Left)
                HStack {
                    Button(action: {
                        showCloseSessionModal = true
                        SoundManager.shared.playButtonClick()
                    }) {
                        HStack(spacing: 8) {
                            ZStack {
                                Circle().fill(Color.white).frame(width: 22, height: 22)
                                Text("G")
                                    .font(.system(size: 14, weight: .black))
                                    .foregroundColor(.blue)
                            }
                            Text("CERRAR SESIÓN")
                                .font(.system(size: 12, weight: .black))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(6)
                        .shadow(color: .black.opacity(0.3), radius: 4)
                    }
                    .padding(.leading, 24)
                    .padding(.bottom, 16)
                    
                    Spacer()
                }
            }
            
            // CERRAR SESIÓN Dialog (Exact match from video ff2019_06.jpg)
            if showCloseSessionModal {
                ZStack {
                    Color.black.opacity(0.7).ignoresSafeArea()
                    
                    VStack(spacing: 16) {
                        HStack {
                            Text("CERRAR SESIÓN")
                                .font(.system(size: 15, weight: .black))
                                .foregroundColor(.white)
                            Spacer()
                            Button(action: { showCloseSessionModal = false }) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, 4)
                        
                        Divider().background(Color.yellow.opacity(0.4))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 8) {
                                Circle().fill(Color.yellow).frame(width: 8, height: 8)
                                Text("Cerrar sesión de la cuenta actual.")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            HStack(spacing: 8) {
                                Circle().stroke(Color.gray, lineWidth: 1.5).frame(width: 8, height: 8)
                                Text("Cerrar sesión en todos los dispositivos.")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button(action: {
                            showCloseSessionModal = false
                        }) {
                            Text("CERRAR SESIÓN")
                                .font(.system(size: 13, weight: .black))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(FreeFireTheme.gold)
                                .cornerRadius(6)
                        }
                    }
                    .padding(20)
                    .frame(width: 380)
                    .background(Color(white: 0.12))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.yellow.opacity(0.6), lineWidth: 1.5))
                }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
                rasenganRotation = 360
            }
            withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
                auraPulse = 1.08
            }
        }
    }
}
