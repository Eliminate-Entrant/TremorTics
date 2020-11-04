//
//  result.swift
//  Tremor Tics
//
//  Created by Shaheer Chaudry on 8/26/19.
//  Copyright © 2019 Shaheer Chaudry. All rights reserved.
//

import Foundation
class results {
    
    func testResult(for x: Array<Double>, from base: Double) -> Bool{
        var highX = x.filter(){ $0 >= 0  }
        var lowX = x.filter(){ $0 <= 0  }
        
        var countH = 0
        var countL = 0
        if base >= 0 {
            for (element) in highX{
                let calc: Double = Double(element) - base
                if calc >= 1.00000 || calc <= -1.00000 {
                    
                    countH += 1
                    
                }
                
            }
            
        }
            
        else{
            for (element) in highX{
                let calc: Double = Double(element) + base
                if calc >= 1.00000 || calc <= -1.00000  {
                    
                    countH += 1
                }
            }
        }
        
        if base >= 0 {
            for (element) in lowX{
                let calc: Double = Double(element) + base
                if calc >= 1.00000 || calc <= -1.00000  {
                    
                    countL += 1
                }
                
            }
        }
            
        else{
            for (element) in lowX{
                let calc: Double = Double(element) - base
                if calc >= 1.00000 || calc <= -1.00000  {
                    
                    countL += 1
                }
            }
        }
        
        if countH > 2 || countL > 2 {
            
            highX.removeAll()
            lowX.removeAll()
            
            return true
        } else {
            highX.removeAll()
            lowX.removeAll()
            return false }
        
        
    }
    
    
}


