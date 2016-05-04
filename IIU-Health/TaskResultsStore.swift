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
    var resultsParser:ResultParser
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("taskResults")
    
    override init() {
        firstName = ""
        lastName = ""
        pedData = [PedometerData]()
        heartData = [HeartRateData]()
        resultsParser = ResultParser()
        super.init()

    }
    
    init(firstName: String, lastName:String, pedData:[PedometerData], heartData:[HeartRateData]) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.pedData = pedData
        self.heartData = heartData
        resultsParser = ResultParser()

    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let firstName = decoder.decodeObjectForKey("firstName") as? String,
            let lastName = decoder.decodeObjectForKey("lastName") as? String,
            let pedData = decoder.decodeObjectForKey("pedData") as? [PedometerData],
            let heartData = decoder.decodeObjectForKey("heartData") as? [HeartRateData]
            else { return nil }
        self.init(
        firstName: firstName,
        lastName: lastName,
        pedData: pedData,
        heartData: heartData
        )
        
    
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.firstName, forKey: "firstName")
        coder.encodeObject(self.lastName, forKey: "lastName")
        coder.encodeObject(self.pedData, forKey:"pedData")
        coder.encodeObject(self.heartData, forKey:"heartData")

    }
    
    func storeFitnessCheckData(result: ORKTaskResult) {

        if let pedData = resultsParser.getFitnessCheckPedData(result) {
            addPedData(pedData)
        }
        if let heartData = resultsParser.getFitnessCheckHeartData(result) {
            addHeartData(heartData)
        }
        
    }
    
    func addPedData(pedData:PedometerData) {
        self.pedData.append(pedData)
    }
    
    func addHeartData(heartData:HeartRateData) {
        self.heartData.append(heartData)
    }
    
    func getPedDataCount() -> Int {
        return pedData.count
    }
    
    func getHeartDataCount() -> Int {
        return heartData.count
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
    

}
