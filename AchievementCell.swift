//
//  AchievementCell.swift
//  Weitful
//
//  Created by Julia Miller on 1/4/17.
//  Copyright © 2017 Julia Miller. All rights reserved.
//

import UIKit

class AchievementCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var numOfTimesAchievedLbl: UILabel!
    
    func configure(achievement x: Achievement){
        let image = UIImage(data: x.image as! Data)
        iconImageView.image = image
        titleLbl.text = x.title
        descriptionLbl.text = x.detail
        numOfTimesAchievedLbl.text = x.numOfTimesAchievedString
    }
    


}
