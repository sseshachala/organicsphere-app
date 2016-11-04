//
//  ProductsViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-25.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import CCBottomRefreshControl
import AlamofireImage


class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var selectedProduct = "Products"
    var selectedCategory:OSCategory = OSCategory()
    var products:[OSProductList] = []
    var errorDescription = ""
    let refreshControl = UIRefreshControl()
    var pageNumber = 1
    var rightBarButton: ENMBadgedBarButtonItem?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedProduct
        
        fetchProducts()
        addRefreshControlToTheBottom()
        setUpRightBarButton()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        rightBarButton?.badgeValue = "\(OSCartService.sharedInstance.productsInCart.count)"
    }
    
    func addRefreshControlToTheBottom() {
        // set up the refresh control
        refreshControl.attributedTitle = NSAttributedString(string: "Loading more content")
        refreshControl.addTarget(self, action: #selector(CategoriesViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        self.tableView?.bottomRefreshControl = refreshControl
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        fetchProducts()
    }
    
    func fetchProducts () {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
        let productService = OSProductService()
        productService.getProductsFor(categoryId: selectedCategory.id!, pageNumber: pageNumber) {
            productList, error in
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            if let errorResponse = error {
                self.errorDescription = errorResponse.localizedDescription
            } else {
                self.products.append(contentsOf: productList)
                self.pageNumber += 1
                if productList.count == 0 {
                    self.tableView.bottomRefreshControl = nil
                } else {
                    self.refreshControl.endRefreshing()
                }
                if self.products.count == 0 {
                    self.errorDescription = "No products available"
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        if products.count > 0
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
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        cell.textLabel?.text = products[indexPath.row].product_name
        cell.detailTextLabel?.text = products[indexPath.row].prodCatName
        if let productImageUrl = products[indexPath.row].product_images_c {
            setImage(to: cell.imageView!, urlString: productImageUrl)
        }
        else {
            cell.imageView?.image = UIImage(named: "lentils")
        }
        
        
        //Set custom label to the accessory view
        let priceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        priceLabel.textAlignment = NSTextAlignment.right
        if let price = products[indexPath.row].terms_fob_price_c {
            priceLabel.text = price.hasPrefix("$") ? "\(price)" : "$\(price)"
        }
        else {
            priceLabel.text = "Not Available"
        }
        priceLabel.textColor = UIColor().osGreenColor()
        
        cell.accessoryView = priceLabel
        return cell
    }
    
    func setImage(to imageView: UIImageView, urlString:String) {
        if let url = URL(string: urlString) {
            let placeholderImage = UIImage(named: "lentils")!
            imageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
        else {
            imageView.image = UIImage(named: "lentils")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ProductsToProductDetails", sender: indexPath)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productDetailsController = segue.destination as? ProductDetailsViewController  {
            if let indexPath = sender as? IndexPath {
                productDetailsController.selectedProduct = products[indexPath.row]
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
        rightBarButton?.badgeValue = "\(OSCartService.sharedInstance.productsInCart.count)"
        
    }
    
    func rightButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "productListToCart", sender: self)
    }

}
