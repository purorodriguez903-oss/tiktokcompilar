import SwiftUI

struct TikTokPlusButton: View {
    var body: some View {
        ZStack {
            // Cyan background offset to left
            RoundedRectangle(cornerRadius: 8)
                .fill(TikTokTheme.cyan)
                .frame(width: 44, height: 28)
                .offset(x: -3)
            
            // Magenta / Red background offset to right
            RoundedRectangle(cornerRadius: 8)
                .fill(TikTokTheme.red)
                .frame(width: 44, height: 28)
                .offset(x: 3)
            
            // White center pill
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .frame(width: 40, height: 28)
            
            // Black plus symbol
            Image(systemName: "plus")
                .font(.system(size: 14, weight: .black))
                .foregroundColor(.black)
        }
        .frame(width: 50, height: 32)
    }
}

