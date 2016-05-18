//
//  DashboardTasksCompleted.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/17/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import UIKit
import ResearchKit


class DashboardTasksCompleted: UIViewController, ORKPieChartViewDataSource {
    
    @IBOutlet weak var pieChartView: ORKPieChartView!
    var pedDateFormatter:NSDateFormatter
    let taskResultsStore = TaskResults.sharedInstance.taskResultsStore

    required init(coder aDecoder: NSCoder) {
        
        pedDateFormatter = NSDateFormatter()
        pedDateFormatter.dateFormat = "H:mm"
        super.init(coder: aDecoder)!
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Dashboard"
        activityCompletionPercentage = 80

        // pie chart view configuration
        pieChartView.dataSource = self
        pieChartView.title = NSLocalizedString("Activities Completed", comment: "")
        pieChartView.showsTitleAboveChart = true
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        pieChartView.text  = "As of " + dateFormatter.stringFromDate(NSDate())
        
    }
    
    // MARK: Pie chart data source
    func numberOfSegmentsInPieChartView(pieChartView: ORKPieChartView) -> Int {
        return 2
    }
    
    enum PieChartSegment: Int {
        case Completed, Remaining
    }
    
    var activityCompletionPercentage: CGFloat = 0
    
    func pieChartView(pieChartView: ORKPieChartView, valueForSegmentAtIndex index: Int) -> CGFloat {
        switch PieChartSegment(rawValue: index)! {
        case .Completed:
            return activityCompletionPercentage
        case .Remaining:
            return 100 - activityCompletionPercentage
        }
    }
    
    func pieChartView(pieChartView: ORKPieChartView, colorForSegmentAtIndex index: Int) -> UIColor {
        switch PieChartSegment(rawValue: index)! {
        case .Completed:
            return UIColor.greenColor()
        case .Remaining:
            return UIColor.lightGrayColor()
        }
    }
    
    func pieChartView(pieChartView: ORKPieChartView, titleForSegmentAtIndex index: Int) -> String {
        switch PieChartSegment(rawValue: index)! {
        case .Completed:
            return NSLocalizedString("Completed", comment: "")
        case .Remaining:
            return NSLocalizedString("Remaining", comment: "")
        }
    }
    



}
