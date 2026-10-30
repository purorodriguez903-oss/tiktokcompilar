import SwiftUI
import AVFoundation

struct OptimizedPlayerRepresentable: UIViewRepresentable {
    let videoUrl: String
    let isActive: Bool
    @Binding var isPlaying: Bool
    
    func makeUIView(context: Context) -> VideoPlayerUIView {
        let view = VideoPlayerUIView(frame: .zero)
        if isActive {
            view.configure(with: videoUrl)
            if isPlaying {
                view.play()
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: VideoPlayerUIView, context: Context) {
        if isActive {
            if uiView.playerLayer.player == nil {
                uiView.configure(with: videoUrl)
            }
            if isPlaying {
                uiView.play()
            } else {
                uiView.pause()
            }
        } else {
            uiView.stopAndReset()
            // Release memory for offscreen videos
            uiView.cleanUp()
        }
    }
    
    static func dismantleUIView(_ uiView: VideoPlayerUIView, coordinator: ()) {
        uiView.cleanUp()
    }
}

struct VideoPlayerContainer: View {
    let video: VideoItem
    let isActive: Bool
    @State private var isPlaying: Bool = true
    @State private var showPlayPauseIcon: Bool = false
    
    var body: some View {
        ZStack {
            // Background fallback gradient
            LinearGradient(
                colors: video.bgGradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Ultra-lightweight GPU AVPlayerLayer
            OptimizedPlayerRepresentable(
                videoUrl: video.videoUrl,
                isActive: isActive,
                isPlaying: $isPlaying
            )
            .ignoresSafeArea()
            .opacity(isActive ? 1.0 : 0.0)
            
            // Play / Pause Indicator Icon
            if showPlayPauseIcon {
                Image(systemName: isPlaying ? "play.fill" : "pause.fill")
                    .font(.system(size: 64))
                    .foregroundColor(Color.white.opacity(0.85))
                    .shadow(radius: 8)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .onChange(of: isActive) { active in
            isPlaying = active
        }
        .onTapGesture {
            isPlaying.toggle()
            withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) {
                showPlayPauseIcon = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeOut(duration: 0.25)) {
                    showPlayPauseIcon = false
                }
            }
        }
    }
}
