//
//  ReportViewController.swift
//  Tremor Tics
//
//  Created by Shaheer Chaudry on 8/26/19.
//  Copyright © 2019 Shaheer Chaudry. All rights reserved.
//


import UIKit
import CoreData
import os.log
import SwiftChart

var tremorReports : TremorReport?


class ReportViewController: UIViewController, ChartDelegate {
    
    
    
    
    
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        
        graph.hideHighlightLineOnTouchEnd = true
        
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    
    
    
    @IBOutlet weak var graph: Chart!
    @IBOutlet weak var labelLeadingMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    fileprivate var labelLeadingMarginInitialConstant: CGFloat!
    @IBOutlet weak var viewsection: UIView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graph.delegate = self
        graph.xLabels = [0,1,2]
        graph.xLabelsFormatter = { "Test" + String(Int(round($1) + 1)) }
        
        
        
        
        if points.save {
            scoreLabel.text = String(points.score)
            dateLabel.text = String(points.date[0])
            navigationItem.title = ViewController().resultScore()
            chart(rounding(points.maxValuesX), rounding(points.maxValuesY) , rounding(points.maxValuesZ))
        }
        
        
        
        
        if let tremorReport = tremorReports {
            
            navigationItem.title = tremorReport.result
            scoreLabel.text = tremorReport.score
            let date = tremorReport.date[0]
            dateLabel.text = String(date)
            
            
            chart(rounding(tremorReport.maxArrayX as! Array<Double>), rounding(tremorReport.maxArrayY as! Array<Double>), rounding(tremorReport.maxArrayZ as! Array<Double>))
            
            
        }
        
        
    }
    
    
    private func chart(_ X:Array<Double>, _ Y:Array<Double>, _ Z:Array<Double>){
        
        graph.removeAllSeries()
        
        let series1 = ChartSeries(X)
        series1.color = ChartColors.blueColor()
        
        let series2 = ChartSeries(Y)
        series2.color = ChartColors.darkRedColor()
        
        
        let series3 = ChartSeries(Z)
        series3.color = ChartColors.purpleColor()
        
        
        graph.add([series1, series2, series3])
        
    }
    
    
    func rounding(_ x:Array<Double>) -> Array<Double>{
        var array = [Double]()
        for (element) in x{
            let r = (element*1000).rounded()/1000
            array.append(r)
        }
        
        return array
    }
    
    
    
    
    
    
    
    @IBAction func Share(_ sender: Any) {
        csv()
    }
    
    
    func csv(){
        
        let renderer = UIGraphicsImageRenderer(size: viewsection.bounds.size)
        let screenshot = renderer.image { ctx in
            viewsection.drawHierarchy(in: viewsection.bounds, afterScreenUpdates: true)
        }
        
        let fileName = "\(points.Firstname+" "+points.Lastname)'s Tremor Report.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "First Name,Last Name,Age,Number of Records\n\(points.Firstname),\(points.Lastname),\(points.Age),\(tr.count)\n\nDate,Score,X-Axis Base Value (m/s²),Y-Axis Base Value (m/s²),Z-Axis Base Value (m/s²),X-Axis Max Value (m/s²),Y-Axis Max Value (m/s²),Z-Axis Max Value (m/s²), Result\n"
        
        for reports in tr {
            
            
            let newLine = "\(reports.date[0]),\(reports.score),\(reports.baseX),\(reports.baseY),\(reports.baseZ),\(reports.maxX),\(reports.maxY),\(reports.maxZ),\(reports.result)\n"
            
            csvText.append(contentsOf: newLine)
        }
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch{
            print("Failed to create file")
            print("\(error)")
        }
        
        
        let vc = UIActivityViewController(activityItems: [path!,screenshot], applicationActivities: [])
        vc.excludedActivityTypes = [
            UIActivity.ActivityType.assignToContact,
            //UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            //UIActivity.ActivityType.postToTencentWeibo,
            //UIActivity.ActivityType.postToTwitter,
            //UIActivity.ActivityType.postToFacebook,
            //UIActivity.ActivityType.openInIBooks
        ]
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
}






