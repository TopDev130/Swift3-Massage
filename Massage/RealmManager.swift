//
//  RealmManager.swift
//  b2c-ios
//
//  Created by Giles Williams on 12/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation

import RealmSwift

class RealmManager {
  static let sharedInstance = RealmManager()
  private var _realm: Realm
  
  init() {
    var config = Realm.Configuration()
    config.deleteRealmIfMigrationNeeded = true
    
    _realm = try! Realm(configuration: config)
  }
  
  func clearEntireDatabase() {
    self._realm.beginWrite()
    self._realm.deleteAll()
    try! self._realm.commitWrite()
  }
  
  static func realm() -> Realm {
    return RealmManager.sharedInstance._realm
  }
}
