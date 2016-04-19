//
//  ResultsParser.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 4/15/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import Foundation
import ResearchKit

struct ResultParser {
    
    static func findWalkHeartFiles(result: ORKTaskResult) -> [NSURL] {
        
        var urls = [NSURL]()
        
        if let results = result.results
            where results.count > 4,
            let walkResult = results[3] as? ORKStepResult,
            let restResult = results[4] as? ORKStepResult {
            
            // find ORKFileResults
            for result in walkResult.results! {
                if let result = result as? ORKFileResult,
                    let fileUrl = result.fileURL {
                    urls.append(fileUrl)
                }
            }
            
            for result in restResult.results! {
                if let result = result as? ORKFileResult,
                    let fileUrl = result.fileURL {
                    urls.append(fileUrl)
                }
            }
        }
        
        return urls
    }
}