//
//  TipCell.swift
//  Weitful
//
//  Created by Julia Miller on 12/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class TipCell: UITableViewCell {
    
    @IBOutlet weak var tipTextView: UITextView!
    @IBOutlet weak var tipImageView: UIImageView!
    
    
    func configureCell(num: Int, image: UIImage, text: String){
        let beginning = "Day \(String(num))\n "
        tipTextView.text = beginning + text
        tipImageView.image = image
    }
    
}
