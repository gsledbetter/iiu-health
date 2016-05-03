//
//  HeartRateData.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/2/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import Foundation


struct HeartRateData {
    
    var countsPerMinute:Int
    var collectionDate:NSDate
    
    init(value:Int, timestamp:NSDate) {
        
        self.collectionDate = timestamp
        self.countsPerMinute = value
    }
    
}