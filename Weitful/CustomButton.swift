//
//  RoundedCornersBtn.swift
//  Weitful
//
//  Created by Julia Miller on 12/19/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 7.0
    }
    
}
