//
//  CitiesManager.swift
//  Massage
//
//  Created by Panda2 on 11/9/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import ReactiveSwift

class CitiesManager {
    
    static let sharedInstance = CitiesManager()
    let currentCities = MutableProperty<[City]>([])
    
    func loadCities(completionHandler: @escaping (_ error: APIClient.APIError?) -> Void) {
        APIClient.sharedInstance.getCities().startWithResult{ (result) in
            
            if result.value != nil {
                CitiesManager.sharedInstance.currentCities.swap(result.value!)
                completionHandler(nil)
            }
            else if result.error != nil {
                completionHandler(result.error)
            }
        }
    }
}
