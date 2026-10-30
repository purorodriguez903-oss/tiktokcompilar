import SwiftUI

struct TikTokSplashScreen: View {
    @Binding var isPresented: Bool
    @State private var scale: CGFloat = 0.95
    @State private var opacity: Double = 1.0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 16) {
                // TikTok Chromatic Glyph
                ZStack {
                    // Cyan offset
                    Image(systemName: "music.note")
                        .font(.system(size: 78, weight: .bold))
                        .foregroundColor(TikTokTheme.cyan)
                        .offset(x: -4, y: 3)
                    
                    // Red offset
                    Image(systemName: "music.note")
                        .font(.system(size: 78, weight: .bold))
                        .foregroundColor(TikTokTheme.red)
                        .offset(x: 4, y: -3)
                    
                    // White main
                    Image(systemName: "music.note")
                        .font(.system(size: 78, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text("TikTok")
                    .font(.system(size: 38, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .tracking(1)
            }
            .scaleEffect(scale)
            .opacity(opacity)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                scale = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation(.easeOut(duration: 0.4)) {
                    opacity = 0.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    isPresented = false
                }
            }
        }
    }
}

