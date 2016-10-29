//
//  TermsConditionsViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-26.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
//import SwiftSpinner

class OSWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    
    enum URLS : String {
        case TermsAndConditions = "https://organic.b2bsphere.com/terms-conditions/",
        About = "https://organic.b2bsphere.com/about-us/",
        PrivacyPolicy = "https://organic.b2bsphere.com/privacy-policy/"
    }
    
    var urlType:URLS? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = urlType?.rawValue {
            webView.loadRequest(URLRequest(url: URL(string: url)!))
        }
    }
    
    override func viewDidLayoutSubviews() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        webView.isHidden = true
//        SwiftSpinner.show("Loading...")
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        webView.isHidden = false
//        SwiftSpinner.hide()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        webView.isHidden = false
//        SwiftSpinner.hide()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
