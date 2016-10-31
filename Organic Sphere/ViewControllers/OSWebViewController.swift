//
//  TermsConditionsViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-26.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class OSWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    
    enum URLS {
        case TermsAndConditions ,
        About ,
        PrivacyPolicy
    }
    
    var urlType:URLS? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
        
        fetchStaticTexts()
    }
    
    func fetchStaticTexts() {
        OSNetworkManager.sharedInstance.getApplicationStaticText {
            responseJSON, error in
            if let errorResponse = error {
                let _ = SweetAlert().showAlert("Failure", subTitle: "Failed to load the content.\nError: \(errorResponse)", style: AlertStyle.error)
                let _ = self.navigationController?.popViewController(animated: true)
            }
            else {
                if self.urlType == URLS.TermsAndConditions {
                    self.loadWebView(htmlString: responseJSON["tos"].string)
                } else if self.urlType == URLS.About {
                    self.loadWebView(htmlString: responseJSON["aboutUs"].string)
                } else if self.urlType == URLS.PrivacyPolicy {
                    self.loadWebView(htmlString: responseJSON["pp"].string)
                }
                else {
                    let _ = SweetAlert().showAlert("Failure", subTitle: "Failed to load the content.", style: AlertStyle.error)
                    let _ = self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
    }
    
    func loadWebView(htmlString: String?) {
        if let html = htmlString {
            webView.loadHTMLString(html, baseURL: nil)
        } else {
            let _ = SweetAlert().showAlert("Failure", subTitle: "Failed to load the content.", style: AlertStyle.error)
            let _ = self.navigationController?.popViewController(animated: true)

        }
    }
    
    override func viewDidLayoutSubviews() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        webView.isHidden = true
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if(request.url?.absoluteString == "about:blank"){
            return true
        }
        return false
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        webView.isHidden = false
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        webView.isHidden = false
    }

}
