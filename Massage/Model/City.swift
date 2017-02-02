//
//  City.swift
//  b2c-ios
//
//  Created by Giles Williams on 12/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class City: Object, Mappable {
  dynamic var id: String = ""
  dynamic var name: String = ""
  dynamic var telephoneHuman: String = ""
  dynamic var telephoneLink: String = ""
  dynamic var timezone: String = ""
  dynamic var referralAmount: Int = 10
  dynamic var referralKickback: Int = 10
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    telephoneHuman <- map["telephoneHuman"]
    telephoneLink <- map["telephoneLink"]
    timezone <- map["timezone"]
    referralAmount <- map["referralAmount"]
    referralAmount <- map["referralAmount"]
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
