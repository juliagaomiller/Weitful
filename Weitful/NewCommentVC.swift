//
//  NewCommentVC.swift
//  Weitful
//
//  Created by Julia Miller on 12/14/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class NewCommentVC: UIViewController {
    
    
    @IBOutlet weak var thumbsUpBtn: UIButton!
    @IBOutlet weak var thumbsdownBtn: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    let context = delegate.persistentContainer.viewContext

    let smallSize = CGSize(width: 10, height: 15)
    let largeSize = CGSize(width: 25, height: 30)
    var observation: Observation!
    var isPositive = true

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        thumbsUpBtn.frame.size = largeSize
        thumbsdownBtn.frame.size = smallSize
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @IBAction func up(){
        thumbsUpBtn.frame.size = largeSize
        thumbsdownBtn.frame.size = smallSize
        isPositive = true
    }
    
    @IBAction func down(){
        thumbsUpBtn.frame.size = smallSize
        thumbsdownBtn.frame.size = largeSize
        isPositive = false
    }
    
    @IBAction func clear(){
        
    }
    
    @IBAction func done(){
        if textView.text != "" {
             let _ = ObservationComments(text: textView.text, observation: observation, isPositive: isPositive, context: context)
            delegate.saveContext()
        }
        self.dismiss(animated: false, completion: nil)
    }


}
