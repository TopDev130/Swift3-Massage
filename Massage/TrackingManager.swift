//
//  TrackingManager.swift
//  b2c-ios
//
//  Created by Giles Williams on 13/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation
import Analytics
import AdSupport

class TrackingManager {
  static let sharedInstance = TrackingManager()
  
  private var segmentTracker: SEGAnalytics
  
  init() {
    let segmentConfig = SEGAnalyticsConfiguration(writeKey: Environment.SEGMENT_WRITE_KEY)
    segmentTracker = SEGAnalytics(configuration: segmentConfig)
    
    #if DEBUG
      print("TrackingManager#init", segmentConfig)
    #endif
    
//    SessionStore.sharedInstance.currentSession.signal.observeNext { [weak self] (currentSession) in
//      self!.identify(currentSession)
//    }
//    self.identify(SessionStore.sharedInstance.currentSession.value)
  }
  
  func udid() -> String {
    if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
      return ASIdentifierManager.shared().advertisingIdentifier?.uuidString ?? "?"
    }
    else {
      return UIDevice.current.identifierForVendor?.uuidString ?? "?"
    }
  }
  
  func setCleanedPushToken(_ pushToken: String) {
//    APIClient.sharedInstance.setCleanedPushToken(pushToken).startWithNext { _ in
//      // done
//    }
  }
  
  func trackEvent(_ event: TrackingEvent) {
    self.trackEvent(event, properties: nil)
  }
  
  func trackEvent(_ event: TrackingEvent, properties: [NSObject: AnyObject]?) {
    let eventName = event.rawValue
    #if DEBUG
      print("TrackingManager#trackEvent", eventName, properties)
    #endif
    
    segmentTracker.track(eventName, properties: properties)
  }
  
  func identify(_ session: Session?) {
    #if DEBUG
      print("TrackingManager#identify", session)
    #endif
    
    if(session != nil) {
      // has session
      if let user = session?.user {
        segmentTracker.identify(String(format: "%li", user.id))
      }
    }
    else {
      // has logged out
      segmentTracker.reset()
    }
  }
  
  func screen(_ screenName: String) {
    #if DEBUG
      print("TrackingManager#screen", screenName)
    #endif
    
    segmentTracker.screen(screenName)
  }
  
  func appDidLaunch() {
    #if DEBUG
      print("TrackingManager#appDidLaunch")
    #endif
    
  }
}
