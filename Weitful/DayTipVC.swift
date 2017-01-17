//
//  File.swift
//  Weitful
//
//  Created by Julia Miller on 1/10/17.
//  Copyright © 2017 Julia Miller. All rights reserved.
//

import Foundation
import UIKit

class DayTipVC: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tipTextView: UITextView!
    @IBOutlet weak var tipImageView: UIImageView!
    
    var background: UIImage!
    var tipText: String!
    var tipImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = background
        tipTextView.text = tipText
        tipImageView.image = tipImage
    }
    
    @IBAction func done(){
        self.dismiss(animated: false, completion: nil)
    }
    
}
