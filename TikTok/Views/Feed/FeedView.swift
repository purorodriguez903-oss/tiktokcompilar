import SwiftUI

enum FeedTabMode: String, CaseIterable {
    case stem = "STEM"
    case community = "Community"
    case following = "Following"
    case forYou = "For You"
}

struct FeedView: View {
    @ObservedObject var viewModel: FeedViewModel
    @ObservedObject var languageManager = LanguageManager.shared
    @State private var selectedTab: FeedTabMode = .forYou
    @State private var floatingHearts: [FloatingHeartItem] = []
    @State private var showSTEMModal: Bool = false
    @State private var activePhotoIndex: Int = 0
    
    let communityColumns = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4)
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()
            
            if selectedTab == .community {
                // Community 2-Column Grid (Frame 005)
                communityGridView
            } else {
                // Vertical Paging Feed
                standardFeedView
            }
            
            // Double-tap hearts
            FloatingHeartsView(hearts: $floatingHearts)
            
            // Double tap gesture detector overlay (only in paging feed)
            if selectedTab != .community {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture(count: 2) { location in
                        handleDoubleTap(at: location)
                    }
            }
            
            // Top Navigation Bar matching video (Frame 002, 004, 005)
            VStack(spacing: 4) {
                HStack(alignment: .center, spacing: 0) {
                    // LIVE Button
                    Button(action: { TikTokTheme.haptic(.light) }) {
                        HStack(spacing: 4) {
                            Image(systemName: "tv")
                                .font(.system(size: 15, weight: .semibold))
                            Text("LIVE")
                                .font(.system(size: 12, weight: .bold))
                        }
                        .foregroundColor(Color.white.opacity(0.9))
                    }
                    .frame(width: 60, alignment: .leading)
                    
                    Spacer()
                    
                    // 4 Tabs: STEM | Community | Following | For You
                    HStack(spacing: 14) {
                        ForEach(FeedTabMode.allCases, id: \.self) { tab in
                            Button(action: {
                                TikTokTheme.haptic(.light)
                                withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                                    selectedTab = tab
                                    if tab == .stem {
                                        showSTEMModal = true
                                    }
                                }
                            }) {
                                VStack(spacing: 4) {
                                    Text(tab.rawValue)
                                        .font(.system(size: 16, weight: selectedTab == tab ? .bold : .semibold))
                                        .foregroundColor(selectedTab == tab ? .white : Color.white.opacity(0.6))
                                    
                                    // Underline or Dual Dot Indicator
                                    if selectedTab == tab {
                                        if tab == .community {
                                            // Red & Cyan Dual-dot indicator as shown in video Frame 005!
                                            HStack(spacing: 3) {
                                                Circle().fill(TikTokTheme.red).frame(width: 5, height: 5)
                                                Circle().fill(TikTokTheme.cyan).frame(width: 5, height: 5)
                                            }
                                        } else {
                                            Rectangle()
                                                .fill(Color.white)
                                                .frame(width: 24, height: 2)
                                                .cornerRadius(1)
                                        }
                                    } else {
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(width: 24, height: 2)
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Search Icon
                    Button(action: { TikTokTheme.haptic(.light) }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 19, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 60, alignment: .trailing)
                }
                .padding(.horizontal, 16)
                .padding(.top, 48)
                
                // Photo Counter "1/2" below search icon if photo post
                if selectedTab != .community {
                    let currentV = viewModel.currentVideos[safe: viewModel.currentVideoIndex]
                    if case .photoCarousel(let photos) = currentV?.mediaType {
                        HStack {
                            Spacer()
                            Text("\(activePhotoIndex + 1)/\(photos.count)")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(Color.black.opacity(0.45))
                                .cornerRadius(10)
                                .padding(.trailing, 16)
                        }
                    }
                }
            }
            
            // STEM Welcome Modal (Frame 006)
            if showSTEMModal {
                stemModalView
            }
        }
        .sheet(isPresented: $viewModel.showCommentsSheet) {
            if let video = viewModel.selectedVideoForComments {
                CommentsSheetView(video: video, viewModel: viewModel)
                    .presentationDetents([.fraction(0.68), .large])
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
    
    // Standard Paging Feed
    private var standardFeedView: some View {
        GeometryReader { geometry in
            TabView(selection: $viewModel.currentVideoIndex) {
                ForEach(Array(viewModel.currentVideos.enumerated()), id: \.element.id) { index, video in
                    ZStack {
                        // Media: Video or Photo Carousel
                        switch video.mediaType {
                        case .video:
                            VideoPlayerContainer(
                                video: video,
                                isActive: viewModel.currentVideoIndex == index
                            )
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            
                        case .photoCarousel(let photos):
                            TabView(selection: $activePhotoIndex) {
                                ForEach(Array(photos.enumerated()), id: \.offset) { pIdx, pUrl in
                                    CachedAsyncImageView(urlString: pUrl, contentMode: .fit)
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                        .tag(pIdx)
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                        }
                        
                        // Bottom gradient shade
                        LinearGradient(
                            colors: [Color.clear, Color.black.opacity(0.8)],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea()
                        .allowsHitTesting(false)
                        
                        // Carousel dots indicator (Frame 002)
                        if case .photoCarousel(let photos) = video.mediaType {
                            HStack(spacing: 5) {
                                ForEach(0..<photos.count, id: \.self) { idx in
                                    Circle()
                                        .fill(activePhotoIndex == idx ? Color.white : Color.white.opacity(0.4))
                                        .frame(width: 5, height: 5)
                                }
                            }
                            .padding(.bottom, 160)
                        }
                        
                        // Feed Overlay
                        FeedOverlayView(video: video, viewModel: viewModel)
                            .padding(.bottom, 78)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .ignoresSafeArea()
    }
    
    // Community 2-Column Grid (Frame 005)
    private var communityGridView: some View {
        ScrollView {
            LazyVGrid(columns: communityColumns, spacing: 6) {
                ForEach(viewModel.currentVideos) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        ZStack(alignment: .bottomLeading) {
                            LinearGradient(colors: item.bgGradient, startPoint: .top, endPoint: .bottom)
                                .frame(height: 220)
                                .cornerRadius(6)
                            
                            HStack(spacing: 4) {
                                Image(systemName: "heart")
                                    .font(.system(size: 11))
                                    .foregroundColor(.white)
                                Text("\(item.likeCount)")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .padding(6)
                        }
                        
                        Text(item.description)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .padding(.horizontal, 4)
                        
                        Text(item.authorHandle)
                            .font(.system(size: 11))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 4)
                    }
                }
            }
            .padding(.horizontal, 4)
            .padding(.top, 96)
            .padding(.bottom, 90)
        }
    }
    
    // STEM Welcome Modal (Frame 006)
    private var stemModalView: some View {
        ZStack {
            Color.black.opacity(0.65).ignoresSafeArea()
                .onTapGesture { showSTEMModal = false }
            
            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    Button(action: { showSTEMModal = false }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(8)
                    }
                }
                
                // Lightbulb Illustration
                ZStack {
                    Circle()
                        .fill(TikTokTheme.cyan.opacity(0.2))
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "lightbulb.fill")
                        .font(.system(size: 42))
                        .foregroundColor(TikTokTheme.cyan)
                }
                
                Text("Welcome to the STEM feed")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text("In this feed, you'll see videos related to science, technology, engineering, and mathematics.")
                    .font(.system(size: 14))
                    .foregroundColor(Color(white: 0.75))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                
                Button(action: {
                    TikTokTheme.hapticNotification(.success)
                    showSTEMModal = false
                }) {
                    Text("Got it")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(TikTokTheme.red)
                        .cornerRadius(24)
                }
                .padding(.top, 8)
                .padding(.horizontal, 16)
            }
            .padding(20)
            .background(TikTokTheme.darkCard)
            .cornerRadius(18)
            .padding(.horizontal, 32)
        }
        .transition(.scale.combined(with: .opacity))
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

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
