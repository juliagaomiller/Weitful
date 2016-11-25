//
//  MainVC.swift
//  Weitful
//
//  Created by Julia Miller on 11/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var exerciseLbl: UILabel!
    @IBOutlet weak var eatingLbl: UILabel!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let context = delegate.persistentContainer.viewContext
    let x = "- -"
    var prevDayLogs: [DayLog] = []
    var today: DayLog!
    var indexForCell: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        updateView()
    }
    
    func setUp(){
        tableView.delegate = self
        tableView.dataSource = self
        checkForFirstLaunch()
//        updateView()
    }
    
    func checkForFirstLaunch(){
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    func updateView(){
        updatePrevDayLogs()
        guard let _ = today else {
            fatalError()
        }
        dateLbl.text = today.date!.convertToString(format: "MMMM dd, yyyy")
        exerciseLbl.text = today.exercise
        eatingLbl.text = today.eating
        weightLbl.text = today.weight
        if prevDayLogs.count != 0 {
            progressLbl.text = MainVC.calculateProgress(after: today, before: prevDayLogs[0])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier!){
        case "cellLog":
            let vc = segue.destination as! LogVC
            vc.dayLog = prevDayLogs[indexForCell]
        case "cellReflect":
            let vc = segue.destination as! ReflectVC
            vc.dayLog = prevDayLogs[indexForCell]
        case "todayLog":
            let vc = segue.destination as! LogVC
            vc.dayLog = today
        case "todayReflect":
            let vc = segue.destination as! ReflectVC
            vc.dayLog = today
        default:
            break
        }
    }
    
    func updatePrevDayLogs(){
        let request: NSFetchRequest<DayLog> = DayLog.fetchRequest()
        do {
            prevDayLogs = try context.fetch(request)
        } catch {
            fatalError()
        }
        //print(prevDayLogs.count)
        if prevDayLogs.count == 0 {
            today = DayLog(weight: x, exercise: x, eating: x, context: context)
            return
        } else {
            prevDayLogs.sort(by: { $0.date!.compare($1.date as! Date) == .orderedDescending })
            let date = NSDate()
            if prevDayLogs[0].MMddyy == date.convertToString(format: "MMddyy") {
                today = prevDayLogs[0]
                prevDayLogs.removeFirst()
            } else {
                today = DayLog(weight: x, exercise: x, eating: x, context: context)
            }
        }
        delegate.saveContext()
        tableView.reloadData()
    }
    
    static func calculateProgress(after: DayLog, before: DayLog)->String{
        if after.weight != "- -" && before.weight != "- -"{
            let p = Double(before.weight!)! - Double(after.weight!)!
            if p > 0 {
                return "+\(p)"
            } else {
                return "-\(p)"
            }
        }
        return ""
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if prevDayLogs.count <= 1 {
            return 1
        } else {
            return prevDayLogs.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if prevDayLogs.count <= 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Placeholder")!
            return cell
        } else {
            let i = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell") as! LogCell
            if i >= 1 {
               cell.configureCell(log: prevDayLogs[i], previous: prevDayLogs[i-1])
            } else {
                cell.configureCell(log: prevDayLogs[i], previous: nil)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexForCell = indexPath.row
    }
}
