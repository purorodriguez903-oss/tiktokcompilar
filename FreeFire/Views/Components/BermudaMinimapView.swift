import SwiftUI

struct BermudaMinimapView: View {
    let playerPos: CGPoint
    let safeZoneRadius: CGFloat
    
    var body: some View {
        ZStack {
            // Radar base
            Circle()
                .fill(Color(red: 0.1, green: 0.14, blue: 0.1).opacity(0.85))
                .frame(width: 86, height: 86)
                .overlay(
                    Circle().stroke(Color(white: 0.35), lineWidth: 1.5)
                )
            
            // Grid lines
            Path { path in
                path.move(to: CGPoint(x: 43, y: 0))
                path.addLine(to: CGPoint(x: 43, y: 86))
                path.move(to: CGPoint(x: 0, y: 43))
                path.addLine(to: CGPoint(x: 86, y: 43))
            }
            .stroke(Color.white.opacity(0.15), lineWidth: 1)
            
            // Safe zone circle (white)
            Circle()
                .stroke(Color.white.opacity(0.7), lineWidth: 1.5)
                .frame(width: safeZoneRadius * 0.7, height: safeZoneRadius * 0.7)
            
            // Player arrow / dot in center
            Circle()
                .fill(Color.yellow)
                .frame(width: 8, height: 8)
                .overlay(
                    Circle().stroke(Color.black, lineWidth: 1)
                )
            
            // North indicator
            Text("N")
                .font(.system(size: 8, weight: .black))
                .foregroundColor(.white)
                .offset(y: -36)
        }
        .frame(width: 86, height: 86)
    }
}
