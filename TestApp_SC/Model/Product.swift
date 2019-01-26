//
//  Product.swift
//  TestApp_SC
//
//  Created by Isai Yepez on 1/16/19.
//  Copyright © 2019 Isai Yepez. All rights reserved.
//

import Foundation

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
}


struct Products: Decodable {
    var products: [Product]
    var totalProducts: Int
    var pageNumber: Int
    var pageSize: Int
    var statusCode: Int
}
