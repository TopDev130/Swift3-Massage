//
//  AddressManager.swift
//  b2c-ios
//
//  Created by Giles Williams on 28/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import ReactiveSwift

class AddressManager {
  static let sharedInstance = AddressManager()
  let availableSavedAddresses = MutableProperty<[SavedAddress]>([])
  
  init() {
    SessionManager.sharedInstance.currentSession.producer.startWithValues { [weak self] _ in
      self?.reloadSavedAddresses()
      self?.syncSavedAddresses(completionHandler: nil)
    }
  }
  
  func saveNewAddressForSearch(search: Search, completionHandler: ((_ error: APIClient.APIError?) -> Void)?) {
    completionHandler?(nil)
  }
  
  func updatedSavedAddressForSearch(search: Search, address: SavedAddress, completionHandler: ((_ error: APIClient.APIError?) -> Void)?) {
    
  }
  
  func syncSavedAddresses(completionHandler: ((_ error: APIClient.APIError?) -> Void)?) {
    APIClient.sharedInstance.getAddresses().startWithResult { [weak self] result in
      if let addresses = result.value {
        try! RealmManager.realm().write {
          for address in addresses {
            RealmManager.realm().add(address, update: true)
          }
          
          self?.reloadSavedAddresses()
        }
        return;
      }
      
      // TODO - handle error!
    }
  }
  
  func reloadSavedAddresses() {
    if SessionManager.sharedInstance.currentSession.value != nil {
      let addressResults = RealmManager.realm().objects(SavedAddress.self)

      var addresses = [SavedAddress]()
      for address in addressResults {
        addresses.append(address)
      }

      self.availableSavedAddresses.swap(addresses)
    }
    else {
      self.availableSavedAddresses.swap([])
    }
  }
}
