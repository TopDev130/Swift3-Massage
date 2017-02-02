//
//  SavedAddress.swift
//  b2c-ios
//
//  Created by Giles Williams on 12/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class SavedAddress: Object, Mappable {
  dynamic var id: String = ""
  dynamic var user_id: Int = 0
  dynamic var type: String = ""
  dynamic var address1: String = ""
  dynamic var address2: String = ""
  dynamic var city: String = ""
  dynamic var postcode: String = ""
  dynamic var lat: Float = 0
  dynamic var lng: Float = 0
  dynamic var lastKnownServiceArea_id: String = ""
  dynamic var lastKnownCity_id: String = ""
  dynamic var lastKnownCountry_id: String = ""
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    id <- map["_id"]
    user_id <- map["_id"]
    type <- map["type"]
    address1 <- map["address1"]
    address2 <- map["address2"]
    city <- map["city"]
    postcode <- map["postcode"]
    lat <- map["lat"]
    lng <- map["lng"]
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  func singleLineDescriptor() -> String {
    var addressParts = [String]()
    if self.address1 != "" {
      addressParts.append(self.address1)
    }
    if self.address2 != "" {
      addressParts.append(self.address2)
    }
    if self.postcode != "" && addressParts.count < 2 {
      addressParts.append(self.postcode)
    }
    
    return (addressParts as NSArray).componentsJoined(by: ", ")
  }
}
