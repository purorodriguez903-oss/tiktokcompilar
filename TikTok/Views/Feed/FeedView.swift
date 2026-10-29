import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel: FeedViewModel
    @ObservedObject var languageManager = LanguageManager.shared
    @State private var floatingHearts: [FloatingHeartItem] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()
            
            // Fullscreen vertical paging video list
            GeometryReader { geometry in
                TabView(selection: $viewModel.currentVideoIndex) {
                    ForEach(Array(viewModel.currentVideos.enumerated()), id: \.element.id) { index, video in
                        ZStack {
                            VideoPlayerContainer(
                                video: video,
                                isActive: viewModel.currentVideoIndex == index
                            )
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            
                            // Bottom gradient shade for readability
                            LinearGradient(
                                colors: [Color.clear, Color.black.opacity(0.75)],
                                startPoint: .center,
                                endPoint: .bottom
                            )
                            .ignoresSafeArea()
                            .allowsHitTesting(false)
                            
                            // Overlay: user info & action buttons
                            FeedOverlayView(video: video, viewModel: viewModel)
                                .padding(.bottom, 60) // Above tab bar
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .ignoresSafeArea()
            
            // Double-tap hearts
            FloatingHeartsView(hearts: $floatingHearts)
            
            // Double tap gesture detector overlay
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture(count: 2) { location in
                    handleDoubleTap(at: location)
                }
            
            // Top Bar: LIVE | Siguiendo - Para ti | Buscar
            HStack(spacing: 20) {
                // Live Button
                Button(action: {
                    TikTokTheme.haptic(.light)
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "dot.radiowaves.left.and.right")
                            .font(.system(size: 15))
                        Text(languageManager.t("feed_live"))
                            .font(.system(size: 13, weight: .bold))
                    }
                    .foregroundColor(Color.white.opacity(0.85))
                }
                
                Spacer()
                
                // Tabs: Siguiendo & Para ti
                HStack(spacing: 16) {
                    // Following
                    Button(action: {
                        withAnimation { viewModel.feedType = .following }
                    }) {
                        VStack(spacing: 4) {
                            Text(languageManager.t("feed_following"))
                                .font(.system(size: 17, weight: viewModel.feedType == .following ? .bold : .medium))
                                .foregroundColor(viewModel.feedType == .following ? .white : Color.white.opacity(0.6))
                            
                            Rectangle()
                                .fill(viewModel.feedType == .following ? Color.white : Color.clear)
                                .frame(width: 28, height: 2)
                                .cornerRadius(1)
                        }
                    }
                    
                    // For You
                    Button(action: {
                        withAnimation { viewModel.feedType = .forYou }
                    }) {
                        VStack(spacing: 4) {
                            Text(languageManager.t("feed_foryou"))
                                .font(.system(size: 17, weight: viewModel.feedType == .forYou ? .bold : .medium))
                                .foregroundColor(viewModel.feedType == .forYou ? .white : Color.white.opacity(0.6))
                            
                            Rectangle()
                                .fill(viewModel.feedType == .forYou ? Color.white : Color.clear)
                                .frame(width: 28, height: 2)
                                .cornerRadius(1)
                        }
                    }
                }
                
                Spacer()
                
                // Search Button
                Button(action: {
                    TikTokTheme.haptic(.light)
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 50)
        }
        .sheet(isPresented: $viewModel.showCommentsSheet) {
            if let video = viewModel.selectedVideoForComments {
                CommentsSheetView(video: video, viewModel: viewModel)
                    .presentationDetents([.fraction(0.65), .large])
                    .presentationDragIndicator(.visible)
            }
        }
        .sheet(isPresented: $viewModel.showShareSheet) {
            if let video = viewModel.selectedVideoForShare {
                ShareSheetView(video: video)
                    .presentationDetents([.fraction(0.38)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
    
    private func handleDoubleTap(at location: CGPoint) {
        TikTokTheme.haptic(.heavy)
        
        let currentVideos = viewModel.currentVideos
        if viewModel.currentVideoIndex < currentVideos.count {
            let video = currentVideos[viewModel.currentVideoIndex]
            if !video.isLiked {
                viewModel.toggleLike(for: video.id)
            }
        }
        
        var heart = FloatingHeartItem(
            point: location,
            rotation: Double.random(in: -25...25)
        )
        floatingHearts.append(heart)
        
        let heartId = heart.id
        withAnimation(.spring(response: 0.35, dampingFraction: 0.5)) {
            if let idx = floatingHearts.firstIndex(where: { $0.id == heartId }) {
                floatingHearts[idx].scale = 1.2
                floatingHearts[idx].offsetY = -40
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeOut(duration: 0.4)) {
                if let idx = floatingHearts.firstIndex(where: { $0.id == heartId }) {
                    floatingHearts[idx].opacity = 0
                    floatingHearts[idx].offsetY = -90
                    floatingHearts[idx].scale = 1.4
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            floatingHearts.removeAll(where: { $0.id == heartId })
        }
    }
}
