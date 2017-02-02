//
//  ServiceArea.swift
//  b2c-ios
//
//  Created by Giles Williams on 25/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class ServiceArea: Object, Mappable {
  dynamic var id: String = ""
  dynamic var city_id: String = ""
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    id <- (map["id"], TransformOf<String, String>(fromJSON: { $0!.trimmingCharacters(in: .whitespacesAndNewlines) }, toJSON: { $0 }))
    city_id <- map["city_id"]
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
}

