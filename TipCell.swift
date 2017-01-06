//
//  TipCell.swift
//  Weitful
//
//  Created by Julia Miller on 12/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class TipCell: UITableViewCell {
    
    @IBOutlet weak var tipLbl: UILabel!
    
    func configureCell(num: Int, text: String){
        let beginning = "Day \(String(num))\n "
        tipLbl.text = beginning + text
    }
    
}
