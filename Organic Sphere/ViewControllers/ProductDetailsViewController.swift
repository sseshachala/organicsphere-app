//
//  ProductDetailsViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-25.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit

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
    
    var selectedProduct = "Product"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedProduct
        
        //Add border to label
        productOrderCountLabel.layer.borderColor = UIColor.gray.cgColor
        productOrderCountLabel.layer.borderWidth = 1
    }
    
    func makeButtonCircular(button:UIButton) {
        button.layer.cornerRadius = button.frame.width * 0.50
        button.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        makeButtonCircular(button: increaseProductCountButton)
        makeButtonCircular(button: decreaseProductCountButton)
        
        buyButton.layer.cornerRadius = buyButton.frame.width * 0.15
    }
    
    @IBAction func descreaseProductCountButtonTapped(_ sender: AnyObject) {
        if let currentOrderCountText = productOrderCountLabel.text {
            if var currentOrderCount = Int(currentOrderCountText) {
                if currentOrderCount > 0 {
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
