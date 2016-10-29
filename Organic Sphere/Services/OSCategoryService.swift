//
//  OSCategoryService.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-29.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class OSCategoryService: NSObject {
    
    func getCategories(completionHandler:@escaping (_ response:[OSCategory], _ error:Error?) -> Void) {

        OSNetworkManager.sharedInstance.getCategories() {
            categoriesJOSN, error in
            if let errorResponse = error {
                completionHandler([], errorResponse)
            } else {
                let categoriesArray = self.categories(json: categoriesJOSN)
                completionHandler(categoriesArray, error)
            }
        }
    }
    
    
    func categories(json:JSON) -> [OSCategory]{
        var arrayOfCategoryObjects:[OSCategory] = []
        if let jsonRootObject = json["heirarchyArr"].array {
            for parentsJsonObject in jsonRootObject {
                if let subCategoriesObject = parentsJsonObject["subcats"].array {
                    for subcategory in subCategoriesObject {
                        let dictionaryObject = subcategory.dictionaryObject
                        let category = OSCategory()
                        category.parse(dict: dictionaryObject as! [String : String])
                        arrayOfCategoryObjects.append(category)
                    }
                }
            }
        }
        return arrayOfCategoryObjects
    }

}
