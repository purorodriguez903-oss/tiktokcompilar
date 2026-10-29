import SwiftUI

struct MarqueeText: View {
    let text: String
    @State private var offset: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "music.note")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.white)
            
            GeometryReader { geo in
                let fullText = "\(text)      \(text)      \(text)"
                Text(fullText)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .fixedSize()
                    .offset(x: offset)
                    .onAppear {
                        withAnimation(
                            Animation.linear(duration: 8.0)
                                .repeatForever(autoreverses: false)
                        ) {
                            offset = -geo.size.width * 1.5
                        }
                    }
            }
            .frame(height: 18)
            .clipped()
        }
    }
}

