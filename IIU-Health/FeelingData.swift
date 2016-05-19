//
//  FeelingData.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/18/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import Foundation

class FeelingData:  NSObject, NSCoding {
    
    var feeling:Int
    var collectionDate:NSDate
    
    init(feeling:Int, timestamp:NSDate) {
        
        self.collectionDate = timestamp
        self.feeling = feeling
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let collectionDate = decoder.decodeObjectForKey("collectionDate") as? NSDate
            else { return nil }
        
        self.init(feeling:decoder.decodeIntegerForKey("feeling"), timestamp: collectionDate)
    }
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInt(Int32(self.feeling), forKey: "feeling")
        coder.encodeObject(self.collectionDate, forKey: "collectionDate")
        
    }
    
    
}