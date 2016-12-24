//
//  File.swift
//  Weitful
//
//  Created by Julia Miller on 12/8/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit

class InstructionCell: UITableViewCell {
    
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var textV: UITextView!
    
    func configureCell(eating: Eating){
        textV.textColor = UIColor.white
        rankLbl.textColor = UIColor.white
        rankLbl.text = String(eating.rank)
        if eating.userText == nil {
            textV.text = eating.defaultText!
        } else {
            textV.text = eating.userText!
        }
        backgroundColor = UIColor.black
    }
    
    func configureCell(exercising ex: Exercising){
        textV.textColor = UIColor.black
        rankLbl.textColor = UIColor.black
        rankLbl.text = String(ex.rank)
        if ex.userText == nil {
            textV.text = ex.defaultText
        } else {
            textV.text = ex.userText!
        }
        backgroundColor = UIColor.white
    }
}
