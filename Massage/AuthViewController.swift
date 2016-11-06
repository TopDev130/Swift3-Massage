//
//  AuthViewController.swift
//  Massage
//
//  Created by Panda2 on 11/4/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import UIKit
import DropDown

class AuthViewController: UIViewController, UITextFieldDelegate {
    
    var isSignInView = false
    var keyboardMoveHeight = 0
    
    var selectedUIColor = UIColor(red: 254/255.0, green: 194/255.0, blue: 0.0, alpha: 1.0)
    var unSelectedUIColor = UIColor(red: 231/255.0, green: 233/255.0, blue: 238/255.0, alpha: 1.0)
    
    var unfocusedFontColor = UIColor(red: 73/255.0, green: 72/255.0, blue: 92/255.0, alpha: 0.2).cgColor
    var fontColor = UIColor(red: 73/255.0, green: 72/255.0, blue: 92/255.0, alpha: 1.0)
    
    let selectCityDropDown = DropDown()
    
    @IBOutlet weak var SignInEmailSelectView: UIView!
    @IBOutlet weak var SignInPasswordSelectView: UIView!
    
    @IBOutlet weak var SignUpFullNameSelectView: UIView!
    @IBOutlet weak var SignUpEmailSelectView: UIView!
    @IBOutlet weak var SignUpPasswordSelectView: UIView!
    @IBOutlet weak var SignUpConfirmSelectView: UIView!
    
    @IBOutlet weak var SignUpTabClickedView: UIView!
    @IBOutlet weak var SignInTabClickedView: UIView!
    
    @IBOutlet weak var SignUpButtonView: UIButton!
    
    @IBOutlet weak var SignInInputView: UIView!
    @IBOutlet weak var SignInEmailAddress: UITextField!
    @IBOutlet weak var SignInPassword: UITextField!
    
    @IBOutlet weak var SignUpInputView: UIView!
    @IBOutlet weak var SignUpFullName: UITextField!
    @IBOutlet weak var SignUpEmailAddress: UITextField!
    @IBOutlet weak var SignUpPassword: UITextField!
    @IBOutlet weak var SignUpConfirmPassword: UITextField!
    @IBOutlet weak var SelectCityButton: UIButton!
    
    @IBOutlet weak var SignUpFullNameView: UIView!
    @IBOutlet weak var SingUpEmailView: UIView!
    @IBOutlet weak var SignUpPasswordView: UIView!
    @IBOutlet weak var SignUpConfirmView: UIView!
    @IBOutlet weak var SignUpCityView: UIView!
    @IBOutlet weak var SignInEmailView: UIView!
    @IBOutlet weak var SignInPasswordView: UIView!
    
    
    @IBOutlet weak var TabViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var ContainViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SignInTabClickedView.isHidden = true
        self.SignInInputView.isHidden = true
        
        let signUIColor = UIColor(red: 231/255.0, green: 233/255.0, blue: 238/255.0, alpha: 1.0).cgColor
        
        let fontUIColor = UIColor(red: 73/255.0, green: 72/255.0, blue: 92/255.0, alpha: 1.0)
        
        //sign up input view attributes definition
        self.SignUpInputView.layer.borderWidth = 1
        self.SignUpInputView.layer.borderColor = signUIColor
        self.SignUpFullName.attributedPlaceholder = NSAttributedString(string: "Enter Your Full Name", attributes: [NSForegroundColorAttributeName: fontUIColor])
        self.SignUpEmailAddress.attributedPlaceholder = NSAttributedString(string: "Enter Your Email", attributes: [NSForegroundColorAttributeName:fontUIColor])
        self.SignUpPassword.attributedPlaceholder = NSAttributedString(string: "Create a Password", attributes: [NSForegroundColorAttributeName: fontUIColor])
        self.SignUpConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSForegroundColorAttributeName: fontUIColor])
        
        self.SignInInputView.layer.cornerRadius = 7
        self.SignInInputView.layer.borderWidth = 1
        self.SignInInputView.layer.borderColor = signUIColor
        self.SignInEmailAddress.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSForegroundColorAttributeName: fontUIColor])
        self.SignInPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: fontUIColor])
        
        setupSelectCityDropDown()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.SignUpFullName.delegate = self
        self.SignUpEmailAddress.delegate = self
        self.SignUpPassword.delegate = self
        self.SignUpConfirmPassword.delegate = self
        
        self.SignInEmailAddress.delegate = self
        self.SignInPassword.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unfocusedTextField()
    }
    
    @IBAction func onBackButtonClicked(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSignUpTabClicked(_ sender: AnyObject) {
        self.SignInTabClickedView.isHidden = true
        self.SignUpTabClickedView.isHidden = false
        self.SignInInputView.isHidden = true
        self.SignUpInputView.isHidden = false
        self.isSignInView = false
        self.SignUpButtonView.setTitle("SIGN UP", for: UIControlState.normal)
        unfocusedTextField()
    }
    
    @IBAction func onSignInTabClicked(_ sender: AnyObject) {
        self.SignInTabClickedView.isHidden = false
        self.SignUpTabClickedView.isHidden = true
        self.SignInInputView.isHidden = false
        self.SignUpInputView.isHidden = true
        self.isSignInView = true
        self.SignUpButtonView.setTitle("SIGN IN", for: UIControlState.normal)
        unfocusedTextField()
    }
    
    @IBAction func onSelectCityButtonClicked(_ sender: AnyObject) {
        selectCityDropDown.show()
        unfocusedTextField()
    }
    
    func setTextFieldMask() {
        self.SignUpFullNameSelectView.backgroundColor = self.unSelectedUIColor
        self.SignUpEmailSelectView.backgroundColor = self.unSelectedUIColor
        self.SignUpPasswordSelectView.backgroundColor = self.unSelectedUIColor
        self.SignUpConfirmSelectView.backgroundColor = self.unSelectedUIColor
        self.SignInEmailSelectView.backgroundColor = self.unSelectedUIColor
        self.SignInPasswordSelectView.backgroundColor = self.unSelectedUIColor

        self.SignUpFullNameView.layer.opacity = 0.2
        self.SingUpEmailView.layer.opacity = 0.2
        self.SignUpPasswordView.layer.opacity = 0.2
        self.SignUpConfirmView.layer.opacity = 0.2
        self.SignUpCityView.layer.opacity = 0.2
        self.SignInPasswordView.layer.opacity = 0.2
        self.SignInEmailView.layer.opacity = 0.2
        
    }
    
    @IBAction func onTextFieldTouchDown(_ sender: AnyObject) {
        
        setTextFieldMask()
        
        if sender as! NSObject == self.SignUpFullName {
            self.SignUpFullNameSelectView.backgroundColor = self.selectedUIColor
            self.SignUpFullNameView.layer.opacity = 1
        }
        if sender as! NSObject == self.SignUpEmailAddress {
            self.SignUpEmailSelectView.backgroundColor = self.selectedUIColor
            self.SingUpEmailView.layer.opacity = 1
        }
        if sender as! NSObject == self.SignUpPassword {
            self.SignUpPasswordSelectView.backgroundColor = self.selectedUIColor
            self.SignUpPasswordView.layer.opacity = 1
        }
        if sender as! NSObject == self.SignUpConfirmPassword {
            self.SignUpConfirmSelectView.backgroundColor = self.selectedUIColor
            self.SignUpConfirmView.layer.opacity = 1
        }
        if sender as! NSObject == self.SignInEmailAddress {
            self.SignInEmailSelectView.backgroundColor = self.selectedUIColor
            self.SignInEmailView.layer.opacity = 1
        }
        if sender as! NSObject == self.SignInPassword {
            self.SignInPasswordSelectView.backgroundColor = self.selectedUIColor
            self.SignInPasswordView.layer.opacity = 1
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.SignUpFullName {
            self.SignUpEmailAddress.becomeFirstResponder()
            self.SignUpFullNameSelectView.backgroundColor = self.unSelectedUIColor
        }
        if textField == self.SignUpEmailAddress {
            self.SignUpPassword.becomeFirstResponder()
            self.SignUpEmailSelectView.backgroundColor = self.unSelectedUIColor
        }
        if textField == self.SignUpPassword {
            self.SignUpConfirmPassword.becomeFirstResponder()
            self.SignUpPasswordSelectView.backgroundColor = self.unSelectedUIColor
        }
        if textField == self.SignUpConfirmPassword {
            textField.resignFirstResponder()
            self.SignUpConfirmSelectView.backgroundColor = self.unSelectedUIColor
        }
        
        if textField == self.SignInEmailAddress {
            self.SignInPassword.becomeFirstResponder()
            self.SignInEmailSelectView.backgroundColor = self.unSelectedUIColor
        }
        if textField == self.SignInPassword {
            textField.resignFirstResponder()
            self.SignInPasswordSelectView.backgroundColor = self.unSelectedUIColor
            //go to login
        }
        
        return true
    }
    
    func unfocusedTextField() {
        self.SignInEmailAddress.resignFirstResponder()
        self.SignInPassword.resignFirstResponder()
        
        self.SignUpFullName.resignFirstResponder()
        self.SignUpEmailAddress.resignFirstResponder()
        self.SignUpPassword.resignFirstResponder()
        self.SignUpConfirmPassword.resignFirstResponder()
        
        self.SignUpFullNameSelectView.backgroundColor = self.unSelectedUIColor
        self.SignUpEmailSelectView.backgroundColor = self.unSelectedUIColor
        self.SignUpPasswordSelectView.backgroundColor = self.unSelectedUIColor
        self.SignUpConfirmSelectView.backgroundColor = self.unSelectedUIColor
        self.SignInEmailSelectView.backgroundColor = self.unSelectedUIColor
        self.SignInPasswordSelectView.backgroundColor = self.unSelectedUIColor
        
        self.SignUpFullNameView.layer.opacity = 1
        self.SingUpEmailView.layer.opacity = 1
        self.SignUpPasswordView.layer.opacity = 1
        self.SignUpConfirmView.layer.opacity = 1
        self.SignUpCityView.layer.opacity = 1
        self.SignInPasswordView.layer.opacity = 1
        self.SignInEmailView.layer.opacity = 1

    }
    
    func setupSelectCityDropDown() {
        selectCityDropDown.anchorView = SelectCityButton
        
        selectCityDropDown.topOffset = CGPoint(x: 0, y: SelectCityButton.bounds.height)
        selectCityDropDown.dataSource = ["City1", "City2", "City3"]
        
        selectCityDropDown.selectionAction = { [unowned self] (index, item) in
            self.SelectCityButton.setTitle(item, for: .normal)
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        
        if self.TabViewTopConstraint.constant==0 {
            if self.isSignInView == true {
                UIView.animate(withDuration: 0.1, animations: {() -> Void in
                    self.TabViewTopConstraint.constant = self.TabViewTopConstraint.constant - (keyboardSize?.height)!/4
                    self.ContainViewBottomConstraint.constant = self.ContainViewBottomConstraint.constant + (keyboardSize?.height)!/4
                })
            } else {
                UIView.animate(withDuration: 0.1, animations: {() -> Void in
                    self.TabViewTopConstraint.constant = self.TabViewTopConstraint.constant - (keyboardSize?.height)!/2
                    self.ContainViewBottomConstraint.constant = self.ContainViewBottomConstraint.constant + (keyboardSize?.height)!/2
                })
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if self.TabViewTopConstraint.constant != 0 {
            UIView.animate(withDuration: 0.1, animations: {() -> Void in
                self.TabViewTopConstraint.constant = 0
                self.ContainViewBottomConstraint.constant = 0
            })
        }
    }
}
