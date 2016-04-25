//
//  PedDataStore.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 4/25/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import Foundation


class PedDataStore {
    
    var pedDataPoints:[PedometerData]
    
    init() {
        
        pedDataPoints = []
        
    }
    
    func addPedData(pedData:PedometerData) {
        pedDataPoints.append(pedData)
    }
    
    func getPedDataCount() -> Int {
        return pedDataPoints.count
    }
    
    func getPedDataAtIndex(index:Int) -> PedometerData? {
        
        if  index < pedDataPoints.count {
            return pedDataPoints[index]
        }
        return nil
    }
    
}