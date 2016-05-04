//
//  HeartRateData.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/2/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import Foundation


class HeartRateData:  NSObject, NSCoding {
    
    var countsPerMinute:Int
    var collectionDate:NSDate
    
    init(value:Int, timestamp:NSDate) {
        
        self.collectionDate = timestamp
        self.countsPerMinute = value
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let collectionDate = decoder.decodeObjectForKey("collectionDate") as? NSDate
            else { return nil }
        
        self.init(value:decoder.decodeIntegerForKey("countsPerMinute"), timestamp: collectionDate)
    }
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInt(Int32(self.countsPerMinute), forKey: "countsPerMinute")
        coder.encodeObject(self.collectionDate, forKey: "collectionDate")
        
    }

    
}