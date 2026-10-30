import SwiftUI

struct SplashScreenView: View {
    @Binding var isGameLoaded: Bool
    @State private var loadingProgress: CGFloat = 0.0
    @State private var tipIndex: Int = 0
    @State private var showGarenaLogo: Bool = true
    @State private var showTapToStart: Bool = false
    
    let tips = [
        "Consejo: Usa las paredes Gloo para cubrirte en campo abierto.",
        "Consejo: El chaleco nivel 3 absorbe hasta un 65% de daño recibido.",
        "Consejo: Los hongos aumentan tu barra de EP para regenerar vida gradualmente.",
        "Consejo: Apuntar a la cabeza inflige daño crítico con cualquier arma."
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if showGarenaLogo {
                // Garena Iconic Red & White Splash
                VStack(spacing: 16) {
                    Circle()
                        .fill(Color(red: 0.9, green: 0.1, blue: 0.15))
                        .frame(width: 90, height: 90)
                        .overlay(
                            Text("G")
                                .font(.system(size: 56, weight: .black, design: .serif))
                                .foregroundColor(.white)
                        )
                    
                    Text("GARENA")
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .tracking(6)
                }
                .transition(.opacity)
            } else {
                // Free Fire 2019 Classic Wallpaper & Loading Bar
                ZStack {
                    // Military camouflage gradient backdrop
                    LinearGradient(
                        colors: [Color(red: 0.1, green: 0.14, blue: 0.1), Color(red: 0.05, green: 0.06, blue: 0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    
                    VStack(spacing: 14) {
                        Spacer()
                        
                        // Classic Free Fire 2019 Logo
                        VStack(spacing: 2) {
                            Text("FREE FIRE")
                                .font(.system(size: 44, weight: .black, design: .rounded))
                                .foregroundColor(FreeFireTheme.gold)
                                .shadow(color: .orange, radius: 10)
                            
                            Text("BATTLEGROUNDS • EDICIÓN 2019")
                                .font(.system(size: 13, weight: .heavy))
                                .foregroundColor(Color.white.opacity(0.85))
                                .tracking(3)
                        }
                        
                        Spacer()
                        
                        if showTapToStart {
                            // Tap to start screen
                            VStack(spacing: 16) {
                                Button(action: {
                                    FreeFireTheme.booyahVictoryHaptic()
                                    withAnimation { isGameLoaded = true }
                                }) {
                                    HStack {
                                        Text("INICIAR SESIÓN (INVITADO)")
                                            .font(.system(size: 16, weight: .black))
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 320, height: 50)
                                    .background(FreeFireTheme.gold)
                                    .cornerRadius(6)
                                    .shadow(color: .orange.opacity(0.5), radius: 8)
                                }
                                
                                Text("TOCA LA PANTALLA PARA ENTRAR AL LOBBY")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding(.bottom, 40)
                            .transition(.scale.combined(with: .opacity))
                        } else {
                            // Loading Progress Bar
                            VStack(spacing: 8) {
                                Text(tips[tipIndex])
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(Color.white.opacity(0.75))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                                
                                // Outer Bar
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(white: 0.15))
                                        .frame(width: 320, height: 10)
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(
                                            LinearGradient(
                                                colors: [FreeFireTheme.gold, .yellow],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .frame(width: 320 * loadingProgress, height: 10)
                                }
                                
                                Text("Cargando archivos del juego... \(Int(loadingProgress * 100))%")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.white.opacity(0.9))
                            }
                            .padding(.bottom, 40)
                        }
                    }
                }
            }
        }
        .onAppear {
            // Dismiss Garena logo after 1.5s
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 0.4)) {
                    showGarenaLogo = false
                }
                startLoadingProgress()
            }
        }
    }
    
    private func startLoadingProgress() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if loadingProgress < 1.0 {
                loadingProgress += 0.03
                if loadingProgress > 0.5 && tipIndex == 0 {
                    tipIndex = 1
                }
            } else {
                timer.invalidate()
                withAnimation(.spring()) {
                    showTapToStart = true
                }
            }
        }
    }
}

