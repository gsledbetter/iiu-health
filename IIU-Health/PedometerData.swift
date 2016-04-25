//
//  PedometerData.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 4/25/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import Foundation


struct PedometerData {
    
    var steps:Int
    var collectionDate:NSDate
    
    init(steps:Int, timestamp:NSDate) {
        
        self.collectionDate = timestamp
        self.steps = steps
    }
    
}