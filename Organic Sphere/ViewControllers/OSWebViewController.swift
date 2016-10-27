//
//  TermsConditionsViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-26.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class OSWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    enum URLS : String {
        case TermsAndConditions = "https://organic.b2bsphere.com/terms-conditions/",
        About = "https://organic.b2bsphere.com/about-us/",
        PrivacyPolicy = "https://organic.b2bsphere.com/privacy-policy/"
    }
    
    var urlType:URLS? = nil
//    var title:String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = urlType?.rawValue {
            webView.loadRequest(URLRequest(url: URL(string: url)!))
            
            let activityData = ActivityData()
            
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
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
