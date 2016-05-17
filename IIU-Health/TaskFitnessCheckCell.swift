//
//  TaskFitnessCheckCell.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/16/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import Foundation
import UIKit

class TaskFitnessCheckCell: UIViewController {
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var statusView: UIView!
    var status:String
    
    required init(coder aDecoder: NSCoder) {
        status = ""
        super.init(coder: aDecoder)!
        
    }
    
    override func viewDidLoad() {
        lblSummary.text = "Select this task to complete the fitness check part of the study."
        updateCell()
    }
    
    func updateCell() {
        if TaskResults.sharedInstance.taskResultsStore.fitnessCheckComplete {
            lblStatus.text = "Completed"
        } else {
            lblStatus.text = "Not Done"
            
        }
        
    }
    
    func taskComplete() {
        TaskResults.sharedInstance.taskResultsStore.fitnessCheckComplete = true
        updateCell()
    }
    
}
