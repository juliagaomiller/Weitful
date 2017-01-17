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
    @IBOutlet weak var achievementImageView: UIImageView!
    
    var achievement: Achievement!
    var backgroundImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        whiteView.alpha = 0
        whiteView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 0.6, animations: {
            self.whiteView.alpha = 1
            self.whiteView.transform = CGAffineTransform.identity
        })
    }
    
    func setUp(){
        imageView.image = backgroundImage
        let image = UIImage(data: achievement.image as! Data)
        achievementImageView.image = image
        titleLbl.text = achievement.title
        discriptionLbl.text = achievement.detail

    }
    
    @IBAction func done() {
        UIView.animate(withDuration: 0.6, animations: {
            self.whiteView.alpha = 0
            self.whiteView.transform = CGAffineTransform.identity
        })
        self.dismiss(animated: false, completion: nil)
    }
    

    
}
