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
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var showTextView: UIView!
    @IBOutlet weak var cellTextLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = delegate.persistentContainer.viewContext
    let offscreenRight = OffScreenRightAC()
    let swipeDownAC = SwipeDownAC()
    
    var prevDayLogs: [DayLog] = []
    var cellSelectedLog: DayLog?
    var today: DayLog!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForFirstLaunch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID.observationVC {
            let vc = segue.destination
            vc.transitioningDelegate = self
        } else if segue.identifier == segueID.instructionsVC {
            let vc = segue.destination
            vc.transitioningDelegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUp()
    }
    
    @IBAction func edit(){
        guard let log = cellSelectedLog else {fatalError()}
        segueToLogVC(log: log)
    }
    
    @IBAction func back(){
        hideCellInfo()
    }
    
    func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        addTapRecognizerToView()
        addSwipeDownGestureRecognizer()
        addSwipeLeftGestureRecognizer()
        fetchLogs()
        updateView()
    }

    func updateView(){
        hideCellInfo()
        dateLbl.text = today.dateString
        weightLbl.text = today.weightString
        exerciseLbl.text = today.exerciseString
        eatingLbl.text = today.eatingString
        commentLbl.text = today.commentary
        if prevDayLogs.count != 0 {
           progressLbl.text = H.calculateProgress(now: today.weight, before: prevDayLogs[0].weight)
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
            return cell
        }
        if prevDayLogs.count < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Placeholder")!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell") as! LogCell
            if i < prevDayLogs.count - 1 {
                //previous is for calculating progress
                cell.configureCell(log: prevDayLogs[i], previous: prevDayLogs[i+1])
            } else {
                //there is only one prev day log so can't calculate previous
                cell.configureCell(log: prevDayLogs[i], previous: nil)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let i = indexPath.row
        if cell?.reuseIdentifier == "LogCell"{
            //show text commentary and buttons
            cellSelectedLog = prevDayLogs[i]
            cellTextLbl.text = cellSelectedLog!.commentary
            editBtn.isHidden = false
            backBtn.isHidden = false
            showTextView.isHidden = false
        } else if cell?.reuseIdentifier == "AddDate"{
            let newLog = DayLog(context: context)
            var date: NSDate!
            //if no prevDayLogs return todays date
            if prevDayLogs.count == 0 {date = today.date}
            //return date for last log in array
            else {date = prevDayLogs.last?.date}
            let newDate = date.dayBefore
            newLog.date = newDate
            delegate.saveContext()
            segueToLogVC(log: newLog)
        }
    }
}
