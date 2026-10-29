import SwiftUI

struct CachedAsyncImageView: View {
    let urlString: String
    var contentMode: ContentMode = .fill
    var placeholderColor: Color = Color(white: 0.2)
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .fill(placeholderColor)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(0.8)
                    )
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            case .failure:
                Rectangle()
                    .fill(placeholderColor)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: 20))
                            .foregroundColor(Color.white.opacity(0.4))
                    )
            @unknown default:
                EmptyView()
            }
        }
    }
}
