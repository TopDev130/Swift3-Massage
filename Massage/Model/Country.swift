//
//  Country.swift
//  b2c-ios
//
//  Created by Giles Williams on 12/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Country: Object, Mappable {
  dynamic var id: String = ""
  dynamic var currency_id: String = ""
  dynamic var name: String = ""
  dynamic var fallbackPhoneHuman: String = ""
  dynamic var fallbackPhoneFormatted: String = ""
  dynamic var fallbackReferralAmount: Int = 10
  dynamic var fallbackReferralKickback: Int = 10
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    currency_id <- map["currency_id"]
    name <- map["name"]
    fallbackPhoneHuman <- map["fallbackPhoneHuman"]
    fallbackPhoneFormatted <- map["fallbackPhoneFormatted"]
    fallbackReferralAmount <- map["fallbackReferralAmount"]
    fallbackReferralKickback <- map["fallbackReferralKickback"]
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
