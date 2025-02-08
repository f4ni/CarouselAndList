//
//  AsyncImageLoader.swift
//  CarouselAndList
//
//  Created by Furkan ic on 8.02.2025.
//

import UIKit

class AsyncImageLoader {
    static let shared = AsyncImageLoader()
    private let cache = NSCache<NSURL, UIImage>()
    
    private init() {}
    
    // Load image asynchronously
    func loadImage(from url: URL) async -> UIImage? {
        // Check if the image is already cached
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }
        
        // Download the image
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                // Cache the downloaded image
                cache.setObject(image, forKey: url as NSURL)
                return image
            }
        } catch {
            print("Failed to load image: \(error)")
        }
        
        return nil
    }
}

