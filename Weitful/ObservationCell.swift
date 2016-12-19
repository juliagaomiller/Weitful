//
//  ObservationCell.swift
//  Weitful
//
//  Created by Julia Miller on 12/11/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData

//protocol ObservationVCDelegate {
//    func updateTableView()
//    func returnArrayCount()->Int
//    func segueToComments()
//    func segueToNewComments()
//}

class ObservationCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var positiveLabel: UILabel!
    @IBOutlet weak var negativeLabel: UILabel!
    @IBOutlet weak var thumbBtn: UIButton!
    @IBOutlet weak var upBtn: UIButton!
    @IBOutlet weak var downBtn: UIButton!
    
    var observation: Observation!
    
    var negCount: Int = 0 {
        didSet {
            negativeLabel.text = String(negCount)
        }
    }
    var posCount: Int = 0 {
        didSet {
            positiveLabel.text = String(posCount)
        }
    }
    
    func configure(observation x: Observation, comments: [ObservationComments]){
        self.observation = x
        checkComments(comments: comments)
        textView.text = x.text
        backgroundColor = Color.lightBrown

    }
    
    func checkComments(comments: [ObservationComments]){
        posCount = 0
        negCount = 0
        for x in comments {
            if x.isPositive {posCount += 1}
            else {negCount += 1}
        }
    }

}
