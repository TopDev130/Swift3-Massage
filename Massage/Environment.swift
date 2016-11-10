//
//  Environment.swift
//  b2c-ios
//
//  Created by Giles Williams on 12/10/2016.
//  Copyright © 2016 Urban Massage. All rights reserved.
//

import Foundation

struct Environment {
#if STAGING
  static let PAYMENT_URL_SCHEME = "com.urbanmassage.Massage-STG.payments"
  static let URL_SCHEME = "massage-stg"
  static let SEGMENT_WRITE_KEY = "yWt0CAF4sylOfgBCVdtLJvOr6OH78VAL"
  static let GOOGLE_MAPS_KEY = "AIzaSyB8xBbZYVZm3KIjEu0_aIv9TjX1idVSKl0"
  static let ITUNES_APP_ID = ""
  static let FACEBOOK_APP_ID = "426395184166832"
  static let SUPPORT_KIT_KEY = "b9r0hb67agol6evjqb1pirasg"
  static let WEBSITE_BASE_URL = "http://staging.urbanmassage.com"
  static let ENV_NAME = "staging"
  static let GOSQUARED_SITE_TOKEN = "GSN-485822-Y"
  
  static let API_BASE_URL = "http://api.staging.urbanmassage.com"
  static let API_APPLICATION_IDENTIFIER = "sl4ylsyg4lsyl8s4gyls"
  #else
  static let PAYMENT_URL_SCHEME = "com.urbanmassage.Massage.payments"
  static let URL_SCHEME = "massage"
  static let SEGMENT_WRITE_KEY = "W9sLZvsB0HqDiH4EJA0j0pVjqA6A9vXV"
  static let GOOGLE_MAPS_KEY = "AIzaSyBi03s7m1o0qZIIKRUw6mnhb02QDERr3iQ"
  static let ITUNES_APP_ID = "917672501"
  static let FACEBOOK_APP_ID = "426391724167178"
  static let SUPPORT_KIT_KEY = "dmb1a62jn1iqqpf6bcvpfhisc"
  static let WEBSITE_BASE_URL = "https://www.urbanmassage.com"
  static let ENV_NAME = "production"
  static let GOSQUARED_SITE_TOKEN = "GSN-762892-Q"
  
  static let API_BASE_URL = "https://api.urbanmassage.com"
  static let API_APPLICATION_IDENTIFIER = "hs4lghs4l8ghl8s4gg7"
#endif
}
