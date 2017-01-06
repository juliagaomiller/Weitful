//
//  MainVC.swift
//  WeitfulIntro
//
//  Created by Julia Miller on 12/28/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

let intro: [(image: UIImage, text: String)] = [
    (#imageLiteral(resourceName: "notReady1"), "I think I have something in my teeth..."),
    (#imageLiteral(resourceName: "notReady2"), "Oh, we're live?"),
    (#imageLiteral(resourceName: "pretty"), "Hi! Welcome to Weitful! My friend's first app!"),
    (#imageLiteral(resourceName: "pretty"), "Have you downloaded this app before?"),
    (#imageLiteral(resourceName: "prettyteeth"), "In that case, let me give you a quick introduction."),
    (#imageLiteral(resourceName: "present"), "Here, there are NO GOALS."),
    (#imageLiteral(resourceName: "notes"), "We are simply tracking our weight for the sake of tracking..."),
    (#imageLiteral(resourceName: "notes"), "Why?"),
    (#imageLiteral(resourceName: "monk"), "You may be surprised what you can learn..."),
    (#imageLiteral(resourceName: "monk"), "By simply being AWARE..."),
    (#imageLiteral(resourceName: "doctor"), "Look at this as an EXPERIMENT where YOU are the test subject..."),
    (#imageLiteral(resourceName: "doctor"), "X much exercise + X much food = X much weight loss or gain."),
    (#imageLiteral(resourceName: "doctor"), "Well, sometimes there might not even be a correlation..."),
    (#imageLiteral(resourceName: "present"), "How it all works. "),
    (#imageLiteral(resourceName: "present"), "Tap the top half of your screen to log today's weight"),
    (#imageLiteral(resourceName: "present"), "Weight logs from previous days are here."),
    (#imageLiteral(resourceName: "notes"), "Swipe right to write down your observations"),
    (#imageLiteral(resourceName: "present"), "Swipe down to review the exercise and eating ratings."),
    (#imageLiteral(resourceName: "prettyteeth"), "Swipe left to see my tips. I'll send you one each day for 30 days."),
    (#imageLiteral(resourceName: "present"), "And if you're ever confused, just tap on the button up here."),
    (#imageLiteral(resourceName: "monk"), "Knock yourselves out.")
]

class IntroVC: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var yesNoStack: UIStackView!
    
    @IBOutlet weak var rightArrow: UIImageView!
    @IBOutlet weak var leftArrow: UIImageView!
    @IBOutlet weak var rotatedArrow: UIImageView!
    @IBOutlet weak var downArrow: UIImageView!
    @IBOutlet weak var smallDownArrow: UIImageView!
    
    @IBOutlet weak var greyView: UIView!
    
    let pressedYes = "Alright! Well if you ever get confused, just click on the button up there."
    
    var backgroundImage: UIImage!
    var introArray = [(image: UIImage, text: String)]()
    
    var i: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = backgroundImage
        yesNoStack.isHidden = true
        
        nextBtn.adjustsImageWhenDisabled = true
        nextBtn.setTitleColor(UIColor.lightGray, for: .disabled)
        
        introArray = intro
        goToNextComment()
        
    }
    
    @IBAction func continueIntro(){
        goToNextComment()
        
    }
    
    @IBAction func dismiss(){
        label.text = pressedYes
        yesNoStack.isHidden = true
        nextBtn.isHidden = false
    }
    
    func dismissVC(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func nextPressed(sender: UIButton!){
        if label.text == pressedYes {
            dismissVC()
        } else {
            goToNextComment()
        }
        
    }
    
    func goToNextComment(){
        i += 1
        handleArrows(i: i)
        if i == 3 {
            yesNoStack.isHidden = false
            nextBtn.isHidden = true
        } else {
            yesNoStack.isHidden = true
            nextBtn.isHidden = false
        }
        if i < introArray.count{
            let tuple = introArray[i]
            imageView.image = tuple.image
            label.text = tuple.text
            
            nextBtn.isEnabled = false
            
            let deadlineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                self.nextBtn.isEnabled = true
            })
        } else {
            dismissVC()
        }
        
    }
    
    func handleArrows(i: Int){
        rightArrow.isHidden = true
        leftArrow.isHidden = true
        downArrow.isHidden = true
        rotatedArrow.isHidden = true
        smallDownArrow.isHidden = true
        switch(i){
            //will need to change this if add comments.
        case 14: greyView.isHidden = true
        case 15: smallDownArrow.isHidden = false
        case 16: rightArrow.isHidden = false
        case 17: downArrow.isHidden = false
        case 18: leftArrow.isHidden = false
        case 19: rotatedArrow.isHidden = false
        default: return
        }
    }
    
}
