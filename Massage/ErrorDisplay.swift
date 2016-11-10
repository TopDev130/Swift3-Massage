//
//  Error.swift
//  b2c-ios
//
//  Created by Giles Williams on 27/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import UIKit

class ErrorDisplay {
  static func displayAPIError(_ error: APIClient.APIError, from: UIViewController?) {
    let alert = UIAlertController(title: error.message, message: "test", preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
      alert.dismiss(animated: true, completion: nil)
    }))
    
    alert.show(from ?? AppDelegate.topMostController(), sender: nil)
  }
}
