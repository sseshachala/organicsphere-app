//
//  OSCartService.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-29.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit

class OSCartService: NSObject {
    
    static let sharedInstance : OSCartService = {
        let instance = OSCartService()
        return instance
    }()
    
    var productsInCart:[OSProductList] = []
    var wasPlacingOrderProcessInitiated = false
    var wasOrderPlaced = false
    var taxValue: Double = 0.0
    var taxValueType = "%"
    var postalCode:String?
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
}
