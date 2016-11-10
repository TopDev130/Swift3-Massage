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
import FacebookCore
import FacebookLogin
import Localize_Swift

class AuthViewController: UIViewController, UITextFieldDelegate {
    
    var isSignInView = false
    var isFacebookConnect = false
    var keyboardMoveHeight = 0
    
    var selectedCity: String = ""
    var selectedCityID: String = ""
    
    let selectCityDropDown = DropDown()
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var facebookButton: UIButton!
    
    @IBOutlet weak var ORLabel: UILabel!
    
    @IBOutlet weak var SupportButton: UIButton!
    @IBOutlet weak var TermsButton: UIButton!
    @IBOutlet weak var PrivacyButton: UIButton!
    
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
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var TabViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var ContainViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButton.setTitle("CreateAccountTab".localized(), for: .normal)
        loginButton.setTitle("LoginTab".localized(), for: .normal)
        SignUpButtonView.setTitle("signupButton".localized(), for: .normal)
        facebookButton.setTitle("facebookLoginButton".localized(), for: .normal)
        ORLabel.text = "OR".localized()
        SelectCityButton.setTitle("SelectYourCity".localized(), for: .normal)
        SupportButton.setTitle("SupportButton".localized(), for: .normal)
        TermsButton.setTitle("TermsButton".localized(), for: .normal)
        PrivacyButton.setTitle("PrivacyButton".localized(), for: .normal)
        forgotPasswordButton.setTitle("forgotPasswordButton".localized(), for: .normal)
        
        self.SignInTabClickedView.isHidden = true
        self.SignInInputView.isHidden = true
        
        //sign up input view attributes definition
        self.SignUpInputView.layer.borderWidth = 1
        self.SignUpInputView.layer.borderColor = Color.canvasBG.cgColor
        self.SignUpFullName.attributedPlaceholder = NSAttributedString(string: "EnterFullName".localized(), attributes: [NSForegroundColorAttributeName: Color.primary])
        self.SignUpEmailAddress.attributedPlaceholder = NSAttributedString(string: "EnterEmail".localized(), attributes: [NSForegroundColorAttributeName: Color.primary])
        self.SignUpPassword.attributedPlaceholder = NSAttributedString(string: "CreatePassword".localized(), attributes: [NSForegroundColorAttributeName: Color.primary])
        self.SignUpConfirmPassword.attributedPlaceholder = NSAttributedString(string: "ConfirmPassword".localized(), attributes: [NSForegroundColorAttributeName: Color.primary])
        
        self.SignInInputView.layer.cornerRadius = 7
        self.SignInInputView.layer.borderWidth = 1
        self.SignInInputView.layer.borderColor = Color.canvasBG.cgColor
        self.SignInEmailAddress.attributedPlaceholder = NSAttributedString(string: "EmailAddress".localized(), attributes: [NSForegroundColorAttributeName: Color.primary])
        self.SignInPassword.attributedPlaceholder = NSAttributedString(string: "Password".localized(), attributes: [NSForegroundColorAttributeName: Color.primary])
        
//        setupSelectCityDropDown()
        
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
        self.SignUpButtonView.setTitle("signupButton".localized(), for: UIControlState.normal)
        unfocusedTextField()
    }
    
    @IBAction func onSignInTabClicked(_ sender: AnyObject) {
        self.SignInTabClickedView.isHidden = false
        self.SignUpTabClickedView.isHidden = true
        self.SignInInputView.isHidden = false
        self.SignUpInputView.isHidden = true
        self.isSignInView = true
        self.SignUpButtonView.setTitle("signinButton".localized(), for: UIControlState.normal)
        unfocusedTextField()
    }
    
    @IBAction func onSelectCityButtonClicked(_ sender: AnyObject) {
        unfocusedTextField()
        self.isFacebookConnect = false
        selectCityActionSheet()
    }
    
    @IBAction func onFacebookButtonClicked(_ sender: AnyObject) {
        self.isFacebookConnect = true
        selectCityActionSheet()
    }
    
    func facebookLogin() {
        
        let loginManager = LoginManager()

        loginManager.logIn([.publicProfile], viewController: self, completion: { LoginResult in
            switch LoginResult {
            case .failed(let error):
                print("facebook login falied", error)
            case .cancelled:
                print("user facebook login cancelled")
            case .success(grantedPermissions: _, declinedPermissions: _, token: let accessToken):
                    print("Login in success!")
                    Loader.show()
                    SessionManager.sharedInstance.attemptFacebookLogin(fbToken: accessToken.authenticationToken, city_id: self.selectedCityID).startWithResult { (result) in
                        print("facebook login:=>", result)
                        Loader.hide()
                    }
            }
        })
    }
    
    func selectCityActionSheet() {
        let cityActionSheet = UIAlertController(title: nil, message: "selectCityActionsheetTitle".localized(), preferredStyle: .alert)
        
        for item in CitiesManager.sharedInstance.currentCities.value {
            let action = UIAlertAction(title: item.name, style: .default, handler: {action -> Void in
                self.selectedCity = item.name
                self.selectedCityID = item.id
                self.SelectCityButton.setTitle(item.name.localized(), for: .normal)
                if self.isFacebookConnect {
                    self.facebookLogin()
                }
            })
            cityActionSheet.addAction(action)
        }
        
        if self.isFacebookConnect {
            let CancelAction = UIAlertAction(title: "Cancel".localized(), style: .default, handler: { action -> Void in
            })
            cityActionSheet.addAction(CancelAction)
        }
        
        cityActionSheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: UInt(0))
        cityActionSheet.popoverPresentationController?.sourceView = self.view

        let rect = CGRect(x: self.view.bounds.size.width/8, y: self.view.bounds.size.height/5, width: self.view.bounds.size.width*0.75, height: self.view.bounds.size.height * 0.6)
        cityActionSheet.popoverPresentationController?.sourceRect = rect
        
        self.present(cityActionSheet, animated: true, completion: nil)
    }
    
    func setTextFieldMask() {
        self.SignUpFullNameSelectView.backgroundColor = Color.canvasBG
        self.SignUpEmailSelectView.backgroundColor = Color.canvasBG
        self.SignUpPasswordSelectView.backgroundColor = Color.canvasBG
        self.SignUpConfirmSelectView.backgroundColor = Color.canvasBG
        self.SignInEmailSelectView.backgroundColor = Color.canvasBG
        self.SignInPasswordSelectView.backgroundColor = Color.canvasBG

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
            self.SignUpFullNameSelectView.backgroundColor = Color.cta
            self.SignUpFullNameView.layer.opacity = 1
        }
        if sender as! NSObject == self.SignUpEmailAddress {
            self.SignUpEmailSelectView.backgroundColor = Color.cta
            self.SingUpEmailView.layer.opacity = 1
        }
        if sender as! NSObject == self.SignUpPassword {
            self.SignUpPasswordSelectView.backgroundColor = Color.cta
            self.SignUpPasswordView.layer.opacity = 1
        }
        if sender as! NSObject == self.SignUpConfirmPassword {
            self.SignUpConfirmSelectView.backgroundColor = Color.cta
            self.SignUpConfirmView.layer.opacity = 1
        }
        if sender as! NSObject == self.SignInEmailAddress {
            self.SignInEmailSelectView.backgroundColor = Color.cta
            self.SignInEmailView.layer.opacity = 1
        }
        if sender as! NSObject == self.SignInPassword {
            self.SignInPasswordSelectView.backgroundColor = Color.cta
            self.SignInPasswordView.layer.opacity = 1
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        setTextFieldMask()
        
        if textField == self.SignUpFullName {
            self.SignUpEmailAddress.becomeFirstResponder()
            self.SignUpFullNameSelectView.backgroundColor = Color.canvasBG
            self.SignUpEmailSelectView.backgroundColor = Color.cta
            self.SingUpEmailView.layer.opacity = 1
        }
        if textField == self.SignUpEmailAddress {
            self.SignUpPassword.becomeFirstResponder()
            self.SignUpEmailSelectView.backgroundColor = Color.canvasBG
            self.SignUpPasswordSelectView.backgroundColor = Color.cta
            self.SignUpPasswordView.layer.opacity = 1
        }
        if textField == self.SignUpPassword {
            self.SignUpConfirmPassword.becomeFirstResponder()
            self.SignUpPasswordSelectView.backgroundColor = Color.canvasBG
            self.SignUpConfirmSelectView.backgroundColor = Color.cta
            self.SignUpConfirmView.layer.opacity = 1
        }
        if textField == self.SignUpConfirmPassword {
            textField.resignFirstResponder()
            self.SignUpConfirmSelectView.backgroundColor = Color.canvasBG
            unfocusedTextField()
        }
        
        if textField == self.SignInEmailAddress {
            self.SignInPassword.becomeFirstResponder()
            self.SignInEmailSelectView.backgroundColor = Color.canvasBG
            self.SignInPasswordSelectView.backgroundColor = Color.cta
            self.SignInPasswordView.layer.opacity = 1
        }
        if textField == self.SignInPassword {
            textField.resignFirstResponder()
            self.SignInPasswordSelectView.backgroundColor = Color.canvasBG
            //go to login
            unfocusedTextField()
            onLoginFunction()
        }
        
        return true
    }
    
    func isValidEmail(emailStr: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    func isValidPassword(passwordStr: String) -> Bool {
        
        if passwordStr.characters.count < 5 {
            return false
        }
        return true
    }
    
    func isEmptyString(testStr: String) -> Bool {
        if testStr.characters.count == 0 {
            return true
        }
        return false
    }
    
    func isMatchingPassword(passwordStr: String, confirmPasswordStr: String) -> Bool {
        return (passwordStr == confirmPasswordStr)
    }
    
    func onLoginFunction() {
        
        if !isValidEmail(emailStr: SignInEmailAddress.text!) {
            
            AlertDisplay.showAlert(title: "emailInputErrorTitle", message: "emailAddressInvalidMessage", cancellButtonTitle: "OK".localized(), onViewController: self, completion: nil)
            return
            
        } else if !isValidPassword(passwordStr: SignInPassword.text!) {

            AlertDisplay.showAlert(title: "passwordInputErrorTitle", message: "passwordInputErrorMessage", cancellButtonTitle: "OK".localized(), onViewController: self, completion: nil)
            return
            
        } else {
            Loader.show()
            SessionManager.sharedInstance.attemptLogin(emailAddress: SignInEmailAddress.text!, password: SignInPassword.text!).startWithResult { (result) in
                print("login:=>", result)
                Loader.hide()
            }
        }
    }
    
    func onSignUpButton() {
        
        if isEmptyString(testStr: SignUpFullName.text!) {
            
            AlertDisplay.showAlert(title: "fullNameInputErrorTitle", message: "fullNameInputErrorMessage", cancellButtonTitle: "OK".localized(), onViewController: self, completion: nil)
            return
            
        } else if !isValidEmail(emailStr: SignUpEmailAddress.text!) {
            
            AlertDisplay.showAlert(title: "emailInputErrorTitle", message: "emailAddressInvalidMessage", cancellButtonTitle: "OK".localized(), onViewController: self, completion: nil)
            return
            
        } else if !isValidPassword(passwordStr: SignUpPassword.text!) {
            
            AlertDisplay.showAlert(title: "passwordInputErrorTitle", message: "passwordInputErrorMessage", cancellButtonTitle: "OK".localized(), onViewController: self, completion: nil)
            return
            
        } else if !isMatchingPassword(passwordStr: SignUpPassword.text!, confirmPasswordStr: SignUpConfirmPassword.text!) {

            AlertDisplay.showAlert(title: "passwordInputErrorTitle", message: "passwordInputNotMatchingMessage", cancellButtonTitle: "OK".localized(), onViewController: self, completion: nil)
            return

        } else {
            Loader.show()
            SessionManager.sharedInstance.attemptSignup(emailAddress: SignUpEmailAddress.text!, password: SignUpPassword.text!, fullName: SignUpFullName.text!, city_id: self.selectedCityID).startWithResult { (result) in
                print("sign up:=>",result)
                Loader.hide()
            }
        }
    }
    
    @IBAction func onSignButtonClicked(_ sender: AnyObject) {
        
        unfocusedTextField()
        
        if self.isSignInView == true {
            onLoginFunction()
        } else {
            onSignUpButton()
        }
    }
    
    func unfocusedTextField() {
        self.SignInEmailAddress.resignFirstResponder()
        self.SignInPassword.resignFirstResponder()
        
        self.SignUpFullName.resignFirstResponder()
        self.SignUpEmailAddress.resignFirstResponder()
        self.SignUpPassword.resignFirstResponder()
        self.SignUpConfirmPassword.resignFirstResponder()
        
        self.SignUpFullNameSelectView.backgroundColor = Color.canvasBG
        self.SignUpEmailSelectView.backgroundColor = Color.canvasBG
        self.SignUpPasswordSelectView.backgroundColor = Color.canvasBG
        self.SignUpConfirmSelectView.backgroundColor = Color.canvasBG
        self.SignInEmailSelectView.backgroundColor = Color.canvasBG
        self.SignInPasswordSelectView.backgroundColor = Color.canvasBG
        
        self.SignUpFullNameView.layer.opacity = 1
        self.SingUpEmailView.layer.opacity = 1
        self.SignUpPasswordView.layer.opacity = 1
        self.SignUpConfirmView.layer.opacity = 1
        self.SignUpCityView.layer.opacity = 1
        self.SignInPasswordView.layer.opacity = 1
        self.SignInEmailView.layer.opacity = 1

    }
    
//    func setupSelectCityDropDown() {
//        selectCityDropDown.anchorView = SelectCityButton
//        
//        selectCityDropDown.topOffset = CGPoint(x: 0, y: SelectCityButton.bounds.height)
//        selectCityDropDown.dataSource = ["City1", "City2", "City3"]
//        
//        selectCityDropDown.selectionAction = { [unowned self] (index, item) in
//            self.SelectCityButton.setTitle(item, for: .normal)
//        }
//    }
    
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
