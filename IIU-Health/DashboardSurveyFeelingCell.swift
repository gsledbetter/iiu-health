//
//  DashboardSurveyFeelingCell.swift
//  IIU-Health
//
//  Created by Greg Ledbetter on 5/18/16.
//  Copyright © 2016 IIU. All rights reserved.
//

import UIKit
import ResearchKit

class DashboardSurveyFeelingCell: UIViewController, ORKGraphChartViewDataSource {

    @IBOutlet weak var lblMinMax: UILabel!
    @IBOutlet weak var lineGraphView: ORKLineGraphChartView!
    var dateFormatter:NSDateFormatter
    
    let taskResultsStore = TaskResults.sharedInstance.taskResultsStore
    
    required init(coder aDecoder: NSCoder) {
        
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "H:mm"
        super.init(coder: aDecoder)!
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
    // MARK: Line chart data soource
    // Required methods
    
    func graphChartView(graphChartView: ORKGraphChartView, pointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKRangedPoint {
        let point = taskResultsStore.getFeelingAtIndex(pointIndex)?.feeling
        return ORKRangedPoint(value:CGFloat(point!))
        
    }
    
    func graphChartView(graphChartView: ORKGraphChartView, numberOfPointsForPlotIndex plotIndex: Int) -> Int {
        return taskResultsStore.getFeelingDataCount()
    }
    
    // Optional methods
    
    // Returns the number of points to the graph chart view
    func numberOfPlotsInGraphChartView(graphChartView: ORKGraphChartView) -> Int {
        return 1
    }
    
    // Sets the maximum value on the y axis
    func maximumValueForGraphChartView(graphChartView: ORKGraphChartView) -> CGFloat {
        return 3
    }
    
    // Sets the minimum value on the y axis
    func minimumValueForGraphChartView(graphChartView: ORKGraphChartView) -> CGFloat {
        return 0
    }
    
    // Provides titles for x axis
    func graphChartView(graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        
        
        let collectionDate = taskResultsStore.getFeelingAtIndex(pointIndex)?.collectionDate
        return dateFormatter.stringFromDate(collectionDate!)
        
        
    }
    
    // Returns the color for the given plot index
    func graphChartView(graphChartView: ORKGraphChartView, colorForPlotIndex plotIndex: Int) -> UIColor {
        return UIColor.blueColor()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
