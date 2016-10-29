//
//  CartViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-26.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var codButton: UIButton!
    
    @IBOutlet weak var tax: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var products = OSCartService.sharedInstance.productsInCart

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Shopping Cart"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        products = OSCartService.sharedInstance.productsInCart
        tableView.reloadData()
    }
    
    
    override func viewDidLayoutSubviews() {
        codButton.layer.cornerRadius = codButton.frame.width * 0.12
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
            noDataLabel.text = "No products in the cart"
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)
        cell.textLabel?.text = products[indexPath.row].product_name
        cell.detailTextLabel?.text = products[indexPath.row].prodCatName
        cell.imageView?.image = UIImage(named: "lentils")
        
        //Set custom label to the accessory view
        let priceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        }
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
