//
//  ForgotViewController.swift
//  Massage
//
//  Created by Panda2 on 11/5/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import UIKit

class ForgotViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var EmailInputView: UIView!
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var SendBtBotttomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let borderColor = UIColor(red: 254/255.0, green: 194/255.0, blue: 0.0, alpha: 1.0).cgColor
        
        self.EmailInputView.layer.cornerRadius = 7
        self.EmailInputView.layer.borderWidth = 1
        self.EmailInputView.layer.borderColor = borderColor
        
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
    
    func onSendEmail() {
        
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
            })
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if self.SendBtBotttomConstraint.constant != 0 {
            UIView.animate(withDuration: 0.1, animations: {() -> Void in
                self.SendBtBotttomConstraint.constant = 0
            })
        }
    }

}
