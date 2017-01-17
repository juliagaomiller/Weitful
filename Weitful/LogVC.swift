//
//  LogVC.swift
//  Weitful
//
//  Created by Julia Miller on 11/23/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit


class LogVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var exerciseLbl: UILabel!
    @IBOutlet weak var eatingLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var commentTV: UITextView!
    @IBOutlet weak var commentsStack: UIStackView!
    @IBOutlet weak var dateBackground: UIView!
    @IBOutlet weak var commentPlaceholderLbl: UILabel!
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var eatingImageView: UIImageView!
    
    @IBOutlet var keypad: Array<UIButton>?
    
    var log: DayLog!
    var weightString = ""
    let defaultExerciseImage = #imageLiteral(resourceName: "ex2")
    let defaultEatingImage = #imageLiteral(resourceName: "eat-3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBAction func questionMark(_ sender: Any) {
        let screenshot = H.takeScreenshot(view: self.view)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: segueID.tutorialVC ) as! TutorialVC
        vc.screenshot = screenshot
        vc.VCTitle = segueID.logVC
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func adjustExercise(sender: UIButton!){
        var x: Int!
        if exerciseLbl.text == "~" {
            log.exercise = 0
            exerciseLbl.text = "0"
            updateView()
            return
            
        }
        if sender.accessibilityIdentifier == "-" {
            if log.exercise <= 0 {x = 0}
            else {x = -1}
        }
        else {
            if log.exercise == 3 {x = 0}
            else {x = 1}
        }
        log.exercise += x
        delegate.saveContext()
        updateView()
    }
    
    @IBAction func adjustEating(sender: UIButton!){
        var x: Int!
        if eatingLbl.text == "~" {
            log.eating = 0
            eatingLbl.text = "0"
            updateView()
            return
        }
        if sender.accessibilityIdentifier == "-" {
            if log.eating == -3 {x = 0}
            else {x = -1}
        }
        else {
            if log.eating == 3 {x = 0}
            else {x = 1}
        }
        log.eating += x
        delegate.saveContext()
        updateView()
    }
    
    @IBAction func clear(){
        commentTV.text = ""
    }
    
    func returnRatingImage(eat: Bool, ratingString: String)->UIImage {
        let imageString = (eat == true) ? "eat" + ratingString : "ex" + ratingString
        let image = UIImage(named: imageString)
        return image!
    }
    
    
    @IBAction func done(){
        log.commentary = commentTV.text
        delegate.saveContext()
        commentTV.resignFirstResponder()
        commentsStack.isHidden = true
    }
    
    func setUp(){
        self.view.sendSubview(toBack: dateBackground)
        commentTV.delegate = self
        addSwipeToView()
        assignActionsToKeypad()
        updateView()
    }
    
    func updateView(){
        commentTV.text = log.commentary
        commentsStack.isHidden = true
        dateLbl.text = log.dateString
        exerciseLbl.text = log.exerciseString
        eatingLbl.text = log.eatingString
        weightLbl.text = log.weightString
        if commentTV.text != "" {
            commentPlaceholderLbl.isHidden = true
        }
        let ex = log.exercise
        let eat = log.eating
        exerciseImageView.image = (ex == Int(noData)) ? defaultExerciseImage : returnRatingImage(eat: false, ratingString: String(ex))
        eatingImageView.image = (eat == Int(noData)) ? defaultEatingImage : returnRatingImage(eat: true, ratingString: String(eat))
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentsStack.isHidden = false
        commentPlaceholderLbl.isHidden = true
    }
    
}
