import SwiftUI

struct TikTokLoaderView: View {
    @State private var isAnimating: Bool = false
    var dotSize: CGFloat = 14
    var distance: CGFloat = 20
    
    var body: some View {
        ZStack {
            // Cyan Dot
            Circle()
                .fill(TikTokTheme.cyan)
                .frame(width: dotSize, height: dotSize)
                .scaleEffect(isAnimating ? 1.15 : 0.85)
                .offset(x: isAnimating ? distance : -distance)
                .zIndex(isAnimating ? 1 : 0)
            
            // Red Dot
            Circle()
                .fill(TikTokTheme.red)
                .frame(width: dotSize, height: dotSize)
                .scaleEffect(isAnimating ? 0.85 : 1.15)
                .offset(x: isAnimating ? -distance : distance)
                .zIndex(isAnimating ? 0 : 1)
        }
        .onAppear {
            withAnimation(
                Animation.easeInOut(duration: 0.6)
                    .repeatForever(autoreverses: true)
            ) {
                isAnimating = true
            }
        }
    }
}

