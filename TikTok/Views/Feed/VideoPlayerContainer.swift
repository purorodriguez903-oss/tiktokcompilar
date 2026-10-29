import SwiftUI
import AVKit

struct VideoPlayerRepresentable: UIViewControllerRepresentable {
    let videoUrl: String
    @Binding var isPlaying: Bool
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        
        if let url = URL(string: videoUrl) {
            let player = AVPlayer(url: url)
            controller.player = player
            
            // Loop video
            NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: player.currentItem,
                queue: .main
            ) { _ in
                player.seek(to: .zero)
                if self.isPlaying {
                    player.play()
                }
            }
            
            if isPlaying {
                player.play()
            }
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if let player = uiViewController.player {
            if isPlaying {
                player.play()
            } else {
                player.pause()
            }
        }
    }
}

struct VideoPlayerContainer: View {
    let video: VideoItem
    let isActive: Bool
    @State private var isPlaying: Bool = true
    @State private var showPlayPauseIcon: Bool = false
    
    var body: some View {
        ZStack {
            // Background gradient fallback
            LinearGradient(
                colors: video.bgGradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Native AVPlayer
            VideoPlayerRepresentable(videoUrl: video.videoUrl, isPlaying: $isPlaying)
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
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                showPlayPauseIcon = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeOut(duration: 0.3)) {
                    showPlayPauseIcon = false
                }
            }
        }
    }
}
