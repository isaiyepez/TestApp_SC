//
//  ViewController.swift
//  TestApp_SC
//
//  Created by Isai Yepez on 1/16/19.
//  Copyright © 2019 Isai Yepez. All rights reserved.
// 

import UIKit

class ProductsListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var productMC: ProductModelController = ProductModelController()
    
    var page: Int {
        
        return productList.count / 10
    }
    
    var productList = [Product]()
    
    var totalNumberOfProducts = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        getProducts()
    }
    
    // MARK: - Get products
    private func getProducts() {
        
        productMC.getProducts(pageNumber: page + 1) { (productsData) in
            guard let data = productsData else { return }
                
                self.productList.append(contentsOf: data.products)
                self.totalNumberOfProducts = data.totalProducts
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }            
        }
    }
}

extension ProductsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return productList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        
        let productMC = ProductModelController()
        
        let product = productList[indexPath.row]
        
        let productInfo = productMC.getProductFormatted(product: product)
        
        cell.productName.text = productInfo.name
        cell.price.text = productInfo.price
        cell.shortDescription.attributedText = productInfo.shortDesc
        cell.reviewRating.text = String(productInfo.rating)
        cell.inStock.text = productInfo.inStock
        
        cell.productImage.image = productInfo.productImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == productList.count - 1 && productList.count % 10 == 0 && productList.count < totalNumberOfProducts {
            
            getProducts()
            
        }
    }
}
