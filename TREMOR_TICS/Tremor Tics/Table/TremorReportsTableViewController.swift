//
//  TremorReportsTableViewController.swift
//  Tremor Tics
//
//  Created by Shaheer Chaudry on 8/26/19.
//  Copyright © 2019 Shaheer Chaudry. All rights reserved.
//


import UIKit
import  CoreData
import os.log
var tr = [TremorReport]()

class NC: UINavigationController {
    
}


class TremorReportsTableViewController: UITableViewController {
    
    //  var tremorReport = [TremorReport]()
    
    @IBOutlet weak var searchFooter: SearchFooter!
    var detailViewController: ReportViewController? = nil
    
    var filteredReports = [TremorReport]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Date"
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
            tableView.tableHeaderView = searchController.searchBar
        }
        definesPresentationContext = true
        
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "NEGATIVE 🥳", "POSITIVE 🤒"]
        searchController.searchBar.delegate = self
        
        tableView.tableHeaderView = searchFooter
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        /* if let save = loadReports(){
         tr += save
         
         }*/
        
        /*
         if let splitViewController = splitViewController {
         let controllers = splitViewController.viewControllers
         detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ReportViewController
         }*/
        
        
        //tableView.reloadData()
        // if let savedReports = loadReports() {
        //       tr += savedReports
        
        //  }
        //  else {
        // Load the sample data.
        
        //      loadSampleReports()
        //  }
        
        
    }
    
    // MARK: - Table view data source
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredReports.count, of: tr.count)
            return filteredReports.count
        }
        
        // #warning Incomplete implementation, return the number of rows
        searchFooter.setNotFiltering()
        return tr.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cells", for: indexPath) as? TremorReportsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TremorReportsTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        
        let tremorReports: TremorReport
        if isFiltering() {
            tremorReports = filteredReports[indexPath.row]
        } else {
            tremorReports = tr[indexPath.row]
        }
        
        
        if Int(tremorReports.score)! > 1 { cell.ScoreLabel.backgroundColor = .red } else {cell.ScoreLabel.backgroundColor = #colorLiteral(red: 0, green: 0.4793452024, blue: 0.9990863204, alpha: 1)}
        if tremorReports.result == "NEGATIVE 🥳" { cell.scoreResult.textColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1) } else { cell.scoreResult.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) }
        cell.ScoreLabel.text = tremorReports.score
        cell.ScoreLabel.textColor = .white
        cell.dateLabel.text = String(tremorReports.date[1])
        cell.scoreResult.text = tremorReports.result
        cell.maxLabel.text = String(format: "Max:%6.3f", tremorReports.maxX) + " m/s²"
        cell.baseLabel.text = String(format: "Base:%6.3f", tremorReports.baseX) + " m/s²"
        
        
        // Configure the cell...
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //let tremorReports: TremorReport
            
            if isFiltering() {
                for element in tr {
                    if element == filteredReports[indexPath.row] {
                        tr.firstIndex(of: element).map { tr.remove(at: $0) }
                        
                        print("deleting works")
                    }
                }
                filteredReports.remove(at: indexPath.row)
                
            } else {
                tr.remove(at: indexPath.row)
            }
            
            saveReports()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
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
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "ShowDetail" {
     if let indexPath = tableView.indexPathForSelectedRow {
     let object = tremorReport[indexPath.row]
     let controller = segue.destination as! ReportViewController
     controller.tremorReports = object
     }
     }
     }
     */
    override func didMove(toParent parent: UIViewController?) {
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let report: TremorReport
                if isFiltering() {
                    report = filteredReports[indexPath.row]
                } else {
                    report = tr[indexPath.row]
                }
                guard let controller = segue.destination as? ReportViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                // guard let tableController = segue.destination as? ReportTableViewController else {
                //     fatalError("Unexpected destination: \(segue.destination)")
                //  }
                tremorReports = report
                //ReportTableViewController().tremorReports = report
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    
    
    
    
    
    
    
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     super.prepare(for: segue, sender: sender)
     
     switch(segue.identifier ?? "") {
     
     case "AddItem":
     os_log("Adding a new report.", log: OSLog.default, type: .debug)
     
     case "ShowDetail":
     
     
     
     /* guard let reportDetailViewController = segue.destination as? ReportViewController else {
     fatalError("Unexpected destination: \(segue.destination)")
     }
     
     guard let selectedReportCell = sender as? TremorReportsTableViewCell else {
     fatalError("Unexpected sender: \(sender)")
     }
     
     guard let indexPath = tableView.indexPath(for: selectedReportCell) else {
     fatalError("The selected cell is not being displayed by the table")
     }
     
     let selectedReport = tr[indexPath.row]
     reportDetailViewController.tremorReports = selectedReport
     */
     default:
     fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
     }
     }*/
    
    
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let _ = sender.source as? NC, let _ = ViewController().tremorReports {
            print("woroweorkowekroweorkowekr")
            let newIndexPath = IndexPath(row: tr.count, section: 0)
            print("NC")
            print("whyasdas", tr.count)
            
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            //saveReports()
            
            
            
        }
    }
    
    
    
    private func loadSampleReports() {
        
        //  let photo1 = UIImage(named: "meal1")
        // let photo2 = UIImage(named: "meal2")
        //  let photo3 = UIImage(named: "meal3")
        /*
         guard let report1 = TremorReport(score: "10", date: "Thursday", max: "Max : 4", base: "Base : 5", maxArray: [1,2,3,4,5], testValues: [5,6,7,8,9]) else {
         fatalError("Unable to instantiate meal1")
         }
         
         guard let report2 = TremorReport(score: "7", date: "Wednesday", max: "Max : 5", base: "Base : 4", maxArray: [1,2,3,4,5], testValues: [5,6,7,8,9]) else {
         fatalError("Unable to instantiate meal2")
         }
         
         guard let report3 = TremorReport(score: "4", date: "Tuesday", max: "Max : 7", base: "Base : 6", maxArray: [1,2,3,4,5], testValues: [5,6,7,8,9]) else {
         fatalError("Unable to instantiate meal2")
         }
         
         tr += [report1, report2, report3]*/
    }
    
    
    func saveReports() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tr, toFile: TremorReport.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Report successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save report...", log: OSLog.default, type: .error)
        }
    }
    
    func loadReports() -> [TremorReport]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: TremorReport.ArchiveURL.path) as? [TremorReport]
    }
    
    
    // MARK: - Private instance methods
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredReports = tr.filter({( report : TremorReport) -> Bool in
            let doesCategoryMatch = (scope == "All") || (report.result == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                let date = String(report.date[1])
                return doesCategoryMatch && date.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    
    
}



extension TremorReportsTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension TremorReportsTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

