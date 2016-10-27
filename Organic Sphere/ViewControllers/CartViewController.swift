//
//  CartViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-26.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let products = ["Cinnamon Bark", "Kasuri Methi Leaves", "Bay Leaf", "Mustard Yellow", "Fenu Greek", "Rai", "Red Chilli Whole", "Flack Seed", "Ajwain"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Shopping Cart"
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)
        cell.textLabel?.text = products[indexPath.row]
        cell.detailTextLabel?.text = "Organic Sphere"
        cell.imageView?.image = UIImage(named: "lentils")
        
        //Set custom label to the accessory view
        let priceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        priceLabel.text = "$1.83"
        priceLabel.textColor = UIColor().osGreenColor()
        
        cell.accessoryView = priceLabel
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
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
