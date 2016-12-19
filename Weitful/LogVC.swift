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
    
    @IBOutlet var keypad: Array<UIButton>?
    
    var log: DayLog!
    
    var weightString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBAction func adjustExercise(sender: UIButton!){
        var x: Int!
        if exerciseLbl.text == "~" {
            log.exercise = 0
            exerciseLbl.text = "0"
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
    
    @IBAction func done(){
        log.commentary = commentTV.text
        delegate.saveContext()
        commentTV.resignFirstResponder()
        commentsStack.isHidden = true
    }
    
    func setUp(){
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
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentsStack.isHidden = false
    }
    
}
