//
//  MenuViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-25.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import SideMenu

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
        let viewForLogo = UIView(frame: CGRect(x:0, y:0, width: 100, height:100))
        let splashImageView = UIImageView(frame: CGRect(x:tableView.frame.width/2 - 75, y:0, width: 150, height:100))
        splashImageView.image = UIImage(named: "splashImage")
        viewForLogo.addSubview(splashImageView)
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


}
