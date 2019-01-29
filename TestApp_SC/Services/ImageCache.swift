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
    
    func getImage(from urlString: String, with completion: @escaping (UIImage) -> Void) {
        // check cache for image with urlString
        if let cachedImage = getImageFromCache(identifier: urlString) {
            return completion(cachedImage)
        }else {
        
        // if no image, download image self.downloadImage(completion: Image)
        guard let url = URL(string: urlString) else { completion(UIImage()); return }
            
            downloadImage(with: url) { (image) in
                // save image to cache
                self.saveImageToCache(identifier: urlString, image: image)
                // complete with image
                completion(image)
            }
        }
    }
    
    func downloadImage(with url: URL, completion: @escaping (UIImage) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let safeData = data else { completion(UIImage()); return }
            guard let image = UIImage(data: safeData) else { completion(UIImage()); return }
            completion(image)
        }
        task.resume()
    }
}
