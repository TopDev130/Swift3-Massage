//
//  URLNavigator.swift
//  b2c-ios
//
//  Created by Giles Williams on 12/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import URLNavigator

struct URLNavigator {
  
  static func viewController(forPath path: String) -> UIViewController? {
    return Navigator.viewController(for: URLNavigator.addScheme(path))
  }
  
  static func openPath(_ path: String) {
    let url = URLNavigator.addScheme(path)
    Navigator.open(url)
  }
  
  static func pushPath(_ path: String) {
    let url = URLNavigator.addScheme(path)
    Navigator.push(url, from: nil, animated: false)
  }
  
  static func presentPath(_ path: String) {
    URLNavigator.presentPath(path, animated: false, from: nil)
  }
  
  static func presentPath(_ path: String, animated: Bool) {
    URLNavigator.presentPath(path, animated: animated, from: nil)
  }
  
  static func presentPath(_ path: String, animated: Bool, from: UINavigationController?) {
    if let vc = self.viewController(forPath: path) {
      let nc = UINavigationController(rootViewController: vc)
      nc.isNavigationBarHidden = true
      
      Navigator.present(nc, wrap: false, from: from, animated: animated, completion: nil)
    }
  }
  
  static func addScheme(_ path: String) -> String {
    return String(format: "%@:/%@", Environment.URL_SCHEME, path)
  }
  
  static func initialize() {
//    Navigator.map(self.addScheme("/"), BookViewController.self)
//    Navigator.map(self.addScheme("/login"), LoginViewController.self)
//    Navigator.map(self.addScheme("/address"), AddressPickerViewController.self)
//    Navigator.map(self.addScheme("/address/<string:id>"), AddressPickerViewController.self)
//    Navigator.map(self.addScheme("/workers/search"), WorkersSearchViewController.self)
//    Navigator.map(self.addScheme("/workers/<int:id>"), BookWorkerViewController.self)
  }
  
}
