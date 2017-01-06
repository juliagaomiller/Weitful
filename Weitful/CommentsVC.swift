//
//  ObservationsCommentsVC.swift
//  Weitful
//
//  Created by Julia Miller on 12/14/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearDone: UIStackView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var TVContainer: UIView!
    @IBOutlet weak var thumbsUpBtn: UIButton!
    @IBOutlet weak var thumbsDownBtn: UIButton!
    @IBOutlet weak var observationTV: UITextView!
    
    
    let context = delegate.persistentContainer.viewContext
    let smallThumbInsets = UIEdgeInsetsMake(14, 60, 14, 60)
    let defaultThumbInset = UIEdgeInsetsMake(0,0,0,0)
    
    var observation: Observation!
    var observationComments = [ObservationComments]()
    var editingObservation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observationTV.text = observation.text
        observationTV.delegate = self
        setUpTableView()
        hideNewCommentView()
        addSwipeBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateObservationComments()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        clearDone.isHidden = false
        clearDone.alpha = 1
        if textView == observationTV {
            editingObservation = true
        }
    }
    
    
    
    @IBAction func questionMark(_ sender: Any) {
        let screenshot = H.takeScreenshot(view: self.view)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: segueID.tutorialVC ) as! TutorialVC
        vc.screenshot = screenshot
        vc.VCTitle = segueID.commentsVC
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func thumbsUp(){
        thumbsUpBtn.imageEdgeInsets = defaultThumbInset
        thumbsDownBtn.imageEdgeInsets = smallThumbInsets
    }
    
    @IBAction func thumbsDown(){
        thumbsUpBtn.imageEdgeInsets = smallThumbInsets
        thumbsDownBtn.imageEdgeInsets = defaultThumbInset
    }
    
    @IBAction func clear(){
        if textView.isHidden == true {
            observation.text = ""
        } else {
           textView.text = ""
        }
    }
    
    @IBAction func done(){
        if editingObservation {
            observationTV.resignFirstResponder()
            if observationTV.text != "" {
                observation.text = observationTV.text
                delegate.saveContext()
                clearDone.isHidden = true
            }
        } else if textView.text != "" {
            let bool = checkIfIsPositive()
            let _ = ObservationComments(text: textView.text, observation: observation, isPositive: bool, context: context)
            delegate.saveContext()
            animateNewCommentView(isActivated: false)
            updateObservationComments()
        }
    }
    
    func checkIfIsPositive()->Bool {
        if thumbsUpBtn.imageEdgeInsets == defaultThumbInset {
            return true
        } else {return false}
    }
    
    @IBAction func newComment(){
        animateNewCommentView(isActivated: true)
    }
    
    //---TableView Functions---//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observationComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObservationCommentCell") as! ObservationCommentCell
        cell.configure(comment: observationComments[indexPath.row])
        cell.selectionStyle = .none
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = Color.lightCellColor
        } else {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let comment = observationComments[indexPath.row]
            context.delete(comment)
            delegate.saveContext()
            updateObservationComments()
        }
    }
}


