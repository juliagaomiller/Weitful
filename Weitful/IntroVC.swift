//
//  MainVC.swift
//  WeitfulIntro
//
//  Created by Julia Miller on 12/28/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

let intro: [(number: Int, image: UIImage, text: String)] = [
    //insert after #22 when you're not ready, you're not ready. trust me. my partner here has been walking/jogging 5+ miles for the past couple days, still hasn't lost weight, and feels hungry all the time. you need to be a hundred percent committed.
    //numbers are a mildly inefficient way to figure out a way to present arrows when needed
    (34,#imageLiteral(resourceName: "notReady1"), "I think I have something in my teeth..."),
    (55, #imageLiteral(resourceName: "notReady2"), "Oh, we're live?"),
    (85,#imageLiteral(resourceName: "pretty"), "Hi! Welcome to Weitful! My first app!"),
    (23,#imageLiteral(resourceName: "pretty"), "Have you downloaded this app before?"),
    (79,#imageLiteral(resourceName: "prettyteeth"), "In that case, let me give you a quick introduction."),
    (3,#imageLiteral(resourceName: "present"), "Here, there are no weight goals."),
    (5,#imageLiteral(resourceName: "notes"), "We are simply tracking our weight for the sake of tracking..."),
    (33,#imageLiteral(resourceName: "notes"), "Why?"),
    (51, #imageLiteral(resourceName: "ex3"), "When you're not ready, you're not ready! Let's not sugarcoat it, losing weight is HARD."),
    (52, #imageLiteral(resourceName: "ex3"), "Trust me, I have been jogging/walking ~5 miles–"),
    (53, #imageLiteral(resourceName: "ex3"), "for the past couple of days and still haven't lost a single pound. Not demoralizing at all."),
    (37, #imageLiteral(resourceName: "present"), "However, that doesn't mean that we should stop keeping track of our weight and exercise."),
    (11,#imageLiteral(resourceName: "present"), "You may be surprised by how much your eating and exercising–"),
    (77,#imageLiteral(resourceName: "present"), "behavior can be influenced by simply keeping a daily log..."),
    (80,#imageLiteral(resourceName: "doctor"), "See this as an objective experiment where YOU are the test subject..."),
    (90,#imageLiteral(resourceName: "doctor"), "X much exercise + X much food = X much weight loss or gain. There will be no 'guilt-tripping' involved."),
    (99,#imageLiteral(resourceName: "doctor"), "Also be aware that sometimes there might not even be a correlation..."),
    (14,#imageLiteral(resourceName: "present"), "How it all works. "),
    (15,#imageLiteral(resourceName: "present"), "Tap the top half of your screen to log today's weight."),
    (16,#imageLiteral(resourceName: "present"), "Weight logs from previous days are here."),
    (17,#imageLiteral(resourceName: "notes"), "Swipe right to write down your observations."),
    (18,#imageLiteral(resourceName: "present"), "Swipe down to review the exercise and eating ratings."),
    (19, #imageLiteral(resourceName: "present"), "Swipe up to see your achievements."),
    (20, #imageLiteral(resourceName: "present"), "Tap the statistics button in the upper left-hand corner to see your weekly and monthly statistics."),
    //swipe up to see your achievements
    (21,#imageLiteral(resourceName: "prettyteeth"), "Swipe left to read some tips I've learned along the way. I'll send you one each day for ~30 days."),
    (22,#imageLiteral(resourceName: "present"), "And if you're ever confused, just tap on the question mark button up there."),
    (0, #imageLiteral(resourceName: "monk"), "I want to share this quote with you."),
    (8, #imageLiteral(resourceName: "monk"), "It's the expanded version of our launch screen quote."),
    (1, #imageLiteral(resourceName: "monk"), "'At the individual level, Swaraj is vitally connected with the capacity for–"),
    (2, #imageLiteral(resourceName: "monk"), "dispassionate self-assessment, ceaseless self purification and growing self-reliance...."),
    (4, #imageLiteral(resourceName: "monk"), "It is Swaraj when we learn to rule ourselves.' - Mahatma Ghandi"),
    (101, #imageLiteral(resourceName: "monk"), "That quote is one of my inspirations for making this app."),
    (6, #imageLiteral(resourceName: "monk"), "Feel free to send me feedback to roguelifestudios@gmail.com so that I can make improvements for future apps."),
    (7,#imageLiteral(resourceName: "monk"), "If you use this app for awhile and enjoy it, a rating would be much appreciated. Enjoy!")

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
    @IBOutlet weak var leftRotatedArrow: UIImageView!
    @IBOutlet weak var upArrow: UIImageView!
    
    @IBOutlet weak var greyView: UIView!
    
    let pressedYes = "Alright! Well if you ever get confused, just tap on the question mark button in the upper right-hand corner."
    
    var backgroundImage: UIImage!
//    var introArray = [(image: UIImage, text: String)]()
    
    var i: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = backgroundImage
        yesNoStack.isHidden = true
        
        nextBtn.adjustsImageWhenDisabled = true
        nextBtn.setTitleColor(UIColor.lightGray, for: .disabled)
        
//        introArray = intro
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
        if i == 3 {
            yesNoStack.isHidden = false
            nextBtn.isHidden = true
        } else {
            yesNoStack.isHidden = true
            nextBtn.isHidden = false
        }
        if i < intro.count{
            handleArrows(i: intro[i].number)
            let tuple = intro[i]
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
        leftRotatedArrow.isHidden = true
        upArrow.isHidden = true
        switch(i){
            //will need to add for achievements and photos option
        case 14: greyView.alpha = 0.5
        case 16: smallDownArrow.isHidden = false
        case 17: rightArrow.isHidden = false
        case 18: downArrow.isHidden = false
        case 19: upArrow.isHidden = false
        case 20: leftRotatedArrow.isHidden = false
        case 21: leftArrow.isHidden = false
        case 22: rotatedArrow.isHidden = false
        default: return
        }
    }
    
}
