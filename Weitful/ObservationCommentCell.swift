//
//  ObservationCommentCell.swift
//  Weitful
//
//  Created by Julia Miller on 12/14/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class ObservationCommentCell: UITableViewCell {
    
    @IBOutlet weak var timeElapsedLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    func configure(comment: ObservationComments){
        timeElapsedLabel.isHidden = true
        textView.text = comment.text
        dateLabel.text = comment.dateString
        timeLabel.text = comment.timeString
    }
}
