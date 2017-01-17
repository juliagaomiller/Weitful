//
//  LogCell.swift
//  Weitful
//
//  Created by Julia Miller on 11/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

func checkIfSameWeek(now: NSDate, dayAfter: NSDate)->Bool{
    let dayAfterInt = dayAfter.returnDayOfWeekInt()
    let todayInt = now.returnDayOfWeekInt()
    let elapsed = abs(now.daysBetween(otherDate: dayAfter))
    //more than a week has elapsed
    if abs(elapsed) > 6 {return false}
    //e.g. if
    if dayAfterInt < todayInt {
        return false}
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
    
    func configureCell(log: DayLog, dayAfter: DayLog?, dayBefore: DayLog?, prevCellColor: UIColor?){
        let weekday = log.date!.returnDayOfWeek(abbreviated: true)
        dateLbl.text = weekday + " " + log.MMdd
        weightLbl.text = log.weightString
        exerciseLbl.text = log.exerciseStringWithPlusSign
        eatingLbl.text = log.eatingStringWithPlusSign
        progressLbl.text = ""
        if prevCellColor == nil {
            //we are on the first cell
            self.backgroundColor = Color.mediumCellColor }
        else {
            self.backgroundColor = returnWeekColor(now: log.date!, dayAfter: dayAfter!.date!, color: prevCellColor!)
        }
        if dayBefore != nil {
            progressLbl.text = H.calculateProgress(now: log.weight, before: dayBefore!.weight)
        }
    }
    
    
    func returnWeekColor(now: NSDate, dayAfter: NSDate, color: UIColor)->UIColor{
        if checkIfSameWeek(now: now, dayAfter: dayAfter){
            return color
        } else {
            return returnOppositeCellBackgroundColor(color: color)}
    }
    
    func returnOppositeCellBackgroundColor(color: UIColor)-> UIColor{
        if color == Color.darkCellColor {
            return Color.mediumCellColor
        } else {
            
            return Color.darkCellColor }
    }

}
