//
//  OSProductService.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-29.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class OSProductService: NSObject {
    
    func getProductsFor(categoryId:String, pageNumber:Int, completionHandler:@escaping (_ response:[OSProductList], _ error:Error?) -> Void) {
        
        OSNetworkManager.sharedInstance.getProducList(categoryId: categoryId, pageNumber: pageNumber) {
            productsJSON, error in
            if let errorResponse = error {
                completionHandler([], errorResponse)
            } else {
                let productsList = self.productList(json: productsJSON)
                completionHandler(productsList, error)
            }
        }
    }
    
    func productList(json:JSON) -> [OSProductList]{
        var arrayOfProducts:[OSProductList] = []
        if let jsonRootObject = json["products"].array {
            for productJsonObject in jsonRootObject {
                if let dictionaryObject = productJsonObject.dictionaryObject {
                    let productList = OSProductList()
                    productList.parse(dict: dictionaryObject)
                    arrayOfProducts.append(productList)
                }
            }
        }
        return arrayOfProducts
    }

    
}
