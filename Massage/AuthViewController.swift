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
    let selectCityDropDown = DropDown()
    
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
        
        SignUpEmailAddress.UITextFieldDelegate = self
        SignUpFullName.UITextFieldDelegate = self
        SignUpConfirmPassword.UITextFieldDelegate = self
        SignUpPassword.UITextFieldDelegate = self
        
        SignInEmailAddress.UITextFieldDelegate = self
        SignInPassword.UITextFieldDelegate = self
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
        self.SignUpButtonView.titleLabel?.text = "SIGN UP"
    }
    
    @IBAction func onSignInTabClicked(_ sender: AnyObject) {
        self.SignInTabClickedView.isHidden = false
        self.SignUpTabClickedView.isHidden = true
        self.SignInInputView.isHidden = false
        self.SignUpInputView.isHidden = true
        self.isSignInView = true
        self.SignUpButtonView.titleLabel?.text = "SIGN IN"
    }
    
    @IBAction func onSelectCityButtonClicked(_ sender: AnyObject) {
        selectCityDropDown.show()
    }
    
    
    
    func setupSelectCityDropDown() {
        selectCityDropDown.anchorView = SelectCityButton
        
        selectCityDropDown.topOffset = CGPoint(x: 0, y: SelectCityButton.bounds.height)
        selectCityDropDown.dataSource = ["City1", "City2", "City3"]
        
        selectCityDropDown.selectionAction = { [unowned self] (index, item) in
            self.SelectCityButton.setTitle(item, for: .normal)
        }
    }
}
