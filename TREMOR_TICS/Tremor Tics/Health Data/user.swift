//
//  user.swift
//  Tremor Tics
//
//  Created by Shaheer Chaudry on 8/26/19.
//  Copyright © 2019 Shaheer Chaudry. All rights reserved.
//


import Foundation
import HealthKit

class UserHealthProfile {
    
    var age: Int?
    var biologicalSex: HKBiologicalSex?
    var bloodType: HKBloodType?
    var heightInMeters: Double?
    var weightInKilograms: Double?
    
    var bodyMassIndex: Double? {
        
        guard let weightInKilograms = weightInKilograms,
            let heightInMeters = heightInMeters,
            heightInMeters > 0 else {
                return nil
        }
        
        return (weightInKilograms/(heightInMeters*heightInMeters))
    }
}
