//
//  LogCell.swift
//  Weitful
//
//  Created by Julia Miller on 11/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class LogCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var exerciseLbl: UILabel!
    @IBOutlet weak var eatingLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func calculateProgress(after: DayLog, before: DayLog)->String{
//        if after.weight != "- -" && before.weight != "- -"{
//            let p = Double(before.weight!)! - Double(after.weight!)!
//            if p > 0 {
//                return "+\(p)"
//            } else {
//                return "-\(p)"
//            }
//        }
//        return ""
//    }
    
    func configureCell(log: DayLog, previous: DayLog?){
        dateLbl.text = log.MMdd
        weightLbl.text = log.weight
        exerciseLbl.text = log.exercise
        eatingLbl.text = log.eating
        guard let p = previous else {
            progressLbl.text = ""
            return
        }
        progressLbl.text = MainVC.calculateProgress(after: log, before: p)
    }

}
