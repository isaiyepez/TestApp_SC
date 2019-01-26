//
//  ProductCollectionViewCell.swift
//  TestApp_SC
//
//  Created by Isai Yepez on 1/16/19.
//  Copyright © 2019 Isai Yepez. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    static let identifier = "ProductCollectionViewCell"
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var inStock: UILabel!
    @IBOutlet weak var reviewRating: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    

}
