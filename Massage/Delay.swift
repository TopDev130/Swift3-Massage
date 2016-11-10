//
//  Delay.swift
//  b2c-ios
//
//  Created by Giles Williams on 11/09/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation

func delay(_ seconds: Int, _ cb: @escaping (() -> Void)) {
  let time = Int64(seconds) * Int64(NSEC_PER_SEC)
  let delayTime = DispatchTime.now() + Double(time) / Double(NSEC_PER_SEC)
  DispatchQueue.main.asyncAfter(deadline: delayTime) { _ in
    cb()
  }
}
