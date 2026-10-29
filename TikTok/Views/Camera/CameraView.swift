import SwiftUI

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isRecording: Bool = false
    @State private var selectedDuration: String = "PHOTO"
    @State private var selectedBottomMode: String = "CAMERA"
    @State private var flashOn: Bool = false
    
    let durations = ["10m", "60s", "15s", "PHOTO", "TEXT"]
    let bottomModes = ["CAMERA", "CREATE"]
    
    var body: some View {
        ZStack {
            // Viewfinder Camera simulation (matching dark aesthetic with blue ambient glow like keyboard in video)
            LinearGradient(
                colors: [Color(red: 0.05, green: 0.1, blue: 0.2), Color(red: 0.02, green: 0.03, blue: 0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                // Top controls (Frame 010)
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding(12)
                    }
                    
                    Spacer()
                    
                    // Add Sound Pill
                    HStack(spacing: 6) {
                        Image(systemName: "music.note")
                            .font(.system(size: 12, weight: .bold))
                        Text("Add sound")
                            .font(.system(size: 13, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 7)
                    .background(Color.black.opacity(0.45))
                    .cornerRadius(20)
                    
                    Spacer()
                    
                    // Placeholder spacing for symmetry
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.top, 44)
                .padding(.horizontal, 10)
                
                // Right controls toolbar (Frame 010: Flip, Flash, Timer, Filters, Beautify, Expand)
                HStack {
                    Spacer()
                    VStack(spacing: 22) {
                        // Flip
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                        
                        // Flash
                        Button(action: {
                            TikTokTheme.haptic(.light)
                            flashOn.toggle()
                        }) {
                            Image(systemName: flashOn ? "bolt.fill" : "bolt.slash")
                                .font(.system(size: 22))
                                .foregroundColor(flashOn ? .yellow : .white)
                        }
                        
                        // Timer
                        Image(systemName: "timer")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                        
                        // Filters Grid
                        Image(systemName: "square.grid.2x2")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                        
                        // Beautify / Face
                        Image(systemName: "sparkles")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                        
                        // Expand
                        Image(systemName: "chevron.down")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 16)
                }
                .padding(.top, 10)
                
                Spacer()
                
                // Duration Mode Selector: 10m | 60s | 15s | PHOTO | TEXT (Frame 010)
                HStack(spacing: 18) {
                    ForEach(durations, id: \.self) { mode in
                        Button(action: {
                            TikTokTheme.haptic(.light)
                            selectedDuration = mode
                        }) {
                            Text(mode)
                                .font(.system(size: 12, weight: .heavy))
                                .foregroundColor(selectedDuration == mode ? .black : .white)
                                .padding(.horizontal, selectedDuration == mode ? 12 : 4)
                                .padding(.vertical, selectedDuration == mode ? 6 : 4)
                                .background(selectedDuration == mode ? Color.white : Color.clear)
                                .cornerRadius(14)
                        }
                    }
                }
                .padding(.bottom, 22)
                
                // Bottom controls: Gallery Upload | Shutter Button | Effects (Frame 010)
                HStack(spacing: 32) {
                    // Gallery Upload Thumbnail
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.15, green: 0.35, blue: 0.3))
                        .frame(width: 44, height: 44)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2)
                        )
                    
                    // Shutter Button
                    Button(action: {
                        TikTokTheme.haptic(.heavy)
                        withAnimation(.spring(response: 0.25)) {
                            isRecording.toggle()
                        }
                    }) {
                        ZStack {
                            Circle()
                                .stroke(Color.white, lineWidth: 5)
                                .frame(width: 82, height: 82)
                            
                            if selectedDuration == "PHOTO" {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 66, height: 66)
                            } else {
                                if isRecording {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(TikTokTheme.red)
                                        .frame(width: 30, height: 30)
                                } else {
                                    Circle()
                                        .fill(TikTokTheme.red)
                                        .frame(width: 66, height: 66)
                                }
                            }
                        }
                    }
                    
                    // Face / Effects Thumbnails
                    HStack(spacing: 10) {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 44, height: 44)
                            .overlay(
                                Text("😜")
                                    .font(.system(size: 24))
                            )
                        
                        Circle()
                            .fill(Color.purple.opacity(0.4))
                            .frame(width: 44, height: 44)
                            .overlay(
                                Text("💃")
                                    .font(.system(size: 24))
                            )
                    }
                }
                .padding(.bottom, 18)
                
                // Mode switcher at very bottom: CAMERA | CREATE (Frame 010)
                HStack(spacing: 24) {
                    ForEach(bottomModes, id: \.self) { bMode in
                        Button(action: {
                            TikTokTheme.haptic(.light)
                            selectedBottomMode = bMode
                        }) {
                            Text(bMode)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(selectedBottomMode == bMode ? .white : .gray)
                        }
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}
