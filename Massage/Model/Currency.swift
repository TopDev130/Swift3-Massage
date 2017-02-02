//
//  Currency.swift
//  b2c-ios
//
//  Created by Giles Williams on 12/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Currency: Object, Mappable {
  dynamic var id: String = ""
  dynamic var name: String = ""
  dynamic var textSymbol: String = ""
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    textSymbol <- map["textSymbol"]
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
