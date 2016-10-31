//
//  OSOrderConfirmationViewController.swift
//  Organic Sphere
//
//  Created by Harshdeep Singh on 2016-10-29.
//  Copyright © 2016 Arshdeep Singh. All rights reserved.
//

import UIKit
import MessageUI


class OSOrderConfirmationViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var selectDateTimeField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var pinTextField: UITextField!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var confirmOrderButton: UIButton!
    @IBOutlet weak var crossButtonClicked: UIButton!
    var overlayRect = CGRect()
    var phoneNumber = ["4082039960","8327975259"]
    var delegate: OrderConfirmation?

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
        
        checkIfPlaceholderTextIsNeeded(textView: addressTextView)
    }

    override func viewDidLayoutSubviews() {
        confirmOrderButton.layer.cornerRadius = confirmOrderButton.frame.width * 0.12
        addBottomBorderTo(textField: nameTextField)
        addBottomBorderToTextView(textView: addressTextView)
        addBottomBorderTo(textField: pinTextField)
        addBottomBorderTo(textField: selectDateTimeField)
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
    
    @IBAction func crossButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == selectDateTimeField {
            let datePickerView:UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
            datePickerView.minimumDate = Date()//Calendar.current.date(byAdding: .day, value: 1, to: Date())
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(OSOrderConfirmationViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .full
        
        dateFormatter.timeStyle = .medium

        selectDateTimeField.text = dateFormatter.string(from: sender.date)
        
        enableDisableDoneButton()
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
        if(addressTextView.text.characters.count > 0 && (nameTextField.text?.characters.count)! > 0 && (pinTextField.text?.characters.count)! > 0 && (selectDateTimeField.text?.characters.count)! > 0) {
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
    
    @IBAction func confirmatioTapped(_ sender: AnyObject) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.subject = "Organic Sphere Mobile Order"
            controller.body = createOrderMessageFormat()
            
            if OSCartService.sharedInstance.phoneNumbersToSendOrderTo.count == 0{
                controller.recipients = phoneNumber
            }
            else {
                controller.recipients = OSCartService.sharedInstance.phoneNumbersToSendOrderTo
            }
            
            controller.messageComposeDelegate = self
            present(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
        switch result {
        case .cancelled:
            let _ = SweetAlert().showAlert("Failure", subTitle: "Order was cancelled by the user.", style: AlertStyle.warning)
        case .failed:
            let _ = SweetAlert().showAlert("Failure", subTitle: "Failed to place the order because the system was unable to send the message.", style: AlertStyle.error)
        case .sent:
            let _ = SweetAlert().showAlert("Success", subTitle: "Order was sent successfully!", style: AlertStyle.success)
            dismiss(animated: true, completion: nil)
            delegate?.didConfirmOder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func createOrderMessageFormat() -> String {
        var messageFormat = ""
        for product in OSCartService.sharedInstance.productsInCart {
            messageFormat.append("\(product.product_name!), \(product.orderedQuantity)\n\n")
        }
        messageFormat.append("Total Bill: $\(OSCartService.sharedInstance.totalPrice())\n")
        messageFormat.append("Tax: \(OSCartService.sharedInstance.taxValue)\(OSCartService.sharedInstance.taxValueType)\n")
        messageFormat.append("Delivery Charges: $\(OSCartService.sharedInstance.totalPrice() < 100 ? 20 : 0)\n")
        
        messageFormat.append("\n")
        
        messageFormat.append("\(nameTextField.text!)\n")
        messageFormat.append("Delivery Time: \(selectDateTimeField.text!)\n")
        messageFormat.append("\(addressTextView.text!)\n")
        
        return messageFormat;
    }
    


}
