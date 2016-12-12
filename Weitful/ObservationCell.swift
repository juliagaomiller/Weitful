//
//  ObservationCell.swift
//  Weitful
//
//  Created by Julia Miller on 12/11/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class ObservationCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var negativeBtn: UIButton!
    @IBOutlet weak var positiveBtn: UIButton!
    
    func configure(observation x: Observation){
        textView.text = x.text
        backgroundColor = x.color
        
        negativeBtn.isHidden = true
        positiveBtn.isHidden = true
    }

}
