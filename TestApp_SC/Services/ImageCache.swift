//
//  ImageCache.swift
//  TestApp_SC
//
//  Created by Isai Yepez on 1/26/19.
//  Copyright © 2019 Isai Yepez. All rights reserved.
//

import UIKit

struct ImageCache {
    
    private let cache = NSCache<NSString, UIImage>()
    static let shared = ImageCache()
    
    func saveImageToCache(identifier: String, image: UIImage) {
        cache.setObject(image, forKey: identifier as NSString)
    }
    
    func getImageFromCache(identifier: String) -> UIImage? {
        return cache.object(forKey: identifier as NSString)
    }
}
