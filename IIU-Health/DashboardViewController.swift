//
//  DashboardViewController.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 4/19/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import UIKit
import ResearchKit

class DashboardViewController: UITableViewController  {
    
    
    
    var taskResultsStore:TaskResultsStore!

    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Dashboard"
        

    }
    
}