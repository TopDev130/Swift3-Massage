//
//  AlertDisplay.swift
//  Massage
//
//  Created by Panda2 on 11/7/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

class AlertDisplay {
    
    class func showAlert(title:String?, message:String?, cancellButtonTitle:String, onViewController:UIViewController, completion:(()->())?) {
        let alertController = UIAlertController(title: title?.localized(), message: message?.localized(), preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancellButtonTitle.localized(), style: .cancel) { (action) in
            completion?()
        }
        alertController.addAction(cancelAction)
        
        onViewController.present(alertController, animated: true, completion: nil)
    }
}
