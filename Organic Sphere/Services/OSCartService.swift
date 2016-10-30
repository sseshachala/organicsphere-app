//
//  OSCartService.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-29.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class OSCartService: NSObject {
    
    static let sharedInstance : OSCartService = {
        let instance = OSCartService()
        return instance
    }()
    
    var productsInCart:[OSProductList] = []
    var wasPlacingOrderProcessInitiated = false
    var wasOrderPlaced = false
    var taxValue: Double = 8.0
    var taxValueType = "%"
    var postalCode:String? {
        didSet {
            getTaxdetails(postalCode: postalCode!)
        }
    }
    var orderDescription:String?
    var fullName:String?
    var address:String?
    
    
    
    
    //Fetch Total Price
    func totalPrice() -> Double {
        var totalPrice:Double = 0.0
        for productList in productsInCart {
            if let stringPrice = productList.terms_fob_price_c {
                if let price = Double(stringPrice) {
                    totalPrice +=  price * Double(productList.orderedQuantity)
                }
            }
        }
        return totalPrice
    }
    
    func getTaxdetails(postalCode:String) {
        OSNetworkManager.sharedInstance.getTaxDetailsFor(postalCode: postalCode) {
            responseJSON, error in
            if let _ = error {
                
            } else {
                if let tax = Double(responseJSON["taxrate"].stringValue) {
                    self.taxValue = tax
                    self.taxValueType = responseJSON["unit"].stringValue
                }
            }
        }
    }
}
