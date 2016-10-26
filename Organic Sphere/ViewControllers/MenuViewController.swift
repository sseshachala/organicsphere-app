//
//  MenuViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-25.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let menuDataSource = ["HOME", "CATEGORY", "TERMS AND CONDITIONS", "PRIVACY POLICY", "ABOUT"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor().osGreenColor()
        tableView.backgroundColor = UIColor().osGreenColor()
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
        return 80;
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
