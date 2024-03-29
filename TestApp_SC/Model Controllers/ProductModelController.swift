//
//  ProductModelController.swift
//  TestApp_SC
//
//  Created by Isai Yepez on 1/16/19.
//  Copyright © 2019 Isai Yepez. All rights reserved.
//

import UIKit

class ProductModelController {
    
    private let baseUrl: String = "https://mobile-tha-server.firebaseapp.com"
    private var products:[Product] = [Product]()
    private let numberOfProducts = 10
    
    func getProducts(pageNumber: Int, completion: @escaping (Products?) -> Void) {
          
        guard let url = URL(string: baseUrl + "/walmartproducts/\(String(pageNumber))/\(String(numberOfProducts))") else { completion(nil); return }
        
        NetworkController.performRequest(for: url, httpMethod: NetworkController.HTTPMethod.Get, urlParameters: nil, body: nil) { (data, error) in
            guard let data = data else { completion(nil); return }
            
            
            do {
                
                let productListDecoded = try JSONDecoder().decode(Products.self, from: data)
                self.products = productListDecoded.products
                
                completion(productListDecoded)
                
            } catch let jsonErr {
                print("Error serializing json: ", jsonErr)
                completion(nil)
            }
        }
    }
    
//    typealias productInfo = (
//        id: String,
//        name: String,
//        shortDesc: NSAttributedString,
//        longDesc: NSAttributedString,
//        price: String,
//        imageUrl: String,
//        rating: Double,
//        reviewCount: Int,
//        inStock: String,
//        productImage: UIImage)
//    
//    //Here you should handle nil case for text
//    func getProductFormatted(product: Product) -> productInfo {
//        
//        let product = product
//        
//        var shortDescription = NSAttributedString()
//        var longDescription = NSAttributedString()
//        var inStockText = String()
//        var fetchedImage = UIImage()
//        
//        let getShort: String = product.shortDescription ?? "No short description provided"
//        let getLong: String = product.longDescription ?? "No long description provided"
//        
//        shortDescription = transformToAttributedString(htmlString: getShort)!
//        longDescription = transformToAttributedString(htmlString: getLong)!
//        
//        
//        
//        if let imageUrl = product.imageUrl{
//            
//            if let image = ImageCache.shared.getImageFromCache(identifier: imageUrl) {
//                fetchedImage = image
//            } else {
//            
//            getImage(url: baseUrl + "\(imageUrl)") { (image) in
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
//                    guard let img = image else {fetchedImage = UIImage(named: "iconCamera")!; return }
//                    ImageCache.shared.saveImageToCache(identifier: imageUrl, image: img)
//                    fetchedImage = img
//                })
//                
//                }
//            }
//            
//        } else {
//            fetchedImage = UIImage(named: "iconCamera")!
//        }
//        
//        
//        return (id: product.productId ?? "No ID provided",
//                name: product.productName ?? "No product name provided",
//                shortDesc: shortDescription,
//                longDesc: longDescription,
//        price: product.price ?? "No price",
//        imageUrl: product.imageUrl ?? "No image provided",
//        rating: product.reviewRating ?? 0.0,
//        reviewCount: product.reviewCount ?? 0,
//        inStock: inStockText,
//        productImage: fetchedImage)
//    }
//    
//    func getProducts() -> [Product]{
//        
//        return self.products
//    }
//    
//    private func getImage(url: String, completion: @escaping (UIImage?)->()){
//        
//        guard let url = URL(string: url) else { completion(nil); return }
//        
//        let task = URLSession.shared.dataTask(with: url) {
//            (data, response, error) in
//            guard let safeData = data else { completion(nil); return }
//            guard let image = UIImage(data: safeData) else { completion(nil); return }
//            completion(image)
//        }
//        task.resume()
//    }
    
    
}
