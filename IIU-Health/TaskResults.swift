//
//  TaskResults.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/16/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import Foundation

class TaskResults {
    
    static let sharedInstance = TaskResults()

    var taskResultsStore:TaskResultsStore!

    init() {
        
        print("Loading Task Results from file \(TaskResultsStore.ArchiveURL.path!)")
        if let storedTaskResultsStore = NSKeyedUnarchiver.unarchiveObjectWithFile(TaskResultsStore.ArchiveURL.path!) as? TaskResultsStore {
            taskResultsStore = storedTaskResultsStore
        } else {
            taskResultsStore = TaskResultsStore()
        }
        
    }
    
    // MARK: NSCoding
    func saveTaskResults() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(taskResultsStore, toFile: TaskResultsStore.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save task results...")
        }
    }
    
    
}


