//
//  Loader.swift
//  b2c-ios
//
//  Created by Giles Williams on 27/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import UIKit
import KVNProgress

struct Loader {
  static func success() {
    KVNProgress.showSuccess()
  }
  static func showSuccessWithCompletion(completion: KVNCompletionBlock!) {
    KVNProgress.showSuccess(completion: completion)
  }
  static func show() {
    KVNProgress.show()
  }
  static func hide() {
    KVNProgress.dismiss()
  }
}
