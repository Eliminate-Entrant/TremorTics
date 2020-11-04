//
//  Authorize HealthKit.swift
//  Tremor Tics
//
//  Created by Shaheer Chaudry on 8/26/19.
//  Copyright © 2019 Shaheer Chaudry. All rights reserved.
//

import Foundation
import HealthKit

func authorizeHealthKit() {
    
    HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
        
        guard authorized else {
            
            let baseMessage = "HealthKit Authorization Failed"
            
            if let error = error {
                print("\(baseMessage). Reason: \(error.localizedDescription)")
            } else {
                print(baseMessage)
            }
            
            return
        }
        
        print("HealthKit Successfully Authorized.")
    }
    
}

