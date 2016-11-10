//
//  SearchLocation.swift
//  b2c-ios
//
//  Created by Giles Williams on 25/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchLocation: NSObject, Mappable {
  /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
  public required init?(map: Map) {
    
  }

  dynamic var address1: String = ""
  dynamic var address2: String = ""
  dynamic var city: String = ""
  dynamic var postcode: String = ""
  
  dynamic var lat: Float = 0
  dynamic var lng: Float = 0
  
  func mapping(map: Map) {
    address1 <- map["address1"]
    address2 <- map["address2"]
    city <- map["city"]
    postcode <- map["postcode"]
    
    lat <- map["lat"]
    lng <- map["lng"]
  }
  
  func typeaheadTitle() -> String {
    var addressParts = [String]()
    if self.address1 != "" {
      addressParts.append(self.address1)
    }
    if self.address2 != "" {
      addressParts.append(self.address2)
    }
    if self.city != "" {
      addressParts.append(self.city)
    }
    if self.postcode != "" {
      addressParts.append(self.postcode)
    }
    
    return (addressParts as NSArray).componentsJoined(by: ", ")
  }
}
