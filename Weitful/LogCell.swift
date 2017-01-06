//
//  LogCell.swift
//  Weitful
//
//  Created by Julia Miller on 11/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

func checkIfSameWeek(now: NSDate, previous: NSDate)->Bool{
    let previousInt = previous.returnDayOfWeekInt()
    let todayInt = now.returnDayOfWeekInt()
    if previousInt > todayInt {return false}
    let elapsed = abs(now.daysBetween(otherDate: previous))
    if abs(elapsed) > 6 {return false}
    else {
        return true
    }
}

class LogCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var exerciseLbl: UILabel!
    @IBOutlet weak var eatingLbl: UILabel!
    
    func configureCell(log: DayLog, previous: DayLog?, prevCellColor: UIColor?){
        let weekday = log.date!.returnDayOfWeek(abbreviated: true)
        dateLbl.text = weekday + " " + log.MMdd
        weightLbl.text = log.weightString
        exerciseLbl.text = log.exerciseStringWithPlusSign
        eatingLbl.text = log.eatingStringWithPlusSign
        progressLbl.text = ""
        if prevCellColor == nil || previous == nil {
            self.backgroundColor = Color.mediumCellColor
        }
        if let p = previous {
            let elapsed = log.date!.daysBetween(otherDate: p.date!)
            if elapsed < 0 {
                progressLbl.text = H.calculateProgress(now: log.weight, before: p.weight)
                if prevCellColor == nil {
                } else {
                    self.backgroundColor = returnWeekColor(now: log.date!, previous: p.date!, color: prevCellColor!)
                }
            } else {
                //if "previous" means the day AFTER log, then that means that we are on the last table view cell
                self.backgroundColor = returnWeekColor(now: p.date!, previous: log.date!, color: prevCellColor!)
            }
        }
    }
    
//    func checkIfSameWeek(now: NSDate, previous: NSDate)->Bool{
//        let previousInt = previous.returnDayOfWeekInt()
//        let todayInt = now.returnDayOfWeekInt()
//        if previousInt > todayInt {return false}
//        let elapsed = abs(now.daysBetween(otherDate: previous))
//        if abs(elapsed) > 6 {return false}
//        else {
//            return true
//        }
//    }
    
    func returnWeekColor(now: NSDate, previous: NSDate, color: UIColor)->UIColor{
        if checkIfSameWeek(now: now, previous: previous){
            return color
        } else {return returnOppositeCellBackgroundColor(color: color)}
    }
    
    func returnOppositeCellBackgroundColor(color: UIColor)-> UIColor{
        if color == Color.darkCellColor {
            return Color.mediumCellColor
        } else { return Color.darkCellColor }
    }

}
