//
//  OSProduct.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-29.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit

class OSProduct: NSObject {
    var company_id: String?
    var company_name: String?
    var product_id: String?
    var product_name: String?
    var product_logo: String?
    var productDescription: String?
    var tags: String?
    var model: String?
    var vendor: String?
    var specifications_c: String?
    var terms_fob_price_c: String?
    var terms_lead_time_c: String?
    var terms_port_c: String?
    var terms_capacity_c: String?
    var terms_min_order_c: String?
    var terms_terms_c: String?
    var certifications_c: String?
    var company_type: String?
    var contact_person: String?
    var email_address: String?
    var slug_product_name: String?
    var order_samples_c: String?
    var addtocart_c: String?
    var product_images_c: String?
    var horizontal_variants_c: String?
    var vertical_variants_c: String?
    var variants_c: String?

    func parse(dict: [String: String]){
        company_id = dict["company_id"]
        company_name = dict["company_name"]
        product_id = dict["product_id"]
        product_name = dict["product_name"]
        product_logo = dict["product_logo"]
        productDescription = dict["description"]
        tags = dict["tags"]
        model = dict["model"]
        vendor = dict["vendor"]
        specifications_c = dict["specifications_c"]
        terms_fob_price_c = dict["terms_fob_price_c"]
        terms_lead_time_c = dict["terms_lead_time_c"]
        terms_port_c = dict["terms_port_c"]
        terms_capacity_c = dict["terms_capacity_c"]
        terms_min_order_c = dict["terms_min_order_c"]
        terms_terms_c = dict["terms_terms_c"]
        certifications_c = dict["certifications_c"]
        company_type = dict["company_type"]
        contact_person = dict["contact_person"]
        email_address = dict["email_address"]
        slug_product_name = dict["slug_product_name"]
        order_samples_c = dict["order_samples_c"]
        addtocart_c = dict["addtocart_c"]
        product_images_c = dict["product_images_c"]
        horizontal_variants_c = dict["horizontal_variants_c"]
        vertical_variants_c = dict["vertical_variants_c"]
        variants_c = dict["variants_c"]
    }}
