//
//  ProductDetailsViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-25.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import SideMenu
import AlamofireImage


class ProductDetailsViewController: UIViewController {

    
    @IBOutlet weak var productDescriptionView: UITextView!
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
    @IBOutlet weak var productView: UIView!
    var rightBarButton: ENMBadgedBarButtonItem?

    
    var selectedProduct:OSProductList = OSProductList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Product Details"
        
        setAllTheLabels()
        setImage()
    }
    
    func setAllTheLabels() {
        //Set product name
        productNameLabel.text = selectedProduct.product_name
        //Set categor/company
        productCategoryLabel.text = selectedProduct.brand_c
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
        
        if let productDescription = selectedProduct.productDescription{
            productDescriptionView.text = productDescription
        }
        else {
            productDescriptionView.text = "No description available."
        }
        
        productView.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    
    func setImage() {
        if let urlString  = selectedProduct.product_logo {
            if let url = URL(string: urlString) {
                let placeholderImage = UIImage(named: "banner")!
                productImageView.af_setImage(withURL: url, placeholderImage: placeholderImage)

            }
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
        setUpRightBarButton()
        productDescriptionView.setContentOffset(CGPoint(x:0, y:0), animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rightBarButton?.badgeValue = "\(OSCartService.sharedInstance.productsInCart.count)"
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
//        present(SideMenuManager.menuRightNavigationController!, animated: true, completion: nil)
        selectedProduct.orderedQuantity = Int(productOrderCountLabel.text!)!
        let _ = SweetAlert().showAlert("Success", subTitle: "Successfuly added \(selectedProduct.orderedQuantity) \(selectedProduct.product_name!) to cart!", style: AlertStyle.success)
        if OSCartService.sharedInstance.postalCode == nil {
            OSLocationManager.sharedInstance.manager.requestLocation()
        }
        OSCartService.sharedInstance.productsInCart.append(selectedProduct)
        rightBarButton?.badgeValue = "\(OSCartService.sharedInstance.productsInCart.count)"

    }

    func showAlert() {
        let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to add ", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
//    func delay(_ delay:Double, closure:@escaping ()->()) {
//        let when = DispatchTime.now() + delay
//        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
//    }
    
    func setUpRightBarButton() {
        let image = UIImage(named: "cart")
        let button = UIButton(type: .custom)
        if let knownImage = image {
            button.frame = CGRect(x: 0.0, y: 0.0, width: knownImage.size.width, height: knownImage.size.height)
        } else {
            button.frame = CGRect.zero;
        }
        
        button.setBackgroundImage(image, for: UIControlState())
        button.addTarget(self,
                         action: #selector(CategoriesViewController.rightButtonPressed(_:)),
                         for: UIControlEvents.touchUpInside)
        
        let newBarButton = ENMBadgedBarButtonItem(customView: button, value: "\(OSCartService.sharedInstance.productsInCart.count)")
        rightBarButton = newBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        rightBarButton?.badgeBackgroundColor = UIColor.red
        rightBarButton?.badgeTextColor = UIColor.white
        rightBarButton?.badgeValue = "\(OSCartService.sharedInstance.productsInCart.count)"
    }
    
    func rightButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "productDetailsToCart", sender: self)
    }

}
