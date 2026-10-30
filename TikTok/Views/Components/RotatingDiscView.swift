import SwiftUI

struct RotatingDiscView: View {
    let avatarUrl: String
    @State private var rotation: Double = 0
    @State private var animateNotes: Bool = false
    
    var body: some View {
        ZStack {
            // Floating music notes
            ZStack {
                Text("♪")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color.white.opacity(0.8))
                    .offset(x: animateNotes ? -20 : -10, y: animateNotes ? -40 : 0)
                    .scaleEffect(animateNotes ? 1.2 : 0.6)
                    .opacity(animateNotes ? 0 : 0.9)
                
                Text("♫")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color.white.opacity(0.7))
                    .offset(x: animateNotes ? -35 : -15, y: animateNotes ? -60 : -10)
                    .scaleEffect(animateNotes ? 1.0 : 0.4)
                    .opacity(animateNotes ? 0 : 0.8)
            }
            .animation(
                Animation.easeInOut(duration: 2.2).repeatForever(autoreverses: false),
                value: animateNotes
            )
            
            // Vinyl Record Disc
            ZStack {
                Circle()
                    .fill(Color(white: 0.14))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Circle()
                            .stroke(Color(white: 0.28), lineWidth: 1.5)
                    )
                
                // Grooves
                Circle()
                    .stroke(Color(white: 0.22), lineWidth: 1)
                    .frame(width: 38, height: 38)
                
                // Center Album Cover with Cached Image
                CachedAsyncImageView(
                    urlString: avatarUrl,
                    targetSize: CGSize(width: 26, height: 26)
                )
                .frame(width: 26, height: 26)
                .clipShape(Circle())
            }
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 4.5).repeatForever(autoreverses: false)
                ) {
                    rotation = 360
                }
                animateNotes = true
            }
        }
    }
}
