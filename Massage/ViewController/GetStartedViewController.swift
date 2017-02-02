//
//  GetStartedViewController.swift
//  Massage
//
//  Created by Panda2 on 11/9/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

class GetStartedViewController: UIViewController {
    
    @IBOutlet weak var AndRelaxLabel: UILabel!
    @IBOutlet weak var AndRelaxDescriptionLabel: UILabel!
    @IBOutlet weak var GetStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AndRelaxLabel.text = "RelaxLabel".localized()
        AndRelaxDescriptionLabel.text = "GetStartedDescription".localized()
        GetStartedButton.setTitle("GetStartedButton".localized(), for: .normal)
    }
    
}
