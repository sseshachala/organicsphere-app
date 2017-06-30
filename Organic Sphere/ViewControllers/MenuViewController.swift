//
//  MenuViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-25.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import SideMenu

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var tableView: UITableView!
    let menuDataSource = ["HOME", "CATEGORY", "TERMS & CONDITIONS", "PRIVACY POLICY", "ABOUT"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor().osGreenColor()
        tableView.backgroundColor = UIColor().osGreenColor()
        
        //
        self.navigationController?.setNavigationBarHidden(true, animated: false);
        
        self.tableView.isScrollEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        let viewForLogo = UIView(frame: CGRect(x:0, y:0, width: 100, height:400))
        let verbageLabel = UILabel(frame: CGRect(x:0, y:0, width:self.tableView.frame.width, height:60))
        verbageLabel.textColor = UIColor.white
        let footerMessage = "Your neighborhood stores for Organic groceries and healthy natural products \n https://www.organic-sphere.com/"
        let mutableAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: footerMessage)
        _ = mutableAttributedString.setAsLink(textToFind: "https://www.organic-sphere.com/", linkURL: "https://www.organic-sphere.com/")
        verbageLabel.attributedText = mutableAttributedString
        verbageLabel.textAlignment = NSTextAlignment.center
        verbageLabel.font = verbageLabel.font.withSize(13)

        verbageLabel.numberOfLines = 0
        let splashImageView = UIImageView(frame: CGRect(x:tableView.frame.width/2 - 100, y:verbageLabel.frame.height, width: 200, height:150))
        splashImageView.image = UIImage(named: "splash")
        viewForLogo.addSubview(verbageLabel)
        viewForLogo.addSubview(splashImageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        viewForLogo.addGestureRecognizer(tap)
        
        self.tableView.tableFooterView = viewForLogo
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuDataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text = menuDataSource[indexPath.row]
        cell.imageView?.image = UIImage(named: menuDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2, 3 ,4:
            performSegue(withIdentifier: "ToOSWebViewController", sender: indexPath)
            break
        case 0:
            performSegue(withIdentifier: "showHome", sender: indexPath)
        default:
            dismiss(animated: true, completion: nil)
            break
        }
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  let controller = segue.destination as? OSWebViewController {
            if let indexPath = sender as? NSIndexPath {
                controller.title = menuDataSource[indexPath.row]
                switch indexPath.row {
                case 2:
                    controller.urlType = .TermsAndConditions
                    break
                case 3:
                    controller.urlType = .PrivacyPolicy
                    break
                case 4:
                    controller.urlType = .About
                    break
                default: break
                }
            }
        }
    }
    
    func handleTap() {
        guard let url = URL(string: "https://www.organic-sphere.com/") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:]) {_ in }
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(url)
        }
    }


}


extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(NSLinkAttributeName, value: linkURL, range: foundRange)
            self.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: foundRange)
            self.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: foundRange)

            return true
        }
        return false
    }
}
