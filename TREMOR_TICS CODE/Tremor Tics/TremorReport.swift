//
//  TremorReport.swift
//  Tremor Tics
//
//  Created by Shaheer Chaudry on 8/26/19.
//  Copyright © 2019 Shaheer Chaudry. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import os.log


class TremorReport: NSObject, NSCoding {
    
    //MARK: Properties
    
    var score: String
    var result: String
    var date: Array<String>
    var maxX: Double
    var maxY: Double
    var maxZ: Double
    var baseX: Double
    var baseY: Double
    var baseZ: Double
    var maxArrayX: Array<Any>
    var maxArrayY: Array<Any>
    var maxArrayZ: Array<Any>
    var testValuesX: Array<Any>
    var testValuesY: Array<Any>
    var testValuesZ: Array<Any>
    
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tremorReports")
    
    //MARK: Types
    
    struct PropertyKey {
        static let score = "score"
        static let result = "result"
        static let maxX = "maxX"
        static let maxY = "maxY"
        static let maxZ = "maxZ"
        static let baseX = "baseX"
        static let baseY = "baseY"
        static let baseZ = "baseZ"
        static let date = "date"
        static let maxArrayX = "maxArrayX"
        static let maxArrayY = "maxArrayY"
        static let maxArrayZ = "maxArrayZ"
        static let testValuesX = "testValuesX"
        static let testValuesY = "testValuesY"
        static let testValuesZ = "testValuesZ"
    }
    
    //MARK: Initialization
    
    init?(score: String, date: Array<String>, maxX: Double, maxY: Double, maxZ: Double, baseX: Double, baseY: Double, baseZ: Double, maxArrayX: Array<Any>,maxArrayY: Array<Any>, maxArrayZ: Array<Any>, testValuesX: Array<Any>, testValuesY: Array<Any>, testValuesZ: Array<Any>, result: String) {
        
        // Initialize stored properties.
        self.score = score
        self.result = result
        self.date = date
        self.maxX = maxX
        self.maxY = maxY
        self.maxZ = maxZ
        self.baseX = baseX
        self.baseY = baseY
        self.baseZ = baseZ
        self.maxArrayX = maxArrayX
        self.maxArrayY = maxArrayY
        self.maxArrayZ = maxArrayZ
        self.testValuesX = testValuesX
        self.testValuesY = testValuesY
        self.testValuesZ = testValuesZ
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(score, forKey: PropertyKey.score)
        aCoder.encode(result, forKey: PropertyKey.result)
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(maxX, forKey: PropertyKey.maxX)
        aCoder.encode(maxY, forKey: PropertyKey.maxY)
        aCoder.encode(maxZ, forKey: PropertyKey.maxZ)
        aCoder.encode(baseX, forKey: PropertyKey.baseX)
        aCoder.encode(baseY, forKey: PropertyKey.baseY)
        aCoder.encode(baseZ, forKey: PropertyKey.baseZ)
        aCoder.encode(maxArrayX, forKey: PropertyKey.maxArrayX)
        aCoder.encode(maxArrayY, forKey: PropertyKey.maxArrayY)
        aCoder.encode(maxArrayZ, forKey: PropertyKey.maxArrayZ)
        aCoder.encode(testValuesX, forKey: PropertyKey.testValuesX)
        aCoder.encode(testValuesY, forKey: PropertyKey.testValuesY)
        aCoder.encode(testValuesZ, forKey: PropertyKey.testValuesZ)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let score = aDecoder.decodeObject(forKey: PropertyKey.score) as? String else {
            os_log("Unable to decode the name for a Report object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let result = aDecoder.decodeObject(forKey: PropertyKey.result) as? String else {
            os_log("Unable to decode the name for a Report object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? Array<String> else {
            os_log("Unable to decode the name for a Report object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let maxX = aDecoder.decodeDouble(forKey:  PropertyKey.maxX)
        let maxY = aDecoder.decodeDouble(forKey:  PropertyKey.maxY)
        let maxZ = aDecoder.decodeDouble(forKey:  PropertyKey.maxZ)
        let baseX = aDecoder.decodeDouble(forKey: PropertyKey.baseX)
        let baseY = aDecoder.decodeDouble(forKey: PropertyKey.baseY)
        let baseZ = aDecoder.decodeDouble(forKey: PropertyKey.baseZ)
        let maxArrayX = aDecoder.decodeObject(forKey: PropertyKey.maxArrayX) as! Array<Any>
        let maxArrayY = aDecoder.decodeObject(forKey: PropertyKey.maxArrayY) as! Array<Any>
        let maxArrayZ = aDecoder.decodeObject(forKey: PropertyKey.maxArrayZ) as! Array<Any>
        let testValuesX = aDecoder.decodeObject(forKey: PropertyKey.testValuesX) as! Array<Any>
        let testValuesY = aDecoder.decodeObject(forKey: PropertyKey.testValuesY) as! Array<Any>
        let testValuesZ = aDecoder.decodeObject(forKey: PropertyKey.testValuesZ) as! Array<Any>
        
        // Must call designated initializer.
        self.init(score: score, date: date, maxX: maxX, maxY: maxY, maxZ: maxZ, baseX: baseX, baseY: baseY, baseZ: baseZ, maxArrayX: maxArrayX, maxArrayY: maxArrayY, maxArrayZ: maxArrayZ, testValuesX: testValuesX, testValuesY: testValuesY, testValuesZ: testValuesZ, result: result)
        
    }
}

