//
//  SpecialityManager.swift
//  Massage
//
//  Created by Panda2 on 11/8/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import ReactiveSwift

class SpecialityManager {
    
    static let sharedInstance = SpecialityManager()
    let currentSpecialites = MutableProperty<[Speciality]>([])

    func loadSpecialities(completionHandler: @escaping (_ error: APIClient.APIError?) -> Void) {
        APIClient.sharedInstance.getSpecialities(forServiceArea: nil).startWithResult { (result) in

            if result.value != nil {
                SpecialityManager.sharedInstance.currentSpecialites.swap(result.value!)
                completionHandler(nil)
            }
            else if result.error != nil {
                completionHandler(result.error)
            }
        }
    }
}
