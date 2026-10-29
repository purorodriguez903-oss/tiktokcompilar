import SwiftUI

struct FloatingHeartItem: Identifiable {
    let id = UUID()
    let point: CGPoint
    let rotation: Double
    var scale: CGFloat = 0.2
    var opacity: Double = 1.0
    var offsetY: CGFloat = 0
}

struct FloatingHeartsView: View {
    @Binding var hearts: [FloatingHeartItem]
    
    var body: some View {
        ZStack {
            ForEach(hearts) { heart in
                Image(systemName: "heart.fill")
                    .font(.system(size: 72))
                    .foregroundColor(TikTokTheme.red)
                    .shadow(color: Color.black.opacity(0.4), radius: 6, x: 0, y: 3)
                    .scaleEffect(heart.scale)
                    .rotationEffect(.degrees(heart.rotation))
                    .opacity(heart.opacity)
                    .offset(y: heart.offsetY)
                    .position(heart.point)
            }
        }
        .allowsHitTesting(false)
    }
}
