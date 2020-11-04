//
//  ProfileDataStore.swift
//  Tremor Tics
//
//  Created by Shaheer Chaudry on 8/26/19.
//  Copyright © 2019 Shaheer Chaudry. All rights reserved.
//


import Foundation
import Foundation
import HealthKit

class ProfileDataStore {
    
    class func getAgeSexAndBloodType() throws -> (age: Int,
        biologicalSex: HKBiologicalSex,
        bloodType: HKBloodType) {
            
            let healthKitStore = HKHealthStore()
            
            do {
                
                //1. This method throws an error if these data are not available.
                let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
                let biologicalSex =       try healthKitStore.biologicalSex()
                let bloodType =           try healthKitStore.bloodType()
                
                //2. Use Calendar to calculate age.
                var age : Int? = nil
                let today = Date()
                let calendar = Calendar.current
                
                let todayDateComponents = calendar.dateComponents([.year,.month,.day],
                                                                  from: today)
                
                let thisYear = todayDateComponents.year!
                let thisMonth = todayDateComponents.month!
                let thisDay = todayDateComponents.day!
                print(birthdayComponents.month!)
                if thisMonth >= birthdayComponents.month! {
                    if thisDay >= birthdayComponents.day! {
                        age = thisYear - birthdayComponents.year!
                    } else { age = thisYear - birthdayComponents.year! - 1}
                }
                

                let unwrappedBiologicalSex = biologicalSex.biologicalSex
                let unwrappedBloodType = bloodType.bloodType
                
                return (age!, unwrappedBiologicalSex, unwrappedBloodType)
            }
    }
    
    class func getMostRecentSample(for sampleType: HKSampleType,
                                   completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {
        
        //1. Use HKQuery to load the most recent samples.
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
        
        let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                                            
                                            //2. Always dispatch to the main thread when complete.
                                            DispatchQueue.main.async {
                                                
                                                guard let samples = samples,
                                                    let mostRecentSample = samples.first as? HKQuantitySample else {
                                                        
                                                        completion(nil, error)
                                                        return
                                                }
                                                
                                                completion(mostRecentSample, nil)
                                            }
        }
        
        HKHealthStore().execute(sampleQuery)
    }
    
    
    
}
