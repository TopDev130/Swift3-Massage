//
//  AddressViewController.swift
//  Massage
//
//  Created by Panda2 on 11/5/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import UIKit

class AddressViewController: UIViewController {
    
    @IBOutlet weak var AddressInputView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.AddressInputView.layer.cornerRadius = 20
        self.AddressInputView.layer.borderColor = UIColor(red: 231/255.0, green: 233/255.0, blue: 238/255.0, alpha: 1.0).cgColor
        self.AddressInputView.layer.borderWidth = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
