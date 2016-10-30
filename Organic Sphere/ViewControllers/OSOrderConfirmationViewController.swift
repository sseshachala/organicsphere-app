//
//  OSOrderConfirmationViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-29.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit

class OSOrderConfirmationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var desciptionTextField: UITextField!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var confirmOrderButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        view.isOpaque = false
        
        overlayView.layer.borderColor = UIColor.gray.cgColor
        overlayView.layer.borderWidth = 0.5
        overlayView.layer.cornerRadius = 15
    }

    override func viewDidLayoutSubviews() {
        confirmOrderButton.layer.cornerRadius = confirmOrderButton.frame.width * 0.12
        addBottomBorderTo(textField: nameTextField)
        addBottomBorderTo(textField: addressTextField)
        addBottomBorderTo(textField: pinTextField)
        addBottomBorderTo(textField: desciptionTextField)
    }
    
    func addBottomBorderTo(textField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    @IBAction func confirmatioTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
