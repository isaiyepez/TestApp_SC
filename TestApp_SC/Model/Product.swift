//
//  Product.swift
//  TestApp_SC
//
//  Created by Isai Yepez on 1/16/19.
//  Copyright © 2019 Isai Yepez. All rights reserved.
//

import UIKit

// IYG: Try to use structs anytime you can. Classes are used for mutable data
//  So for representing a stateful complex entity, a class is awesome. But for values that are simply a measurement or bits of related data, a struct makes more sense so that you can easily copy them around and calculate with them or modify the values without fear of side effects.
struct Product: Decodable {
    
    enum CodingKeys: String, CodingKey  {
        case productId, productName, shortDescription, longDescription, price, reviewRating, reviewCount, inStock
        case imageUrl = "productImage"
    }
    
    var productId: String?
    var productName: String?
    var shortDescription: String?
    var longDescription: String?
    var price: String?
    var imageUrl: String?
    var reviewRating: Double?
    var reviewCount: Int?
    var inStock: Bool?
    
    var shortDescriptionStringFromHTML: NSAttributedString {
        let getShort: String = shortDescription ?? "No short description provided"
        let formattedShortDescription = transformToAttributedString(htmlString: getShort)!
        return formattedShortDescription
    }
    
    var longDescriptionStringFromHTML: NSAttributedString {
        let getLong: String = longDescription ?? "No long description provided"
        let formattedLongDescription = transformToAttributedString(htmlString: getLong)!
        return formattedLongDescription
    }
    
    var ratingStringFromDouble: String {
        var reviewFormatted: String
        let getReviewRating = reviewRating ?? 0.0
        let getReviewCount = reviewCount ?? 0
        if getReviewRating == 0.0 {
            reviewFormatted = "No reviews yet"
        } else {
            reviewFormatted = "Reviews: " + String(format: "%.1f", getReviewRating) + " / 5" + " (\(getReviewCount))"
        }
        
        return reviewFormatted
    }
    
    var inStockStringFromBool: String {
        let getInStock = inStock ?? false        
        switch getInStock {
        case true:
            return "In Stock"
        default:
            return "Out of Stock"
        }
    }
    
    var imageUrlString: String {
        var imageUrlCompleted = String()
        if let unwrappedImageUrl = imageUrl {
            imageUrlCompleted = "https://mobile-tha-server.firebaseapp.com" + unwrappedImageUrl
        } else {
            imageUrlCompleted = "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"
        }
        return imageUrlCompleted
    }
}


struct Products: Decodable {
    var products: [Product]
    var totalProducts: Int
    var pageNumber: Int
    var pageSize: Int
    var statusCode: Int
}

private func transformToAttributedString(htmlString: String) -> NSAttributedString? {
    guard let data = htmlString.data(using: .utf8) else { return nil }
    do{
        let stringAttributed = try NSMutableAttributedString(data: data,
                                                             options: [.documentType: NSAttributedString.DocumentType.html,
                                                                       .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        stringAttributed.addAttributes([.font : UIFont.systemFont(ofSize: 18.0)],
                                       range: NSMakeRange(0, stringAttributed.length))
        return stringAttributed
    }catch{
        return NSAttributedString()
    }
}
