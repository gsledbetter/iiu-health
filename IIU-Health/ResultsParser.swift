//
//  ResultsParser.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 4/15/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import Foundation
import ResearchKit
import SwiftyJSON


class ResultParser {
    

    
//    func parseFitnessCheckResults(result: ORKTaskResult) -> [NSURL] {
//        
//        let walkResultsIndex = 3
//        let restResultsIndex = 4
//        
//        var urls = [NSURL]()
//        
//        if let results = result.results
//            where results.count > 4,
//            let walkResult = results[walkResultsIndex] as? ORKStepResult,
//            let restResult = results[restResultsIndex] as? ORKStepResult {
//            
//            if let pedFileUrl = getPedometerFileURL(walkResult) {
//                getFitnessCheckPedData(pedFileUrl)
//                
//            }
//            if let heartRateFileUrl = getPedometerFileURL(walkResult) {
//                printWalkTaskPedometerData(heartRateFileUrl)
//                
//            }
//
//        }
//        
//        return urls
//    }
    
    func getFitnessCheckPedData(result: ORKTaskResult) -> PedometerData?  {
        
        if let results = result.results
            where results.count > 4,
            let walkResult = results[3] as? ORKStepResult {
            print ("Walk Task Pedometer URL = \(getPedometerFileURL(walkResult))")
            if let pedFileUrl = getPedometerFileURL(walkResult) {
                return getPedometerData(pedFileUrl)
                
            }
        }
        
        return nil
        
    }
    
    func getFitnessCheckHeartData(result: ORKTaskResult) -> HeartRateData?  {
        
        if let results = result.results
            where results.count > 4,
            let walkResult = results[4] as? ORKStepResult {
            print ("Fitness Check Heart Rate  URL = \(getPedometerFileURL(walkResult))")
            if let pedFileUrl = getHeartRateFileURL(walkResult) {
                return getHeartData(pedFileUrl)
                
            }
        }
        
        return nil
        
    }
    
    func getPedometerFileURL(walkResults:ORKStepResult) -> NSURL? {
        
        var url:NSURL? = nil
        for walkResult in walkResults.results! {
            
            if let walkResult = walkResult as? ORKFileResult,
                let resultFileUrl = walkResult.fileURL {
                
                let fileString = resultFileUrl.lastPathComponent
                let nameComponents  = fileString!.componentsSeparatedByString("_")
                
                if nameComponents.first == "pedometer" {
                    url = resultFileUrl
                    print ("Fitness Check Pedometer URLS = \(url)")

                }
                
            }
        }
        
        return url
    }
    
    func getHeartRateFileURL(walkResults:ORKStepResult) -> NSURL? {
        
        var url:NSURL? = nil
        for walkResult in walkResults.results! {
            
            if let walkResult = walkResult as? ORKFileResult,
                let resultFileUrl = walkResult.fileURL {
                
                let fileString = resultFileUrl.lastPathComponent
                let nameComponents  = fileString!.componentsSeparatedByString("_")
                
                if nameComponents.first == "HKQuantityTypeIdentifierHeartRate" {
                    url = resultFileUrl
                    print ("Fitness Check Heart Rate URLS = \(url)")
                    
                }
                
            }
        }
        
        return url
    }
    
    func getPedometerData(pedometerFileURL:NSURL) -> PedometerData? {
        
        
        var pedData:PedometerData? = nil
        
        if let data = NSData(contentsOfURL:pedometerFileURL) {
            
            let json = JSON(data:data)
            
            for item in json["items"].arrayValue {
                if let steps = item["numberOfSteps"].int {
                    print("Number of steps = \(steps)")
                    if let collectionTimestamp = item["startDate"].string {
                        print("Start date = \(collectionTimestamp)")
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                        if let date = dateFormatter.dateFromString(collectionTimestamp) {
                            pedData = PedometerData(steps: steps, timestamp: date)
                        }
                    }
                    
                }
            }
        }
        
        
        return pedData
        
    }
    
    func getHeartData(heartRateFileURL:NSURL) -> HeartRateData? {
        
        
        var heartData:HeartRateData? = nil
        
        if let data = NSData(contentsOfURL:heartRateFileURL) {
            
            let json = JSON(data:data)
            
            for item in json["items"].arrayValue {
                if let unit = item["unit"].string {
                    print("Unit = \(unit)")
                    if let value = item["value"].int {
                        if let collectionTimestamp = item["startDate"].string {
                            print("Start date = \(collectionTimestamp)")
                            let dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                            if let date = dateFormatter.dateFromString(collectionTimestamp) {
                                heartData = HeartRateData(value: value, timestamp: date)
                            }
                        }
                    }
                    
                }
            }
        }
        
        
        return heartData
        
    }
    
    func printWalkTaskPedometerData(pedometerFileURL:NSURL)  {
        
        if let data = NSData(contentsOfURL:pedometerFileURL) {
            
            let json = JSON(data:data)
            
            for item in json["items"].arrayValue {
                if let steps = item["numberOfSteps"].int {
                    print("Number of steps = \(steps)")
                    if let steps = item["distance"].int {
                        print("Distance = \(steps)")
                    }
                    
                    if let steps = item["floorsAscended"].int {
                        print("Floors ascended = \(steps)")
                    }
                    if let steps = item["floorsDescended"].int {
                        print("Floors ascended = \(steps)")
                    }
                    if let steps = item["startDate"].string {
                        print("Start date = \(steps)")
                    }
                    if let steps = item["endDate"].string {
                        print("End date = \(steps)")
                    }
                    
                }
                
            }
        }
        
        
    }
    
     func printHeartRateDate() {
        // print our some heart rate data
        let heartRateType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!
        
        if (HKHealthStore.isHealthDataAvailable()){
            var csvString = "Time,Date,Heartrate(BPM)\n"
            HealthKitManager.hkStore.requestAuthorizationToShareTypes(nil, readTypes:[heartRateType], completion:{(success, error) in
                let sortByTime = NSSortDescriptor(key:HKSampleSortIdentifierEndDate, ascending:false)
                let timeFormatter = NSDateFormatter()
                timeFormatter.dateFormat = "hh:mm:ss"
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM/dd/YYYY"
                
                let query = HKSampleQuery(sampleType:heartRateType, predicate:nil, limit:600, sortDescriptors:[sortByTime], resultsHandler:{(query, results, error) in
                    guard let results = results else { return }
                    for quantitySample in results {
                        let quantity = (quantitySample as! HKQuantitySample).quantity
                        let heartRateUnit = HKUnit(fromString: "count/min")
                        
                        //                        csvString.extend("\(quantity.doubleValueForUnit(heartRateUnit)),\(timeFormatter.stringFromDate(quantitySample.startDate)),\(dateFormatter.stringFromDate(quantitySample.startDate))\n")
                        //                        println("\(quantity.doubleValueForUnit(heartRateUnit)),\(timeFormatter.stringFromDate(quantitySample.startDate)),\(dateFormatter.stringFromDate(quantitySample.startDate))")
                        csvString += "\(timeFormatter.stringFromDate(quantitySample.startDate)),\(dateFormatter.stringFromDate(quantitySample.startDate)),\(quantity.doubleValueForUnit(heartRateUnit))\n"
                        print("\(timeFormatter.stringFromDate(quantitySample.startDate)),\(dateFormatter.stringFromDate(quantitySample.startDate)),\(quantity.doubleValueForUnit(heartRateUnit))")
                    }
                    
                    do {
                        let documentsDir = try NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain:.UserDomainMask, appropriateForURL:nil, create:true)
                        try csvString.writeToURL(NSURL(string:"heartratedata.csv", relativeToURL:documentsDir)!, atomically:true, encoding:NSASCIIStringEncoding)
                    }
                    catch {
                        print("Error occured")
                    }
                    
                })
                HealthKitManager.hkStore.executeQuery(query)
            })
        }
        
    }
}