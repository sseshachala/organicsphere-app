//
//  ProductDetailsViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-25.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import SideMenu

class ProductDetailsViewController: UIViewController {

    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productOrderCountLabel: UILabel!
    @IBOutlet weak var decreaseProductCountButton: UIButton!
    @IBOutlet weak var increaseProductCountButton: UIButton!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var selectedProduct:OSProductList = OSProductList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Product Details"
        
        setAllTheLabels()
    }
    
    func setAllTheLabels() {
        //Set product name
        productNameLabel.text = selectedProduct.product_name
        //Set categor/company
        productCategoryLabel.text = selectedProduct.company_name
        ///set price
        if let price = selectedProduct.terms_fob_price_c {
            priceLabel.text = "$\(price)"
        } else {
            priceLabel.text = "Not available."
        }
        //Set category
        if let categoryName = selectedProduct.prodCatName {
            categoriesLabel.text = "Category: \(categoryName)"
        } else {
            categoriesLabel.text = "Category: Category not available."
        }
        //Set Tags
        if let tags = selectedProduct.tags_c {
            tagsLabel.text = "Tags: \(tags)"
        } else {
            tagsLabel.text = "Tags: No available tags at the moment"
        }
    }
    
    func makeButtonCircular(button:UIButton) {
        button.layer.cornerRadius = button.frame.width * 0.50
        button.clipsToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        
        makeButtonCircular(button: increaseProductCountButton)
        makeButtonCircular(button: decreaseProductCountButton)
        
        buyButton.layer.cornerRadius = buyButton.frame.width * 0.12
        
        //Add border to label
        productOrderCountLabel.layer.borderColor = UIColor.gray.cgColor
        productOrderCountLabel.layer.borderWidth = 1
    }
    
    @IBAction func descreaseProductCountButtonTapped(_ sender: AnyObject) {
        if let currentOrderCountText = productOrderCountLabel.text {
            if var currentOrderCount = Int(currentOrderCountText) {
                if currentOrderCount > 1 {
                    currentOrderCount -= 1
                    productOrderCountLabel.text = "\(currentOrderCount)"
                }
            }
        }
        
    }

    @IBAction func increaseProductCountButtonTapped(_ sender: AnyObject) {
        if let currentOrderCountText = productOrderCountLabel.text {
            if var currentOrderCount = Int(currentOrderCountText) {
                currentOrderCount += 1
                productOrderCountLabel.text = "\(currentOrderCount)"
            }
        }
    }
    @IBAction func buyButtonTapped(_ sender: AnyObject) {
//        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
        
        OSLocationManager.sharedInstance.manager.requestLocation()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
