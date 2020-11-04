//
//  ReportTableViewController.swift
//  Tremor Tics
//
//  Created by Shaheer Chaudry on 8/26/19.
//  Copyright © 2019 Shaheer Chaudry. All rights reserved.
//


import UIKit

class ReportTableViewController: UITableViewController {
    
    @IBOutlet weak var XBase: UILabel!
    @IBOutlet weak var Xmax: UILabel!
    
    @IBOutlet weak var YBase: UILabel!
    @IBOutlet weak var Ymax: UILabel!
    
    @IBOutlet weak var ZBase: UILabel!
    @IBOutlet weak var Zmax: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if points.save {
            XBase.text = String(format: "%6.4f",ViewController().maxValue(for: points.maxValuesX))
            Xmax.text = String(format: "%6.4f",points.baseValueX)
            YBase.text = String(format: "%6.4f",ViewController().maxValue(for: points.maxValuesY))
            Ymax.text = String(format: "%6.4f",points.baseValueY)
            ZBase.text = String(format: "%6.4f",ViewController().maxValue(for: points.maxValuesZ))
            Zmax.text = String(format: "%6.4f",points.baseValueZ)
            
            
        }
        
        
        if let tremorReport = tremorReports {
            
            XBase.text = String(format: "%6.4f",tremorReport.baseX)
            YBase.text = String(format: "%6.4f",tremorReport.baseY)
            ZBase.text = String(format: "%6.4f",tremorReport.baseZ)
            
            Xmax.text = String(format: "%6.4f",tremorReport.maxX)
            Ymax.text = String(format: "%6.4f",tremorReport.maxY)
            Zmax.text = String(format: "%.4f",tremorReport.maxZ)
            
            
            
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
