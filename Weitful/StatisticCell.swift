//
//  File.swift
//  Weitful
//
//  Created by Julia Miller on 1/12/17.
//  Copyright © 2017 Julia Miller. All rights reserved.
//

import UIKit

class StatisticCell: UITableViewCell {
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    let none = "No data.\n"

    var lbsString = "Lbs avg: "
    var eatString = "Eating avg: "
    var exString = "Exercise avg: "
    var detailString = "THIS MONTH\n"
    
    
    func updateDetailString(a: Average){
        lbsString = (a.lbs == nil) ? lbsString + none : lbsString + "\(a.lbs!)\n"
        eatString = (a.eating == nil) ? eatString + none : eatString + "\(a.eating!)\n"
        exString = (a.exercise == nil) ? exString + none: exString + "\(a.exercise!)\n"
        detailString += lbsString + eatString + exString
        lbsString = "Lbs avg: "
        eatString = "Eating avg: "
        exString = "Exercise avg: "
    }
    
    func configure(stats: CellStats){
        self.monthLbl.text = stats.monthName
        if let a = stats.month {
            updateDetailString(a: a)
        } else { detailString += none }
        detailString += "\nWEEK ONE\n"
        if let a = stats.weekOne {
            updateDetailString(a: a)
        } else { detailString += none }
        detailString += "WEEK TWO\n"
        if let a = stats.weekTwo {
            updateDetailString(a: a)
        } else { detailString += none }
        detailString += "WEEK THREE\n"
        if let a = stats.weekThree {
            updateDetailString(a: a)
        } else { detailString += none}
        detailString += "WEEK FOUR\n"
        if let a = stats.weekFour {
            updateDetailString(a: a)
        } else {detailString += none}
        self.detailTextView.text = detailString
        
    }
}
