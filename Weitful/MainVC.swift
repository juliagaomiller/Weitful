//
//  MainVC.swift
//  Weitful
//
//  Created by Julia Miller on 11/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData

let instructionsVCSegue = "InstructionsVCSegue"

//UIViewControllerTransitioningDelegate
class MainVC: UIViewController {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var exerciseLbl: UILabel!
    @IBOutlet weak var eatingLbl: UILabel!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var lastLogLbl: UILabel!
    @IBOutlet weak var commentTV: UITextView!
    @IBOutlet weak var whiteTV: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = delegate.persistentContainer.viewContext
    let offscreenRight = OffScreenRightAC()
    let swipeDownAC = SwipeDownAC()
    let splitAC = SplitAC()
    let swipeLeftAC = SwipeLeftAC()
    
    var prevDayLogs: [DayLog] = []
    var cellSelectedLog: DayLog?
    var newLog: DayLog?
    var today: DayLog!
    var cellColors = [UIColor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkForFirstLaunch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        vc.transitioningDelegate = self
        if segue.identifier == segueID.logVC {
            let logVC = segue.destination as! LogVC
            //logVC.transitioningDelegate = self
            logVC.log = sender as! DayLog
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUp()
    }
    
    @IBAction func edit(){
        guard let log = cellSelectedLog else {fatalError()}
        performSegue(withIdentifier: segueID.logVC, sender: log)
    }
    
    @IBAction func back(){
        hideCellInfo()
    }
    
    func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        commentTV.layer.cornerRadius = 7.0
        whiteTV.layer.cornerRadius = 7.0
        addGestureRecognizers()
        fetchLogs()
        updateView()
    }
    
    func updateView(){
        hideCellInfo()
        dateLbl.text = today.dateString
        weightLbl.text = today.weightString
        exerciseLbl.text = today.exerciseString
        eatingLbl.text = today.eatingString
        commentTV.text = today.commentary
        if prevDayLogs.count != 0 {
           progressLbl.text = H.calculateProgress(now: today.weight, before: prevDayLogs[0].weight)
            calculateLastLog()
        } else {progressLbl.text = ""}
        
        //add date extension to calculate progress
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if prevDayLogs.count <= 1 {
            //one for "no previous logs" cell, one for "add previous weight" cell
            return 2
        } else {
            return prevDayLogs.count + 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        let numOfRows = tableView.numberOfRows(inSection: indexPath.section)
        if i == numOfRows - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddDate")!
            cell.selectionStyle = .none
            return cell
        }
        if prevDayLogs.count < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Placeholder")!
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell") as! LogCell
            if i == 5 {
                
            }
            if i < prevDayLogs.count - 1 {
                //the tableView is organized so that yesterday is at the top of the prevDayLogs array.
                if i > 0 {
                    cell.configureCell(log: prevDayLogs[i], previous: prevDayLogs[i+1], prevCellColor: cellColors[i-1])
                } else {
                   cell.configureCell(log: prevDayLogs[i], previous: prevDayLogs[i+1], prevCellColor: nil)
                }
            } else {
                //we're on the last cell in the table.
                if i > 0 {
                    cell.configureCell(log: prevDayLogs[i], previous: prevDayLogs[i-1], prevCellColor: cellColors[i-1])
                } else {
                    cell.configureCell(log: prevDayLogs[i], previous: nil, prevCellColor: nil)
                }
                
            }
            if cellColors.count < prevDayLogs.count {
                cellColors.append(cell.backgroundColor!)
            }
            cell.selectionStyle = .default
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let i = indexPath.row
        if cell?.reuseIdentifier == "LogCell"{
            //show text commentary and buttons
            cellSelectedLog = prevDayLogs[i]
            whiteTV.isHidden = false
            whiteTV.text = cellSelectedLog!.commentary
            editBtn.isHidden = false
            backBtn.isHidden = false
        } else if cell?.reuseIdentifier == "AddDate"{
            newLog = DayLog(context: context)
            var date: NSDate!
            //if no prevDayLogs return todays date
            if prevDayLogs.count == 0 {date = today.date}
            //return date for last log in array
            else {date = prevDayLogs.last?.date}
            let newDate = date.dayBefore
            newLog!.date = newDate
            delegate.saveContext()
            performSegue(withIdentifier: segueID.logVC, sender: newLog)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let log = prevDayLogs[indexPath.row]
            prevDayLogs.remove(at: indexPath.row)
            context.delete(log)
            delegate.saveContext()
            tableView.reloadData()
            //just in case prevDayLog[0] was deleted
            updateView()
        }
    }
}
