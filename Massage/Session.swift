//
//  Session.swift
//  b2c-ios
//
//  Created by Giles Williams on 12/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Session: Object, Mappable {
  dynamic var token: String = ""
  dynamic var user: User?
  
  convenience init?(token: String) {
    self.init()
    self.token = token
  }
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    token <- map["token"]
    user <- map["user"]
  }
  
  override static func primaryKey() -> String? {
    return "token"
  }
}
