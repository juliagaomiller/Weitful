//
//  NewAchievementVC.swift
//  Weitful
//
//  Created by Julia Miller on 1/4/17.
//  Copyright © 2017 Julia Miller. All rights reserved.
//

import UIKit

class NewAchievementVC: UIViewController {
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var discriptionLbl: UILabel!
    
    var achievement: Achievement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        let image = UIImage(data: achievement.image as! Data)
        imageView.image = image
        titleLbl.text = achievement.title
        discriptionLbl.text = achievement.detail

    }
    
    @IBAction func done() {
        self.dismiss(animated: false, completion: nil)
    }
    
}
