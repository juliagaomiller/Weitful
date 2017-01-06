//
//  AchievementPlaceholderCell.swift
//  Weitful
//
//  Created by Julia Miller on 1/4/17.
//  Copyright © 2017 Julia Miller. All rights reserved.
//

import UIKit

class AchievementPlaceholderCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func configure(achievement x: Achievement){
        descriptionLbl.text = x.detail
    }

}
