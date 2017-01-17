//
//  Statistics.swift
//  Weitful
//
//  Created by Julia Miller on 1/12/17.
//  Copyright © 2017 Julia Miller. All rights reserved.
//

import UIKit

struct CellStats {
    var monthName: String
    var month: Average?
    var weekOne: Average?
    var weekTwo: Average?
    var weekThree: Average?
    var weekFour: Average?
    init(monthName: String, month: Average?, weekOne: Average?, weekTwo: Average?, weekThree: Average?, weekFour: Average?){
        self.monthName = monthName
        self.month = month
        self.weekOne = weekOne
        self.weekTwo = weekTwo
        self.weekThree = weekThree
        self.weekFour = weekFour
    }
}

struct Average {
    var lbs: Double?
    var eating: Double?
    var exercise: Double?
    init(lbs: Double?, eating: Double?, exercise: Double?){
        self.lbs = lbs
        self.eating = eating
        self.exercise = exercise
    }
}

struct MonthDayLog {
    var monthName: String
    var monthLogs: [DayLog]
    var weekOne: [DayLog]
    var weekTwo: [DayLog]
    var weekThree: [DayLog]
    var weekFour: [DayLog]
    init(monthName: String, weekOne: [DayLog], weekTwo: [DayLog], weekThree: [DayLog], weekFour: [DayLog]){
        self.monthName = monthName
        self.weekOne = weekOne
        self.weekTwo = weekTwo
        self.weekThree = weekThree
        self.weekFour = weekFour
        self.monthLogs = weekOne + weekTwo + weekThree + weekFour
    }
}

class StatisticVC: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allLogs: [DayLog]!
    
    var monthLogs = [MonthDayLog]()
    var cellStats = [CellStats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180
        
        allLogs.sort(by: { $0.date!.compare($1.date! as Date) == ComparisonResult.orderedAscending })
        
        createMonthLogs()
        createCellStats()
        tableView.reloadData()
    }
    
    @IBAction func done(){
        self.dismiss(animated: false, completion: nil)
    }
    
    func createCellStats(){
        for x in monthLogs {
            let monthAvg = calculateDayLogAverage(logs: x.monthLogs)
            let week1Avg = calculateDayLogAverage(logs: x.weekOne)
            let week2Avg = calculateDayLogAverage(logs: x.weekTwo)
            let week3Avg = calculateDayLogAverage(logs: x.weekThree)
            let week4Avg = calculateDayLogAverage(logs: x.weekFour)
            let stat = CellStats(monthName: x.monthName, month: monthAvg, weekOne: week1Avg, weekTwo: week2Avg, weekThree: week3Avg, weekFour: week4Avg)
            cellStats.append(stat)
        }
        
    }
    
    func createMonthLogs(){
        var months = [[DayLog]]()
        var temp = [DayLog]()
        temp.append(allLogs[0])
        for x in allLogs {
            if temp[0] != x {
                let currentMonth = temp[0].date!.returnMonthName()
                let compareMonth = x.date!.returnMonthName()
                if compareMonth == currentMonth {
                    temp.append(x)
                } else {
                    months.append(temp)
                    temp.removeAll()
                }
            }
        }
        months.append(temp)
        temp.removeAll()
        var week1 = [DayLog]()
        var week2 = [DayLog]()
        var week3 = [DayLog]()
        var week4 = [DayLog]()
        var monthDayLog: MonthDayLog!
        for allLogs in months {
            for x in allLogs {
               let week = x.date!.returnWeekOfMonth()
                switch(week){
                case 1: week1.append(x)
                case 2: week2.append(x)
                case 3: week3.append(x)
                case 4: week4.append(x)
                default: fatalError()
                }
            }
            let monthName = allLogs[0].date!.returnMonthName()
            monthDayLog = MonthDayLog(monthName: monthName, weekOne: week1, weekTwo: week2, weekThree: week3, weekFour: week4)
            monthLogs.append(monthDayLog)
        }
        
    }
    
    func calculateDayLogAverage(logs: [DayLog])->Average?{
        
        if logs.count == 0 {
            return nil
        }

        var lbsArray = [Double]()
        var eatingArray = [Double]()
        var exerciseArray = [Double]()
        for x in logs {
            let lbs: Double? = (x.weight == Double(noData)) ? nil : x.weight
            let eating: Double? = (x.eating == Int(noData)) ? nil : Double(x.eating)
            let exercise: Double? = (x.exercise == Int(noData)) ? nil : Double(x.exercise)
            if let x = lbs {lbsArray.append(x)}
            if let x = eating {eatingArray.append(x)}
            if let x = exercise {exerciseArray.append(x)}
        }
        let lbsAvg: Double? = calculateAverage(array: lbsArray)
        let eatingAvg: Double? = calculateAverage(array: eatingArray)
        let exerciseAvg: Double? = calculateAverage(array: exerciseArray)
        
        let average = Average(lbs: lbsAvg, eating: eatingAvg, exercise: exerciseAvg)
        return average
    }
    
    func calculateAverage(array: [Double])->Double?{
        if array.count == 0 {
            return nil
        }
        var average: Double = 0
        for x in array {
            average = average + x
        }
        average = average / Double(array.count)
        average = Double(round(10*average)/10)
        return average
    }
    
    //-----------------TABLEVIEW FUNCTIONS------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellStats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticCell") as! StatisticCell
        cell.configure(stats: cellStats[indexPath.row])
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = Color.lightCellColor
        } else {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    
}
