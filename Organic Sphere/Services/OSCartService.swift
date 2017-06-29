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
    let deliveryCharge = 0
    var wasPlacingOrderProcessInitiated = false
    var wasOrderPlaced = false
    var taxValue: Double = 0.0
    var taxValueType = "%"
    let useServerTaxVal = false
    var postalCode:String? {
        didSet {
            getTaxdetails(postalCode: postalCode!)
        }
    }
    var orderDescription:String?
    var fullName:String?
    var address:String?
    var phoneNumbersToSendOrderTo:[String] = []
    
    
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
        if !useServerTaxVal {
            return
        }
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
    
    // get phone Numbers
    func getPhoneNumbers() {
        OSNetworkManager.sharedInstance.getPhoneNumbers() {
            responseJSON, error in
            if let _ = error {
                
            } else {
                if let phoneNmber = responseJSON["phone1"].string {
                    self.phoneNumbersToSendOrderTo.append(phoneNmber)
                }
                if let phoneNmber = responseJSON["phone2"].string {
                    self.phoneNumbersToSendOrderTo.append(phoneNmber)
                }
            }
        }
    }
    
    func sendOrderMessage(phoneNumbers: [String], baseEncodedString:String, completionHandler:@escaping (_ isSuccess:Bool, _ error:Error?) -> Void) {
        OSNetworkManager.sharedInstance.sendOrderMessage(phoneNumbers: phoneNumbers, baseEncodedString: baseEncodedString) {
            responseJSON, error in
            if let _ = error {
                
            } else {
                if let resultMessage = responseJSON["message_send"].string {
                    if resultMessage == "Success"{
                        completionHandler(true, error)
                    } else {
                        completionHandler(false, error)
                    }
                }
                else {
                    completionHandler(false, error)
                }
            }
        }
    }
}
