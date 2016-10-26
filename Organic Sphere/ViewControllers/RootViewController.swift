//
//  ViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-25.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class RootViewController: SlideMenuController {

    override func awakeFromNib() {
        
        SlideMenuOptions.leftViewWidth = view.frame.width * 0.80
        SlideMenuOptions.contentViewScale = 0.50
        
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController") {
            self.mainViewController = controller
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") {
            self.leftViewController = controller
        }
        super.awakeFromNib()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.addLeftBarButtonWithImage(UIImage(named: "menu")!)
        self.addRightBarButtonWithImage(UIImage(named: "cart")!)
        
        navigationController?.navigationBar.barTintColor = UIColor().osGreenColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

