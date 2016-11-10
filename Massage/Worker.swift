//
//  Worker.swift
//  b2c-ios
//
//  Created by Giles Williams on 15/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import ObjectMapper

class Worker: NSObject, Mappable {
  dynamic var id: Int = 0
  dynamic var name: String = ""
  dynamic var bio: String = ""
  dynamic var rating: Float = 5.0
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    rating <- map["rating"]
    bio <- map["bio"]
  }
}
