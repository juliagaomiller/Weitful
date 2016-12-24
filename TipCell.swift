//
//  TipCell.swift
//  Weitful
//
//  Created by Julia Miller on 12/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class TipCell: UITableViewCell {
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var tipLbl: UILabel!
    
    func configureCell(dictionary d: [Int:String]){
        dayLbl.text = "Day \(String(d.0))"
        tipLbl.text = d.1
    }
    
}
