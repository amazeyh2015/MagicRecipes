//
//  ImageCache.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/2.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

/// Memory cache for images
class ImageCache {
    
    static let shared = ImageCache()
    
    private var images: [String: UIImage] = [:]
    
    func setImage(_ image: UIImage?, forKey key: String) {
        images[key] = image
    }
    
    func image(forKey key: String) -> UIImage? {
        return images[key]
    }
}
