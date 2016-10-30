//
//  OSOrderConfirmationViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-29.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit

class OSOrderConfirmationViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var desciptionTextView: UITextView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var confirmOrderButton: UIButton!
    @IBOutlet weak var crossButtonClicked: UIButton!
    var overlayRect = CGRect()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        view.isOpaque = false
        
        overlayView.layer.borderColor = UIColor.gray.cgColor
        overlayView.layer.borderWidth = 0.5
        overlayView.layer.cornerRadius = 15
        addSavedValues()
        enableDisableDoneButton()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: .UIKeyboardDidHide, object: nil)

    }
    
    func addSavedValues() {
        pinTextField.text = OSCartService.sharedInstance.postalCode
        addressTextView.text = OSCartService.sharedInstance.address
        nameTextField.text = OSCartService.sharedInstance.fullName
        
        checkIfPlaceholderTextIsNeeded(textView: desciptionTextView)
        checkIfPlaceholderTextIsNeeded(textView: addressTextView)
    }

    override func viewDidLayoutSubviews() {
        confirmOrderButton.layer.cornerRadius = confirmOrderButton.frame.width * 0.12
        addBottomBorderTo(textField: nameTextField)
        addBottomBorderToTextView(textView: addressTextView)
        addBottomBorderTo(textField: pinTextField)
        addBottomBorderToTextView(textView: desciptionTextView)
        overlayRect = overlayView.frame
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
    
    func addBottomBorderToTextView(textView: UITextView) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: textView.frame.size.height - width, width:  textView.frame.size.width, height: textView.frame.size.height)
        
        border.borderWidth = width
        textView.layer.addSublayer(border)
        textView.layer.masksToBounds = true
    }
    
    @IBAction func confirmatioTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func crossButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        enableDisableDoneButton()
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        checkIfPlaceholderTextIsNeeded(textView: textView)
        enableDisableDoneButton()
    }
    
    func textViewShouldBeginEditing(_ aTextView: UITextView) -> Bool
    {
        if aTextView.text == "Address" || aTextView.text == "Description"
        {
            // move cursor to start
            moveCursorToStart(aTextView: aTextView)
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // remove the placeholder text when they start typing
        // first, see if the field is empty
        // if it's not empty, then the text should be black and not italic
        // BUT, we also need to remove the placeholder text if that's the only text
        
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        let newLength = textView.text.utf16.count + text.utf16.count - range.length
        if newLength > 0 // have text, so don't show the placeholder
        {
            // check if the only text is the placeholder and remove it if needed
            if textView.text == "Address" || textView.text == "Description"
            {
                applyNonPlaceholderStyle(aTextview: textView)
                textView.text = ""
            }
        }
        
        
        return true
    }
    
    func checkIfPlaceholderTextIsNeeded(textView:UITextView) {
        if textView.text.characters.count > 0 {
            applyNonPlaceholderStyle(aTextview: textView)
        }
        else {
            switch textView.tag {
            case 0:
                applyPlaceholderStyle(aTextview: textView, placeholderText: "Address")
            case 1:
                applyPlaceholderStyle(aTextview: textView, placeholderText: "Description")
            default: break
            }
        }
    }
    
    
    func applyNonPlaceholderStyle(aTextview: UITextView)
    {
        // make it look like normal text instead of a placeholder
        aTextview.textColor = UIColor.darkText
        aTextview.alpha = 1.0
    }
    
    func applyPlaceholderStyle(aTextview: UITextView, placeholderText: String)
    {
        // make it look (initially) like a placeholder
        aTextview.textColor = UIColor.lightGray
        aTextview.text = placeholderText
    }
    
    func moveCursorToStart(aTextView: UITextView)
    {
        DispatchQueue.main.async {
            aTextView.selectedRange = NSMakeRange(0, 0);
        }
    }
    
    func enableDisableDoneButton() {
        if(addressTextView.text.characters.count > 0 && (nameTextField.text?.characters.count)! > 0 && (pinTextField.text?.characters.count)! > 0) {
            confirmOrderButton.isEnabled = true
            confirmOrderButton.backgroundColor = UIColor().osGreenColor()
        }
        else {
            confirmOrderButton.isEnabled = false
            confirmOrderButton.backgroundColor = UIColor.lightGray
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        overlayView.frame = CGRect(x: overlayView.frame.origin.x, y: 80, width: overlayView.frame.width, height: overlayView.frame.height )
    }
    
    func keyboardDidHide(notification: NSNotification) {
        overlayView.frame = overlayRect
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
