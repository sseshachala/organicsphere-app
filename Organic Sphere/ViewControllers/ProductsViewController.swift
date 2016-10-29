//
//  ProductsViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-25.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var selectedProduct = "Products"
    var selectedCategory:OSCategory = OSCategory()
    var products:[OSProductList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedProduct
        
        fetchProducts()
    }
    
    func fetchProducts () {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
        let productService = OSProductService()
        productService.getProductsFor(categoryId: selectedCategory.id!, pageNumber: 1) {
            productList, error in
            
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            
            if let _ = error {
                
            } else {
                self.products = productList
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if products.count > 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No products available"
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        cell.textLabel?.text = products[indexPath.row].product_name
        cell.detailTextLabel?.text = products[indexPath.row].prodCatName
        cell.imageView?.image = UIImage(named: "lentils")
        
        //Set custom label to the accessory view
        let priceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        priceLabel.textAlignment = NSTextAlignment.right
        if let price = products[indexPath.row].terms_fob_price_c {
            priceLabel.text = price.hasPrefix("$") ? "\(price)" : "$\(price)"
        }
        else {
            priceLabel.text = "Not Available"
        }
        priceLabel.textColor = UIColor().osGreenColor()
        
        cell.accessoryView = priceLabel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ProductsToProductDetails", sender: indexPath)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productDetailsController = segue.destination as? ProductDetailsViewController  {
            if let indexPath = sender as? IndexPath {
                productDetailsController.selectedProduct = products[indexPath.row]
            }
        }
    }

}
