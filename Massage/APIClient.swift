//
//  APIClient.swift
//  Massage
//
//  Created by Panda2 on 11/6/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire
import SwiftyJSON
import ObjectMapper

class APIClient {
    static let sharedInstance = APIClient()
    
    init() {
        
    }
    
    // email / password login
    func login(emailAddress: String, password: String) -> SignalProducer<Session, APIClient.APIError> {
        let requestBody = [
            "email": emailAddress,
            "password": password,
            ];
        
        return self.requestWithAPIPath("/auth/login", method: .post, requestBody: requestBody).map({ (response) -> Session in
            let session = Mapper<Session>().map(JSONObject: response?.object)
            return session!
        })
    }
    
    
    func login(withFacebookToken: String, city_id: String) -> SignalProducer<Session, APIClient.APIError> {
        let requestBody = [
            "adapter": "facebook",
            "type": "customer",
            "secure": [
                "token": withFacebookToken,
            ],
            "profile": [
                "homeCity_id": city_id,
            ],
            ] as [String : Any];
        
        return self.requestWithAPIPath("/auth/oauth", method: .post, requestBody: requestBody).map({ (response) -> Session in
            let session = Mapper<Session>().map(JSONObject: response?.object)
            return session!
        })
    }
    
    func signup(withEmail: String, password: String, name: String, city_id: String) -> SignalProducer<Session, APIClient.APIError> {
        let requestBody = [
            "email": withEmail,
            "password": password,
            "name": name,
            "homeCity_id": city_id,
            "type": "customer",
        ] as [String : Any];
        
        return self.requestWithAPIPath("/user", method: .post, requestBody: requestBody).map({ (response) -> Session in
            let session = Mapper<Session>().map(JSONObject: response?.object)
            return session!
        })
    }
    
    func requestPasswordReset(emailAddress: String) -> SignalProducer<Void, APIClient.APIError> {
        let requestBody = [
            "email": emailAddress,
            ];
        
        return self.requestWithAPIPath("/auth/resetPassword", method: .post, requestBody: requestBody).map({ (response) -> Void in
            return
        })
    }
    
    
    func locationTypeaheadSearch(term: String) -> SignalProducer<[LocationTypeaheadResult], APIClient.APIError> {
        let urlStr = String(format: "/search/location/typeahead?term=%@", term.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!)
        return self.requestWithAPIPath(urlStr, method: .get, requestBody: nil).map({ (response) -> [LocationTypeaheadResult] in
            let results = response!["results"].arrayValue
            return results.map { item -> LocationTypeaheadResult in
                let result = Mapper<LocationTypeaheadResult>().map(JSONObject: item.object)!
                return result
            }
        })
    }
    
    
    func validateLocationSearch(resultSource: String, result_id: String) -> SignalProducer<Search, APIClient.APIError> {
        let urlStr = String(format: "/search/location/validate?resultSource=%@&result_id=%@", resultSource, result_id)
        return self.requestWithAPIPath(urlStr, method: .get, requestBody: nil).map({ (response) -> Search in
            let search = Mapper<Search>().map(JSONObject: response?.object)
            return search!
        })
    }
    
    
    func getSpecialities(forServiceArea: ServiceArea?) -> SignalProducer<[Speciality], APIClient.APIError> {
        var urlStr = "/specialities"
        if let serviceArea = forServiceArea {
            urlStr = String(format: "/specialities?serviceArea=%@", serviceArea.id)
        }
        
        return self.requestWithAPIPath(urlStr, method: .get, requestBody: nil).map({ (response) -> [Speciality] in
            let results = response!["specialities"].arrayValue
            return results.map { item -> Speciality in
                let result = Mapper<Speciality>().map(JSONObject: item.object)!
                return result
            }
        })
    }
    
    
    func getWorkers(limit: Int) -> SignalProducer<[Worker], APIClient.APIError> {
        let urlStr = String(format: "/workers?limit=%li", limit)
        
        return self.requestWithAPIPath(urlStr, method: .get, requestBody: nil).map({ (response) -> [Worker] in
            let results = response!["workers"].arrayValue
            return results.map { item -> Worker in
                let result = Mapper<Worker>().map(JSONObject: item.object)!
                return result
            }
        })
    }
    
    
    func getCities() -> SignalProducer<[City], APIClient.APIError> {
        let urlStr = "/cities?visible=1"
        
        return self.requestWithAPIPath(urlStr, method: .get, requestBody: nil).map({ (response) -> [City] in
            let results = response!["cities"].arrayValue
            return results.map { item -> City in
                let result = Mapper<City>().map(JSONObject: item.object)!
                return result
            }
        })
    }
    
    
    func getAddresses() -> SignalProducer<[SavedAddress], APIClient.APIError> {
        return self.requestWithAPIPath("/me/addresses", method: .get, requestBody: nil).map({ (response) -> [SavedAddress] in
            let results = response!["addresses"].arrayValue
            return results.map { item -> SavedAddress in
                let result = Mapper<SavedAddress>().map(JSONObject: item.object)!
                return result
            }
        })
    }
    
    
    func createAddress(address: SavedAddress) -> SignalProducer<SavedAddress, APIClient.APIError> {
        var addressObj = address.toJSON()
        addressObj.removeValue(forKey: "_id")
        
        return self.requestWithAPIPath("/me/addresses", method: .post, requestBody: ["address": addressObj]).map({ (response) -> SavedAddress in
            let address = Mapper<SavedAddress>().map(JSONObject: response?["address"].object)
            return address!
        })
    }
    
    
    func updateAddress(address: SavedAddress) -> SignalProducer<SavedAddress, APIClient.APIError> {
        let urlStr = String(format: "/me/addresses/%@", address.id)
        return self.requestWithAPIPath(urlStr, method: .put, requestBody: ["address": address.toJSON()]).map({ (response) -> SavedAddress in
            let address = Mapper<SavedAddress>().map(JSONObject: response?["address"].object)
            return address!
        })
    }
    
    
    //
    //  // facebook login
    //  func login(facebookLoginToken: String) -> SignalProducer<Session, APIClient.APIError> {
    //    let requestBody = [
    //      "facebookToken": facebookLoginToken
    //    ];
    //
    //    return self.requestWithAPIPath("/activate", method: .POST, requestBody: requestBody).map({ (response) -> Session in
    //      let session = Mapper<Session>().map(response.rawValue)
    //      return session!
    //    })
    //  }
    //
    //  // enrollment code login
    //  func loginViaEnrollmentCode(enrollmentCode: String) -> SignalProducer<Session, APIClient.APIError> {
    //    let requestBody = [
    //      "enrollmentCode": enrollmentCode
    //    ];
    //
    //    return self.requestWithAPIPath("/activate", method: .POST, requestBody: requestBody).map({ (response) -> Session in
    //      let session = Mapper<Session>().map(response.rawValue)
    //      return session!
    //    })
    //  }
    //
    //  func resetPassword(emailAddress: String) -> SignalProducer<Void, APIClient.APIError> {
    //    let requestBody = [
    //      "email": emailAddress
    //    ];
    //
    //    return self.requestWithAPIPath("/api/hero/password-reset/request", method: .POST, requestBody: requestBody).map({ (response) -> Void in
    //      return
    //    })
    //  }
    
    func me() -> SignalProducer<Session, APIClient.APIError> {
        #if DEBUG
            print("APIClient#me")
        #endif
        
        return self.requestWithAPIPath("/me", method: .get, requestBody: nil).map({ (response) -> Session in
            let session: Session! = Mapper<Session>().map(JSONObject: [
                "user": response?.object,
                ])
            
            #if DEBUG
                print("APIClient#me got session", session)
            #endif
            
            // GET /me doesn't include the token back in the response, so we pop it on manually here so persistence works correctly
            // we can assume that currentSession.value.token is correct, as it's just been used to fetch /me
            
            session!.token = (SessionManager.sharedInstance.currentSession.value?.token)!
            
            return session!
        })
    }
    
    //  func getBookings(since: NSDate?) -> SignalProducer<Array<Booking>, APIClient.APIError> {
    //    #if DEBUG
    //      print("APIClient#getBookings")
    //    #endif
    //
    //    var urlPath = "/bookings"
    //    if let updatedAt = since {
    //      urlPath = urlPath + "?lastUpdated=" + updatedAt.ISO8601String()!.urlEncoded()
    //    }
    //
    //    return self.requestWithAPIPath(urlPath, method: .GET, requestBody: nil).map({ (response) -> Array<Booking> in
    //      #if DEBUG
    //        print("APIClient#getBookings got data", response.rawValue)
    //      #endif
    //
    //      let results = response["bookings"].arrayValue
    //      return results.map { item -> Booking in
    //        let json = item.rawValue
    //        let booking = Mapper<Booking>().map(json)!
    //        return booking
    //      }
    //    })
    //  }
    //
    //  func getBookingById(id: Int) -> SignalProducer<Booking, APIClient.APIError> {
    //    #if DEBUG
    //      print("APIClient#getBookingById", String(id))
    //    #endif
    //
    //    return self.requestWithAPIPath("/bookings/"+String(id), method: .GET, requestBody: nil).map({ (response) -> Booking in
    //      #if DEBUG
    //        print("APIClient#getBookingById", String(id), "got data", response.rawValue)
    //      #endif
    //
    //      let booking: Booking! = Mapper<Booking>().map(response["booking"].rawValue)
    //      return booking
    //    })
    //  }
    //
    //  func updateBookingById(booking_id: Int, data: [String: AnyObject]) -> SignalProducer<Booking, APIClient.APIError> {
    //    #if DEBUG
    //      print("APIClient#updateBooking")
    //    #endif
    //
    //    return self.requestWithAPIPath("/bookings/"+String(booking_id), method: .PUT, requestBody: data).map({ (response) -> Booking in
    //      #if DEBUG
    //        print("APIClient#updateBooking got data", response.rawValue)
    //      #endif
    //
    //      let booking: Booking! = Mapper<Booking>().map(response["booking"].rawValue)
    //      return booking
    //    })
    //  }
    
    //  func getExtensionOptionsForBookingById(id: Int) -> SignalProducer<(
    //    currency: Currency,
    //    extensionOptions: Array<ExtensionOption>
    //  ), APIClient.APIError> {
    //    #if DEBUG
    //      print("APIClient#getExtensionOptionsForBookingById", String(id))
    //    #endif
    //
    //    return self.requestWithAPIPath("/bookings/"+String(id)+"/extend", method: .GET, requestBody: nil).map({ (response) -> (
    //      currency: Currency,
    //      extensionOptions: Array<ExtensionOption>
    //    ) in
    //      #if DEBUG
    //        print("APIClient#getExtensionOptionsForBookingById", String(id), "got data", response.rawValue)
    //      #endif
    //
    //      let currency = Mapper<Currency>().map(response["currency"].rawValue)!
    //
    //      let options = response["options"].arrayValue.map { item -> ExtensionOption in
    //        let json = item.rawValue
    //        let option = Mapper<ExtensionOption>().map(json)!
    //        return option
    //      }
    //
    //      return (
    //        currency: currency,
    //        extensionOptions: options
    //      )
    //    })
    //  }
    
    //
    //
    //  func setCleanedPushToken(pushToken: String) -> SignalProducer<Void, APIClient.APIError> {
    //    #if DEBUG
    //      print("APIClient#setCleanedPushToken")
    //    #endif
    //
    //    let data = [
    //      "id": TrackingManager.sharedInstance.udid(),
    //      "platform": "ios",
    //      "pushToken": pushToken,
    //    ]
    //
    //    return self.requestWithAPIPath("/devices", method: .PUT, requestBody: data).map { _ in
    //      return
    //    }
    //  }
    //
    
    
    
    // MARK - internal request methods
    
    private func requestURLStringForAPIPath(_ apiPath: String) -> String {
        let sessionToken: String! = SessionManager.sharedInstance.currentSession.value?.token
        
        if(sessionToken != nil) {
            var addChar = "?"
            if(apiPath.contains("?")) {
                addChar = "&"
            }
            
            return String(format: "%@%@%@userIdentifier=%@", Environment.API_BASE_URL, apiPath, addChar, sessionToken)
        }
        else {
            return String(format: "%@%@", Environment.API_BASE_URL, apiPath)
        }
    }
    
    private func formattedLanguagesHeader() -> String {
        var languages: String
        if let languageForApp = Locale.current.languageCode {
            languages = languageForApp + "," + NSLocale.preferredLanguages.joined(separator: ",")
        }
        else {
            languages = NSLocale.preferredLanguages.joined(separator: ",")
        }
        
        return languages.lowercased()
    }
    
    private func requestWithAPIPath(_ apiPath: String, method: HTTPMethod, requestBody: [String: Any]?) -> SignalProducer<JSON?, APIClient.APIError> {
        let headers = [
            "x-application-identifier": Environment.API_APPLICATION_IDENTIFIER,
            "x-device-platform": "b2c-ios",
            "x-accept-language": self.formattedLanguagesHeader(),
            ]
        
        let path = requestURLStringForAPIPath(apiPath)
        
        var request: DataRequest
        if(requestBody != nil) {
            request = Alamofire.request(path, method: method, parameters: requestBody, encoding: JSONEncoding.default, headers: headers)
        }
        else {
            request = Alamofire.request(path, method: method, headers: headers)
        }
        #if DEBUG
            print("APIClient#requestWithAPIPath", request, requestBody)
            debugPrint(request)
        #endif
        
        return SignalProducer { observer, disposable in
            request.responseJSON { res in
                #if DEBUG
                    print("APIClient#requestWithAPIPath", apiPath, "response", res)
                #endif
                
                switch res.result {
                case .success(let value):
                    if((res.response?.statusCode)! >= 400) {
                        // the server sent a response and it's an error
                        let error = APIClient.APIError(res)
                        observer.send(error: error)
                    }
                    else {
                        observer.send(value: JSON(value))
//                        print("----", JSON(value))
                        observer.sendCompleted()
                    }
                    
                case .failure:
                    // this will actually be a request error at this point
                    let error = APIClient.APIError(res)
                    observer.send(error: error)
                }
            }
            
            //      disposable.addDisposable(request.cancel)
        }
    }
    
    
    // MARK - error handling
    
    class APIError : Error {
        let _domain: String = "APIClient"
        let _code: Int = 100000
        
        private(set) var httpStatus: Int = 0
        private(set) var code: String = "UNKNOWN_API_ERROR"
        private(set) var message: String = "an unknown error occured"//.localized()
        private(set) var data: JSON!
        
        init (_ res: Alamofire.DataResponse<Any>) {
            if let response = res.response {
                self.httpStatus = response.statusCode
            }
            
            // grab the full data out
            if let data = res.data {
                self.data = JSON(data: data)
                
                self.code = self.data["code"].stringValue
            }
            
            self.setupMessage()
        }
        
        init (code: String) {
            self.code = code
        }
        
        private func setupMessage() {
            //      if(self.code.localized() != self.code) {
            //        // a localized error is available, use it
            //        self.message = self.code.localized()
            //      }
        }
    }
}
