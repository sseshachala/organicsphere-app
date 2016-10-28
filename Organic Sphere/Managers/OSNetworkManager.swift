//
//  OSNetworkManager.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-27.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OSNetworkManager: NSObject {
    
    enum URLMapping : String {
        case Categories = "https://devqa.b2bsphere.com/api/v1/rest/catalog/organicCategories",
        Products = "po",
        PostalCodeTaxes = "pc"
    }
    
    
    //MARK: Shared Instance
    
    static let sharedInstance : OSNetworkManager = {
        let instance = OSNetworkManager()
        return instance
    }()
    
    
    func getCategories(completionHandler:@escaping (_ response:[OSCategory], _ error:Error?) -> Void) {
        Alamofire.request(URLMapping.Categories.rawValue, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                //to get status code
                
                switch response.result {
                case .success(let value):
                    completionHandler(self.categories(json: JSON(value)), nil)
                case .failure(let error):
                    completionHandler([], error)
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
