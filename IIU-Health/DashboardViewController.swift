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
    
    var pedDataStore:PedDataStore!
    var pedDateFormatter:NSDateFormatter

    
    var plotPoints =
        [
            [
                ORKRangedPoint(value: 200),
                ORKRangedPoint(value: 450),
                ORKRangedPoint(value: 500),
                ORKRangedPoint(value: 250),
                ORKRangedPoint(value: 300),
                ORKRangedPoint(value: 600),
                ORKRangedPoint(value: 300),
            ],
            [
                ORKRangedPoint(value: 100),
                ORKRangedPoint(value: 350),
                ORKRangedPoint(value: 400),
                ORKRangedPoint(value: 150),
                ORKRangedPoint(value: 200),
                ORKRangedPoint(value: 500),
                ORKRangedPoint(value: 400),
            ]
    ]
    
    required init(coder aDecoder: NSCoder) {
        
        pedDateFormatter = NSDateFormatter()
        pedDateFormatter.dateFormat = "MM/dd HH:mm:ss"

        super.init(coder: aDecoder)!
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityCompletionPercentage = 80
        
        // pie chart view configuration
        pieChartView.dataSource = self
        pieChartView.title = NSLocalizedString("IIU Health Dashboard", comment: "")
        pieChartView.showsTitleAboveChart = true
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        pieChartView.text  = dateFormatter.stringFromDate(NSDate())
        
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
        
        //return plotPoints[plotIndex][pointIndex]
        let point = pedDataStore.getPedDataAtIndex(pointIndex)?.steps
        return ORKRangedPoint(value:CGFloat(point!))
    }
    
    func graphChartView(graphChartView: ORKGraphChartView, numberOfPointsForPlotIndex plotIndex: Int) -> Int {
        // return plotPoints[plotIndex].count
        return pedDataStore.getPedDataCount()
    }
    
    // Optional methods
    
    // Returns the number of points to the graph chart view
    func numberOfPlotsInGraphChartView(graphChartView: ORKGraphChartView) -> Int {
        return 1
    }
    
    // Sets the maximum value on the y axis
    func maximumValueForGraphChartView(graphChartView: ORKGraphChartView) -> CGFloat {
        return 20
    }
    
    // Sets the minimum value on the y axis
    func minimumValueForGraphChartView(graphChartView: ORKGraphChartView) -> CGFloat {
        return 0
    }
    
    // Provides titles for x axis
    func graphChartView(graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
//        switch pointIndex {
//        case 0:
//            return "Mon"
//        case 1:
//            return "Tue"
//        case 2:
//            return "Wed"
//        case 3:
//            return "Thu"
//        case 4:
//            return "Fri"
//        case 5:
//            return "Sat"
//        case 6:
//            return "Sun"
//        default:
//            return "Day \(pointIndex + 1)"
//        }
        
        let collectionDate = pedDataStore.getPedDataAtIndex(pointIndex)?.collectionDate
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