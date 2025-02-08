//
//  UIImageView+extension.swift
//  CarouselAndList
//
//  Created by Furkan ic on 8.02.2025.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) async {
        // Set a placeholder image while loading
        self.image = placeholder
        
        // Load the image asynchronously
        if let image = await AsyncImageLoader.shared.loadImage(from: url) {
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
