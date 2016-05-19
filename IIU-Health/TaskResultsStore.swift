//
//  TaskResultsStore.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/2/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import Foundation
import ResearchKit

class TaskResultsStore: NSObject, NSCoding {
    
    var firstName: String
    var lastName: String
    var pedData:[PedometerData]
    var heartData:[HeartRateData]
    var feelingData:[FeelingData]
    var resultsParser:ResultParser
    var consentComplete:Bool
    var fitnessCheckComplete:Bool
    var surveyComplete:Bool
    
    var maxSteps:Int
    var minSteps:Int
    var maxHeartRate:Int
    var minHeartRate:Int
    
    static let sharedInstance = TaskResultsStore()
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("taskResults")
    
    let MAX_RESULTS = 7
    
    override init() {
        firstName = ""
        lastName = ""
        pedData = [PedometerData]()
        heartData = [HeartRateData]()
        feelingData = [FeelingData]()
        consentComplete = false
        fitnessCheckComplete = false
        surveyComplete = false
        maxSteps = 0
        minSteps = 0
        maxHeartRate = 0
        minHeartRate = 0
        resultsParser = ResultParser()
        super.init()

    }
    
    init(firstName: String, lastName:String, pedData:[PedometerData], heartData:[HeartRateData], feelingData:[FeelingData], consentComplete:Bool, fitnessCheckComplete:Bool, surveyComplete:Bool,
         maxSteps:Int, minSteps:Int, maxHeartRate:Int, minHeartRate:Int) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.pedData = pedData
        self.heartData = heartData
        self.feelingData = feelingData
        self.consentComplete = consentComplete
        self.fitnessCheckComplete = fitnessCheckComplete
        self.surveyComplete = surveyComplete
        self.maxSteps = maxSteps
        self.minSteps = minSteps
        self.maxHeartRate = maxHeartRate
        self.minHeartRate = minHeartRate
        resultsParser = ResultParser()

    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let firstName = decoder.decodeObjectForKey("firstName") as? String,
            let lastName = decoder.decodeObjectForKey("lastName") as? String,
            let pedData = decoder.decodeObjectForKey("pedData") as? [PedometerData],
            let heartData = decoder.decodeObjectForKey("heartData") as? [HeartRateData],
            let feelingData = decoder.decodeObjectForKey("feelingData") as? [FeelingData]
            else { return nil }
        self.init(
        firstName: firstName,
        lastName: lastName,
        pedData: pedData,
        heartData: heartData,
        feelingData: feelingData,
        consentComplete: decoder.decodeBoolForKey("consentComplete"),
        fitnessCheckComplete: decoder.decodeBoolForKey("fitnessCheckComplete"),
        surveyComplete: decoder.decodeBoolForKey("surveyComplete"),
            maxSteps: decoder.decodeIntegerForKey("maxSteps"),
            minSteps: decoder.decodeIntegerForKey("minSteps"),
            maxHeartRate: decoder.decodeIntegerForKey("maxHeartRate"),
            minHeartRate: decoder.decodeIntegerForKey("minHeartRate")
            
        )
    
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.firstName, forKey: "firstName")
        coder.encodeObject(self.lastName, forKey: "lastName")
        coder.encodeObject(self.pedData, forKey:"pedData")
        coder.encodeObject(self.heartData, forKey:"heartData")
        coder.encodeObject(self.feelingData, forKey:"feelingData")
        coder.encodeBool(self.consentComplete, forKey: "consentComplete")
        coder.encodeBool(self.fitnessCheckComplete, forKey: "fitnessCheckComplete")
        coder.encodeBool(self.surveyComplete, forKey: "surveyComplete")
        coder.encodeInteger(self.maxSteps, forKey: "maxSteps")
        coder.encodeInteger(self.minSteps, forKey: "minSteps")
        coder.encodeInteger(self.maxHeartRate, forKey: "maxHeartRate")
        coder.encodeInteger(self.minHeartRate, forKey: "minHeartRate")

    }
    
    func storeFitnessCheckData(result: ORKTaskResult) {

        if let pedData = resultsParser.getFitnessCheckPedData(result) {
            addPedData(pedData)
        }
        if let heartData = resultsParser.getFitnessCheckHeartData(result) {
            addHeartData(heartData)
        }
        
    }
    
    func storeSurveyData(feeling:Int) {
        let date = NSDate()
        let newFeelingData = FeelingData(feeling: feeling, timestamp: date)
        self.feelingData.append(newFeelingData)
        if self.feelingData.count > MAX_RESULTS {
            self.feelingData.removeAtIndex(0)
        }
    }
    
    func addPedData(pedData:PedometerData) {
        self.pedData.append(pedData)
        if self.pedData.count > MAX_RESULTS {
            self.pedData.removeAtIndex(0)
        }
        findStepsMinMax()

    }
    
    func findStepsMinMax() {
        for pd in self.pedData {
            if pd.steps < minSteps {
                minSteps = pd.steps
            }
            if pd.steps > maxSteps {
                maxSteps = pd.steps
            }
        }
    }
    

    func addHeartData(heartData:HeartRateData) {
        self.heartData.append(heartData)
        if self.heartData.count > MAX_RESULTS {
            self.heartData.removeAtIndex(0)
        }
        findHeartRateMinMax()
    }
    
    func findHeartRateMinMax() {
        for hd in self.heartData {
            if hd.countsPerMinute < minHeartRate {
                minHeartRate = hd.countsPerMinute
            }
            if hd.countsPerMinute > maxHeartRate {
                maxHeartRate = hd.countsPerMinute
            }
        }
    }
    
    
    func getPedDataCount() -> Int {
        return pedData.count
    }
    
    
    func getHeartDataCount() -> Int {
        return heartData.count
    }
    
    func getFeelingDataCount() -> Int {
        return feelingData.count
    }
    
    
    func getPedDataAtIndex(index:Int) -> PedometerData? {
        
        if  index < pedData.count {
            return pedData[index]
        }
        return nil
    }

    func getHeartDataAtIndex(index:Int) -> HeartRateData? {
        
        if  index < heartData.count {
            return heartData[index]
        }
        return nil
    }
    
    func getFeelingAtIndex(index:Int) -> FeelingData? {
        
        if  index < feelingData.count {
            return feelingData[index]
        }
        return nil
    }
    
    func clearData() {
        self.firstName = ""
        self.lastName = ""
        self.pedData.removeAll()
        self.heartData.removeAll()
        self.feelingData.removeAll()
        self.consentComplete = false
        self.fitnessCheckComplete = false
        self.surveyComplete = false
  
    }
    
    func pruneData() {
        while self.pedData.count > MAX_RESULTS {
            self.pedData.removeAtIndex(0)

        }
        while self.heartData.count > MAX_RESULTS {
            self.heartData.removeAtIndex(0)
            
        }
        while self.feelingData.count > MAX_RESULTS {
            self.feelingData.removeAtIndex(0)
            
        }
        findStepsMinMax()
        findHeartRateMinMax()
    }
    
}
