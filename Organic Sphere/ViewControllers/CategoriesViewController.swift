    //
//  CategoriesViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-25.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import SideMenu
import NVActivityIndicatorView

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    @IBOutlet weak var cartButton: ENMBadgedBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var categoriesDataSource:[OSCategory] = []
    let refreshControl = UIRefreshControl()
    var rightBarButton: ENMBadgedBarButtonItem?
    var errorDescription:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.title = "Categories"
        
        SideMenuManager.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
//        SideMenuManager.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
//        SideMenuManager.menuEnableSwipeGestures = false
        SideMenuManager.menuFadeStatusBar = false
        
        OSLocationManager.sharedInstance.intializeLocationManager()
        //Add refresh control to the table
        addRefreshControl()
        
        //Get ctegories
        fetchCategories(isFromPullToRefresh: false)
        
        //
        setUpRightBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rightBarButton?.badgeValue = "\(OSCartService.sharedInstance.productsInCart.count)"
    }
    
    func addRefreshControl() {
        // set up the refresh control
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(CategoriesViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        self.tableView?.addSubview(refreshControl)
    }
    
    func fetchCategories(isFromPullToRefresh:Bool) {
        
        if !isFromPullToRefresh {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
        }
        
        let categoryService = OSCategoryService()
        categoryService.getCategories() {
            categories, error in
            //End Refreshing
            isFromPullToRefresh ? self.refreshControl.endRefreshing() : NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            //Handle request success/failure
            if let errorResponse = error {
                self.errorDescription = errorResponse.localizedDescription
            }
            else {
                self.categoriesDataSource = categories
                if self.categoriesDataSource.count == 0 {
                    self.errorDescription = "No categories available at the moment"
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        fetchCategories(isFromPullToRefresh: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if categoriesDataSource.count > 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = errorDescription
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesDataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categoriesDataSource[indexPath.row].prodCatName
        cell.detailTextLabel?.text = categoriesDataSource[indexPath.row].parentName
        cell.imageView?.image = UIImage(named: "lentils")
        cell.accessoryView = UIImageView(image: UIImage(named: "disclosure"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CategoriesToProducts", sender: indexPath)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productsController = segue.destination as? ProductsViewController  {
            if let indexPath = sender as? IndexPath {
                if let productName = categoriesDataSource[indexPath.row].prodCatName {
                    productsController.selectedProduct = productName
                    productsController.selectedCategory = categoriesDataSource[indexPath.row]
                }
            }
        }
    }
    
    func setUpRightBarButton() {
        let image = UIImage(named: "cart")
        let button = UIButton(type: .custom)
        if let knownImage = image {
            button.frame = CGRect(x: 0.0, y: 0.0, width: knownImage.size.width, height: knownImage.size.height)
        } else {
            button.frame = CGRect.zero;
        }
        
        button.setBackgroundImage(image, for: UIControlState())
        button.addTarget(self,
                         action: #selector(CategoriesViewController.rightButtonPressed(_:)),
                         for: UIControlEvents.touchUpInside)
        
        let newBarButton = ENMBadgedBarButtonItem(customView: button, value: "\(OSCartService.sharedInstance.productsInCart.count)")
        rightBarButton = newBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        rightBarButton?.badgeBackgroundColor = UIColor.red
        rightBarButton?.badgeTextColor = UIColor.white

    }
    
    func rightButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toCart", sender: self)
    }

}
