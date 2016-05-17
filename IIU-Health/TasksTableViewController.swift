//
//  ActivitiesTableViewController.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/4/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import UIKit
import ResearchKit

class TasksTableViewController: UITableViewController, ORKTaskViewControllerDelegate, UITabBarControllerDelegate {

    var taskResultsStore:TaskResultsStore
    var consentCellVC:TaskConsentCell?

    required init(coder aDecoder: NSCoder) {
        
        taskResultsStore = TaskResults.sharedInstance.taskResultsStore
        consentCellVC = nil
        super.init(coder: aDecoder)!
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.tableFooterView = UIView()
        self.tableView.layoutMargins = UIEdgeInsetsZero
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.preservesSuperviewLayoutMargins = false
        self.title = "Tasks"
        self.tabBarController?.delegate = self
        
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row  {
        
        case 1: // consent
            let taskViewController = ORKTaskViewController(task: ConsentTask, taskRunUUID: nil)
            taskViewController.delegate = self
            presentViewController(taskViewController, animated: true, completion: nil)
        
        case 2: // fitness check
            let taskViewController = ORKTaskViewController(task: FitnessCheckTask, taskRunUUID: nil)
            taskViewController.delegate = self
            taskViewController.outputDirectory = NSURL(fileURLWithPath:
                NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0],
                                                       isDirectory: true)
            presentViewController(taskViewController, animated: true, completion: nil)
        
        case 3: // survey
            let taskViewController = ORKTaskViewController(task: SurveyTask(), taskRunUUID: nil)
            taskViewController.delegate = self
            presentViewController(taskViewController, animated: true, completion: nil)
            
        case 4: // leave study
            print("Leave study selected.")

        default:
            print("Invalid value for Tasks uitableview indexPath.row \(indexPath.row)")
            
        }
        
    }

    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "taskConsentCellEmbed" {
            
            consentCellVC = segue.destinationViewController as? TaskConsentCell
            
        } 
    }
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        
        // HealthKitManager.stopMockHeartData()
        if taskViewController.task?.identifier == FitnessCheckTaskId && reason == .Completed {
            
            self.taskResultsStore.storeFitnessCheckData(taskViewController.result)
            TaskResults.sharedInstance.saveTaskResults()
            
        } else if taskViewController.task?.identifier == ConsentTaskId && reason == .Completed {
            consentCellVC!.taskComplete()
            TaskResults.sharedInstance.saveTaskResults()
        }
        
        if reason != .Failed {
            taskViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    

}
