import SwiftUI

struct BermudaMinimapView: View {
    let playerPos: CGPoint
    let safeZoneRadius: CGFloat
    
    var body: some View {
        ZStack {
            // Radar base with classic dark military green
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color(red: 0.12, green: 0.18, blue: 0.12), Color(red: 0.05, green: 0.08, blue: 0.05)],
                        center: .center,
                        startRadius: 10,
                        endRadius: 50
                    )
                )
                .frame(width: 96, height: 96)
                .overlay(
                    Circle().stroke(FreeFireTheme.gold.opacity(0.8), lineWidth: 2)
                )
            
            // Island land mass silhouette (Bermuda)
            Path { path in
                path.move(to: CGPoint(x: 24, y: 30))
                path.addQuadCurve(to: CGPoint(x: 75, y: 22), control: CGPoint(x: 48, y: 15))
                path.addQuadCurve(to: CGPoint(x: 82, y: 65), control: CGPoint(x: 85, y: 40))
                path.addQuadCurve(to: CGPoint(x: 40, y: 82), control: CGPoint(x: 65, y: 85))
                path.addQuadCurve(to: CGPoint(x: 18, y: 55), control: CGPoint(x: 20, y: 72))
                path.closeSubpath()
            }
            .fill(Color(red: 0.22, green: 0.32, blue: 0.18).opacity(0.7))
            
            // Bermuda Landmark Dots & Labels
            Group {
                // Peak (Center top)
                miniLabel(text: "PEAK", x: 48, y: 34, color: .yellow)
                // Clock Tower (Left)
                miniLabel(text: "CLOCK", x: 28, y: 48, color: .white)
                // Factory (Right)
                miniLabel(text: "FACTORY", x: 68, y: 52, color: .white)
                // Pochinok (Center bottom)
                miniLabel(text: "POCHINOK", x: 46, y: 66, color: .white)
                // Bimasakti (Center)
                miniLabel(text: "BIMA", x: 50, y: 44, color: .orange)
            }
            
            // Danger Zone (Zona Roja)
            Circle()
                .fill(Color.red.opacity(0.22))
                .frame(width: 28, height: 28)
                .overlay(Circle().stroke(Color.red.opacity(0.6), lineWidth: 1))
                .position(x: 65, y: 35)
            
            // Safe zone circle (white circle)
            Circle()
                .stroke(Color.white.opacity(0.85), lineWidth: 1.5)
                .frame(width: safeZoneRadius * 0.75, height: safeZoneRadius * 0.75)
            
            // Airdrop Drop Beacon icon
            Image(systemName: "shippingbox.fill")
                .font(.system(size: 8))
                .foregroundColor(.yellow)
                .position(x: 60, y: 45)
            
            // Player Arrow in Center
            ZStack {
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 7, height: 7)
                Image(systemName: "arrowtriangle.up.fill")
                    .font(.system(size: 9))
                    .foregroundColor(.yellow)
                    .offset(y: -4)
            }
            
            // Compass N
            Text("N")
                .font(.system(size: 9, weight: .black))
                .foregroundColor(FreeFireTheme.gold)
                .offset(y: -40)
        }
        .frame(width: 96, height: 96)
    }
    
    private func miniLabel(text: String, x: CGFloat, y: CGFloat, color: Color) -> some View {
        Text(text)
            .font(.system(size: 5, weight: .black))
            .foregroundColor(color.opacity(0.85))
            .position(x: x, y: y)
    }
}
