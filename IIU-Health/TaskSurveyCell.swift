//
//  TaskSurveyCell.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/16/16.
//  Copyright © 2016 IIU. All rights reserved.
//
import Foundation
import UIKit

class TaskSurveyCell: UIViewController {
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var statusView: UIView!
    var status:String
    
    required init(coder aDecoder: NSCoder) {
        status = ""
        super.init(coder: aDecoder)!
        
    }
    
    override func viewDidLoad() {
        lblSummary.text = "Select this task to complete the survey part of the study."
        updateCell()
    }
    
    func updateCell() {
        if TaskResults.sharedInstance.taskResultsStore.surveyComplete {
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
        TaskResults.sharedInstance.taskResultsStore.surveyComplete = true
        updateCell()
    }
    
}

