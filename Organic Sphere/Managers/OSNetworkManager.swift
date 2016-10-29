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
    
    struct APIRoutes {
        static let routeCategories = "https://devqa.b2bsphere.com/api/v1/rest/catalog/organicCategories"
        static func routeTax(postalCode: String) -> String {
            return "https://devqa.b2bsphere.com/api/v1/rest/taxrate/\(postalCode)"
        }
        static func routeProductListFor(categoryId: String, pageNumber:Int) -> String {
            return "https://devqa.b2bsphere.com/api/v1/rest/catalog/categoryProducts/\(categoryId)/\(pageNumber)/10"
        }
    }
    
    //MARK: Shared Instance
    
    static let sharedInstance : OSNetworkManager = {
        let instance = OSNetworkManager()
        return instance
    }()
    
    
    func getCategories(completionHandler:@escaping (_ response:JSON, _ error:Error?) -> Void) {
        GET(apiUrl: APIRoutes.routeCategories, completionHandler: completionHandler)
    }
    
    func getTaxDetailsFor(postalCode: String, completionHandler:@escaping (_ response:JSON, _ error:Error?) -> Void) {
        GET(apiUrl: APIRoutes.routeTax(postalCode: postalCode), completionHandler: completionHandler)
    }
    
    func getProducList(categoryId: String, pageNumber: Int, completionHandler:@escaping (_ response:JSON, _ error:Error?) -> Void) {
        GET(apiUrl: APIRoutes.routeProductListFor(categoryId: categoryId, pageNumber: pageNumber), completionHandler: completionHandler)
    }
    
    private func GET(apiUrl: String, completionHandler:@escaping (_ response:JSON, _ error:Error?) -> Void) {
        Alamofire.request(apiUrl, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completionHandler(JSON(value), nil)
                case .failure(let error):
                    completionHandler([], error)
                }
        }
    }
}
