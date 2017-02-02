//
//  OneOffLocationHelper.swift
//  b2c-ios
//
//  Created by Giles Williams on 22/08/2016.
//  Copyright © 2016 Urban Massage Ltd. All rights reserved.
//

import Foundation
import CoreLocation

typealias OneOffLocationHelperCallback = ((_ location: CLLocation?) -> Void)

private let ONE_OFF_LOCATION_CACHE_THRESHOLD_SECONDS: Double = 20

class OneOffLocationHelper: NSObject, CLLocationManagerDelegate {
  let locationManager = CLLocationManager()
  let callback: OneOffLocationHelperCallback
  var hasCalledBack = false
  
  static var cachedLastLocation: CLLocation?
  
  fileprivate static var retainQueue: [OneOffLocationHelper] = []
  
  init(timeoutSeconds: Int, _ cb: @escaping OneOffLocationHelperCallback) {
    self.callback = cb
    
    super.init()
    
    if let lastLocation = OneOffLocationHelper.cachedLastLocation {
      if abs(lastLocation.timestamp.timeIntervalSinceNow) < ONE_OFF_LOCATION_CACHE_THRESHOLD_SECONDS {
        // last location was fetched within threshold, use that
        DispatchQueue.main.async(execute: {
          cb(lastLocation)
        })
        return
      }
    }
    
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    self.locationManager.startUpdatingLocation()
    
    OneOffLocationHelper.retainQueue.append(self)
    
    delay(timeoutSeconds) { [weak self] _ in
      self?.runCallbackWithLocation(nil)
    }
  }
  
  static func isAuthorized() -> Bool {
    return CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways
  }
  
  func runCallbackWithLocation(_ location: CLLocation?) {
    if (self.hasCalledBack == true) {
      return
    }
    
    self.hasCalledBack = true
    
    self.locationManager.delegate = nil
    self.locationManager.stopUpdatingLocation()
    
    DispatchQueue.main.async(execute: {
      self.callback(location)
      
      self.dispose()
    })
  }
  
  fileprivate func dispose() {
    if let itemInQueue = OneOffLocationHelper.retainQueue.index(of: self) {
      OneOffLocationHelper.retainQueue.remove(at: itemInQueue)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    self.runCallbackWithLocation(nil)
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    self.runCallbackWithLocation(locations.last ?? nil)
  }
}
