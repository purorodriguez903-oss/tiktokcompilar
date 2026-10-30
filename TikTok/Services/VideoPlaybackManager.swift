import UIKit
import AVFoundation

final class VideoPlayerUIView: UIView {
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    private var endObserverToken: Any?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        playerLayer.videoGravity = .resizeAspectFill
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .black
        playerLayer.videoGravity = .resizeAspectFill
    }
    
    func configure(with urlString: String) {
        cleanUp()
        guard let url = URL(string: urlString) else { return }
        
        let asset = AVURLAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: item)
        player.actionAtItemEnd = .none
        player.automaticallyWaitsToMinimizeStalling = false
        
        playerLayer.player = player
        
        // Loop video smoothly
        endObserverToken = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: item,
            queue: .main
        ) { [weak player] _ in
            player?.seek(to: .zero, toleranceBefore: .zero, toleranceAfter: .zero)
            player?.play()
        }
    }
    
    func play() {
        playerLayer.player?.play()
    }
    
    func pause() {
        playerLayer.player?.pause()
    }
    
    func stopAndReset() {
        playerLayer.player?.pause()
        playerLayer.player?.seek(to: .zero)
    }
    
    func cleanUp() {
        if let token = endObserverToken {
            NotificationCenter.default.removeObserver(token)
            endObserverToken = nil
        }
        playerLayer.player?.pause()
        playerLayer.player = nil
    }
    
    deinit {
        cleanUp()
    }
}
