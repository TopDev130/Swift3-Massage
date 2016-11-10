//
//  Speciality.swift
//  b2c-ios
//
//  Created by Giles Williams on 15/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import Alamofire

class Speciality: Object, Mappable {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var longName: String = ""
    dynamic var descriptionStr: String = ""
    dynamic var descriptionShort: String = ""
    dynamic var tagLine: String = ""
    dynamic var imgURL: String = ""
    dynamic var imgData: Data? = nil
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    longName <- map["longName"]
    descriptionStr <- map["description"]
    descriptionShort <- map["descriptionShort"]
    tagLine <- map["tagLine"]
    imgURL <- map["imgURL"]
    let imageURL: NSURL = NSURL(string: imgURL)!
    imgData = try! Data(contentsOf: imageURL as URL)

  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
