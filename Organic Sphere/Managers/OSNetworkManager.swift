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
    #if RELEASE
<<<<<<< HEAD
        static let server = "https://b2bsphere.com"
    #else
        static let server = "https://b2bsphere.com"
=======
        static let server = "http://b2bsphere.com"
    #else
        static let server = "http://devqa.b2bsphere.com"
>>>>>>> 302d33ebed4776c8d3a27df6bbace57ed4db8408
    #endif
    
    static let restServicePathFirstVersion = "/api/v1/rest"
    
    struct APIRoutes {
        
        static let routeCategories = "\(server)\(restServicePathFirstVersion)/catalog/organicCategories"
        static let routePhoneNumberList = "\(server)\(restServicePathFirstVersion)/organicsphere/phonenumbers"
        static let routeStaticTextOfApp = "\(server)\(restServicePathFirstVersion)/organicsphere/"
        static func routeTax(postalCode: String) -> String {
            return "\(server)\(restServicePathFirstVersion)/taxrate/\(postalCode)"
        }
        static func routeProductListFor(categoryId: String, pageNumber:Int) -> String {
            return "\(server)\(restServicePathFirstVersion)/catalog/categoryProducts/\(categoryId)/\(pageNumber)/10"
        }

        //ToDo: This should be removed from here and should be added to a UTIlity Class
        static func routePostMessageOn(phoneNumbers: [String], baseEncodedString:String) -> String {
            var commaSeparatedString = ""
            for phone in phoneNumbers {
                commaSeparatedString.append(phone)
                if phone != phoneNumbers.last {
                    commaSeparatedString.append(",")
                }
            }
            return "\(server)\(restServicePathFirstVersion)/organicsphere/sendMessage/\(commaSeparatedString)/\(baseEncodedString)"
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
    
    func getPhoneNumbers(completionHandler:@escaping (_ response:JSON, _ error:Error?) -> Void) {
        GET(apiUrl: APIRoutes.routePhoneNumberList, completionHandler: completionHandler)
    }
    
    func getApplicationStaticText(completionHandler:@escaping (_ response:JSON, _ error:Error?) -> Void) {
        GET(apiUrl: APIRoutes.routeStaticTextOfApp, completionHandler: completionHandler)
    }
    
    func sendOrderMessage(phoneNumbers: [String], baseEncodedString:String, completionHandler:@escaping (_ response:JSON, _ error:Error?) -> Void) {
        GET(apiUrl: APIRoutes.routePostMessageOn(phoneNumbers: phoneNumbers, baseEncodedString: baseEncodedString), completionHandler: completionHandler)
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
