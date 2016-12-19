//
//  NewObservationVC.swift
//  Weitful
//
//  Created by Julia Miller on 12/11/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData

class NewObservationVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var clearDoneStack: UIStackView!
    
    let context = delegate.persistentContainer.viewContext
    
    var rank: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        addBackSwipe()
    }
    
    @IBAction func donePressed(_ sender: Any) {
        textView.resignFirstResponder()
        if textView.text != "" {
            let _ = Observation(text: textView.text, rank: rank, context: context)
            print("Just created new COMMENT with \(textView.text)")
            delegate.saveContext()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearPressed (btn: UIButton){
        textView.text = ""
    }
    
    func addBackSwipe(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissVC))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
    }
    
    func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
}
