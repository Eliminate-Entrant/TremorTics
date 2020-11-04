//
//  ViewController.swift
//  Tremor Tics
//
//  Created by Shaheer Chaudry on 8/26/19.
//  Copyright © 2019 Shaheer Chaudry. All rights reserved.
//

import UIKit
import CoreMotion
import CoreData
import os.log

struct points {
    static var registerX = [Double]()
    static var registerY = [Double]()
    static var registerZ = [Double]()
    static var arrayX = [Double]()
    static var arrayY = [Double]()
    static var arrayZ = [Double]()
    static var maxValuesX = [Double]()
    static var maxValuesY = [Double]()
    static var maxValuesZ = [Double]()
    static var date = [String]()
    static var baseValueX: Double = 0
    static var baseValueY: Double = 0
    static var baseValueZ: Double = 0
    static var score: Int = 0
    static var save: Bool = false
    static var scoreResult: String = ""
    static var Firstname : String = ""
    static var Lastname : String = ""
    static var Age : Int = 0
}


class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let save = TremorReportsTableViewController().loadReports() {
            tr += save
        }
        
    }
}



class ViewController: UIViewController {
    
    
    
    
    
    
    @IBAction func refresh(_ sender: Any) {
        self.graph2.clear()
        self.graph3.clear()
        self.graph4.clear()
        testNo = 0
        reset()
    }
    
    
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var graph2: GraphView!
    @IBOutlet weak var graph3: GraphView!
    @IBOutlet weak var graph4: GraphView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var l: UILabel!
    @IBOutlet weak var A: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var result: UIBarButtonItem!
    
    
    @IBAction func start(_ sender: UITapGestureRecognizer) {
        startButton.isEnabled = false
        testNo += 1
        self.A.text = "Test \(testNo)"
        table = true

         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        
        if testNo == 3{
            points.date = generateCurrentTimeStamp()
            
            resultAvailable = true
            startButton.isEnabled = false
            
        }
        else {
            resultAvailable = false
            
        }
        
        
        
        
        
        
    }
    
    
    
    let motion = CMMotionManager()
    var timer = Timer()
    var count = 3
    var testNo = 0
    var resultAvailable = false
    
    var X: Double = 0
    var Y: Double = 0
    var Z: Double = 0
    var tremorReports: TremorReport?
    
    
   
    
    var MaxX : Float = -10
    
    var MaxY : Float = -10
    
    var MaxZ : Float = -10
    var table = false
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
  
        
        
        
        authorizeHealthKit()
        startButton.isMultipleTouchEnabled = false
        
        let defaults = UserDefaults.standard
        points.Firstname = defaults.string(forKey: "Firstname") ?? ""
        points.Lastname = defaults.string(forKey: "Lastname") ?? ""
        points.Age = defaults.integer(forKey: "Age")
        
        
        if points.Firstname == "" || points.Lastname == "" {
            BioAlert()
            
            
            //let defaults = UserDefaults.standard
        }
        
        
        
        
        self.l.isUserInteractionEnabled = false
        
        self.l.text = "Begin"
        self.A.text = "Press Start To Begin"
        
       // scroll.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        scroll.layer.cornerRadius = 15
        scroll.layer.masksToBounds = true
        
        startButton.layer.cornerRadius = 9
        startButton.layer.shadowColor = UIColor.black.cgColor
        startButton.layer.shadowRadius = 3.0
        startButton.layer.shadowOpacity = 100.0
        startButton.layer.masksToBounds = true
        
        l.layer.shadowColor = UIColor.black.cgColor
        l.layer.shadowRadius = 3.0
        l.layer.shadowOpacity = 1.0
        l.layer.shadowOffset = CGSize(width: 4, height: 4)
        l.layer.cornerRadius =  9
        l.layer.masksToBounds = true
        
        A.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        self.graph2.backgroundTint  = .blue
        self.graph2.capacity        = 1200
        self.graph2.visibleRange    = (-4)...4
        self.graph2.gesturesEnabled = true
        self.graph2.title           = "X - AXIS"
        self.graph2.subtitle        = ""
        
        self.graph3.backgroundTint  = .red
        self.graph3.capacity        = 1200
        self.graph3.gesturesEnabled = false
        self.graph3.title           = "Y - AXIS"
        self.graph3.subtitle        = ""
        self.graph3.visibleRange    = (-4)...4
        
        self.graph4.backgroundTint  = .purple
        self.graph4.capacity        = 1200
        self.graph4.title           = "Z - AXIS"
        self.graph4.subtitle        = ""
        self.graph4.gesturesEnabled = false
        graph4.visibleRange    = (-4)...4
        result.isEnabled = false
        
    }
    
    @objc func update() {
        
        if count >= 1 {
            
            startAccelerometers()
            self.l.text = "\(count)"
            count -= 1
        }
            
        else{
            
            //start.isEnabled = true
            motion.stopAccelerometerUpdates()
            timer.invalidate()
            l.text = "0"
            count = 3
            
            points.arrayX+=points.registerX
            points.arrayY+=points.registerY
            points.arrayZ+=points.registerZ
            points.baseValueX = startValue(from: points.registerX)
            points.baseValueY = startValue(from: points.registerY)
            points.baseValueZ = startValue(from: points.registerZ)
            
            testScore()
            
            points.registerX.removeAll()
            points.registerY.removeAll()
            points.registerZ.removeAll()
            
            
            
            
            points.maxValuesX.append(Double(MaxX))
            points.maxValuesY.append(Double(MaxY))
            points.maxValuesZ.append(Double(MaxZ))
            self.MaxX = -10
            self.MaxY = -10
            self.MaxZ = -10
            
            if resultAvailable {
                result.isEnabled = true
                l.text = "Done"
                self.A.text = "Press Result to view Report. Press Refresh button to take New Readings"
                points.save = true
                saveResult()
                
            } else { startButton.isEnabled = true }
            
            
        }
    }
    func reset(){
        
        motion.stopAccelerometerUpdates()
        timer.invalidate()
        testNo = 0
        count = 3
        startButton.isEnabled = true
        result.isEnabled = false
        points.arrayX.removeAll()
        points.arrayY.removeAll()
        points.arrayZ.removeAll()
        points.score = 0
        self.MaxX = -10
        self.MaxY = -10
        self.MaxZ = -10
        viewDidLoad()
        points.maxValuesX.removeAll()
        points.maxValuesY.removeAll()
        points.maxValuesZ.removeAll()
        
    }
    
    
    func startValue(from array: Array<Double>) -> Double{
        
        let slice = array[...4]
        let sum = slice.reduce(0, {$0 + $1})
        return(sum/5)
        
    }
    
    func testScore(){
        var scoreCount = 0
        if results().testResult(for: points.registerX, from: points.baseValueX){
            scoreCount += 1
            
        }
        if results().testResult(for: points.registerY, from: points.baseValueY){
            scoreCount += 1
            
        }
        if results().testResult(for: points.registerZ, from: points.baseValueZ){
            scoreCount += 1
            
        }
        
        if scoreCount >= 1 {
            points.score += 1
            
        }
        
        
    }
    
    
    
    func generateCurrentTimeStamp () -> Array<String> {
        let dateTime = DateFormatter()
        let date = DateFormatter()
        dateTime.dateFormat = "MMMM dd yyyy  ::  hh:mm a"
        date.dateFormat = "MMMM dd yyyy"
        var array = [(dateTime.string(from: Date()) as NSString) as String]
        array += [(date.string(from: Date()) as NSString) as String]
        return array
    }
    
    
    
    
    
    
    func max(from xi: Double, in graph:GraphView, by m : inout Float){
        // var x: Double = 0
        var x = xi
        if x < 0{
            
            x *= -1
            
        }
        
        if Float(x) > m{
            m = Float(x)
            graph.subtitle = String(format: "Max: %6.4f", xi) + " m/s²"
            
        }
    }
    
    
    func startAccelerometers(){
        
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1/100
            self.motion.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                
                
                // Configure a timer to fetch the data
                if let data = self.motion.accelerometerData {
                    self.view.reloadInputViews()
                    let x = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z
                    
                    self.graph2.add(sample: x)
                    self.graph3.add(sample: y)
                    self.graph4.add(sample: z)
                    
                    self.graph2.title = String(format: "X: %+6.4f", x) + " m/s²"
                    self.graph3.title = String(format: "Y: %+6.4f", y) + " m/s²"
                    self.graph4.title = String(format: "Z: %+6.4f", z) + " m/s²"
                    
                    self.max(from: x, in: self.graph2, by : &self.MaxX)
                    self.max(from: y, in: self.graph3, by : &self.MaxY)
                    self.max(from: z, in: self.graph4, by : &self.MaxZ)
                    
                    points.registerX.append(x)
                    points.registerY.append(y)
                    points.registerZ.append(z)
                    
                    self.X = x
                    self.Y = y
                    self.Z = z
                    
                }
            }
        }
    }
    
    
    func maxValue(for array: Array<Double>) -> Double{
        var value : Double = -10
        for (element) in array{
            var x = element
            if x < 0 {
                x *= -1
            }
            if x > value {
                value = x
            }
        }
        return value
    }
    
    func resultScore() -> String{
        if points.score > 1 {points.scoreResult = "POSITIVE 🤒"} else {points.scoreResult = "NEGATIVE 🥳"}
        return points.scoreResult
    }
    
    
    
    
    func saveResult() {
        
        os_log("Adding a new report.", log: OSLog.default, type: .debug)
        
        let score = String(points.score)
        let date = points.date
        let maxX = maxValue(for: points.maxValuesX)
        let maxY = maxValue(for: points.maxValuesY)
        let maxZ = maxValue(for: points.maxValuesZ)
        let baseX = points.baseValueX
        let baseY = points.baseValueY
        let baseZ = points.baseValueZ
        let maxArrayX = points.maxValuesX
        let maxArrayY = points.maxValuesY
        let maxArrayZ = points.maxValuesZ
        let testValuesX = points.arrayX
        let testValuesY = points.arrayY
        let testValuesZ = points.arrayZ
        let result = resultScore()
        
        
        tremorReports = TremorReport(score: score, date: date, maxX: maxX, maxY: maxY, maxZ: maxZ, baseX: baseX, baseY: baseY, baseZ: baseZ, maxArrayX: maxArrayX, maxArrayY: maxArrayY, maxArrayZ: maxArrayZ, testValuesX: testValuesX, testValuesY: testValuesY, testValuesZ: testValuesZ, result: result)
        
        tr.append(tremorReports!)
        TremorReportsTableViewController().saveReports()
        
        
    }
    
    
    
    func BioAlert() {
        //Step : 1
        let defaults = UserDefaults.standard
        let alert = UIAlertController(title: "Great Title", message: "Please input Your Bio", preferredStyle: UIAlertController.Style.alert)
        //Step : 2
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            let textField2 = alert.textFields![1] as UITextField
            let textField3 = alert.textFields![2] as UITextField
            if textField.text != "" {
                //Read TextFields text data
                
                
                defaults.set(textField.text!, forKey: "Firstname")
                
                
            }
            
            
            if textField2.text != "" {
                
                defaults.set(textField2.text!, forKey: "Lastname")
                
            }
            
            if textField3.text != "" {
                
                let age = Int(textField3.text ?? "0") ?? 0
                defaults.set(age, forKey: "Age")
            }
            
        }
        
        //Step : 3
        //For first TF
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your first name"
            textField.textColor = #colorLiteral(red: 0.8016920337, green: 0.06791342623, blue: 0.1812881171, alpha: 1)
            
            
        }
        //For second TF
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your last name"
            textField.textColor = #colorLiteral(red: 0, green: 0.4793452024, blue: 0.9990863204, alpha: 1)
            
        }
        alert.addTextField { (textField) in
            textField.keyboardType = UIKeyboardType.numberPad
            textField.placeholder = "Enter your Age"
            textField.textColor = #colorLiteral(red: 0.5754343571, green: 0.154294281, blue: 0.7690657384, alpha: 1)
            
        }
        
        //Step : 4
        alert.addAction(save)
        
        self.present(alert, animated:true, completion: nil)
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}



