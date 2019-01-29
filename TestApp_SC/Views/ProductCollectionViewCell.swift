//
//  ProductCollectionViewCell.swift
//  TestApp_SC
//
//  Created by Isai Yepez on 1/16/19.
//  Copyright © 2019 Isai Yepez. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    var product: Product? {
        didSet {
            setUpCell()
        }
    }
    
    static let identifier = "ProductCollectionViewCell"
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var reviewRating: UILabel!
    @IBOutlet weak var inStock: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    private func setUpCell() {
        if let product = product {
            // self. .... (set up all the properties except image)
            productName.text = product.productName
            reviewRating.text = product.ratingStringFromDouble
            price.text = product.price
            inStock.textColor = product.inStockStringFromBool == "In Stock" ? UIColor.blue : UIColor.red
            inStock.text = product.inStockStringFromBool
            
            // ImageCache.shared.getImage(with url:)
            ImageCache.shared.getImage(from: product.imageUrlString, with: { (image) in
                // dispatchQueue.main.async { set image }
                DispatchQueue.main.async {
                    self.productImage.image = image
                }
                
            })
        }
    }
}
