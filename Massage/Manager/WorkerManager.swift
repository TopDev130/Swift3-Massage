//
//  WorkerManager.swift
//  Massage
//
//  Created by Panda2 on 11/8/16.
//  Copyright © 2016 urban. All rights reserved.
//

import Foundation
import ReactiveSwift

class WorkerManager {
    
    static let sharedInstance = WorkerManager()
    let currentWorkers = MutableProperty<[Worker]>([])
    
    func loadWorkers(limitCnt: Int, completionHandler: @escaping (_ error: APIClient.APIError?) -> Void) {
        APIClient.sharedInstance.getWorkers(limit: limitCnt).startWithResult{ (result) in
            
            if result.value != nil {
                WorkerManager.sharedInstance.currentWorkers.swap(result.value!)
                completionHandler(nil)
            }
            else if result.error != nil {
                completionHandler(result.error)
            }
        }
    }
}
