//
//  TutorialStartViewController.swift
//  Massage
//
//  Created by Panda2 on 11/9/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

class TutorialStartViewController: UIViewController {
    
    @IBOutlet weak var EnterAddressLabel: UILabel!
    @IBOutlet weak var TellUsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EnterAddressLabel.text = "EnterYourAddress".localized()
        TellUsLabel.text = "EnterYourAddressDescription".localized()
    }
}
