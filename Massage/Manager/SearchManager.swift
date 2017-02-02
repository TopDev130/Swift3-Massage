//
//  SearchManager.swift
//  b2c-ios
//
//  Created by Giles Williams on 27/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import ReactiveSwift

class SearchManager {
  static let sharedInstance = SearchManager()
  
  var currentSearch = MutableProperty<Search?>(nil)
  
  func loadSavedAddress(address: SavedAddress, completionHandler: @escaping (_ error: APIClient.APIError?) -> Void) {
    APIClient.sharedInstance.validateLocationSearch(resultSource: "latlng", result_id: String(format: "%f,%f", address.lat, address.lng)).startWithResult { result in
      if let search = result.value {
        search.savedAddress = address
        search.location?.address1 = address.address1
        search.location?.address2 = address.address2
        search.location?.city = address.city
        search.location?.postcode = address.postcode
        
        SearchManager.sharedInstance.currentSearch.swap(search)
        completionHandler(nil)
      }
      else if let error = result.error {
        completionHandler(error)
      }
      else {
        completionHandler(nil)
      }
    }
  }
}
