//
//  LocationTypeaheadResult.swift
//  b2c-ios
//
//  Created by Giles Williams on 25/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import ObjectMapper

class LocationTypeaheadResult: NSObject, Mappable {
  /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
  public required init?(map: Map) {
    
  }
  
  dynamic var resultSource: String = ""
  dynamic var result_id: String = ""
  dynamic var descriptionStr: String = ""
  
  func mapping(map: Map) {
    resultSource <- map["resultSource"]
    result_id <- map["result_id"]
    descriptionStr <- map["description"]
  }
  
  func typeaheadResultTexts() -> (top: String, bottom: String) {
    let addressParts = self.descriptionStr.components(separatedBy: ", ")
    
    var moveToBottom = false
    var topParts = [String]()
    var bottomParts = [String]()
    
    for var part in addressParts {
      if(moveToBottom) {
        bottomParts.append(part)
      }
      else {
        topParts.append(part)
        
        if(part.characters.count > 4) {
          moveToBottom = true
        }
      }
    }
    
    return (
      top: topParts.joined(separator: ", "),
      bottom: bottomParts.joined(separator: ", ")
    )
  }
  
}
