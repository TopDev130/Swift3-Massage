//
//  ForgotViewController.swift
//  Massage
//
//  Created by Panda2 on 11/5/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

class ForgotViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var EmailInputView: UIView!
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var SendBtBotttomConstraint: NSLayoutConstraint!
    @IBOutlet weak var ContentViewMiddleConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ForgotPasswordLabel: UILabel!
    @IBOutlet weak var ForgotPasswordDescriptionLabel: UILabel!
    
    @IBOutlet weak var SendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleLabel.text = "ForgotPasswordTitle".localized()
        ForgotPasswordLabel.text = "ForgotPasswordLabel".localized()
        SendButton.setTitle("SendIntroButton".localized(), for: .normal)
        ForgotPasswordDescriptionLabel.text = "ForgotPasswordDescription".localized()
        
        let borderColor = UIColor(red: 254/255.0, green: 194/255.0, blue: 0.0, alpha: 1.0).cgColor
        
        self.EmailInputView.layer.cornerRadius = 7
        self.EmailInputView.layer.borderWidth = 1
        self.EmailInputView.layer.borderColor = borderColor
        
        self.EmailTextField.attributedPlaceholder = NSAttributedString(string: "EnterEmail".localized(), attributes: [NSForegroundColorAttributeName: Color.notInUse])
        
        self.EmailTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.EmailTextField.resignFirstResponder()
    }
    
    @IBAction func onBackButtonClicked(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSendButtonClicked(_ sender: AnyObject) {
        onSendEmail()
    }
    
    func isValidEmail(emailStr: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    func onSendEmail() {
        
        if !isValidEmail(emailStr: EmailTextField.text!) {
            
            AlertDisplay.showAlert(title: "emailInputErrorTitle".localized(), message: "emailAddressInvalidMessage".localized(), cancellButtonTitle: "OK".localized(), onViewController: self, completion: nil)
            
            return
            
        } else {
            
            APIClient.sharedInstance.requestPasswordReset(emailAddress: EmailTextField.text!).startWithResult {(result) in
                
                print("Rest Password", result)
                AlertDisplay.showAlert(title: "checkEmailTitle".localized(), message: "sendPasswordSuccessfully".localized(), cancellButtonTitle: "OK".localized(), onViewController: self, completion: nil)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == self.EmailTextField {
            textField.resignFirstResponder()
            onSendEmail()
        }
        return true
    }

    func keyboardDidShow(notification: NSNotification) {
        
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        
        if self.SendBtBotttomConstraint.constant==0 {
            UIView.animate(withDuration: 0.1, animations: {() -> Void in
                self.SendBtBotttomConstraint.constant = self.SendBtBotttomConstraint.constant - (keyboardSize?.height)!
                self.ContentViewMiddleConstraint.constant = self.ContentViewMiddleConstraint.constant - (keyboardSize?.height)!/2.5
            })
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if self.SendBtBotttomConstraint.constant != 0 {
            UIView.animate(withDuration: 0.1, animations: {() -> Void in
                self.SendBtBotttomConstraint.constant = 0
                self.ContentViewMiddleConstraint.constant = 20;
            })
        }
    }

}
