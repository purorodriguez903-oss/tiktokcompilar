import SwiftUI

struct CachedAsyncImageView: View {
    let urlString: String
    var contentMode: ContentMode = .fill
    var placeholderColor: Color = Color(white: 0.15)
    var targetSize: CGSize? = nil
    
    @State private var loadedImage: UIImage? = nil
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            if let uiImage = loadedImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            } else {
                Rectangle()
                    .fill(placeholderColor)
                    .overlay(
                        Group {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.7)
                            } else {
                                Image(systemName: "photo")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.white.opacity(0.3))
                            }
                        }
                    )
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        if let cached = ImageCacheManager.shared.image(for: urlString) {
            self.loadedImage = cached
            return
        }
        
        isLoading = true
        Task {
            let image = await ImageCacheManager.shared.loadImage(from: urlString, targetSize: targetSize)
            await MainActor.run {
                self.loadedImage = image
                self.isLoading = false
            }
        }
    }
}
