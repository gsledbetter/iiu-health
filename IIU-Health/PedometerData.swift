//
//  PedometerData.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 4/25/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import Foundation


class PedometerData: NSObject, NSCoding {
    
    var steps:Int
    var collectionDate:NSDate
    
    init(steps:Int, timestamp:NSDate) {
        
        self.collectionDate = timestamp
        self.steps = steps
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let collectionDate = decoder.decodeObjectForKey("collectionDate") as? NSDate
            else { return nil }
        
        self.init(steps:decoder.decodeIntegerForKey("steps"), timestamp: collectionDate)
    }
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInt(Int32(self.steps), forKey: "steps")
        coder.encodeObject(self.collectionDate, forKey: "collectionDate")
        
    }
    

}