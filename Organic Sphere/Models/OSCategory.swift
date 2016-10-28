//
//  OSCategory.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-27.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit

class OSCategory: NSObject {
    var id: String?
    var parentId: String?
    var prodCatName: String?
    var parentName: String?
    var _version_: String? ///Don't know what this is for
    
    func parse(dict: [String: String]){
        id = dict["id"]
        parentId = dict["parentId"]
        prodCatName = dict["prodCatName"]
        parentName = dict["parentName"]
        _version_ = dict["_version_"]
    }
}
