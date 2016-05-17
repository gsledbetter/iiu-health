//
//  TaskHeaderCell.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/11/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import UIKit

class TaskHeaderCell: UIViewController {
    
    @IBOutlet weak var lblTodaysDate: UILabel!
    
    override func viewDidLoad() {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = .NoStyle
        
        let dateString = formatter.stringFromDate(NSDate())
        lblTodaysDate.text = "\(dateString)"
    
    }
    

}
