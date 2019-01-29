//
//  ProductDetailController.swift
//  TestApp_SC
//
//  Created by Isai Yepez on 1/27/19.
//  Copyright © 2019 Isai Yepez. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var inStock: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var longDescription: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var product: Product?
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    private func setUpView() {
        guard let product = product else { return }
            // self. .... (set up all the properties except image)
            productName.text = product.productName
            price.text = product.price
            rating.text = product.ratingStringFromDouble
            inStock.textColor = product.inStockStringFromBool == "In Stock" ? UIColor.blue : UIColor.red
            inStock.text = product.inStockStringFromBool
            longDescription.attributedText = product.longDescriptionStringFromHTML
            // ImageCache.shared.getImage(with url:)
            ImageCache.shared.getImage(from: product.imageUrlString, with: { (image) in
                // dispatchQueue.main.async { set image }
                DispatchQueue.main.async {
                    self.productImage.image = image
                }
            })
        }
}
