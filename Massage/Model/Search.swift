//
//  Search.swift
//  b2c-ios
//
//  Created by Giles Williams on 24/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import ObjectMapper

class Search: NSObject, Mappable {
  var savedAddress: SavedAddress?
  
  var location: SearchLocation?
  var serviceArea: ServiceArea?
  var city: City?
  var country: Country?
  var currency: Currency?
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    location <- map["formatted"]
    serviceArea <- map["serviceArea"]
    city <- map["city"]
    country <- map["country"]
    currency <- map["currency"]
  }
}
