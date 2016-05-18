//
//  TaskLeaveStudyCell.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/18/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import UIKit

class TaskLeaveStudyCell: UIViewController {

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var statusView: UIView!
    var status:String
    
    required init(coder aDecoder: NSCoder) {
        status = ""
        super.init(coder: aDecoder)!
        
    }
    
    override func viewDidLoad() {
        lblSummary.text = "Select this task to leave the study and delete all your study data."
        updateCell()
    }
    
    func updateCell() {
        if TaskResults.sharedInstance.taskResultsStore.consentComplete {
            lblStatus.text = "Completed"
        } else {
            lblStatus.text = "Not Done"
            
        }
        
    }
    
    func taskComplete() {
        TaskResults.sharedInstance.taskResultsStore.consentComplete = true
        updateCell()
    }
    

}
