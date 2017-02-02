//
//  User.swift
//  b2c-ios
//
//  Created by Giles Williams on 12/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class User: Object, Mappable {
  dynamic var id = 0
  dynamic var name = ""
  dynamic var email = ""
  dynamic var telephone = ""
  dynamic var referralCode = ""
  
  dynamic var homeCity: City?
  dynamic var homeCountry: Country?
  dynamic var referralCurrency: Currency?
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    email <- map["email"]
    telephone <- map["telephone"]
    referralCode <- map["referalCode"]
    homeCity <- map["homeCity"]
    homeCountry <- map["homeCountry"]
    referralCurrency <- map["referalCurrency"]
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
