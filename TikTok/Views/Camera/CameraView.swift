import SwiftUI

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isRecording: Bool = false
    @State private var selectedSpeed: String = "1x"
    @State private var selectedDuration: String = "15s"
    @State private var flashOn: Bool = false
    @State private var timerActive: Bool = false
    
    let speeds = ["0.3x", "0.5x", "1x", "2x", "3x"]
    let durations = ["10m", "60s", "15s", "Foto", "Texto"]
    
    var body: some View {
        ZStack {
            // Viewfinder Camera simulation background
            LinearGradient(
                colors: [Color(white: 0.12), Color(white: 0.05)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                // Top controls
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
                            .font(.system(size: 13, weight: .bold))
                        Text("Añadir sonido")
                            .font(.system(size: 13, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(20)
                    
                    Spacer()
                    
                    // Flash
                    Button(action: {
                        TikTokTheme.haptic(.light)
                        flashOn.toggle()
                    }) {
                        Image(systemName: flashOn ? "bolt.fill" : "bolt.slash.fill")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(flashOn ? .yellow : .white)
                            .padding(12)
                    }
                }
                .padding(.top, 40)
                .padding(.horizontal, 10)
                
                Spacer()
                
                // Right controls toolbar
                HStack {
                    Spacer()
                    VStack(spacing: 20) {
                        // Flip
                        VStack(spacing: 4) {
                            Image(systemName: "camera.rotate.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            Text("Girar")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.white)
                        }
                        
                        // Speed
                        VStack(spacing: 4) {
                            Image(systemName: "gauge.with.needle.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            Text("Velocidad")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.white)
                        }
                        
                        // Filters
                        VStack(spacing: 4) {
                            Image(systemName: "camera.filters")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            Text("Filtros")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.white)
                        }
                        
                        // Beautify
                        VStack(spacing: 4) {
                            Image(systemName: "wand.and.stars")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            Text("Embellecer")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.white)
                        }
                        
                        // Timer
                        VStack(spacing: 4) {
                            Image(systemName: "timer")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            Text("Tiempo")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.trailing, 16)
                }
                
                Spacer()
                
                // Speed Selector row
                HStack(spacing: 16) {
                    ForEach(speeds, id: \.self) { sp in
                        Button(action: {
                            TikTokTheme.haptic(.light)
                            selectedSpeed = sp
                        }) {
                            Text(sp)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(selectedSpeed == sp ? .black : .white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(selectedSpeed == sp ? Color.white : Color.black.opacity(0.4))
                                .cornerRadius(6)
                        }
                    }
                }
                .padding(.bottom, 16)
                
                // Bottom controls: Effects | Record Button | Gallery
                HStack(spacing: 40) {
                    // Effects
                    VStack(spacing: 4) {
                        Circle()
                            .fill(LinearGradient(colors: [Color.purple, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: "sparkles")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            )
                        Text("Efectos")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    // Big Red Record Button
                    Button(action: {
                        TikTokTheme.haptic(.heavy)
                        withAnimation(.spring(response: 0.3)) {
                            isRecording.toggle()
                        }
                    }) {
                        ZStack {
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                                .frame(width: 82, height: 82)
                            
                            if isRecording {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(TikTokTheme.red)
                                    .frame(width: 32, height: 32)
                            } else {
                                Circle()
                                    .fill(TikTokTheme.red)
                                    .frame(width: 68, height: 68)
                            }
                        }
                    }
                    
                    // Upload Gallery
                    VStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(white: 0.25))
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            )
                        Text("Cargar")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 20)
                
                // Duration Mode Selector
                HStack(spacing: 24) {
                    ForEach(durations, id: \.self) { mode in
                        Button(action: {
                            TikTokTheme.haptic(.light)
                            selectedDuration = mode
                        }) {
                            Text(mode)
                                .font(.system(size: 14, weight: selectedDuration == mode ? .bold : .medium))
                                .foregroundColor(selectedDuration == mode ? .white : .gray)
                        }
                    }
                }
                .padding(.bottom, 24)
            }
        }
    }
}
