//
//  DashboardViewController.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 4/19/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import UIKit
import ResearchKit

class DashboardViewController: UITableViewController, ORKPieChartViewDataSource , ORKGraphChartViewDataSource {
    
    
    @IBOutlet weak var pieChartView: ORKPieChartView!
    @IBOutlet weak var lineGraphView: ORKLineGraphChartView!
    
    var taskResultsStore:TaskResultsStore!
    var pedDateFormatter:NSDateFormatter

    
    required init(coder aDecoder: NSCoder) {
        
        pedDateFormatter = NSDateFormatter()
        pedDateFormatter.dateFormat = "H:mm"
        taskResultsStore = TaskResults.sharedInstance.taskResultsStore
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
        
        // line graph view configuration
        lineGraphView.dataSource = self
        lineGraphView.showsHorizontalReferenceLines = true
        lineGraphView.showsVerticalReferenceLines = true
        lineGraphView.axisColor = UIColor.whiteColor()
        lineGraphView.verticalAxisTitleColor = UIColor.orangeColor()
        lineGraphView.showsHorizontalReferenceLines = true
        lineGraphView.showsVerticalReferenceLines = true
        lineGraphView.scrubberLineColor = UIColor.redColor()

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
    
    // MARK: Line chart data soource
    // Required methods
    
    func graphChartView(graphChartView: ORKGraphChartView, pointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKRangedPoint {
        
        switch plotIndex {
        case 0:
            let point = taskResultsStore.getPedDataAtIndex(pointIndex)?.steps
            return ORKRangedPoint(value:CGFloat(point!))
        default:
            let point = taskResultsStore.getHeartDataAtIndex(pointIndex)?.countsPerMinute
            return ORKRangedPoint(value:CGFloat(point!))

        }
    }
    
    func graphChartView(graphChartView: ORKGraphChartView, numberOfPointsForPlotIndex plotIndex: Int) -> Int {
        // return plotPoints[plotIndex].count
        if plotIndex == 0 {
            return taskResultsStore.getPedDataCount()
        } else if plotIndex == 1 {
            return taskResultsStore.getHeartDataCount()

        }
        
        return 0
    }
    
    // Optional methods
    
    // Returns the number of points to the graph chart view
    func numberOfPlotsInGraphChartView(graphChartView: ORKGraphChartView) -> Int {
        return 2
    }
    
    // Sets the maximum value on the y axis
    func maximumValueForGraphChartView(graphChartView: ORKGraphChartView) -> CGFloat {
        return 160
    }
    
    // Sets the minimum value on the y axis
    func minimumValueForGraphChartView(graphChartView: ORKGraphChartView) -> CGFloat {
        return 0
    }
    
    // Provides titles for x axis
    func graphChartView(graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        

            let collectionDate = taskResultsStore.getPedDataAtIndex(pointIndex)?.collectionDate
            return pedDateFormatter.stringFromDate(collectionDate!)
            
        
    }
    
    // Returns the color for the given plot index
    func graphChartView(graphChartView: ORKGraphChartView, colorForPlotIndex plotIndex: Int) -> UIColor {
        if plotIndex == 0 {
            return UIColor.blueColor()
        }
        return UIColor.yellowColor()
    }
}