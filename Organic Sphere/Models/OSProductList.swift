//
//  OSProductList.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-29.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit

class OSProductList: NSObject {
    
    var vendor_sku_c: String?
    var horizontal_variants_c: String?
    var threshold_discount_c: String?
    var company_id: String?
    var specifications_c: String?
    var product_id: String?
    var terms_port_c: String?
    var prodCatName: String?
    var product_name: String?
    var company_type: String?
    var model_c: String?
    var id: String?
    var prodCatParentId: String?
    var main_contact: String?
    var sponsored_c: String?
    var company_name: String?
    var productDescription: String?
    var featured_c: String?
    var certifications_c: String?
    var product_logo: String?
    var variants_c: String?
    var order_samples_c: String?
    var terms_capacity_c: String?
    var contact_person: String?
    var terms_lead_time_c: String?
    var vertical_variants_c: String?
    var brand_c: String?
    var addtocart_c: String?
    var product_images_c: String?
    var terms_fob_price_c: String?
    var tags_c: String?
    var terms_terms_c: String?
    var terms_min_order_c: String?
    var product_enquiry_c: String?
    var productCatId: String?
    var email_address: [String]?
    var _version_: String?
    var orderedQuantity = 1
    
    func parse(dict: [String: Any]){
        vendor_sku_c = dict["vendor_sku_c"] as? String
        horizontal_variants_c = dict["horizontal_variants_c"] as? String
        threshold_discount_c = dict["threshold_discount_c"] as? String
        company_id = dict["company_id"] as? String
        specifications_c = dict["specifications_c"] as? String
        terms_port_c = dict["terms_port_c"] as? String
        prodCatName = dict["prodCatName"] as? String
        product_name = dict["product_name"] as? String
        company_type = dict["company_type"] as? String
        model_c = dict["model_c"] as? String
        id = dict["id"] as? String
        prodCatParentId = dict["prodCatParentId"] as? String
        main_contact = dict["main_contact"] as? String
        sponsored_c = dict["sponsored_c"] as? String
        company_name = dict["company_name"] as? String
        productDescription = dict["description"] as? String
        featured_c = dict["featured_c"] as? String
        certifications_c = dict["certifications_c"] as? String
        product_logo = dict["product_logo"] as? String
        order_samples_c = dict["order_samples_c"] as? String
        variants_c = dict["variants_c"] as? String
        terms_capacity_c = dict["terms_capacity_c"] as? String
        contact_person = dict["contact_person"] as? String
        terms_lead_time_c = dict["terms_lead_time_c"] as? String
        vertical_variants_c = dict["vertical_variants_c"] as? String
        brand_c = dict["brand_c"] as? String
        addtocart_c = dict["addtocart_c"] as? String
        product_images_c = dict["product_images_c"] as? String
        terms_fob_price_c = dict["terms_fob_price_c"] as? String
        tags_c = dict["tags_c"] as? String
        terms_terms_c = dict["terms_terms_c"] as? String
        terms_min_order_c = dict["terms_min_order_c"] as? String
        product_enquiry_c = dict["product_enquiry_c"] as? String
        productCatId = dict["productCatId"] as? String
        email_address = dict["email_address"] as? [String]
        _version_ = dict["_version_"] as? String

        validateData()
    }
    
    func validateData() {
        //Remove $ from the model
        terms_fob_price_c = terms_fob_price_c?.replacingOccurrences(of: "$", with: "")
    }
}
