import UIKit
import SwiftUI
import Combine

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let memoryCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 80 * 1024 * 1024 // 80 MB limit
        cache.countLimit = 200 // Max 200 decoded images in memory
        return cache
    }()
    
    private let urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        config.urlCache = URLCache.shared
        return URLSession(configuration: config)
    }()
    
    private init() {}
    
    func image(for urlString: String) -> UIImage? {
        return memoryCache.object(forKey: urlString as NSString)
    }
    
    func store(_ image: UIImage, for urlString: String) {
        let cost = Int(image.size.width * image.size.height * 4)
        memoryCache.setObject(image, forKey: urlString as NSString, cost: cost)
    }
    
    func clearMemory() {
        memoryCache.removeAllObjects()
    }
    
    func loadImage(from urlString: String, targetSize: CGSize? = nil) async -> UIImage? {
        // 1. Check memory cache
        if let cached = memoryCache.object(forKey: urlString as NSString) {
            return cached
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            // 2. Fetch from network or disk cache
            let (data, response) = try await urlSession.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return nil
            }
            
            // 3. Downsample and decode in background thread to prevent UI frame drops
            let decodedImage: UIImage? = await withCheckedContinuation { continuation in
                DispatchQueue.global(qos: .userInitiated).async {
                    if let targetSize = targetSize, targetSize.width > 0, targetSize.height > 0 {
                        let maxDimension = max(targetSize.width, targetSize.height) * UIScreen.main.scale
                        let sourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
                        guard let source = CGImageSourceCreateWithData(data as CFData, sourceOptions) else {
                            continuation.resume(returning: UIImage(data: data))
                            return
                        }
                        
                        let downsampleOptions = [
                            kCGImageSourceCreateThumbnailFromImageAlways: true,
                            kCGImageSourceShouldCacheImmediately: true,
                            kCGImageSourceCreateThumbnailWithTransform: true,
                            kCGImageSourceThumbnailMaxPixelSize: maxDimension
                        ] as CFDictionary
                        
                        if let downsampledCG = CGImageSourceCreateThumbnailAtIndex(source, 0, downsampleOptions) {
                            continuation.resume(returning: UIImage(cgImage: downsampledCG))
                            return
                        }
                    }
                    
                    continuation.resume(returning: UIImage(data: data))
                }
            }
            
            if let finalImage = decodedImage {
                store(finalImage, for: urlString)
                return finalImage
            }
        } catch {
            return nil
        }
        
        return nil
    }
}
