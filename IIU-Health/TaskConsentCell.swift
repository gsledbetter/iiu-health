//
//  TaskConsentCell.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/11/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import UIKit

class TaskConsentCell: UIViewController {
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var statusView: UIView!
    var status:String

    required init(coder aDecoder: NSCoder) {
        status = ""
        super.init(coder: aDecoder)!
        
    }
    
    override func viewDidLoad() {
        lblSummary.text = "Select this task to give your consent to join the study."
        updateCell()
    }
    
    func updateCell() {
        if TaskResults.sharedInstance.taskResultsStore.consentComplete {
            lblStatus.text = "Done"
            lblStatus.textColor = UIColor.redColor()
            statusView.backgroundColor = UIColor.redColor()
        } else {
            lblStatus.text = "Not Done"
            lblStatus.textColor = UIColor.greenColor()
            statusView.backgroundColor = UIColor.greenColor()
            
        }
        
    }
    
    func taskComplete() {
        TaskResults.sharedInstance.taskResultsStore.consentComplete = true
        updateCell()
    }
    
}

