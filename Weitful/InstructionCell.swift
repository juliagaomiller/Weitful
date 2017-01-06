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
    @IBOutlet weak var displayImage: UIImageView!
    
    
    func configureCell(eating: Eating){
        let stringNum = String(eating.rank)
        let imageString = "eat" + stringNum
        displayImage.image = UIImage(named: imageString)
        textV.textColor = UIColor.white
        rankLbl.textColor = UIColor.white
        rankLbl.text = stringNum
        if eating.userText == nil {
            textV.text = eating.defaultText!
        } else {
            textV.text = eating.userText!
        }
        backgroundColor = UIColor.black
    }
    
    func configureCell(exercising ex: Exercising){
        let stringNum = String(ex.rank)
        let imageString = "ex" + stringNum
        displayImage.image = UIImage(named: imageString)
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
