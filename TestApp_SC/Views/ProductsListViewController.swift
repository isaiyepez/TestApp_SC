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
    
    var productPage: Int {
        
        return productList.count / 10
    }
    
    var productList = [Product]()
    
    var totalNumberOfProducts = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        let nib = UINib(nibName: ProductCollectionViewCell.identifier, bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        getProducts()
    }
    
    // MARK: - Get products
    private func getProducts(){
        
//        let completionClosure: (Products?) -> Void = { (productsData) in
//            if let data = productsData {
//
//                self.productList = data.products
//
//
//                DispatchQueue.main.async {
//
//                    self.collectionView.reloadData()
//                }
//            }
//        }
        
//        let pageDict = ["One" : "1", "Ten" : "10"]
//        //let pageSize = ["Ten" : "10"]
//
//        guard let baseUrl = URL(string: NetworkController.baseUrl) else { return }
//
//        let url = NetworkController.url(byAdding: pageDict, to: baseUrl)
//
//        print(url)
        
//        ProductModelController.getProducts(pageNumber: 1, numberOfProducts: 10, completion: completionClosure)
        productMC.getProducts(pageNumber: 1, numberOfProducts: 10) { (productsData) in
            if let data = productsData {
                
                self.productList = data.products
                
                print(self.productList[0])
                
                DispatchQueue.main.async {
                    
                    self.collectionView.reloadData()
                }//End of DispatchQueue.main.async
            }//End of closure
        }//End of productMC.getProducts
    }//End of getProducts
}//End of ProductsListViewController

extension ProductsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Pretty sure this is not the best way I could do this...
        
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
}
