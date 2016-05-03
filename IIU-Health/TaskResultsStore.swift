//
//  TaskResultsStore.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/2/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import Foundation
import ResearchKit

class TaskResultsStore {
    
    var pedDataPoints:[PedometerData]
    var heartDataPoints:[HeartRateData]
    var resultsParser:ResultParser
    
    init() {
        
        pedDataPoints = []
        heartDataPoints = []
        resultsParser = ResultParser()

    }
    
    func storeFitnessCheckData(result: ORKTaskResult) {

        //resultsParser.parseFitnessCheckResults(result)
        if let pedData = resultsParser.getFitnessCheckPedData(result) {
            addPedData(pedData)
        }
        if let heartData = resultsParser.getFitnessCheckHeartData(result) {
            addHeartData(heartData)
        }
        
        
    }
    
    func addPedData(pedData:PedometerData) {
        pedDataPoints.append(pedData)
    }
    
    func addHeartData(heartData:HeartRateData) {
        heartDataPoints.append(heartData)
    }
    
    func getPedDataCount() -> Int {
        return pedDataPoints.count
    }
    
    func getHeartDataCount() -> Int {
        return heartDataPoints.count
    }
    
    func getPedDataAtIndex(index:Int) -> PedometerData? {
        
        if  index < pedDataPoints.count {
            return pedDataPoints[index]
        }
        return nil
    }

    func getHeartDataAtIndex(index:Int) -> HeartRateData? {
        
        if  index < heartDataPoints.count {
            return heartDataPoints[index]
        }
        return nil
    }
    

}
